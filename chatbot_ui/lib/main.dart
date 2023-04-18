import 'package:flutter/material.dart';
import 'package:common_ui/my_module.dart';
import 'chatbot_ui_screen.dart';

void main() {
  runApp(
    const MyModule(
      title: 'Chatbot Ui',
      home: ChatbotUiScreen(),
    ),
  );
}
