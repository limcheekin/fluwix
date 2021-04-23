import 'package:flutter/material.dart';
import 'package:showcase_view/showcase_view.dart';

import 'chart_data_table_widget.dart';

class ChartDataTableScreen extends StatelessWidget {
  const ChartDataTableScreen({Key key}) : super(key: key);

  static const owner = 'limcheekin';
  static const repository = 'fluwix';
  static const branch = 'chart_data_table';

  @override
  Widget build(BuildContext context) {
    return ShowcaseView(
      title: 'Chart Data Table',
      widget: ChartDataTableWidget(),
      owner: owner,
      repository: repository,
      ref: branch,
      readMe: '$branch/README.md',
      codePaths: [
        '$branch/pubspec.yaml',
        '$branch/lib/chart_data_table_screen.dart',
        '$branch/lib/chart_data_table_widget.dart',
      ],
    );
  }
}
