import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:showcase_view/showcase_screen.dart';
import 'package:source_code_view/source_code_view_screen.dart';

import 'about/about_screen.dart';
import 'animate_icons/animate_icons_screen.dart';
import 'chart_datatable/chart_datatable_screen.dart';
import 'charts/charts_screen.dart';
import 'expansion_collapse_view/expansion_collapse_view_screen.dart';
import 'markdown/markdown_screen.dart';
import 'nested_list/nested_list_screen.dart';
import 'shimmer/shimmer_effect_screen.dart';
import 'stock_chart/stock_chart_screen.dart';
import 'syntax_view/syntax_view_screen.dart';
import '../tab_buttons/lib/tab_buttons_screen.dart';
import 'url_launcher/url_launcher_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> names = [
      'Nested List',
      'Tab Buttons',
      'Stock Chart',
      'Expansion/Collapse View',
      'Charts Gallery',
      'Chart & Data Table',
      'Syntax View',
      'Animate Icons',
      'URL Launcher',
      'Markdown View',
      'Shimmer Effect',
      'About Dialog',
      'Source Code View',
      'Showcase View',
    ];

    final List<Widget> aboutBoxChildren = <Widget>[
      SizedBox(height: 24),
      Text(
        'Learn, test and showcase flutter widgets in one application.',
        style: Theme.of(context).textTheme.bodyText2,
      ),
    ];

    return MaterialApp(
      title: "Flutter Widgets Explorer",
      home: Scaffold(
          appBar: AppBar(
            title: Text('Flutter Widgets'),
            actions: [
              FutureBuilder<PackageInfo>(
                future: PackageInfo.fromPlatform(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    final packageInfo = snapshot.data;
                    return IconButton(
                      icon: Icon(Icons.info_outline),
                      onPressed: () {
                        showAboutDialog(
                          context: context,
                          applicationIcon: Logo(),
                          applicationName: packageInfo.appName,
                          applicationVersion: packageInfo.version,
                          applicationLegalese:
                              '\u{a9} ${DateTime.now().year} Lim Chee Kin',
                          children: aboutBoxChildren,
                        );
                      },
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ],
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
                        case 8:
                          _gotoScreen(context, UrlLauncherScreen());
                          break;
                        case 9:
                          _gotoScreen(context, MarkdownScreen());
                          break;
                        case 10:
                          _gotoScreen(context, ShimmerEffectScreen());
                          break;
                        case 11:
                          _gotoScreen(context, AboutScreen());
                          break;
                        case 12:
                          _gotoScreen(context, SourceCodeViewScreen());
                          break;
                        case 13:
                          _gotoScreen(context, ShowcaseScreen());
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
