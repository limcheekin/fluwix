import 'package:flutter/material.dart';
import 'package:rich_text_editor/rich_text_editor_widget.dart';
import 'package:showcase_view/showcase_view.dart';

class RichTextEditorScreen extends StatelessWidget {
  const RichTextEditorScreen({super.key});

  static const owner = 'singerdmx';
  static const repository = 'flutter-quill';
  static const branch = 'master';

  @override
  Widget build(BuildContext context) {
    return const ShowcaseView(
      title: 'Rich Text Editor',
      widget: RichTextEditorWidget(),
      owner: owner,
      repository: repository,
      ref: branch,
      readMe: 'README.md',
      codePaths: [
        'example/pubspec.yaml',
        'example/lib/main.dart',
      ],
    );
  }
}
