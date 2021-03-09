import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';

class AnimateIconsScreen extends StatefulWidget {
  const AnimateIconsScreen({Key key}) : super(key: key);

  @override
  _AnimateIconsScreenState createState() => _AnimateIconsScreenState();
}

class _AnimateIconsScreenState extends State<AnimateIconsScreen> {
  AnimateIconController _controller;
  @override
  void initState() {
    _controller = AnimateIconController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animate Icons"),
      ),
      body: Builder(builder: (context) {
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
                      content: Text("onEndIconPress called"),
                      duration: Duration(seconds: 1),
                    ),
                  );
                  return true;
                },
                onStartIconPress: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("onStartIconPress called"),
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
                      content:
                          Text("Animate using controller, onPress not called"),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
