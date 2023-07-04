import 'package:flutter/material.dart';
import 'package:common_ui/my_module.dart';
import 'shimmer_effect_screen.dart';

void main() {
  runApp(
    const MyModule(
      title: 'Shimmer Effect',
      home: ShimmerEffectScreen(),
    ),
  );
}
