import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:showcase_view/showcase_view.dart';

class TabButtonsScreen extends StatefulWidget {
  TabButtonsScreen({Key key}) : super(key: key);

  @override
  _TabButtonsScreenState createState() => _TabButtonsScreenState();
}

class _TabButtonsScreenState extends State<TabButtonsScreen> {
  static const owner = 'limcheekin';
  static const repository = 'flutter-widgets-explorer';
  static const branch = 'tab_buttons';

  @override
  Widget build(BuildContext context) {
    return ShowcaseView(
      title: 'Tab Buttons',
      widget: TabButtonsWidget(),
      owner: owner,
      repository: repository,
      ref: branch,
      readMe: '$branch/README.md',
      codePaths: [
        '$branch/pubspec.yaml',
        '$branch/lib/main.dart',
        'common_ui/lib/my_module.dart',
        '$branch/lib/tab_buttons_screen.dart',
      ],
    );
  }
}

class TabButtonsWidget extends StatelessWidget {
  const TabButtonsWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 6,
        child: Column(
          children: <Widget>[
            ButtonsTabBar(
              unselectedBackgroundColor: Colors.grey[300],
              unselectedLabelStyle: TextStyle(color: Colors.black),
              labelStyle:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              tabs: [
                Tab(
                  icon: Icon(Icons.directions_car),
                  text: "car",
                ),
                Tab(
                  icon: Icon(Icons.directions_transit),
                  text: "transit",
                ),
                Tab(icon: Icon(Icons.directions_bike)),
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  Center(
                    child: Icon(Icons.directions_car),
                  ),
                  Center(
                    child: Icon(Icons.directions_transit),
                  ),
                  Center(
                    child: Icon(Icons.directions_bike),
                  ),
                  Center(
                    child: Icon(Icons.directions_car),
                  ),
                  Center(
                    child: Icon(Icons.directions_transit),
                  ),
                  Center(
                    child: Icon(Icons.directions_bike),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
