import 'package:flutter/material.dart';
import 'package:showcase_view/showcase_view.dart';

import 'settings_screen.dart';

class SettingsUiShowcaseScreen extends StatelessWidget {
  const SettingsUiShowcaseScreen({Key? key}) : super(key: key);

  static const owner = 'yako-dev';
  static const repository = 'flutter-settings-ui';
  static const branch = 'master';

  @override
  Widget build(BuildContext context) {
    return ShowcaseView(
      title: 'Settings UI Showcase',
      widget: SettingsScreen(),
      owner: owner,
      repository: repository,
      ref: branch,
      readMe: 'README.md',
      codePaths: [
        'example/pubspec.yaml',
        'example/lib/main.dart',
        'example/lib/screens/settings_screen.dart',
        'example/lib/screens/languages_screen.dart',
      ],
    );
  }
}
