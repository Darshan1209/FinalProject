import 'dart:developer';

import 'package:apt3065/src/utils/firebase_services.dart';
import 'package:apt3065/src/widgets/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'messagingPage.dart'; // Ensure you have this import correct for MessagePage

class UserListPage extends StatelessWidget {
  final ChatService chatService = ChatService();

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(title: const Text('All Users')),
      body: StreamBuilder<QuerySnapshot>(
        stream: chatService.getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data?.docs ?? [];
          final filteredUsers =
              users.where((userDoc) => userDoc.id != currentUserId).toList();

          if (filteredUsers.isEmpty) {
            return const Center(
              child: Text('No other users found.'),
            );
          }

          return ListView.builder(
            itemCount: filteredUsers.length,
            itemBuilder: (context, index) {
              final user = filteredUsers[index].data() as Map<String, dynamic>;
              final userId = filteredUsers[index].id;

              return FutureBuilder<DocumentSnapshot<Object?>>(
                future: chatService.getLastMessage(currentUserId!, userId),
                builder: (context, messageSnapshot) {
                  String lastMessage = 'No messages yet'; // Default message
                  String lastMessageSender = 'You:'; // Default message
                  if (messageSnapshot.hasData && messageSnapshot.data != null) {
                    final messageData =
                        messageSnapshot.data?.data() as Map<String, dynamic>?;
                    // log(messageData.toString());

                    // Get the 'lastMessage' from the document data
                    lastMessage =
                        messageData?['lastMessage'] ?? 'No messages yet';
                    lastMessageSender = messageData?['lastMessageSender'] ==
                            FirebaseAuth.instance.currentUser?.email.toString()
                        ? 'You:'
                        : '';
                  }

                  return ListTile(
                    title: Text(user['name']),
                    subtitle: Text(lastMessage),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MessagePage(
                            receiverUserId: userId,
                            receiverUserEmail: user['email'],
                            receiverUserName: user['name'],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
