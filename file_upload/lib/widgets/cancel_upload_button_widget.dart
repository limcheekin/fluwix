import 'package:flutter/material.dart';

import '../model.dart';

class CancelUploadButtonWidget extends StatelessWidget {
  final UploadFile item;
  const CancelUploadButtonWidget(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: item,
      builder: (BuildContext context, Widget? child) {
        return Align(
          alignment: Alignment.topRight,
          child: _build(),
        );
      },
    );
  }

  Widget _build() {
    Widget cancelUploadButton;
    if (item.status == UploadFileStatus.uploading) {
      cancelUploadButton = IconButton(
        icon: const Icon(Icons.cancel),
        onPressed: () {
          item.cancel();
        },
      );
    } else {
      cancelUploadButton = const SizedBox.shrink();
    }
    return cancelUploadButton;
  }
}
