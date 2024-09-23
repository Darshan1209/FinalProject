import 'package:apt3065/src/screens/biology_labspage.dart';
import 'package:flutter/material.dart';


class LabsBiologyTopicsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biology Lab Topics'),
      ),
      backgroundColor: Colors.green,
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Card(
              color: Color.fromARGB(255, 181, 230, 126),
              child: ListTile(
                title: Text('Photosynthesis'),
                onTap: () {
                  // Navigate to Topic 1 page
                },
              ),
            ),
            SizedBox(height: 10), // Add space between cards
            Card(
              color: Color.fromARGB(255, 181, 230, 126),
              child: ListTile(
                title: Text('Enzyme Activity'),
                onTap: () {
                  // Navigate to Topic 2 page
                },
              ),
            ),
            SizedBox(height: 10), // Add space between cards
            Card(
              color: Color.fromARGB(255, 181, 230, 126),
              child: ListTile(
                title: Text('Acid Base Reaction'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BiologyLabsPage()),
                  );
                },
              ),
            ),
            SizedBox(height: 10), // Add space between cards
            Card(
              color: Color.fromARGB(255, 181, 230, 126),
              child: ListTile(
                title: Text('Microscopy Investigation'),
                onTap: () {
                  // Navigate to Topic 4 page
                },
              ),
            ),
            SizedBox(height: 10), // Add space between cards
            Card(
              color: Color.fromARGB(255, 181, 230, 126),
              child: ListTile(
                title: Text('Genetics Experiment'),
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
