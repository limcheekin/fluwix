import 'package:flutter/material.dart';
import 'package:showcase_view/showcase_view.dart';

import 'syntax_view_widget.dart';

class SyntaxViewScreen extends StatelessWidget {
  const SyntaxViewScreen({Key key}) : super(key: key);

  static const owner = 'limcheekin';
  static const repository = 'flutter-widgets-explorer';
  static const branch = 'syntax_view';

  @override
  Widget build(BuildContext context) {
    return ShowcaseView(
      title: 'Syntax View',
      widget: SyntaxViewWidget(),
      owner: owner,
      repository: repository,
      ref: branch,
      readMe: '$branch/README.md',
      codePaths: [
        '$branch/pubspec.yaml',
        '$branch/lib/syntax_view_screen.dart',
        '$branch/lib/syntax_view_widget.dart',
      ],
    );
  }
}
