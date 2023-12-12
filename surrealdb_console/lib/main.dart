import 'package:flutter/material.dart';
import 'package:common_ui/my_module.dart';
import 'surrealdb_console_screen.dart';

void main() {
  runApp(
    const MyModule(
      title: 'SurrealDB Console',
      home: SurrealdbConsoleScreen(),
    ),
  );
}
