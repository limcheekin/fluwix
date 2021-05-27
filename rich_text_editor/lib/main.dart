import 'package:flutter/material.dart';
import 'package:common_ui/my_module.dart';
import 'rich_text_editor_screen.dart';

void main() {
  runApp(
    MyModule(
      title: 'Rich Text Editor',
      home: RichTextEditorScreen(),
    ),
  );
}
