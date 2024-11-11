import 'package:apt3065/src/screens/biologyLabs/photosynthesisLab.dart';
import 'package:apt3065/src/screens/biology_labspage.dart';
import 'package:flutter/material.dart';

class LabsBiologyTopicsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biology Lab Topics'),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Card(
              color: const Color.fromARGB(255, 181, 230, 126),
              child: ListTile(
                title: const Text('Photosynthesis ',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PhotosynthesisSimulator()),
                  );
                },
              ),
            ),
            const SizedBox(height: 10), // Add space between cards
            Card(
              color: const Color.fromARGB(255, 181, 230, 126),
              child: ListTile(
                title: const Text(
                  'Anatomy',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                ),
                onTap: () {
                  // Navigate to Topic 1 page
                },
              ),
            ),
            const SizedBox(height: 10), // Add space between cards
            Card(
              color: const Color.fromARGB(255, 181, 230, 126),
              child: ListTile(
                title: const Text('Enzyme Activity',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                onTap: () {
                  // Navigate to Topic 2 page
                },
              ),
            ),
            const SizedBox(height: 10), // Add space between cards
            Card(
              color: const Color.fromARGB(255, 181, 230, 126),
              child: ListTile(
                title: const Text('Acid Base Reaction',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AcidBaseLabsPage()),
                  );
                },
              ),
            ),
            const SizedBox(height: 10), // Add space between cards
            Card(
              color: const Color.fromARGB(255, 181, 230, 126),
              child: ListTile(
                title: const Text('Microscopy Investigation',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                onTap: () {
                  // Navigate to Topic 4 page
                },
              ),
            ),
            const SizedBox(height: 10), // Add space between cards
          ],
        ),
      ),
    );
  }
}
