import 'package:flutter/material.dart';
import 'package:flutter_material_showcase/flutter_material_showcase.dart';
import 'package:showcase_view/showcase_view.dart';

class MaterialDesignShowcaseScreen extends StatelessWidget {
  const MaterialDesignShowcaseScreen({Key key}) : super(key: key);

  static const owner = 'miquelbeltran';
  static const repository = 'flutter_material_showcase';
  static const branch = 'master';

  @override
  Widget build(BuildContext context) {
    return ShowcaseView(
      title: 'Material Design Showcase',
      widget: MaterialDesignShowcaseWidget(),
      owner: owner,
      repository: repository,
      ref: branch,
      readMe: 'README.md',
      codePaths: [
        'example/lib/main.dart',
      ],
    );
  }
}

class MaterialDesignShowcaseWidget extends StatelessWidget {
  const MaterialDesignShowcaseWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MaterialShowcase(),
      ),
    );
  }
}
