import 'package:flutter/material.dart';
import 'package:showcase_view/showcase_view.dart';

import 'sample_circular_page.dart';
import 'sample_linear_page.dart';

class PercentIndicatorShowcaseScreen extends StatelessWidget {
  const PercentIndicatorShowcaseScreen({Key key}) : super(key: key);

  static const owner = 'diegoveloper';
  static const repository = 'flutter_percent_indicator';
  static const branch = 'master';

  @override
  Widget build(BuildContext context) {
    return ShowcaseView(
      title: 'Percent Indicator Showcase',
      widget: PercentIndicatorShowcaseWidget(),
      owner: owner,
      repository: repository,
      ref: branch,
      readMe: 'README.md',
      codePaths: [
        'example/pubspec.yaml',
        'example/lib/sample_circular_page.dart',
        'example/lib/sample_linear_page.dart',
      ],
    );
  }
}

class PercentIndicatorShowcaseWidget extends StatelessWidget {
  const PercentIndicatorShowcaseWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black,
            tabs: <Widget>[
              Tab(
                text: 'Circular',
              ),
              Tab(
                text: 'Linear',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                SampleCircularPage(),
                SampleLinearPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
