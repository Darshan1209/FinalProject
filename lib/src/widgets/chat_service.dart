import 'dart:developer';

import 'package:apt3065/src/widgets/messageModel.dart';
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
      isRead: false, // Mark the message as unread initially
    );

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());

    await _firestore.collection('chat_rooms').doc(chatRoomId).set({
      'lastMessage': message,
      'lastMessageSender': currentUserEmail,
      'lastMessageTimestamp': timestamp,
      'users': ids,
    }, SetOptions(merge: true));
  }

  Stream<QuerySnapshot> getMessages(String receiverId, String currentUserId) {
    List<String> ids = [receiverId, currentUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  Future<void> markMessageAsRead(String messageId, String chatRoomId) async {
    try {
      await _firestore
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages')
          .doc(messageId)
          .update({'isRead': true});
    } catch (e) {
      log("Error marking message as read: $e");
    }
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
      final chatDocSnapshot =
          await _firestore.collection('chat_rooms').doc(chatId).get();

      if (chatDocSnapshot.exists) {
        return chatDocSnapshot;
      }
    } catch (e) {
      log("Error fetching chat room document: $e");
    }
    return Future.value(null);
  }

// Add a method to mark all messages as read in a chat room
  Future<void> markMessagesAsRead(String chatRoomId) async {
    final currentUserId = _auth.currentUser!.uid;

    final unreadMessagesQuery = _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .where('receiverId', isEqualTo: currentUserId)
        .where('isRead', isEqualTo: false);

    final unreadMessagesSnapshot = await unreadMessagesQuery.get();

    for (var doc in unreadMessagesSnapshot.docs) {
      await doc.reference.update({'isRead': true});
    }
  }

  Future<String?> fetchUserProfileImage(String userId) async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('userProfile')
          .doc(userId)
          .get();
      if (userDoc.exists) {
        return userDoc.data()?[
            'imageLink']; // Ensure the 'imageLink' key matches your Firestore field
      }
    } catch (e) {
      log('Error fetching user profile image: $e');
    }
    return null;
  }
}
