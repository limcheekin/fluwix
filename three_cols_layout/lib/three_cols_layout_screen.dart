import 'package:flutter/material.dart';
import 'package:showcase_view/showcase_view.dart';
import 'package:three_cols_layout/three_cols_layout_widget.dart';

class ThreeColsLayoutScreen extends StatelessWidget {
  const ThreeColsLayoutScreen({super.key});

  // Configure the properties for external GitHub repo, for example:
  // https://github.com/miquelbeltran/flutter_material_showcase
  // owner = 'miquelbeltran';
  // repository = 'flutter_material_showcase';
  // branch = 'master';
  static const owner = 'limcheekin';
  static const repository = 'fluwix';
  static const branch = 'three_cols_layout';

  @override
  Widget build(BuildContext context) {
    return const ShowcaseView(
      title: 'Three Cols Layout',
      widget: ThreeColsLayoutWidget(),
      owner: owner,
      repository: repository,
      ref: branch,
      // $branch/ prefix is not needed for external GitHub repo
      // Please refer to the following sample code:
      // https://github.com/limcheekin/fluwix/blob/main/material_design_showcase/lib/material_design_showcase_screen.dart
      readMe: '$branch/README.md',
      codePaths: [
        '$branch/pubspec.yaml',
        '$branch/lib/three_cols_layout_screen.dart',
      ],
    );
  }
}
