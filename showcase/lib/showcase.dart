import 'package:flutter/material.dart';
import 'package:showcase/license_view.dart';
import 'package:showcase/read_me_view.dart';
import 'package:source_code_view/source_code_view.dart';

class Showcase extends StatelessWidget {
  final Widget widget;
  final String owner;
  final String repository;
  final String ref;
  final String readMe;
  final String license;
  final String pubspecPath;
  final List<String> codePaths;
  final bool isShowDependencies;
  final List<String> showDependencies;
  final bool showReadMe;
  final bool showCode;
  final bool showLicense;
  final List<Widget> additionalTabs;
  final List<Widget> additionalTabBarViews;

  const Showcase({
    @required this.widget,
    @required this.owner,
    @required this.repository,
    @required this.ref,
    this.readMe = 'README.md',
    this.license = 'LICENSE',
    this.pubspecPath = 'pubspec.yaml',
    this.codePaths,
    this.additionalTabs,
    this.additionalTabBarViews,
    this.isShowDependencies = false,
    this.showDependencies,
    this.showReadMe = true,
    this.showCode = true,
    this.showLicense = true,
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
            pubspecPath: pubspecPath,
            paths: codePaths,
            showDependencies: this.showDependencies,
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
