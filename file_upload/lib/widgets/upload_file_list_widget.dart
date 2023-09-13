import 'package:flutter/material.dart';

import '../viewmodel.dart';
import 'upload_file_item_widget.dart';

class UploadFileListWidget extends StatefulWidget {
  final UploadFileListViewModel viewModel;

  const UploadFileListWidget({Key? key, required this.viewModel})
      : super(key: key);

  @override
  State<UploadFileListWidget> createState() => _UploadFileListWidgetState();
}

class _UploadFileListWidgetState extends State<UploadFileListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.viewModel.items.length,
      itemBuilder: (context, index) {
        final item = widget.viewModel.items[index];
        return UploadFileItemWidget(item);
      },
    );
  }
}
