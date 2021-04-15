import 'package:flutter/material.dart';
import 'package:showcase_view/showcase_view.dart';
import 'shimmer_effect_widget.dart';

class ShimmerEffectScreen extends StatelessWidget {
  const ShimmerEffectScreen({Key key}) : super(key: key);

  static const owner = 'limcheekin';
  static const repository = 'flutter-widgets-explorer';
  static const branch = 'shimmer_effect';

  @override
  Widget build(BuildContext context) {
    return ShowcaseView(
      title: 'Shimmer Effect',
      widget: ShimmerEffectWidget(),
      owner: owner,
      repository: repository,
      ref: branch,
      readMe: '$branch/README.md',
      codePaths: [
        '$branch/pubspec.yaml',
        '$branch/lib/shimmer_effect_screen.dart',
        '$branch/lib/shimmer_effect_widget.dart',
      ],
    );
  }
}
