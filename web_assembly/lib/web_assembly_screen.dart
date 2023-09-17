import 'package:flutter/material.dart';
import 'package:showcase_view/showcase_view.dart';

import 'web_assembly_widget.dart';

class WebAssemblyScreen extends StatelessWidget {
  const WebAssemblyScreen({Key? key}) : super(key: key);

  // Configure the properties for external GitHub repo, for example:
  // https://github.com/miquelbeltran/flutter_material_showcase
  // owner = 'miquelbeltran';
  // repository = 'flutter_material_showcase';
  // branch = 'master';
  static const owner = 'limcheekin';
  static const repository = 'fluwix';
  static const branch = 'web_assembly';

  @override
  Widget build(BuildContext context) {
    return const ShowcaseView(
      title: 'Web Assembly',
      widget: WebAssemblyWidget(),
      owner: owner,
      repository: repository,
      ref: branch,
      // $branch/ prefix is not needed for external GitHub repo
      // Please refer to the following sample code:
      // https://github.com/limcheekin/fluwix/blob/main/material_design_showcase/lib/material_design_showcase_screen.dart
      readMe: '$branch/README.md',
      codePaths: [
        '$branch/pubspec.yaml',
        '$branch/lib/web_assembly_screen.dart',
        '$branch/lib/web_assembly_widget.dart',
      ],
    );
  }
}
