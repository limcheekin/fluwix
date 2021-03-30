import 'package:flutter/material.dart';
import 'license_view.dart';
import 'read_me_view.dart';
import 'package:source_code_view/source_code_view.dart';

class ShowcaseView extends StatelessWidget {
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
  final List<Widget> additionalTabs;
  final List<Widget> additionalTabBarViews;

  const ShowcaseView({
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
    List<Widget> tabs = [
      Tab(
        text: 'Showcase',
      ),
      if (this.showReadMe)
        Tab(
          text: 'Read Me',
        ),
      if (this.showCode)
        Tab(
          text: 'Code',
        ),
      if (this.showLicense)
        Tab(
          text: 'License',
        ),
    ];

    if (this.additionalTabs != null && this.additionalTabs.isNotEmpty) {
      tabs.addAll(this.additionalTabs);
    }

    List<Widget> tabBarViews = [
      this.widget,
      if (this.showReadMe)
        ReadMeView(
          owner: owner,
          repository: repository,
          ref: ref,
          path: this.readMe,
        ),
      if (this.showCode)
        SingleChildScrollView(
          child: SourceCodeView(
            owner: owner,
            repository: repository,
            ref: ref,
            paths: codePaths,
          ),
        ),
      if (this.showLicense)
        SingleChildScrollView(
          child: LicenseView(
            owner: owner,
            repository: repository,
            ref: ref,
            path: this.license,
          ),
        ),
    ];

    if (this.additionalTabBarViews != null &&
        this.additionalTabBarViews.isNotEmpty) {
      tabBarViews.addAll(this.additionalTabBarViews);
    }

    return DefaultTabController(
      length: tabs.length,
      child: Column(children: [
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
      ]),
    );
  }
}
