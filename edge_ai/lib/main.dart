import 'package:flutter/material.dart';
import 'package:common_ui/my_module.dart';
import 'package:flutter_gemma/flutter_gemma.dart';
import 'edge_ai_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Flutter Gemma (required)
  await FlutterGemma.initialize(enableWebCache: true);

  runApp(
    const MyModule(
      title: 'Edge AI',
      home: EdgeAiScreen(),
    ),
  );
}
