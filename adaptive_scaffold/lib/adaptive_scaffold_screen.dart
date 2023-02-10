import 'package:flutter/material.dart';
import 'package:showcase_view/showcase_view.dart';

import 'adaptive_scaffold_widget.dart';

class AdaptiveScaffoldScreen extends StatelessWidget {
  const AdaptiveScaffoldScreen({Key? key}) : super(key: key);

  // Configure the properties for external GitHub repo, for example:
  // https://github.com/miquelbeltran/flutter_material_showcase
  // owner = 'miquelbeltran';
  // repository = 'flutter_material_showcase';
  // branch = 'master';
  static const owner = 'flutter';
  static const repository = 'packages';
  static const branch = 'main';

  @override
  Widget build(BuildContext context) {
    return const ShowcaseView(
      title: 'Adaptive Scaffold',
      widget: AdaptiveScaffoldWidget(),
      owner: owner,
      repository: repository,
      ref: branch,
      // $branch/ prefix is not needed for external GitHub repo
      // Please refer to the following sample code:
      // https://github.com/limcheekin/fluwix/blob/main/material_design_showcase/lib/material_design_showcase_screen.dart
      readMe: 'packages/flutter_adaptive_scaffold/README.md',
      codePaths: [
        'packages/flutter_adaptive_scaffold/example/pubspec.yaml',
        'packages/flutter_adaptive_scaffold/example/lib/main.dart',
      ],
      license: 'packages/flutter_adaptive_scaffold/LICENSE',
    );
  }
}
