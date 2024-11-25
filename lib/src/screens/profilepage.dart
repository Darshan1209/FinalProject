import 'package:apt3065/src/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? _user;
  Map<String, dynamic>? _userData;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _eduLevelController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUserDetails();
  }

  Future<void> _getUserDetails() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user != null) {
        setState(() {
          _user = user;
        });

        DocumentSnapshot userDoc = await firebaseFireStore
            .collection('userProfile')
            .doc(user.uid)
            .get();
        if (userDoc.exists) {
          setState(() {
            _userData = userDoc.data() as Map<String, dynamic>?;
            _nameController.text = _userData?['name'] ?? '';
            _eduLevelController.text = _userData?['eduLevel'] ?? '';
            _phoneController.text =
                (_userData?['phoneNum']?.substring(3) != null
                    ? "0" + _userData!['phoneNum']!.substring(3)
                    : "0");
          });
        } else {
          print('No user data found in Firestore.');
        }
      }
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }

  Future<void> _showSaveConfirmation() async {
    final shouldSave = await Get.dialog<bool>(
      AlertDialog(
        title: const Text("Save Changes"),
        content: const Text("Do you want to save the changes?"),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false), // Cancel
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Get.back(result: true), // Confirm
            child: const Text("Save"),
          ),
        ],
      ),
    );
    if (shouldSave == true) {
      await _saveChanges();
    }
  }

  Future<void> _saveChanges() async {
    try {
      await firebaseFireStore.collection('userProfile').doc(_user!.uid).update({
        'name': _nameController.text,
        'eduLevel': _eduLevelController.text,
        'phoneNum': _phoneController.text,
      });
      Get.snackbar("Success", "Profile updated successfully!",
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      print("Error updating profile: $e");
      Get.snackbar("Error", "Failed to save changes. Please try again.",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> _showLogoutConfirmation() async {
    final shouldLogout = await Get.dialog<bool>(
      AlertDialog(
        title: const Text("Confirm Logout"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false), // Cancel
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Get.back(result: true), // Confirm
            child: const Text("Logout"),
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
      await firebaseAuth.signOut();
      Get.offNamed('/LoginPage');
    } catch (e) {
      Get.snackbar("Error", "Failed to log out. Please try again.",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GeneralAppColors.mainColor,
        title: const Text(
          'Profile Page',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Iconsax.save_add,
              color: Colors.white,
            ),
            onPressed: _showSaveConfirmation, // Save confirmation dialog
          ),
        ],
      ),
      body: Center(
        child: _user != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Profile Picture
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _userData?['imageLink'] != null
                          ? NetworkImage(_userData!['imageLink'])
                          : const AssetImage('assets/images/profile_icon.png')
                              as ImageProvider,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Editable User Information
                  _buildEditableCard('Name', _nameController),
                  _buildEditableCard('Education Level', _eduLevelController),
                  _buildEditableCard(
                      'Email', TextEditingController(text: _user!.email),
                      readOnly: true),
                  _buildEditableCard('Phone', _phoneController),

                  const Spacer(),
                  // Save and Sign Out Button Row
                  _buildButtonRow(),
                ],
              )
            : const CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildEditableCard(String label, TextEditingController controller,
      {bool readOnly = false}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      elevation: 4.0,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
        title: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
        subtitle: TextField(
          controller: controller,
          readOnly: readOnly,
          decoration: const InputDecoration(border: InputBorder.none),
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }

  Widget _buildButtonRow() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Save Button
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ElevatedButton(
              onPressed: _showSaveConfirmation, // Save confirmation dialog
              style: ElevatedButton.styleFrom(
                backgroundColor: GeneralAppColors.mainColor,
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 12.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
              ),
              child: const Text(
                'Save',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Balsamiq Sans",
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ),
          // Sign Out Button
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: ElevatedButton(
              onPressed: _showLogoutConfirmation,
              style: ElevatedButton.styleFrom(
                backgroundColor: GeneralAppColors.mainColor,
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 12.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
              ),
              child: const Text(
                'Sign out',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Balsamiq Sans",
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 228, 228, 228)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
