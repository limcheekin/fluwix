import 'package:flutter/material.dart';
import 'package:glassmorphism_design/glassmorphism_design_screen.dart';
import 'package:nested_list/nested_list_screen.dart';
import 'package:neumorphism_design/neumorphism_design_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:percent_indicator_showcase/percent_indicator_showcase_screen.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:rich_text_editor/rich_text_editor_screen.dart';
import 'package:settings_ui_showcase/settings_ui_showcase_screen.dart';
import 'package:showcase_view/showcase_screen.dart';
import 'package:source_code_view/source_code_view_screen.dart';
import 'package:stock_chart/stock_chart_screen.dart';
import 'package:tab_buttons/tab_buttons_screen.dart';
import 'package:material_design_showcase/material_design_showcase_screen.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:about_dialog/about_dialog_screen.dart';
import 'package:animated_icons/animated_icons_screen.dart';
import 'package:chart_data_table/chart_data_table_screen.dart';
import 'package:charts_gallery/charts_gallery_screen.dart';
import 'package:expansion_collapse_view/expansion_collapse_view_screen.dart';
import 'package:markdown_view/markdown_view_screen.dart';
import 'package:shimmer_effect/shimmer_effect_screen.dart';
import 'package:syntax_view/syntax_view_screen.dart';
import 'package:url_launcher_showcase/url_launcher_showcase_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:common_ui/constants.dart';
import 'package:search_bar/search_bar_screen.dart';
import 'package:number_trivia/number_trivia_screen.dart';
import 'package:number_trivia/dependencies.dart' as number_trivia_di;
import 'package:wallet_connect_showcase/wallet_connect_showcase_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_k_chart/generated/l10n.dart' as k_chart;
import 'string.dart';

final AppModule appModule = AppModule();
void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  setPathUrlStrategy();
  number_trivia_di.init();
  runApp(ModularApp(module: appModule, child: const AppWidget()));
  FlutterNativeSplash.remove();
}

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = List.from([
    // ChildRoute(Modular.initialRoute, child: (context, args) => HomeScreen()),
    ChildRoute('/', child: (_, __) => const HomeScreen()),
    ChildRoute('/nested_list', child: (_, __) => NestedListScreen()),
    ChildRoute('/tab_buttons', child: (_, __) => TabButtonsScreen()),
    ChildRoute('/stock_chart', child: (_, __) => StockChartScreen()),
    ChildRoute('/expansion_collapse_view',
        child: (_, __) => const ExpansionCollapseViewScreen()),
    ChildRoute('/charts_gallery',
        child: (_, __) => const ChartsGalleryScreen()),
    ChildRoute('/chart_data_table',
        child: (_, __) => const ChartDataTableScreen()),
    ChildRoute('/syntax_view', child: (_, __) => const SyntaxViewScreen()),

    ChildRoute('/animated_icons',
        child: (_, __) => const AnimatedIconsScreen()),
    ChildRoute('/url_launcher_showcase',
        child: (_, __) => const UrlLauncherShowcaseScreen()),
    ChildRoute('/markdown_view', child: (_, __) => const MarkdownViewScreen()),
    ChildRoute('/shimmer_effect',
        child: (_, __) => const ShimmerEffectScreen()),
    ChildRoute('/about_dialog', child: (_, __) => const AboutDialogScreen()),
    ChildRoute('/source_code_view',
        child: (_, __) => const SourceCodeViewScreen()),
    ChildRoute('/showcase_view', child: (_, __) => const ShowcaseScreen()),
    ChildRoute('/material_design_showcase',
        child: (_, __) => const MaterialDesignShowcaseScreen()),
    ChildRoute('/percent_indicator_showcase',
        child: (_, __) => const PercentIndicatorShowcaseScreen()),
    ChildRoute('/glassmorphism_design',
        child: (_, __) => const GlassmorphismDesignScreen()),
    ChildRoute('/neumorphism_design',
        child: (_, __) => const NeumorphismDesignScreen()),
    ChildRoute('/settings_ui_showcase',
        child: (_, __) => const SettingsUiShowcaseScreen()),
    ChildRoute('/search_bar', child: (_, __) => const SearchBarScreen()),
    ChildRoute('/rich_text_editor',
        child: (_, __) => const RichTextEditorScreen()),
    ChildRoute('/number_trivia', child: (_, __) => const NumberTriviaScreen()),
    ChildRoute('/wallet_connect_showcase',
        child: (_, __) => const WalletConnectShowcaseScreen()),
  ].reversed);
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      localizationsDelegates: const [
        k_chart.S.delegate,
      ],
    ).modular();
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
      const SizedBox(height: 24),
      Text(
        appSubTitle,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    ];

    return AppBar(
      title: const Text(appTitle),
      actions: [
        FutureBuilder<PackageInfo>(
          future: PackageInfo.fromPlatform(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              final packageInfo = snapshot.data;
              return IconButton(
                icon: const Icon(Icons.info_outline),
                onPressed: () {
                  showAboutDialog(
                    context: context,
                    applicationIcon: const Logo(),
                    applicationName: packageInfo.appName,
                    applicationVersion: packageInfo.version,
                    applicationLegalese:
                        '\u{a9} ${DateTime.now().year} Lim Chee Kin',
                    children: aboutBoxChildren,
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

class NarrowLayout extends StatelessWidget {
  final AppBar appBar;
  const NarrowLayout({
    required this.appBar,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: ListView.builder(
        itemCount: appModule.routes.length - 1,
        itemBuilder: (BuildContext context, int index) {
          final routerName = appModule.routes[index].routerName;
          return Card(
            margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            child: ListTile(
              title: Text(routerName.substring(1).toTitleCase()),
              trailing: const Icon(Icons.keyboard_arrow_right),
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
    required this.appBar,
    Key? key,
  }) : super(key: key);

  @override
  _WideLayoutState createState() => _WideLayoutState();
}

class _WideLayoutState extends State<WideLayout> {
  static const corsProxy = 'https://cors.bridged.cc/';
  int _selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      // REF: https://stackoverflow.com/questions/65654632/why-the-scroll-bar-is-missing-in-flutter-web
      body: Row(
        children: [
          SizedBox(
            width: leftNavigationPanelWidth,
            child: ListView.builder(
              itemCount: appModule.routes.length - 1,
              itemBuilder: (BuildContext context, int index) {
                final routerName = appModule.routes[index].routerName;
                return ListTile(
                  title: Text(routerName.substring(1).toTitleCase()),
                  selected: index == _selectedIndex,
                  trailing: index == _selectedIndex
                      ? const Icon(Icons.keyboard_arrow_right)
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
          Expanded(
            child: _selectedIndex == -1
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        corsProxy +
                            'https://flutter-widgets-explorer.netlify.app/images/welcome.png',
                        width: 633.0,
                        height: 475.0,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          text: 'Welcome to Fluwix!\n' + appSubTitle,
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
                : appModule.routes[_selectedIndex].child!(
                    context, ModularArguments.empty()),
          ),
        ],
      ),
    );
  }
}
