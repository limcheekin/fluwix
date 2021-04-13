import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
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
  static const GITHUB_URL = 'https://github.com/';

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
      Container(
        color: Colors.white,
        child: widget,
      ),
      if (showReadMe)
        ReadMeView(
          owner: owner,
          repository: repository,
          ref: ref,
          path: readMe,
        ),
      if (showCode)
        Scrollbar(
          isAlwaysShown: kIsWeb,
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
        LicenseView(
          owner: owner,
          repository: repository,
          ref: ref,
          path: license,
        ),
    ];

    if (additionalTabBarViews != null && additionalTabBarViews.isNotEmpty) {
      tabBarViews.addAll(additionalTabBarViews);
    }

    return DefaultTabController(
      length: tabs.length,
      child: getValueForScreenType<bool>(
        context: context,
        mobile: true,
        tablet: false,
      )
          ? Scaffold(
              appBar: AppBar(
                leading: !kIsWeb
                    ? IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () => Modular.to.navigate(fromRouteName),
                      )
                    : null,
                bottom: TabBar(
                  isScrollable: true,
                  tabs: tabs,
                ),
                title: Text(title),
              ),
              body: TabBarView(
                children: tabBarViews,
              ),
            )
          : Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                bottom: TabBar(
                  isScrollable: true,
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.black,
                  tabs: tabs,
                ),
                title: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.black,
                        ),
                      ),
                      Link(
                        uri: Uri.parse(GITHUB_URL + owner),
                        builder:
                            (BuildContext context, FollowLink followLink) =>
                                Row(
                          children: [
                            Text(
                              'By ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13.0,
                              ),
                            ),
                            TextButton(
                              onPressed: followLink,
                              child: Text(
                                owner,
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                  fontSize: 13.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                backgroundColor: Colors.white,
              ),
              body: TabBarView(
                children: tabBarViews,
              ),
            ),
    );
  }
}
