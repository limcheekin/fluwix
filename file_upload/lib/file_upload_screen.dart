import 'package:flutter/material.dart';
import 'package:showcase_view/showcase_view.dart';
import 'widgets/file_upload_widget.dart';

class FileUploadScreen extends StatelessWidget {
  const FileUploadScreen({Key? key}) : super(key: key);

  // Configure the properties for external GitHub repo, for example:
  // https://github.com/miquelbeltran/flutter_material_showcase
  // owner = 'miquelbeltran';
  // repository = 'flutter_material_showcase';
  // branch = 'master';
  static const owner = 'limcheekin';
  static const repository = 'fluwix';
  static const branch = 'file_upload';

  @override
  Widget build(BuildContext context) {
    return const ShowcaseView(
      title: 'File Upload',
      widget: FileUploadWidget(),
      owner: owner,
      repository: repository,
      ref: branch,
      // $branch/ prefix is not needed for external GitHub repo
      // Please refer to the following sample code:
      // https://github.com/limcheekin/fluwix/blob/main/material_design_showcase/lib/material_design_showcase_screen.dart
      readMe: '$branch/README.md',
      codePaths: [
        '$branch/pubspec.yaml',
        '$branch/lib/constants.dart',
        '$branch/lib/file_upload_screen.dart',
        '$branch/lib/viewmodel.dart',
        '$branch/lib/model.dart',
        '$branch/lib/widgets/cancel_upload_button_widget.dart',
        '$branch/lib/widgets/file_upload_widget.dart',
        '$branch/lib/widgets/message_panel_widget.dart',
        '$branch/lib/widgets/upload_file_item_widget.dart',
        '$branch/lib/widgets/upload_file_list_widget.dart',
        '$branch/lib/widgets/upload_file_status_widget.dart',
        '$branch/lib/widgets/upload_file_zone_widget.dart',
        '$branch/lib/widgets/upload_progress_indicator_widget.dart',
      ],
    );
  }
}
