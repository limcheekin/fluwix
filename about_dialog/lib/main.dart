import 'package:flutter/material.dart';
import 'package:common_ui/my_module.dart';
import 'about_dialog_screen.dart';

void main() {
  runApp(
    const MyModule(
      title: 'About Dialog',
      home: AboutDialogScreen(),
    ),
  );
}
