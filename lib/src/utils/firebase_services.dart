import 'dart:typed_data';
import 'package:apt3065/src/utils/auth_controller.dart';
import 'package:apt3065/src/widgets/navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseStorage firebaseStorage = FirebaseStorage.instance;
FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class AuthenticationService {
  Future<UserCredential?> loginUser(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      Get.offAll(BottomNavigation());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("Authentication Error", "User not found",
            snackPosition: SnackPosition.BOTTOM);
      } else if (e.code == 'wrong-password') {
        Get.snackbar("Authentication Error", "The password is incorrect",
            snackPosition: SnackPosition.BOTTOM);
      } else if (e.code == 'network-request-failed') {
        Get.snackbar(
            "Network Error", "Please check your connection and try again",
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar("Unknown Error Occurred", e.toString(),
            snackPosition: SnackPosition.BOTTOM);
      }
      return Future.error(e);
    }
    return null;
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      Get.snackbar("Success", "Password reset email sent successfully",
          snackPosition: SnackPosition.BOTTOM);
    } on FirebaseAuthException catch (e) {
      String errorMessage = "An error occurred";
      if (e.code == "user-not-found") {
        errorMessage = "No user with this email exists";
      } else if (e.code == "invalid-email") {
        errorMessage = "Invalid email address";
      } else if (e.code == "too-many-requests") {
        errorMessage = "Too many requests. Please try again later";
      } else if (e.code == "network-request-failed") {
        errorMessage = "Check your connection and try again";
      } else {
        errorMessage = e.toString();
      }
      Get.snackbar("Error", errorMessage, snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = firebaseStorage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String?> signUpUser(
      {required String name,
      required String phoneNum,
      required String email,
      required String password,
      required String confPassword,
      required Uint8List file,
      required String eduLevel}) async {
    try {
      // Create user with email and password
      UserCredential userCred =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Check if user is successfully created and UID is not null
      if (userCred.user != null) {
        String userUID = userCred.user!.uid;

        // Upload image to storage
        String imageURL = await uploadImageToStorage(userUID, file);

        // Create or update user document in Firestore
        DocumentReference userDocRef =
            firebaseFireStore.collection('userProfile').doc(userUID);
        await userDocRef.set({
          'name': name,
          'phoneNum': phoneNum,
          'email': email,
          'imageLink': imageURL,
          'eduLevel': eduLevel,
        });

        Get.snackbar("Success", "$name is successfully added",
            snackPosition: SnackPosition.BOTTOM);

        return null;
      } else {
        // Handle the case where user creation failed
        Get.snackbar("Error", "Failed to create user",
            snackPosition: SnackPosition.BOTTOM);
        return "Failed to create user";
      }
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
      return e.toString();
    } catch (e) {
      // Handle other exceptions
      Get.snackbar("Error", "An unknown error occurred",
          snackPosition: SnackPosition.BOTTOM);
      return "An unknown error occurred";
    }
  }

  signInWithGoogle(WidgetRef ref) async {
    // final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // final credential = GoogleAuthProvider.credential(
    //     accessToken: gAuth.accessToken, idToken: gAuth.idToken);
    // ref.read(authProvider.notifier);
    // print("sasasassaasas ${credential}");
    // if (credential.idToken != null) {
    //   await FirebaseAuth.instance.signInWithCredential(credential);
    //   Get.offNamed('/HomePage');
    // }
    // // return await FirebaseAuth.instance.signInWithCredential(credential);
    // GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await gUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        await FirebaseAuth.instance.signInWithCredential(credential);
        Get.offNamed('/BottomNavigation');
      }
    } catch (e) {
      print("Error");
    }
  }
}
