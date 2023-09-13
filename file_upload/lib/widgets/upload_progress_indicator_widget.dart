import 'package:flutter/material.dart';

import '../model.dart';

class UploadProgressIndicatorWidget extends StatelessWidget {
  final UploadFile item;
  const UploadProgressIndicatorWidget(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    Widget uploadProgressIndicator;
    if (item.status == UploadFileStatus.uploading) {
      uploadProgressIndicator = LinearProgressIndicator(
        value: item.uploadingProgress,
        semanticsLabel: 'uploading progress',
      );
    } else if (item.status == UploadFileStatus.processing) {
      uploadProgressIndicator = LinearProgressIndicator(
        value: item.processingProgress,
        semanticsLabel: 'processing progress',
      );
    } else {
      uploadProgressIndicator = const SizedBox.shrink();
    }
    return uploadProgressIndicator;
  }
}
