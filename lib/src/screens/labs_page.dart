import 'package:apt3065/src/constants/colors.dart';
import 'package:apt3065/src/screens/labsbiologytopics.dart';
import 'package:apt3065/src/screens/labschemistrytopics.dart';
import 'package:apt3065/src/screens/labsphysicstopics.dart';
import 'package:apt3065/src/utils/responsive_helper.dart';
import 'package:apt3065/src/widgets/chatbutton.dart';
import 'package:flutter/material.dart';

class LabsPage extends StatelessWidget {
  const LabsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Labs'),
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
                      builder: (context) => LabsBiologyTopicsPage(),
                    ),
                  );
                },
                child: buildCard(
                    'Biology Labs',
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
                      builder: (context) => const LabsChemistryTopicsPage(),
                    ),
                  );
                },
                child: buildCard(
                    'Chemistry Labs',
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
                      builder: (context) => const LabsPhysicsTopicsPage(),
                    ),
                  );
                },
                child: buildCard(
                    'Physics Labs',
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
