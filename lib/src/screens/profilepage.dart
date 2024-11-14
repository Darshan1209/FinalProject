import 'package:apt3065/src/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? _user; // Store user details
  Map<String, dynamic>? _userData; // Store user data from Firestore

  @override
  void initState() {
    super.initState();
    _getUserDetails(); // Fetch user details when the profile page initializes
  }

  Future<void> _getUserDetails() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user != null) {
        setState(() {
          _user = user;
        });

        // Fetch user data from Firestore
        DocumentSnapshot userDoc = await firebaseFireStore.collection('userProfile').doc(user.uid).get();
        if (userDoc.exists) {
          setState(() {
            _userData = userDoc.data() as Map<String, dynamic>?; // Update with user data
          });
        } else {
          print('No user data found in Firestore.');
        }
      }
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }

  Future<void> _showLogoutConfirmation() async {
    final shouldLogout = await Get.dialog<bool>(
      AlertDialog(
        title: Text("Confirm Logout"),
        content: Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false), // Cancel
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Get.back(result: true), // Confirm
            child: Text("Logout"),
          ),
        ],
      ),
    );
    if (shouldLogout == true) {
      await signOut();
    }
  }

  Future<void> signOut() async {
    try {
      print("Logging out");
      await firebaseAuth.signOut();
      print("Logged Out");
      Get.offNamed('/LoginPage');
    } catch (e) {
      print("Error logging out: $e");
      Get.snackbar("Error", "Failed to log out. Please try again.",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GeneralAppColors.mainColor,
        title: Text(
          'Profile Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: _user != null // Check if user details are available
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Profile Picture
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: _userData?['imageLink'] != null
                            ? NetworkImage(_userData!['imageLink']) // Use 'imageLink' here
                            : AssetImage('assets/images/profile_icon.png') as ImageProvider,
                      ),
                    ),

                    SizedBox(height: 20),
                    // User Information
                    _buildDetailCard('Name', _userData?['name'] ?? 'N/A'),
                    _buildDetailCard('Education Level', _userData?['eduLevel'] ?? 'N/A'), // Display education level
                    _buildDetailCard('Email', _user!.email ?? 'N/A'),
                    _buildDetailCard('Phone', _userData?['phoneNum'] ?? 'N/A'),
                    
                    Spacer(), // Add spacer to push sign out button to the bottom
                    Center(child: _buildSignOutButton()), // Centered sign out button
                  ],
                )
              : CircularProgressIndicator(), // Show a loading indicator while fetching user details
        ),
      ),
    );
  }

  Widget _buildDetailCard(String label, String value) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4.0,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        title: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
        subtitle: Text(
          value,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }

  Widget _buildSignOutButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: _showLogoutConfirmation,
        style: ElevatedButton.styleFrom(
          backgroundColor: GeneralAppColors.mainColor, // Customize button color
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 12.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        child: Text(
          'Sign out',
          style: TextStyle(
              fontSize: 15,
              fontFamily: "Balsamiq Sans",
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 228, 228, 228)),
        ),
      ),
    );
  }
}
