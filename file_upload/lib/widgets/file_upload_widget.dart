import 'package:flutter/material.dart';

import '../model.dart';
import '../viewmodel.dart';
import 'message_panel_widget.dart';
import 'upload_file_zone_widget.dart';
import 'upload_file_list_widget.dart';

class FileUploadWidget extends StatefulWidget {
  const FileUploadWidget({Key? key}) : super(key: key);

  @override
  State<FileUploadWidget> createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends State<FileUploadWidget> {
  late UploadFileListViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = UploadFileListViewModel(UploadFileList());
  }

  Future<void> addItem() async {
    await _viewModel.addItem();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          body: Column(
            children: [
              const MessagePanelWidget(
                icon: Icon(Icons.info_outline),
                message: 'The maximum file size to upload is 1MB.',
              ),
              Expanded(
                child: Stack(
                  children: [
                    UploadFileListWidget(
                      viewModel: _viewModel,
                    ),
                    if (_viewModel.items.isEmpty)
                      UploadFileZoneWidget(
                        icon: const Icon(
                          Icons.upload,
                          size: 128,
                          color: Colors.grey,
                        ),
                        message: "Click here to upload file",
                        onTap: () => addItem(),
                      ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: _viewModel.items.isNotEmpty
              ? FloatingActionButton(
                  onPressed: () => addItem(),
                  child: const Icon(Icons.upload_file_outlined),
                )
              : null,
        );
      },
    );
  }
}
