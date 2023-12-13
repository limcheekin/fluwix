import 'package:flutter/material.dart';
import 'package:common_ui/my_module.dart';
import 'rich_text_editor_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MyModule(
      title: 'Rich Text Editor',
      home: RichTextEditorScreen(),
    ),
  );
}
