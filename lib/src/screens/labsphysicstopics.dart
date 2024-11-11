import 'package:apt3065/src/screens/physicsLabs/projectileMotion.dart';
import 'package:apt3065/src/screens/physicsLabs/thermalExpansionLab.dart';
import 'package:apt3065/src/screens/physics_labspage.dart';
import 'package:flutter/material.dart';

class LabsPhysicsTopicsPage extends StatelessWidget {
  const LabsPhysicsTopicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Physics Labs Topics'),
      ),
      backgroundColor: Colors.white, // Set background color to deep orange
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Card(
              color: Colors.orangeAccent, // Use a lighter shade of orange
              child: ListTile(
                title: const Text('Ohms Law',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                onTap: () {
                  // Navigate to Topic 1 page
                },
              ),
            ),
            const SizedBox(height: 10), // Add space between cards
            Card(
              color: Colors.orangeAccent, // Use a lighter shade of orange
              child: ListTile(
                title: const Text('Newtons Law',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                onTap: () {
                  // Navigate to Topic 2 page
                },
              ),
            ),
            const SizedBox(height: 10), // Add space between cards
            Card(
              color: Colors.orangeAccent, // Use a lighter shade of orange
              child: ListTile(
                title: const Text('Pendulum Experiment',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PendulumPhysicsLabsPage()),
                  );
                },
              ),
            ),
            const SizedBox(height: 10), // Add space between cards
            Card(
              color: Colors.orangeAccent, // Use a lighter shade of orange
              child: ListTile(
                title: const Text('Projectile Motion',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                onTap: () {
                  // Navigate to Topic 4 page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProjectileMotionSimulator()),
                  );
                },
              ),
            ),
            const SizedBox(height: 10), // Add space between cards
            Card(
              color: Colors.orangeAccent, // Use a lighter shade of orange
              child: ListTile(
                title: const Text('Thermal Expansion',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                onTap: () {
                  // Navigate to Topic 5 page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ThermalExpansionAnimation()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
