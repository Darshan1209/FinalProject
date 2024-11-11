import 'package:apt3065/src/screens/ChemistryTitrationQuiz';
import 'package:apt3065/src/screens/chemistryTitrationQuiz.dart';
import 'package:flutter/material.dart';

class TestChemistryTopicsPage extends StatelessWidget {
  const TestChemistryTopicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chemistry Quiz Topics'),
      ),
      backgroundColor: Colors.blue, // Set background color to blue
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Card(
              color: const Color.fromARGB(
                  255, 151, 222, 255), // Custom color for the card
              child: ListTile(
                title: const Text('Salts'),
                onTap: () {
                  // Navigate to Topic 1 page
                },
              ),
            ),
            const SizedBox(height: 10), // Add space between cards
            Card(
              color: const Color.fromARGB(
                  255, 151, 222, 255), // Custom color for the card
              child: ListTile(
                title: const Text('Rusting'),
                onTap: () {
                  // Navigate to Topic 2 page
                },
              ),
            ),
            const SizedBox(height: 10), // Add space between cards
            Card(
              color: const Color.fromARGB(
                  255, 151, 222, 255), // Custom color for the card
              child: ListTile(
                title: const Text('Titration'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChemistryTitrationQuiz()),
                  );
                },
              ),
            ),
            const SizedBox(height: 10), // Add space between cards
            Card(
              color: const Color.fromARGB(
                  255, 151, 222, 255), // Custom color for the card
              child: ListTile(
                title: const Text('Periodic Table'),
                onTap: () {
                  // Navigate to Topic 4 page
                },
              ),
            ),
            const SizedBox(height: 10), // Add space between cards
            Card(
              color: const Color.fromARGB(
                  255, 151, 222, 255), // Custom color for the card
              child: ListTile(
                title: const Text('Halogens'),
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
