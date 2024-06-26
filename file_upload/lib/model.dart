import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mime/mime.dart';
import 'constants.dart';

class UploadFileList {
  final List<UploadFile> items = [];
  final UploadFileService _uploadFileService = UploadFileService();

  Future<void> add() async {
    final item = await _uploadFileService.pickFile();
    if (item != null) {
      items.add(item);
      _uploadFileService.upload(item);
    }
  }
}

enum UploadFileStatus {
  pending,
  uploading,
  processing,
  completed,
  failed,
  cancelled,
}

class UploadFile extends ChangeNotifier {
  final String name;
  final int size;
  final MediaType? contentType;
  final Stream<List<int>> stream;
  UploadFileStatus status = UploadFileStatus.pending;
  double _uploadingProgress = 0;
  double _processingProgress = 0;
  DateTime? dateTime;
  CancelToken? _cancelToken;
  String? errorMessage;

  UploadFile(
    this.name,
    this.size,
    this.contentType,
    this.stream,
  );

  double get uploadingProgress => _uploadingProgress;

  set uploadingProgress(double progress) {
    if (progress > 0.0) {
      status = UploadFileStatus.uploading;
    }
    _uploadingProgress = progress;
    notifyListeners();
  }

  double get processingProgress => _processingProgress;

  set processingProgress(double progress) {
    if (progress > 0.0) {
      status = UploadFileStatus.processing;
    }

    _processingProgress = progress;
    notifyListeners();
  }

  void cancel() {
    if (_cancelToken != null && !_cancelToken!.isCancelled) {
      _cancelToken?.cancel();
    }
  }

  void updateStatus(UploadFileStatus newStatus, DateTime newDateTime) {
    status = newStatus;
    dateTime = newDateTime;
    notifyListeners();
  }
}

class UploadFileService {
  Future<UploadFile?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions.split(","),
      allowMultiple: false,
      withData: false,
      withReadStream: true,
    );

    if (result == null || result.files.isEmpty) {
      return null;
    }

    final file = result.files.first;
    String? mimeType;
    String fileName = unknownFileName;
    if (kIsWeb) {
      // REF: https://github.com/miguelpruivo/flutter_file_picker/wiki/FAQ#q-how-do-i-access-the-path-on-web
      final fileBytes = file.bytes;
      fileName = file.name;
      mimeType = lookupMimeType(fileName, headerBytes: fileBytes);
    } else {
      final filePath = file.path;
      if (filePath != null) {
        mimeType = lookupMimeType(filePath);
        fileName = filePath.split(Platform.pathSeparator).last;
      }
    }

    debugPrint("mimeType $mimeType");

    final contentType = mimeType != null ? MediaType.parse(mimeType) : null;

    // REF: https://github.com/miguelpruivo/flutter_file_picker/wiki/FAQ#q-how-do-do-i-use-withreadstream
    final fileReadStream = file.readStream;
    if (fileReadStream == null) {
      throw Exception(fileStreamExceptionMessage);
    }

    return UploadFile(fileName, file.size, contentType, fileReadStream);
  }

  void upload(UploadFile file) async {
    final dio = Dio();
    final cancelToken = CancelToken();
    file._cancelToken = cancelToken;

    final multipartFile = MultipartFile.fromStream(
      () => file.stream,
      file.size,
      filename: file.name,
      contentType: file.contentType,
    );

    final formData = FormData.fromMap({
      "file": multipartFile,
    });

    dio.post(
      backendUrl,
      data: formData,
      cancelToken: cancelToken,
      onSendProgress: (int sent, int total) {
        double progress = sent / total;
        file.uploadingProgress = progress;
      },
      onReceiveProgress: (int count, int total) {
        debugPrint("onReceiveProgress(count: $count, total: $total)");
        double progress = count * 0.01;
        file.processingProgress = progress;
      },
    ).then((response) {
      // Handle the response data in here
      debugPrint(response.data.toString());
    }).catchError((error) {
      // Handle the error in here
      if (error is DioException) {
        // Here's an example of how you might handle different error types
        switch (error.type) {
          case DioExceptionType.cancel:
            debugPrint("Request to API was cancelled");
            file.updateStatus(UploadFileStatus.cancelled, DateTime.now());
            break;
          default:
            debugPrint("*** DioException ERROR ${error.message}");
            // TODO: the error may cause by no response streaming support in AWS Lambda,
            // Self hosting need not to perform the conditional check
            if (error.message != null) {
              file.errorMessage = error.message;
              file.updateStatus(UploadFileStatus.failed, DateTime.now());
            }
        }
      } else {
        debugPrint("*** Other ERROR ${error.message}");
        file.errorMessage = error.message;
        file.updateStatus(UploadFileStatus.failed, DateTime.now());
      }
    }).whenComplete(() {
      // Any cleanup code goes here
      debugPrint('Request completed');
      if (file.status != UploadFileStatus.failed &&
          file.status != UploadFileStatus.cancelled) {
        file.updateStatus(UploadFileStatus.completed, DateTime.now());
      }
    });
  }
}
