import 'package:flutter/material.dart';
import 'package:common_ui/my_module.dart';
import 'url_launcher_showcase_screen.dart';

void main() {
  runApp(
    MyModule(
      title: 'Url Launcher Showcase',
      home: UrlLauncherShowcaseScreen(),
    ),
  );
}
