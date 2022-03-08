import 'package:flutter/material.dart';
import 'package:common_ui/my_module.dart';
import 'syntax_view_screen.dart';

void main() {
  runApp(
    MyModule(
      title: 'Syntax View',
      home: SyntaxViewScreen(),
    ),
  );
}
