import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:showcase_view/showcase_view.dart';

class AnimatedIconsScreen extends StatelessWidget {
  const AnimatedIconsScreen({Key key}) : super(key: key);

  static const owner = 'limcheekin';
  static const repository = 'flutter-widgets-explorer';
  static const branch = 'animated_icons';

  @override
  Widget build(BuildContext context) {
    return ShowcaseView(
      title: 'Animated Icons',
      widget: AnimatedIconsWidget(),
      owner: owner,
      repository: repository,
      ref: branch,
      readMe: '$branch/README.md',
      codePaths: [
        '$branch/pubspec.yaml',
        '$branch/lib/animated_icons_screen.dart',
      ],
    );
  }
}

class AnimatedIconsWidget extends StatefulWidget {
  const AnimatedIconsWidget({Key key}) : super(key: key);

  @override
  _AnimatedIconsWidgetState createState() => _AnimatedIconsWidgetState();
}

class _AnimatedIconsWidgetState extends State<AnimatedIconsWidget> {
  AnimateIconController _controller;
  @override
  void initState() {
    _controller = AnimateIconController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimateIcons(
            startIcon: Icons.copy,
            endIcon: Icons.check,
            size: 100.0,
            controller: _controller,
            // add this tooltip for the start icon
            startTooltip: 'Copy',
            // add this tooltip for the end icon
            endTooltip: 'Copied',
            onEndIconPress: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('onEndIconPress called'),
                  duration: Duration(seconds: 1),
                ),
              );
              return true;
            },
            onStartIconPress: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('onStartIconPress called'),
                  duration: Duration(seconds: 1),
                ),
              );
              return true;
            },
            duration: Duration(milliseconds: 600),
            clockwise: true,
          ),
          IconButton(
            iconSize: 50.0,
            icon: Icon(
              Icons.play_arrow,
            ),
            onPressed: () {
              if (_controller.isStart()) {
                _controller.animateToEnd();
              } else if (_controller.isEnd()) {
                _controller.animateToStart();
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Animate using controller, onPress not called'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
