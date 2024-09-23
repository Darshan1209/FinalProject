import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User? _user; // Store user details

  @override
  void initState() {
    super.initState();
    _getUserDetails(); // Fetch user details when the profile page initializes
  }

  Future<void> _getUserDetails() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      setState(() {
        _user = user; // Set the user details in the state
      });
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Profile'),
      ),
      body: Center(
        child: _user != null // Check if user details are available
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Add spacer to push sign out button to the bottom
                  Center(
                      child: _buildSignOutButton()), // Centered sign out button
                ],
              )
            : CircularProgressIndicator(), // Show a loading indicator while fetching user details
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 8.0),
          Text(
            value,
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  Widget _buildSignOutButton() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () async {
          await signOut();
        },
        child: Text('Sign out'),
      ),
    );
  }

  Future<void> signOut() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    print("Logging out");
    await firebaseAuth.signOut();
    print("Logged Out");

    Get.offNamed('/LoginPage');
  }
}
