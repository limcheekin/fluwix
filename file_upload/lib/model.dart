import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mime/mime.dart';

class UploadFileList {
  static int numberOfConcurrentUploads = 1;
  final List<UploadFile> items = [];
  final UploadFileService _uploadFileService = UploadFileService();
  int uploadIndex = 0;

  Future<void> add() async {
    final item = await _uploadFileService.pickFile();
    items.add(item);
    _uploadFileService.upload(item);
  }
}

enum UploadFileStatus {
  pending,
  uploading,
  processing,
  completed,
  failed,
}

class UploadFile extends ChangeNotifier {
  final String name;
  final int size;
  final MediaType? contentType;
  final Stream<List<int>> stream;
  UploadFileStatus status = UploadFileStatus.pending;
  double _uploadProgress = 0;
  DateTime? dateTime;

  UploadFile(
    this.name,
    this.size,
    this.contentType,
    this.stream,
  );

  double get uploadProgress => _uploadProgress;

  set uploadProgress(double progress) {
    if (status == UploadFileStatus.pending && progress > 0.0) {
      status = UploadFileStatus.uploading;
    } else if (status == UploadFileStatus.uploading && progress == 100.0) {
      status = UploadFileStatus.completed;
    }
    _uploadProgress = progress;
    notifyListeners();
  }
}

class UploadFileService {
  static final uri = Uri.https(
      'ljplkfhip2rceqhupnjwqc7ysm0pifea.lambda-url.us-east-1.on.aws',
      '/upload');
  Future<UploadFile> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'png',
        'mp4',
        'webm',
      ],
      allowMultiple: false,
      withData: false,
      withReadStream: true,
    );

    if (result == null || result.files.isEmpty) {
      throw Exception('No files picked or file picker was canceled');
    }

    final file = result.files.first;
    String? mimeType;
    String fileName = "Unknown";
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
      throw Exception('Cannot read file from null stream');
    }

    return UploadFile(fileName, file.size, contentType, fileReadStream);
  }

  void upload(UploadFile file) async {
    final dio = Dio();

    final multipartFile = MultipartFile.fromStream(
      () => file.stream,
      file.size,
      filename: file.name,
      contentType: file.contentType,
    );

    final formData = FormData.fromMap({
      "file": multipartFile,
    });

    final response = await dio.post(
      uri.toString(),
      data: formData,
      options: Options(responseType: ResponseType.json),
      onSendProgress: (int sent, int total) {
        //debugPrint('sent: $sent total: $total');
        double progress = sent / total;
        //debugPrint("Upload progress: $progress");
        file.uploadProgress = progress;
      },
    );

    debugPrint(response.data.toString());
  }
}
