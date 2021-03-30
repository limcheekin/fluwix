import 'package:flutter/material.dart';
import 'package:nested_list/nested_list_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:showcase_view/showcase_screen.dart';
import 'package:source_code_view/source_code_view_screen.dart';
import 'package:stock_chart/stock_chart_screen.dart';
import 'package:tab_buttons/tab_buttons_screen.dart';
import 'about/about_screen.dart';
import 'animate_icons/animate_icons_screen.dart';
import 'chart_datatable/chart_datatable_screen.dart';
import 'charts/charts_screen.dart';
import 'expansion_collapse_view/expansion_collapse_view_screen.dart';
import 'markdown/markdown_screen.dart';
import 'shimmer/shimmer_effect_screen.dart';
import 'syntax_view/syntax_view_screen.dart';
import 'url_launcher/url_launcher_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'string.dart';

final AppModule appModule = AppModule();
void main() => runApp(ModularApp(module: appModule, child: AppWidget()));

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    // ChildRoute(Modular.initialRoute, child: (context, args) => HomeScreen()),
    ChildRoute('/', child: (_, __) => HomeScreen()),
    ChildRoute('/nested_list', child: (_, __) => NestedListScreen()),
    ChildRoute('/tab_buttons', child: (_, __) => TabButtonsScreen()),
    ChildRoute('/stock_chart', child: (_, __) => StockChartScreen()),
    ChildRoute('/expansion_collapse_view',
        child: (_, __) => ExpansionCollapseViewScreen()),
    ChildRoute('/charts_gallery', child: (_, __) => ChartsScreen()),
    ChildRoute('/chart_data_table', child: (_, __) => ChartDataTableScreen()),
    ChildRoute('/syntax_view', child: (_, __) => SyntaxViewScreen()),
    ChildRoute('/animate_icons', child: (_, __) => AnimateIconsScreen()),
    ChildRoute('/url_launcher', child: (_, __) => UrlLauncherScreen()),
    ChildRoute('/markdown_view', child: (_, __) => MarkdownScreen()),
    ChildRoute('/shimmer_effect', child: (_, __) => ShimmerEffectScreen()),
    ChildRoute('/about_dialog', child: (_, __) => AboutScreen()),
    ChildRoute('/source_code_view', child: (_, __) => SourceCodeViewScreen()),
    ChildRoute('/showcase_view', child: (_, __) => ShowcaseScreen()),
  ];
}

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Widgets Explorer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    ).modular();
  }
}

class HomeScreen extends StatelessWidget {
  static const String WORD_DELIMITER = '_';

  @override
  Widget build(BuildContext context) {
    final List<Widget> aboutBoxChildren = <Widget>[
      SizedBox(height: 24),
      Text(
        'Learn, test and showcase flutter widgets in one application.',
        style: Theme.of(context).textTheme.bodyText2,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Widgets Explorer'),
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
      body: ListView.builder(
        itemCount: appModule.routes.length - 1,
        itemBuilder: (BuildContext context, int index) {
          final route = appModule.routes[index + 1];
          return Card(
            margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
            child: ListTile(
              title: Text(route.routerName
                  .substring(1)
                  .toTitleCase(wordDelimiter: WORD_DELIMITER)),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () => Modular.to.navigate(route.routerName),
            ),
          );
        },
      ),
    );
  }
}
