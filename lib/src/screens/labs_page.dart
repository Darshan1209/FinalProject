import 'package:apt3065/src/screens/labsbiologytopics.dart';
import 'package:apt3065/src/screens/labschemistrytopics.dart';
import 'package:apt3065/src/screens/labsphysicstopics.dart';
import 'package:apt3065/src/widgets/chatbutton.dart';
import 'package:flutter/material.dart';

class LabsPage extends StatelessWidget {
  const LabsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Labs'),
      ),
      body: Padding(
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
                      builder: (context) => LabsBiologyTopicsPage(),
                    ),
                  );
                },
                child: buildCard(
                  'Biology Labs',
                  Colors.green,
                  'assets/images/3Dcell.png',
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
                      builder: (context) => LabsChemistryTopicsPage(),
                    ),
                  );
                },
                child: buildCard(
                  'Chemistry Labs',
                  Colors.white,
                  'assets/images/periodicTable.png',
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
                      builder: (context) => LabsPhysicsTopicsPage(),
                    ),
                  );
                },
                child: buildCard(
                  'Physics Labs',
                  Colors.white,
                  'assets/images/rocket.png',
                ),
              ),
            ),
          ],
        ),
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
              fit: BoxFit.contain,
              alignment: Alignment.centerRight,
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
