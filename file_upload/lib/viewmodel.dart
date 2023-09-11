import 'package:flutter/foundation.dart';

import 'model.dart';

class UploadFileListViewModel extends ChangeNotifier {
  final UploadFileList _uploadFileList;

  UploadFileListViewModel(this._uploadFileList);

  List<UploadFile> get items => _uploadFileList.items;

  Future<void> addItem() async {
    await _uploadFileList.add();
    notifyListeners();
  }
}
