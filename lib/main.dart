import 'package:flutter/material.dart';
import 'package:nested_list/nested_list_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:showcase_view/showcase_screen.dart';
import 'package:source_code_view/source_code_view_screen.dart';
import 'package:stock_chart/stock_chart_screen.dart';
import 'package:tab_buttons/tab_buttons_screen.dart';
import 'package:material_design_showcase/material_design_showcase_screen.dart';
import 'about/about_screen.dart';
import 'package:animated_icons/animated_icons_screen.dart';
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
    ChildRoute('/animated_icons', child: (_, __) => AnimatedIconsScreen()),
    ChildRoute('/url_launcher', child: (_, __) => UrlLauncherScreen()),
    ChildRoute('/markdown_view', child: (_, __) => MarkdownScreen()),
    ChildRoute('/shimmer_effect', child: (_, __) => ShimmerEffectScreen()),
    ChildRoute('/about_dialog', child: (_, __) => AboutScreen()),
    ChildRoute('/source_code_view', child: (_, __) => SourceCodeViewScreen()),
    ChildRoute('/showcase_view', child: (_, __) => ShowcaseScreen()),
    ChildRoute('/material_design_showcase',
        child: (_, __) => MaterialDesignShowcaseScreen()),
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
  @override
  Widget build(BuildContext context) {
    final appBar = _buildAppBar(context);
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => NarrowLayout(appBar: appBar),
      tablet: (BuildContext context) => NarrowLayout(appBar: appBar),
      desktop: (BuildContext context) => WideLayout(appBar: appBar),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    final aboutBoxChildren = <Widget>[
      SizedBox(height: 24),
      Text(
        'Learn and showcase Flutter Widgets in one application.',
        style: Theme.of(context).textTheme.bodyText2,
      ),
    ];

    return AppBar(
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
    );
  }
}

class NarrowLayout extends StatelessWidget {
  final AppBar appBar;
  const NarrowLayout({
    @required this.appBar,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: ListView.builder(
        itemCount: appModule.routes.length - 1,
        itemBuilder: (BuildContext context, int index) {
          final routerName = appModule.routes[index + 1].routerName;
          return Card(
            margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
            child: ListTile(
              title: Text(routerName.substring(1).toTitleCase()),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () => Modular.to.navigate(routerName),
            ),
          );
        },
      ),
    );
  }
}

class WideLayout extends StatefulWidget {
  final AppBar appBar;
  const WideLayout({
    @required this.appBar,
    Key key,
  }) : super(key: key);

  @override
  _WideLayoutState createState() => _WideLayoutState();
}

class _WideLayoutState extends State<WideLayout> {
  int _selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      // REF: https://stackoverflow.com/questions/65654632/why-the-scroll-bar-is-missing-in-flutter-web
      body: Row(
        children: [
          SizedBox(
            width: 280.0,
            child: Scrollbar(
              isAlwaysShown: true,
              child: ListView.builder(
                itemCount: appModule.routes.length - 1,
                itemBuilder: (BuildContext context, int index) {
                  final routerName = appModule.routes[index + 1].routerName;
                  return ListTile(
                    title: Text(routerName.substring(1).toTitleCase()),
                    selected: index == _selectedIndex,
                    trailing: index == _selectedIndex
                        ? Icon(Icons.keyboard_arrow_right)
                        : null,
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: _selectedIndex == -1
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                          'https://flutter-widgets-explorer.netlify.app/welcome.png'),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Welcome to Flutter Widgets Explorer!',
                          style: TextStyle(fontSize: 28.0),
                          children: <TextSpan>[
                            TextSpan(
                              text: '\n\nPlease select a showcase on the left',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : appModule.routes[_selectedIndex + 1].child(context, null),
          ),
        ],
      ),
    );
  }
}
