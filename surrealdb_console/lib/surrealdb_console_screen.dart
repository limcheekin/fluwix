import 'package:flutter/material.dart';
import 'package:showcase_view/showcase_view.dart';
import 'package:surrealdb_console/surrealdb_console_widget_mobile.dart'
    if (dart.library.html) 'package:surrealdb_console/surrealdb_console_widget_web.dart';

class SurrealdbConsoleScreen extends StatelessWidget {
  const SurrealdbConsoleScreen({super.key});

  // Configure the properties for external GitHub repo, for example:
  // https://github.com/miquelbeltran/flutter_material_showcase
  // owner = 'miquelbeltran';
  // repository = 'flutter_material_showcase';
  // branch = 'master';
  static const owner = 'limcheekin';
  static const repository = 'fluwix';
  static const branch = 'surrealdb_console';

  @override
  Widget build(BuildContext context) {
    return const ShowcaseView(
      title: 'SurrealDB Console',
      widget: SurrealdbConsoleWidget(),
      owner: owner,
      repository: repository,
      ref: branch,
      // $branch/ prefix is not needed for external GitHub repo
      // Please refer to the following sample code:
      // https://github.com/limcheekin/fluwix/blob/main/material_design_showcase/lib/material_design_showcase_screen.dart
      readMe: '$branch/README.md',
      codePaths: [
        '$branch/pubspec.yaml',
        '$branch/lib/surrealdb_console_screen.dart',
        '$branch/lib/surrealdb_console_widget.dart',
      ],
    );
  }
}
