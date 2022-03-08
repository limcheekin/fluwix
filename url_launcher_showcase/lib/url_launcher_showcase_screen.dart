import 'package:flutter/material.dart';
import 'package:showcase_view/showcase_view.dart';

import 'url_launcher_showcase_widget.dart';

class UrlLauncherShowcaseScreen extends StatelessWidget {
  const UrlLauncherShowcaseScreen({Key? key}) : super(key: key);

  static const owner = 'limcheekin';
  static const repository = 'fluwix';
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
