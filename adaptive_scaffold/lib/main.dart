import 'package:flutter/material.dart';
import 'package:common_ui/my_module.dart';
import 'adaptive_scaffold_screen.dart';

void main() {
  runApp(
    const MyModule(
      title: 'Adaptive Scaffold',
      home: AdaptiveScaffoldScreen(),
    ),
  );
}
