import 'package:flutter/material.dart';
import 'package:showcase_view/showcase_view.dart';

import 'list_item.dart';

class NestedListScreen extends StatefulWidget {
  NestedListScreen({Key? key}) : super(key: key);

  @override
  _NestedListScreenState createState() => _NestedListScreenState();
}

class _NestedListScreenState extends State<NestedListScreen> {
  static const owner = 'limcheekin';
  static const repository = 'fluwix';
  static const branch = 'nested_list';

  final List<Map<String, Object>> nestedListData = [
    {
      'size': Null,
      'data': ['1.0', '1.1', '1.2', '1.3', '1.4', '1.5', '1.6'],
    },
    {
      'size': Null,
      'data': [
        '2.0',
        '2.1',
        '2.2',
        '2.3',
        '2.4',
        '2.5',
        '2.6',
        '2.7',
        '2.8',
        '2.9',
        '2.10'
      ],
    },
    {
      'size': Null,
      'data': ['3.0', '3.1', '3.2', '3.3', '3.4', '3.5', '3.6', '3.7', '3.8'],
    },
    {
      'size': Null,
      'data': ['4.0', '4.1', '4.2', '4.3', '4.4', '4.5', '4.6', '4.7'],
    },
    {
      'size': Null,
      'data': [
        '5.0',
        '5.1',
        '5.2',
        '5.3',
        '5.4',
        '5.5',
        '5.6',
        '5.7',
        '5.8',
        '5.9',
        '5.10',
        '5.11'
      ],
    },
    {
      'size': Null,
      'data': ['6.0', '6.1', '6.2', '6.3', '6.4', '6.5', '6.6', '6.7', '6.8'],
    },
    {
      'size': Null,
      'data': ['7.0', '7.1', '7.2', '7.3', '7.4', '7.5', '7.6', '7.7'],
    },
    {
      'size': Null,
      'data': [
        '8.0',
        '8.1',
        '8.2',
        '8.3',
        '8.4',
        '8.5',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ShowcaseView(
      title: 'Nested List',
      widget: _buildMainList(),
      owner: owner,
      repository: repository,
      ref: branch,
      readMe: '$branch/README.md',
      codePaths: [
        '$branch/pubspec.yaml',
        '$branch/lib/main.dart',
        'common_ui/lib/my_module.dart',
        '$branch/lib/nested_list_screen.dart',
        '$branch/lib/list_item.dart',
        '$branch/lib/horizontal_list.dart',
        '$branch/lib/content_card.dart',
      ],
    );
  }

  Widget _buildMainList() {
    print('_buildMainList()');
    return ListView.builder(
        itemCount: nestedListData.length,
        itemBuilder: (BuildContext content, int index) {
          return ListItem(
            nestedListData,
            index,
            //key: ValueKey(index),
          );
        });
  }
}
