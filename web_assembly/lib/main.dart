import 'package:flutter/material.dart';
import 'package:common_ui/my_module.dart';
import 'web_assembly_screen.dart';

void main() {
  runApp(
    const MyModule(
      title: 'Web Assembly',
      home: WebAssemblyScreen(),
    ),
  );
}
