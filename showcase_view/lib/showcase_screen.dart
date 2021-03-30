import 'package:flutter/material.dart';

import 'showcase.dart';

class ShowcaseScreen extends StatelessWidget {
  static const owner = 'limcheekin';
  static const repository = 'flutter-widgets-explorer';
  static const branch = 'showcase_view';

  const ShowcaseScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Showcase'),
      ),
      body: Showcase(
        widget: Center(
          child: Text('This is your widget.'),
        ),
        owner: owner,
        repository: repository,
        ref: branch,
        readMe: 'showcase_view/README.md',
        codePaths: [
          'showcase_view/pubspec.yaml',
          'showcase_view/lib/main.dart',
          'common_ui/lib/my_module.dart',
          'showcase_view/lib/showcase_screen.dart',
          'showcase_view/lib/showcase.dart',
          'showcase_view/lib/read_me_view.dart',
          'showcase_view/lib/license_view.dart',
        ],
        additionalTabs: [
          Tab(text: 'Car'),
          Tab(text: 'Transit'),
          Tab(text: 'Bike'),
        ],
        additionalTabBarViews: [
          Icon(Icons.directions_car),
          Icon(Icons.directions_transit),
          Icon(Icons.directions_bike),
        ],
      ),
    );
  }
}
