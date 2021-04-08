import 'package:flutter/material.dart';
import 'package:showcase_view/showcase_view.dart';

class ModuleNameScreen extends StatelessWidget {
  const ModuleNameScreen({Key key}) : super(key: key);

  static const owner = 'limcheekin';
  static const repository = 'flutter-widgets-explorer';
  static const branch = 'module_name';

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
