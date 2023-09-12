import 'package:file_icon/file_icon.dart';
import 'package:file_upload/model.dart';
import 'package:flutter/material.dart';
import 'viewmodel.dart';

class UploadFileListView extends StatefulWidget {
  final UploadFileListViewModel viewModel;

  const UploadFileListView({Key? key, required this.viewModel})
      : super(key: key);

  @override
  State<UploadFileListView> createState() => _UploadFileListViewState();
}

class _UploadFileListViewState extends State<UploadFileListView> {
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

class UploadFileItemWidget extends StatelessWidget {
  static int megaBytes = 1000 * 1000;
  final UploadFile item;

  const UploadFileItemWidget(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
          child: Row(
            children: [
              Container(
                color: Colors.yellow,
                child: FileIcon(
                  item.name,
                  size: 64,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          backgroundColor: Colors.amber),
                    ),
                    const SizedBox(
                        height:
                            4), // Add some spacing between title and subtitle
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                            "${(item.size / megaBytes).toStringAsFixed(2)} MB"),
                        ListenableBuilder(
                          listenable: item,
                          builder: (BuildContext context, Widget? child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 130,
                                  child: UploadProgressIndicator(item),
                                ),
                                Text(item.status.name),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        CancelUploadButton(item),
      ],
    );
  }
}

class UploadProgressIndicator extends StatelessWidget {
  final UploadFile item;
  const UploadProgressIndicator(this.item, {super.key});

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

class CancelUploadButton extends StatelessWidget {
  final UploadFile item;
  const CancelUploadButton(this.item, {super.key});

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
        icon: const Icon(Icons.cancel_outlined),
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
