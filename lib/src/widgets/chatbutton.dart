import 'package:apt3065/src/screens/chat_page.dart';
import 'package:flutter/material.dart';

class ChatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16.0,
      right: 16.0,
      child: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatPage()),
          );
        },
        label: const Text("Need help!""\nChat with us"),

        icon: const Icon(Icons.chat),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
