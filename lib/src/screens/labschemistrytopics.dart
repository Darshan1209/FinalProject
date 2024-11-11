import 'package:apt3065/src/screens/chemistry_labspage.dart';
import 'package:flutter/material.dart';

class LabsChemistryTopicsPage extends StatelessWidget {
  const LabsChemistryTopicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chemistry Lab Topics'),
      ),
      backgroundColor: Colors.white, // Set background color to blue
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Card(
              color: const Color.fromARGB(
                  255, 151, 222, 255), // Custom color for the card
              child: ListTile(
                title: const Text('Gas Laws',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
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
                title: const Text('Crystallization',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
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
                title: const Text('Diffusion Experiment',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChemistryLabsPage()),
                  );
                },
              ),
            ),
            const SizedBox(height: 10), // Add space between cards
            Card(
              color: const Color.fromARGB(
                  255, 151, 222, 255), // Custom color for the card
              child: ListTile(
                title: const Text('Rate of Reaction',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
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
                title: const Text('Calorimetry',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
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
