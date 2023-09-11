import 'package:flutter/material.dart';
import 'package:showcase_view/showcase_view.dart';

import 'view.dart';
import 'model.dart';
import 'viewmodel.dart';

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
        '$branch/lib/file_upload_screen.dart',
      ],
    );
  }
}

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
    return Scaffold(
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (BuildContext context, Widget? child) {
          return UploadFileListView(
            viewModel: _viewModel,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addItem(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
