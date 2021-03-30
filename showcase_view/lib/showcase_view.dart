import 'package:flutter/material.dart';
import 'license_view.dart';
import 'read_me_view.dart';
import 'package:source_code_view/source_code_view.dart';

class ShowcaseView extends StatelessWidget {
  final String title;
  final Widget widget;
  final String owner;
  final String repository;
  final String ref;
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
        SingleChildScrollView(
          child: SourceCodeView(
            owner: owner,
            repository: repository,
            ref: ref,
            paths: codePaths,
          ),
        ),
      if (showLicense)
        SingleChildScrollView(
          child: LicenseView(
            owner: owner,
            repository: repository,
            ref: ref,
            path: license,
          ),
        ),
    ];

    if (additionalTabBarViews != null && additionalTabBarViews.isNotEmpty) {
      tabBarViews.addAll(additionalTabBarViews);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: DefaultTabController(
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
      ),
    );
  }
}
