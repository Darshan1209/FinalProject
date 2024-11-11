import 'package:flutter/material.dart';
import 'chemistry_labspage.dart';
import 'biology_labspage.dart';

class BiologyLabsPageRedirect extends StatelessWidget {
  const BiologyLabsPageRedirect({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back arrow
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
            onPressed: () {
              // Navigate to the experiment page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AcidBaseLabsPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green, // Button background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0), // Rounded corners
              ),
              minimumSize: Size(200, 60), // Set button size
            ),
            child: const Text(
              'Click to Navigate to AcidBase Lab',
              style: TextStyle(
                  fontSize: 20, color: Colors.white), // Text color and size
            ),
          ),
        ),
      ),
    );
  }
}
