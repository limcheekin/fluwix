import 'package:flutter/material.dart';
import 'package:common_ui/my_module.dart';
import 'file_upload_screen.dart';

void main() {
  runApp(
    const MyModule(
      title: 'File Upload',
      home: FileUploadScreen(),
    ),
  );
}
