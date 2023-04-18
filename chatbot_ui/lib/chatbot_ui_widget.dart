import 'providers/models_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/chats_provider.dart';
import 'screens/chat_screen.dart';

class ChatbotUiWidget extends StatelessWidget {
  const ChatbotUiWidget({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ModelsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
      ],
      child: const ChatScreen(),
    );
  }
}
