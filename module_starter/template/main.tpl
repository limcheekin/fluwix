import 'package:flutter/material.dart';
import 'package:common_ui/my_module.dart';
import 'module_name_screen.dart';

void main() {
  runApp(
    MyModule(
      title: 'Module Name',
      home: ModuleNameScreen(),
    ),
  );
}
