import 'package:apt3065/src/screens/PhysicsWavesQuiz.dart';
import 'package:flutter/material.dart';


class TestPhysicsTopicsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Physics Topics'),
      ),
      backgroundColor: Color.fromARGB(255, 255, 126, 87), // Set background color to deep orange
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Card(
              color: Colors.orangeAccent, // Use a lighter shade of orange
              child: ListTile(
                title: Text('Heat'),
                onTap: () {
                  // Navigate to Topic 1 page
                },
              ),
            ),
            SizedBox(height: 10), // Add space between cards
            Card(
              color: Colors.orangeAccent, // Use a lighter shade of orange
              child: ListTile(
                title: Text('Sound'),
                onTap: () {
                  // Navigate to Topic 2 page
                },
              ),
            ),
            SizedBox(height: 10), // Add space between cards
            Card(
              color: Colors.orangeAccent, // Use a lighter shade of orange
              child: ListTile(
                title: Text('Waves'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PhysicsWavesQuiz()),
                  );
                },
              ),
            ),
            SizedBox(height: 10), // Add space between cards
            Card(
              color: Colors.orangeAccent, // Use a lighter shade of orange
              child: ListTile(
                title: Text('Light'),
                onTap: () {
                  // Navigate to Topic 4 page
                },
              ),
            ),
            SizedBox(height: 10), // Add space between cards
            Card(
              color: Colors.orangeAccent, // Use a lighter shade of orange
              child: ListTile(
                title: Text('Force'),
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
