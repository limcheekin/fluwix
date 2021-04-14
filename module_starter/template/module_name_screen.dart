import 'package:flutter/material.dart';
import 'package:showcase_view/showcase_view.dart';

class ModuleNameScreen extends StatelessWidget {
  const ModuleNameScreen({Key key}) : super(key: key);

  /// Github URL: https://github.com/limcheekin/flutter-widgets-explorer/tree/module_starter
  /// owner = 'limcheekin';
  /// repository = 'flutter-widgets-explorer';
  /// branch = 'module_starter';
  static const owner = '';
  static const repository = '';
  static const branch = '';

  @override
  Widget build(BuildContext context) {
    return ShowcaseView(
      title: 'Module Name',
      widget: ModuleNameWidget(),
      owner: owner,
      repository: repository,
      ref: branch,
      readMe: '$branch/README.md',
      codePaths: [
        '$branch/pubspec.yaml',
        '$branch/lib/module_name_screen.dart',
      ],
    );
  }
}

class ModuleNameWidget extends StatelessWidget {
  const ModuleNameWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Replace this with your Module Name widget');
  }
}
