import 'package:flutter/material.dart';
import 'package:showcase_view/showcase_view.dart';

import 'markdown_view_widget.dart';

class MarkdownViewScreen extends StatelessWidget {
  const MarkdownViewScreen({Key? key}) : super(key: key);

  static const owner = 'limcheekin';
  static const repository = 'fluwix';
  static const branch = 'markdown_view';

  @override
  Widget build(BuildContext context) {
    return ShowcaseView(
      title: 'Markdown View',
      widget: MarkdownViewWidget(),
      owner: owner,
      repository: repository,
      ref: branch,
      readMe: '$branch/README.md',
      codePaths: [
        '$branch/pubspec.yaml',
        '$branch/lib/markdown_view_screen.dart',
        '$branch/lib/markdown_view_widget.dart',
      ],
    );
  }
}
