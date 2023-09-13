import 'package:flutter/material.dart';

class MessagePanelWidget extends StatelessWidget {
  final Icon? icon;
  final String message;

  const MessagePanelWidget({super.key, this.icon, required this.message});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0, // Add a subtle shadow
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: icon,
              ),
            Text(
              message,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
