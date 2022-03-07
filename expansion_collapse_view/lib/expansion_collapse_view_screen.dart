import 'package:flutter/material.dart';
import 'package:showcase_view/showcase_view.dart';

import 'expansion_panel_screen.dart';
import 'expansion_tile_screen.dart';

class ExpansionCollapseViewScreen extends StatelessWidget {
  const ExpansionCollapseViewScreen({Key? key}) : super(key: key);

  static const owner = 'limcheekin';
  static const repository = 'fluwix';
  static const branch = 'expansion_collapse_view';

  @override
  Widget build(BuildContext context) {
    return ShowcaseView(
      title: 'Expansion Collapse View',
      widget: ExpansionCollapseViewWidget(),
      owner: owner,
      repository: repository,
      ref: branch,
      readMe: '$branch/README.md',
      codePaths: [
        '$branch/pubspec.yaml',
        '$branch/lib/expansion_collapse_view_screen.dart',
        '$branch/lib/expansion_tile_screen.dart',
        '$branch/lib/expansion_panel_screen.dart',
      ],
    );
  }
}

class ExpansionCollapseViewWidget extends StatelessWidget {
  const ExpansionCollapseViewWidget({Key? key}) : super(key: key);

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
                text: 'Expansion Tile',
              ),
              Tab(
                text: 'Expansion Panel',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                ExpansionTileScreen(),
                ExpansionPanelScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
