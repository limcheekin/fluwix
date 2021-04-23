import 'package:flutter/material.dart';
import 'package:showcase_view/showcase_view.dart';
import 'shimmer_effect_widget.dart';

class ShimmerEffectScreen extends StatelessWidget {
  const ShimmerEffectScreen({Key key}) : super(key: key);

  static const owner = 'hnvn';
  static const repository = 'flutter_shimmer';
  static const branch = 'master';

  @override
  Widget build(BuildContext context) {
    return ShowcaseView(
      title: 'Shimmer Effect',
      widget: ShimmerEffectWidget(),
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
