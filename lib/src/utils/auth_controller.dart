import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthController with ChangeNotifier {
//Within this section, you can integrate authentication methods
//such as Firebase, SharedPreferences, and more.

  bool isLoggedIn = false;

  void signIn() {
    isLoggedIn = true;
    notifyListeners();
  }

  void signOut() {
    isLoggedIn = false;
    notifyListeners();
  }
}

final authProvider = ChangeNotifierProvider((ref) => AuthController());
