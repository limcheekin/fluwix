import 'package:flutter/material.dart';

import '../model.dart';

class UploadFileStatusWidget extends StatelessWidget {
  const UploadFileStatusWidget({
    super.key,
    required this.item,
  });

  final UploadFile item;

  @override
  Widget build(BuildContext context) {
    Color textColor;
    Widget status;
    switch (item.status) {
      case UploadFileStatus.completed:
        textColor = Colors.green;
        break;
      case UploadFileStatus.cancelled:
        textColor = Colors.yellow;
        break;
      case UploadFileStatus.failed:
        textColor = Colors.red;
        break;
      default:
        textColor = Colors.grey;
    }

    if (item.status == UploadFileStatus.failed && item.errorMessage != null) {
      status = Tooltip(
        message: item.errorMessage,
        child: Row(
          children: [
            Text(
              item.status.name,
              style: TextStyle(
                color: textColor,
              ),
            ),
            Icon(
              Icons.help_outline,
              size: 16.0,
              color: textColor,
            ),
          ],
        ),
      );
    } else {
      status = Text(
        item.status.name,
        style: TextStyle(
          color: textColor,
        ),
      );
    }
    return status;
  }
}
