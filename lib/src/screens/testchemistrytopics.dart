import 'package:apt3065/src/screens/ChemistryTitrationQuiz';
import 'package:flutter/material.dart';


class TestChemistryTopicsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chemistry Quiz Topics'),
      ),
      backgroundColor: Colors.blue, // Set background color to blue
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Card(
              color: Color.fromARGB(255, 151, 222, 255), // Custom color for the card
              child: ListTile(
                title: Text('Salts'),
                onTap: () {
                  // Navigate to Topic 1 page
                },
              ),
            ),
            SizedBox(height: 10), // Add space between cards
            Card(
              color: Color.fromARGB(255, 151, 222, 255), // Custom color for the card
              child: ListTile(
                title: Text('Rusting'),
                onTap: () {
                  // Navigate to Topic 2 page
                },
              ),
            ),
            SizedBox(height: 10), // Add space between cards
            Card(
              color: Color.fromARGB(255, 151, 222, 255), // Custom color for the card
              child: ListTile(
                title: Text('Titration'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChemistryTitrationQuiz()),
                  );
                },
              ),
            ),
            SizedBox(height: 10), // Add space between cards
            Card(
              color: Color.fromARGB(255, 151, 222, 255), // Custom color for the card
              child: ListTile(
                title: Text('Periodic Table'),
                onTap: () {
                  // Navigate to Topic 4 page
                },
              ),
            ),
            SizedBox(height: 10), // Add space between cards
            Card(
              color: Color.fromARGB(255, 151, 222, 255), // Custom color for the card
              child: ListTile(
                title: Text('Halogens'),
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
