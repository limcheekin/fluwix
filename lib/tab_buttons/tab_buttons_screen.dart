import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';

class TabButtonsScreen extends StatefulWidget {
  TabButtonsScreen({Key key}) : super(key: key);

  @override
  _TabButtonsScreenState createState() => _TabButtonsScreenState();
}

class _TabButtonsScreenState extends State<TabButtonsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tab Buttons'),
      ),
      body: SafeArea(
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
      ),
    );
  }
}
