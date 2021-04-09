import 'package:flutter/material.dart';
import 'license_view.dart';
import 'read_me_view.dart';
import 'package:source_code_view/source_code_view.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ShowcaseView extends StatelessWidget {
  final String title;
  final Widget widget;
  final String owner;
  final String repository;
  final String ref;
  final String fromRouteName;
  final String readMe;
  final String license;
  final List<String> codePaths;
  final bool showReadMe;
  final bool showCode;
  final bool showLicense;
  final List<Tab> additionalTabs;
  final List<Widget> additionalTabBarViews;

  const ShowcaseView({
    @required this.title,
    @required this.widget,
    @required this.owner,
    @required this.repository,
    @required this.ref,
    this.fromRouteName = '/',
    this.showReadMe = true,
    this.readMe = 'README.md',
    this.showCode = true,
    this.codePaths,
    this.showLicense = true,
    this.license = 'LICENSE',
    this.additionalTabs,
    this.additionalTabBarViews,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabs = [
      Tab(
        text: 'Showcase',
      ),
      if (showReadMe)
        Tab(
          text: 'Read Me',
        ),
      if (showCode)
        Tab(
          text: 'Code',
        ),
      if (showLicense)
        Tab(
          text: 'License',
        ),
    ];

    if (additionalTabs != null && additionalTabs.isNotEmpty) {
      tabs.addAll(additionalTabs);
    }

    final tabBarViews = [
      widget,
      if (showReadMe)
        ReadMeView(
          owner: owner,
          repository: repository,
          ref: ref,
          path: readMe,
        ),
      if (showCode)
        Scrollbar(
          isAlwaysShown: true,
          child: SingleChildScrollView(
            child: SourceCodeView(
              owner: owner,
              repository: repository,
              ref: ref,
              paths: codePaths,
            ),
          ),
        ),
      if (showLicense)
        Scrollbar(
          isAlwaysShown: true,
          child: SingleChildScrollView(
            child: LicenseView(
              owner: owner,
              repository: repository,
              ref: ref,
              path: license,
            ),
          ),
        ),
    ];

    if (additionalTabBarViews != null && additionalTabBarViews.isNotEmpty) {
      tabBarViews.addAll(additionalTabBarViews);
    }

    return getValueForScreenType<bool>(
      context: context,
      mobile: true,
      tablet: false,
    )
        ? Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Modular.to.navigate(fromRouteName),
              ),
              title: Text(title),
            ),
            body: TabPanel(
              tabs: tabs,
              tabBarViews: tabBarViews,
            ),
          )
        : Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 28.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabPanel(
                      tabs: tabs,
                      tabBarViews: tabBarViews,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

class TabPanel extends StatelessWidget {
  const TabPanel({
    Key key,
    @required this.tabs,
    @required this.tabBarViews,
  }) : super(key: key);

  final List<Tab> tabs;
  final List<Widget> tabBarViews;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            isScrollable: true,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black,
            tabs: tabs,
          ),
          Expanded(
            child: TabBarView(
              children: tabBarViews,
            ),
          ),
        ],
      ),
    );
  }
}
