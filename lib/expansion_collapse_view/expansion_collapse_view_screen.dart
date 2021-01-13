import 'package:flutter/material.dart';
import 'expansion_panel_screen.dart';
import 'expansion_tile_screen.dart';

class ExpansionCollapseViewScreen extends StatefulWidget {
  ExpansionCollapseViewScreen({Key key}) : super(key: key);

  @override
  _ExpansionCollapseViewScreenState createState() =>
      _ExpansionCollapseViewScreenState();
}

class _ExpansionCollapseViewScreenState
    extends State<ExpansionCollapseViewScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Expansion/Collapse View"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: "Expansion Tile",
              ),
              Tab(
                text: "Expansion Panel",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ExpansionTileScreen(),
            ExpansionPanelScreen(),
          ],
        ),
      ),
    );
  }
}
