import 'package:apt3065/src/screens/BiologyQuiz.dart';
import 'package:flutter/material.dart';

class TestBiologyTopicsPage extends StatelessWidget {
  const TestBiologyTopicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biology Quiz Topics'),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Card(
              color: const Color.fromARGB(255, 181, 230, 126),
              child: ListTile(
                title: const Text('Excretion'),
                onTap: () {
                  // Navigate to Topic 1 page
                },
              ),
            ),
            const SizedBox(height: 10), // Add space between cards
            Card(
              color: const Color.fromARGB(255, 181, 230, 126),
              child: ListTile(
                title: const Text('Respiration'),
                onTap: () {
                  // Navigate to Topic 2 page
                },
              ),
            ),
            const SizedBox(height: 10), // Add space between cards
            Card(
              color: const Color.fromARGB(255, 181, 230, 126),
              child: ListTile(
                title: const Text('Cells'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BiologyQuiz()),
                  );
                },
              ),
            ),
            const SizedBox(height: 10), // Add space between cards
            Card(
              color: const Color.fromARGB(255, 181, 230, 126),
              child: ListTile(
                title: const Text('Circulation System'),
                onTap: () {
                  // Navigate to Topic 4 page
                },
              ),
            ),
            const SizedBox(height: 10), // Add space between cards
            Card(
              color: const Color.fromARGB(255, 181, 230, 126),
              child: ListTile(
                title: const Text('Health'),
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
