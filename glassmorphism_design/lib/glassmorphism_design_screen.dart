import 'package:flutter/material.dart';
import 'package:showcase_view/showcase_view.dart';

import 'glassmorphism_design_widget.dart';

class GlassmorphismDesignScreen extends StatelessWidget {
  const GlassmorphismDesignScreen({Key key}) : super(key: key);

  // Configure the properties for external GitHub repo, for example:
  // https://github.com/miquelbeltran/flutter_material_showcase
  // owner = 'miquelbeltran';
  // repository = 'flutter_material_showcase';
  // branch = 'master';
  static const owner = 'limcheekin';
  static const repository = 'flutter-widgets-explorer';
  static const branch = 'glassmorphism_design';

  @override
  Widget build(BuildContext context) {
    return ShowcaseView(
      title: 'Glassmorphism Design',
      widget: GlassmorphismDesignWidget(),
      owner: owner,
      repository: repository,
      ref: branch,
      // $branch/ prefix is not needed for external GitHub repo
      // Please refer to the following sample code:
      // https://github.com/limcheekin/flutter-widgets-explorer/blob/main/material_design_showcase/lib/material_design_showcase_screen.dart
      readMe: '$branch/README.md',
      codePaths: [
        '$branch/pubspec.yaml',
        '$branch/lib/glassmorphism_design_screen.dart',
      ],
    );
  }
}
