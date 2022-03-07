import 'package:flutter/material.dart';
import 'package:common_ui/my_module.dart';
import 'chart_data_table_screen.dart';

void main() {
  runApp(
    MyModule(
      title: 'Chart Data Table',
      home: ChartDataTableScreen(),
    ),
  );
}
