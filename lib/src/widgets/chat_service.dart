import 'dart:developer';

import 'package:apt3065/src/widgets/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = _auth.currentUser?.uid ?? '';
    final String currentUserEmail = _auth.currentUser?.email ?? '';
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
    );

    // Construct the chat room ID
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    // Add the new message to the chat room database
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());

    // Update the lastMessage field in the chat room document
    await _firestore.collection('chat_rooms').doc(chatRoomId).set({
      'lastMessage': message,
      'lastMessageSender': currentUserEmail,
      'lastMessageTimestamp': timestamp,
      'users': ids,
    }, SetOptions(merge: true));
  }

  Stream<QuerySnapshot> getMessages(String receiverId, String otherUserUid) {
    List<String> ids = [otherUserUid, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');
    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  // Get a list of all users from the userProfile collection
  Stream<QuerySnapshot> getAllUsers() {
    return _firestore.collection('userProfile').snapshots();
  }

  Future<DocumentSnapshot<Object?>>? getLastMessage(
      String currentUserId, String otherUserId) async {
    final chatId = currentUserId.compareTo(otherUserId) < 0
        ? '$currentUserId' '_' '$otherUserId'
        : '$otherUserId' '_' '$currentUserId';
    log(chatId);

    try {
      final chatDocSnapshot = await _firestore
          .collection('chat_rooms')
          .doc(chatId)
          .get(); // Get the chat document

      log("A");
      log(chatDocSnapshot.data().toString());

      if (chatDocSnapshot.exists) {
        return chatDocSnapshot;
      }
    } catch (e) {
      log("Error fetching chat room document: $e");
    }
    // Return null in case of failure to find chat
    return Future.value(null);
  }
}
