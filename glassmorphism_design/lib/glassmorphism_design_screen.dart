import 'package:flutter/material.dart';
import 'package:showcase_view/showcase_view.dart';

import 'glassmorphism_design_widget.dart';

class GlassmorphismDesignScreen extends StatelessWidget {
  const GlassmorphismDesignScreen({Key key}) : super(key: key);

  static const owner = 'RitickSaha';
  static const repository = 'glassmorphism';
  static const branch = 'master';

  @override
  Widget build(BuildContext context) {
    return ShowcaseView(
      title: 'Glassmorphism Design',
      widget: GlassmorphismDesignWidget(),
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
