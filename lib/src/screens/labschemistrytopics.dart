import 'package:apt3065/src/screens/chemistry_labspage.dart';
import 'package:flutter/material.dart';


class LabsChemistryTopicsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chemistry Lab Topics'),
      ),
      backgroundColor: Colors.blue, // Set background color to blue
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Card(
              color: Color.fromARGB(255, 151, 222, 255), // Custom color for the card
              child: ListTile(
                title: Text('Gas Laws'),
                onTap: () {
                  // Navigate to Topic 1 page
                },
              ),
            ),
            SizedBox(height: 10), // Add space between cards
            Card(
              color: Color.fromARGB(255, 151, 222, 255), // Custom color for the card
              child: ListTile(
                title: Text('Crystallization'),
                onTap: () {
                  // Navigate to Topic 2 page
                },
              ),
            ),
            SizedBox(height: 10), // Add space between cards
            Card(
              color: Color.fromARGB(255, 151, 222, 255), // Custom color for the card
              child: ListTile(
                title: Text('Diffusion Experiment'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChemistryLabsPage()),
                  );
                },
              ),
            ),
            SizedBox(height: 10), // Add space between cards
            Card(
              color: Color.fromARGB(255, 151, 222, 255), // Custom color for the card
              child: ListTile(
                title: Text('Rate of Reaction'),
                onTap: () {
                  // Navigate to Topic 4 page
                },
              ),
            ),
            SizedBox(height: 10), // Add space between cards
            Card(
              color: Color.fromARGB(255, 151, 222, 255), // Custom color for the card
              child: ListTile(
                title: Text('Calorimetry'),
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
