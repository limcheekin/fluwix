import 'package:flutter/material.dart';
import './pages/read_only_page.dart';
import 'package:showcase_view/showcase_view.dart';

class RichTextEditorScreen extends StatelessWidget {
  const RichTextEditorScreen({Key? key}) : super(key: key);

  static const owner = 'singerdmx';
  static const repository = 'flutter-quill';
  static const branch = 'master';

  @override
  Widget build(BuildContext context) {
    return const ShowcaseView(
      title: 'Rich Text Editor',
      widget: ReadOnlyPage(),
      owner: owner,
      repository: repository,
      ref: branch,
      readMe: 'README.md',
      codePaths: [
        'example/pubspec.yaml',
        'example/lib/pages/read_only_page.dart',
      ],
    );
  }
}
