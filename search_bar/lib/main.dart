import 'package:flutter/material.dart';
import 'package:common_ui/my_module.dart';
import 'search_bar_screen.dart';

void main() {
  runApp(
    MyModule(
      title: 'Search Bar',
      home: SearchBarScreen(),
    ),
  );
}
