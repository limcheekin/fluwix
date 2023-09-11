import 'package:file_upload/model.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'viewmodel.dart';

class UploadFileListView extends StatefulWidget {
  final UploadFileListViewModel viewModel;

  const UploadFileListView({Key? key, required this.viewModel})
      : super(key: key);

  @override
  State<UploadFileListView> createState() => _UploadFileListViewState();
}

class _UploadFileListViewState extends State<UploadFileListView> {
  static int megaBytes = 1000 * 1000;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.viewModel.items.length,
      itemBuilder: (context, index) {
        final item = widget.viewModel.items[index];
        return ListTile(
          //key: ValueKey(index),
          title: Text(
            item.name,
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${(item.size / megaBytes).toStringAsFixed(2)} MB"),
              ListenableBuilder(
                listenable: item,
                builder: (BuildContext context, Widget? child) {
                  return Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: item.status == UploadFileStatus.uploading
                              ? LinearPercentIndicator(
                                  progressColor: ThemeData.light().primaryColor,
                                  percent: item.uploadProgress,
                                )
                              : const SizedBox.shrink(),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(item.status.name),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
