import 'package:flutter/material.dart';
import 'package:showcase_view/showcase_view.dart';

import 'url_launcher_showcase_widget.dart';

class UrlLauncherShowcaseScreen extends StatelessWidget {
  const UrlLauncherShowcaseScreen({Key key}) : super(key: key);

  /// Github URL: https://github.com/limcheekin/flutter-widgets-explorer/tree/module_starter
  /// owner = 'limcheekin';
  /// repository = 'flutter-widgets-explorer';
  /// branch = 'module_starter';
  static const owner = 'limcheekin';
  static const repository = 'flutter-widgets-explorer';
  static const branch = 'url_launcher_showcase';

  @override
  Widget build(BuildContext context) {
    return ShowcaseView(
      title: 'Url Launcher Showcase',
      widget: UrlLauncherShowcaseWidget(),
      owner: owner,
      repository: repository,
      ref: branch,
      readMe: '$branch/README.md',
      codePaths: [
        '$branch/pubspec.yaml',
        '$branch/lib/url_launcher_showcase_screen.dart',
        '$branch/lib/url_launcher_showcase_widget.dart',
      ],
    );
  }
}
