import 'package:apt3065/src/screens/PhysicsWavesQuiz.dart';
import 'package:flutter/material.dart';

class TestPhysicsTopicsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Physics Topics'),
      ),
      backgroundColor: Colors.white, // Set background color to deep orange
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Card(
              color: Colors.orangeAccent, // Use a lighter shade of orange
              child: ListTile(
                title: const Text(
                  'Heat',
                ),
                onTap: () {
                  // Navigate to Topic 1 page
                },
              ),
            ),
            const SizedBox(height: 10), // Add space between cards
            Card(
              color: Colors.orangeAccent, // Use a lighter shade of orange
              child: ListTile(
                title: const Text('Sound'),
                onTap: () {
                  // Navigate to Topic 2 page
                },
              ),
            ),
            const SizedBox(height: 10), // Add space between cards
            Card(
              color: Colors.orangeAccent, // Use a lighter shade of orange
              child: ListTile(
                title: const Text('Waves'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PhysicsWavesQuiz()),
                  );
                },
              ),
            ),
            const SizedBox(height: 10), // Add space between cards
            Card(
              color: Colors.orangeAccent, // Use a lighter shade of orange
              child: ListTile(
                title: const Text('Light'),
                onTap: () {
                  // Navigate to Topic 4 page
                },
              ),
            ),
            const SizedBox(height: 10), // Add space between cards
            Card(
              color: Colors.orangeAccent, // Use a lighter shade of orange
              child: ListTile(
                title: const Text('Force'),
                onTap: () {
                  // Navigate to Topic 5 page
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
