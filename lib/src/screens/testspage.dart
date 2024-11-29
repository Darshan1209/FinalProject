import 'package:apt3065/src/constants/colors.dart';
import 'package:apt3065/src/screens/testbiologytopics.dart';
import 'package:apt3065/src/screens/testchemistrytopics.dart';
import 'package:apt3065/src/screens/testphysicstopics.dart';
import 'package:apt3065/src/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class TestsPage extends StatefulWidget {
  const TestsPage({Key? key});

  @override
  State<TestsPage> createState() => _TestsPageState();
}

class _TestsPageState extends State<TestsPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('QUIZZES'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                    GeneralAppColors.biologyColor,
                    'assets/images/3Dcell.png',
                    'assets/images/biologyavatar.png',
                    width,
                    height),
              ),
            ),
            const SizedBox(height: 16), // Add some space between cards
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TestChemistryTopicsPage(),
                    ),
                  );
                },
                child: buildCard(
                    'Chemistry Quizzes',
                    GeneralAppColors.chemistryColor,
                    'assets/images/periodicTable.png',
                    'assets/images/chemistryavatar.png',
                    width,
                    height),
              ),
            ),
            const SizedBox(height: 16), // Add some space between cards
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
                    GeneralAppColors.physicsColor.withOpacity(0.7),
                    'assets/images/rocket.png',
                    'assets/images/physicsavatar.png',
                    width,
                    height),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card buildCard(String title, Color color, String imagePath,
      String secondImagePath, width, height) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: color,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 4, bottom: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          if (imagePath.isNotEmpty)
            Image.asset(
              imagePath,
              fit: BoxFit.contain,
              alignment: Alignment.centerRight,
            ),
          if (imagePath.isNotEmpty)
            Positioned(
              bottom: -2, // Adjust the position if needed
              left: 40, // Adjust the position if needed
              child: Image.asset(
                secondImagePath,
                width: transformWidth(width, 120), // Reduced width
                height: transformHeight(height, 120), // Reduced height
                fit: BoxFit
                    .cover, // This makes the image stay within the given size
              ),
            ),
        ],
      ),
    );
  }
}
