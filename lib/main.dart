import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'animate_icons/animate_icons_screen.dart';
import 'chart_datatable/chart_datatable_screen.dart';
import 'charts/charts_screen.dart';
import 'expansion_collapse_view/expansion_collapse_view_screen.dart';
import 'syntax_view/syntax_view_screen.dart';
import 'tab_buttons/tab_buttons_screen.dart';

import 'nested_list/nested_list_screen.dart';
import 'stock_chart/stock_chart_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> names = [
      'Nested List',
      'Tab Buttons',
      'Stock Chart',
      "Expansion/Collapse View",
      "Charts Gallery",
      "Chart & Data Table",
      "Syntax View",
      "Animate Icons",
    ];
    return MaterialApp(
      title: "Flutter Widgets Explorer",
      home: Scaffold(
          appBar: AppBar(
            title: Text('Flutter Widgets'),
          ),
          body: Center(
            child: ListView.builder(
              itemCount: names.length,
              itemBuilder: (BuildContext context, int position) {
                var name = names[position];
                return Card(
                  margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
                  child: ListTile(
                    title: Text(name),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      switch (position) {
                        case 0:
                          _gotoScreen(context, NestedListScreen());
                          break;
                        case 1:
                          _gotoScreen(context, TabButtonsScreen());
                          break;
                        case 2:
                          _gotoScreen(context, StockChartScreen());
                          break;
                        case 3:
                          _gotoScreen(context, ExpansionCollapseViewScreen());
                          break;
                        case 4:
                          _gotoScreen(context, ChartsScreen());
                          break;
                        case 5:
                          _gotoScreen(context, ChartDataTableScreen());
                          break;
                        case 6:
                          _gotoScreen(context, SyntaxViewScreen());
                          break;
                        case 7:
                          _gotoScreen(context, AnimateIconsScreen());
                          break;
                        default:
                      }
                    },
                  ),
                );
              },
            ),
          )),
    );
  }

  void _gotoScreen(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => screen,
        settings: RouteSettings(name: '/${screen.runtimeType}'),
      ),
    );
  }
}
