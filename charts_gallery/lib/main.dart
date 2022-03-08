import 'package:flutter/material.dart';
import 'package:common_ui/my_module.dart';
import 'charts_gallery_screen.dart';

void main() {
  runApp(
    MyModule(
      title: 'Charts Gallery',
      home: ChartsGalleryScreen(),
    ),
  );
}
