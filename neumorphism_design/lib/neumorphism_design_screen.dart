import 'package:flutter/material.dart';
import 'package:showcase_view/showcase_view.dart';

import 'neumorphism_design_widget.dart';

class NeumorphismDesignScreen extends StatelessWidget {
  const NeumorphismDesignScreen({Key? key}) : super(key: key);

  static const owner = 'Idean';
  static const repository = 'Flutter-Neumorphic';
  static const branch = 'master';

  @override
  Widget build(BuildContext context) {
    return const ShowcaseView(
      title: 'Neumorphism Design',
      widget: FullSampleHomePage(),
      owner: owner,
      repository: repository,
      ref: branch,
      readMe: 'README.md',
      codePaths: [
        'example/pubspec.yaml',
        'example/lib/main.dart',
        'example/lib/main_home.dart',
      ],
    );
  }
}
