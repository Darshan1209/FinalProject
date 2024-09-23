import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

// final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
//   return FirebaseAuth.instance;
// });

// final userLoggedInProvider = StateProvider<bool>((ref) {
//   try {
//     final firebaseAuth1 = ref.watch(firebaseAuthProvider);
//     print(firebaseAuth1.currentUser?.uid.isEmpty);
//     // Listen to authentication state changes
//     final user = firebaseAuth1.authStateChanges();
//     // if user.runtimeType == User {
//     //   return true;
//     // } else {
//     //   return false;
//     // }
//     // Return true if user is logged in, false otherwise
//     return user != null;
//   } catch (e) {}
//   return true;
// });
