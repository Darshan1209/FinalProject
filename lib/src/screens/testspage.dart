import 'package:apt3065/src/screens/testbiologytopics.dart';
import 'package:apt3065/src/screens/testchemistrytopics.dart';
import 'package:apt3065/src/screens/testphysicstopics.dart';
import 'package:apt3065/src/widgets/chatbutton.dart';
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
      body: Stack(
      children: [ 
      Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: InkWell(
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
                  Colors.green,
                  'assets/images/biology_background.jpg', // Path to your image
                ),
              ),
            ),
            SizedBox(height: 16), // Add some space between cards
            Expanded(
              child: InkWell(
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
                  Colors.blue,
                  'assets/images/chemistry_background.jpg', // Path to your image
                ),
              ),
            ),
            SizedBox(height: 16), // Add some space between cards
            Expanded(
              child: InkWell(
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
                  Colors.orange,
                  'assets/images/physics_background.jpg', // Path to your image
                ),
              ),
            ),
          ],
        ),
      ),
      Positioned(
            bottom: 16.0,
            right: 16.0,
            child: ChatButton(), // Include the chat button
          ),
        ],
      ),
    );
  }

  Card buildCard(String title, Color color, String imagePath) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: color,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (imagePath.isNotEmpty)
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
