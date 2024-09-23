import 'package:apt3065/src/screens/BiologyQuiz.dart';
import 'package:flutter/material.dart';


class TestBiologyTopicsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biology Quiz Topics'),
      ),
      backgroundColor: Colors.green,
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Card(
              color: Color.fromARGB(255, 181, 230, 126),
              child: ListTile(
                title: Text('Excretion'),
                onTap: () {
                  // Navigate to Topic 1 page
                },
              ),
            ),
            SizedBox(height: 10), // Add space between cards
            Card(
              color: Color.fromARGB(255, 181, 230, 126),
              child: ListTile(
                title: Text('Respiration'),
                onTap: () {
                  // Navigate to Topic 2 page
                },
              ),
            ),
            SizedBox(height: 10), // Add space between cards
            Card(
              color: Color.fromARGB(255, 181, 230, 126),
              child: ListTile(
                title: Text('Cells'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BiologyQuiz()),
                  );
                },
              ),
            ),
            SizedBox(height: 10), // Add space between cards
            Card(
              color: Color.fromARGB(255, 181, 230, 126),
              child: ListTile(
                title: Text('Circulation System'),
                onTap: () {
                  // Navigate to Topic 4 page
                },
              ),
            ),
            SizedBox(height: 10), // Add space between cards
            Card(
              color: Color.fromARGB(255, 181, 230, 126),
              child: ListTile(
                title: Text('Health'),
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
