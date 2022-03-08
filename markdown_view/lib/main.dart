import 'package:flutter/material.dart';
import 'package:common_ui/my_module.dart';
import 'markdown_view_screen.dart';

void main() {
  runApp(
    MyModule(
      title: 'Markdown View',
      home: MarkdownViewScreen(),
    ),
  );
}
