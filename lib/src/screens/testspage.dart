import 'package:apt3065/src/screens/testbiologytopics.dart';
import 'package:apt3065/src/screens/testchemistrytopics.dart';
import 'package:apt3065/src/screens/testphysicstopics.dart';
import 'package:flutter/material.dart';

class TestsPage extends StatefulWidget {
  const TestsPage({Key? key});

  @override
  State<TestsPage> createState() => _TestsPageState();
}

class _TestsPageState extends State<TestsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QUIZZES'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TestBiologyTopicsPage(),
                    ),
                  );
                },
                child: buildCard(
                  'Biology Quizzes',
                  'assets/images/biology_background.jpg',
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TestChemistryTopicsPage(),
                    ),
                  );
                },
                child: buildCard(
                  'Chemistry Quizzes',
                  'assets/images/chemistry_background.jpg',
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TestPhysicsTopicsPage(),
                    ),
                  );
                },
                child: buildCard(
                  'Physics Quizzes',
                  'assets/images/physics_background.jpg',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Card buildCard(String title, String imagePath) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        children: [
          // Background image with rounded corners
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              imagePath,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Gradient overlay for text readability
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.1),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          // Title text with better positioning
          Positioned(
            bottom: 16,
            left: 16,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.6),
                    offset: Offset(1, 1),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
