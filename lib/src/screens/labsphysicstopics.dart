import 'package:apt3065/src/screens/physics_labspage.dart';
import 'package:flutter/material.dart';


class LabsPhysicsTopicsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Physics Labs Topics'),
      ),
      backgroundColor: Color.fromARGB(255, 255, 126, 87), // Set background color to deep orange
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Card(
              color: Colors.orangeAccent, // Use a lighter shade of orange
              child: ListTile(
                title: Text('Ohms Law'),
                onTap: () {
                  // Navigate to Topic 1 page
                },
              ),
            ),
            SizedBox(height: 10), // Add space between cards
            Card(
              color: Colors.orangeAccent, // Use a lighter shade of orange
              child: ListTile(
                title: Text('Newtons Law'),
                onTap: () {
                  // Navigate to Topic 2 page
                },
              ),
            ),
            SizedBox(height: 10), // Add space between cards
            Card(
              color: Colors.orangeAccent, // Use a lighter shade of orange
              child: ListTile(
                title: Text('Pendulum Experiment'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PhysicsLabsPage()),
                  );
                },
              ),
            ),
            SizedBox(height: 10), // Add space between cards
            Card(
              color: Colors.orangeAccent, // Use a lighter shade of orange
              child: ListTile(
                title: Text('Refraction'),
                onTap: () {
                  // Navigate to Topic 4 page
                },
              ),
            ),
            SizedBox(height: 10), // Add space between cards
            Card(
              color: Colors.orangeAccent, // Use a lighter shade of orange
              child: ListTile(
                title: Text('Thermal Expansion'),
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
