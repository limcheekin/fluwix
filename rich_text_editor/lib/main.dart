import 'package:flutter/material.dart';
import 'package:common_ui/my_module.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'rich_text_editor_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Rich Text Editor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RichTextEditorScreen(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
      ],
    ),
  );
}
