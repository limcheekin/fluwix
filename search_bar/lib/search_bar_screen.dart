import 'package:flutter/material.dart';
import 'search_bar_widget.dart';
import 'package:showcase_view/showcase_view.dart';

class SearchBarScreen extends StatelessWidget {
  const SearchBarScreen({Key key}) : super(key: key);

  static const owner = 'ResoCoder';
  static const repository = 'flutter-search-bar-tutorial';
  static const branch = 'master';

  @override
  Widget build(BuildContext context) {
    return ShowcaseView(
      title: 'Search Bar',
      widget: SearchBarWidget(),
      owner: owner,
      repository: repository,
      ref: branch,
      readMe: 'README.md',
      showLicense: false,
      codePaths: [
        'pubspec.yaml',
        'lib/main.dart',
      ],
    );
  }
}
