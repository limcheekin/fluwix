import 'package:file_icon/file_icon.dart';
import 'package:flutter/material.dart';

import '../model.dart';
import 'upload_file_status_widget.dart';
import 'upload_progress_indicator_widget.dart';
import 'cancel_upload_button_widget.dart';

class UploadFileItemWidget extends StatelessWidget {
  static int megaBytes = 1000 * 1000;
  final UploadFile item;

  const UploadFileItemWidget(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                FileIcon(
                  item.name,
                  size: 64,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                          height:
                              4), // Add some spacing between title and subtitle
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${(item.size / megaBytes).toStringAsFixed(2)} MB",
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 8),
                          ListenableBuilder(
                            listenable: item,
                            builder: (BuildContext context, Widget? child) {
                              return Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child:
                                          UploadProgressIndicatorWidget(item),
                                    ),
                                    const SizedBox(width: 8),
                                    UploadFileStatusWidget(item: item),
                                  ],
                                ),
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
          CancelUploadButtonWidget(item),
        ],
      ),
    );
  }
}
