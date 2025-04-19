import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'messagingPage.dart';
import 'package:apt3065/src/widgets/chat_service.dart';

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

              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('userProfile')
                    .doc(userId)
                    .get(),
                builder: (context, profileSnapshot) {
                  if (profileSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return ListTile(
                      leading: Container(
                        height: 68,
                        padding: EdgeInsets.only(bottom: 18),
                        child: CircleAvatar(
                          radius: 25,
                        ),
                      ),
                      title: Text('Loading...'),
                    );
                  }
                  if (profileSnapshot.hasError || !profileSnapshot.hasData) {
                    return ListTile(
                      leading: const Icon(Icons.error),
                      title: Text(user['name']),
                      subtitle: const Text('Error loading profile.'),
                    );
                  }

                  final profileData =
                      profileSnapshot.data?.data() as Map<String, dynamic>?;
                  final imageUrl = profileData?['imageLink'];

                  return FutureBuilder<DocumentSnapshot<Object?>>(
                    future: chatService.getLastMessage(currentUserId!, userId),
                    builder: (context, messageSnapshot) {
                      String lastMessage = 'No messages yet'; // Default message
                      String lastMessageSender = 'You:'; // Default prefix
                      if (messageSnapshot.hasData &&
                          messageSnapshot.data != null) {
                        final messageData = messageSnapshot.data?.data()
                            as Map<String, dynamic>?;
                        lastMessage =
                            messageData?['lastMessage'] ?? 'No messages yet';
                        lastMessageSender = messageData?['lastMessageSender'] ==
                                FirebaseAuth.instance.currentUser?.email
                            ? 'You:'
                            : '';
                      }

                      return ListTile(
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundImage: imageUrl != null
                              ? CachedNetworkImageProvider(imageUrl)
                              : const AssetImage('assets/images/profile.png')
                                  as ImageProvider<Object>,
                        ),
                        title: Text(user['name']),
                        subtitle: Text(
                            '$lastMessageSender $lastMessage'), // Last message with sender prefix
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
          );
        },
      ),
    );
  }
}
