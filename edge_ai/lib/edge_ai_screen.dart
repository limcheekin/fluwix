import 'package:edge_ai/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:showcase_view/showcase_view.dart';

class EdgeAiScreen extends StatelessWidget {
  const EdgeAiScreen({super.key});

  // Configure the properties for external GitHub repo, for example:
  // https://github.com/miquelbeltran/flutter_material_showcase
  // owner = 'miquelbeltran';
  // repository = 'flutter_material_showcase';
  // branch = 'master';
  static const owner = 'limcheekin';
  static const repository = 'fluwix';
  static const branch = 'edge_ai';

  @override
  Widget build(BuildContext context) {
    return const ShowcaseView(
      title: 'Edge AI',
      widget: EdgeAiWidget(),
      owner: owner,
      repository: repository,
      ref: branch,
      // $branch/ prefix is not needed for external GitHub repo
      // Please refer to the following sample code:
      // https://github.com/limcheekin/fluwix/blob/main/material_design_showcase/lib/material_design_showcase_screen.dart
      readMe: '$branch/README.md',
      codePaths: [
        '$branch/pubspec.yaml',
        '$branch/lib/edge_ai_screen.dart',
      ],
    );
  }
}

class EdgeAiWidget extends StatelessWidget {
  const EdgeAiWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Edge AI',
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      themeMode: ThemeMode.dark,
      home: const SafeArea(child: HomeScreen()),
    );
  }
}
