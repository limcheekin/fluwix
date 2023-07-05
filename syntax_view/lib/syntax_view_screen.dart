import 'package:flutter/material.dart';
import 'package:showcase_view/showcase_view.dart';

import 'syntax_view_widget.dart';

class SyntaxViewScreen extends StatelessWidget {
  const SyntaxViewScreen({Key? key}) : super(key: key);

  static const owner = 'BaderEddineOuaich';
  static const repository = 'flutter_syntax_view';
  static const branch = 'master';

  @override
  Widget build(BuildContext context) {
    return ShowcaseView(
      title: 'Syntax View',
      widget: SyntaxViewWidget(),
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
