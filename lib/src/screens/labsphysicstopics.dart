import 'package:apt3065/src/screens/physicsLabs/newtonsLawLab.dart';
import 'package:apt3065/src/screens/physicsLabs/ohmsLawLab.dart';
import 'package:apt3065/src/screens/physicsLabs/projectileMotion.dart';
import 'package:apt3065/src/screens/physicsLabs/firstLawOfMotionLab.dart';
import 'package:apt3065/src/screens/physicsLabs/thermalExpansionLab1.dart';
import 'package:apt3065/src/screens/physics_labspage.dart';
import 'package:flutter/material.dart';

class LabsPhysicsTopicsPage extends StatelessWidget {
  const LabsPhysicsTopicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Physics Labs Topics'),
        backgroundColor: Colors.grey[300],
      ),
      backgroundColor: Colors.grey[300], // Set background color to deep orange
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of items per row
            crossAxisSpacing: 20.0, // Space between items horizontally
            mainAxisSpacing: 30.0, // Space between items vertically
            childAspectRatio: 1.0, // Maintain aspect ratio for cards
          ),
          itemCount: 6, // Total number of cards (6 titles and 6 images)
          itemBuilder: (context, index) {
            // Define the list of images and titles
            List<String> imagePaths = [
              'assets/images/electricity.png',
              'assets/images/gravity.png',
              'assets/images/pendulum.png',
              'assets/images/rocket.png',
              'assets/images/lawsOfMotion.png',
              'assets/images/refraction.png'
            ];

            List<String> titles = [
              'Ohms Law',
              'Newton\'s Law',
              'Pendulum Experiment',
              'Projectile Motion',
              'First Law of Motion',
              'Thermal Expansion'
            ];
            List<Widget> labs = [
              const OhmsLawLab(),
              const NewtonsLawLab(),
              const PendulumPhysicsLabsPage(),
              ProjectileMotionSimulator(),
              FirstLawSimulationPage(),
              const ThermalExpansionDemo()
            ];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => labs[index],
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300], // Card background color
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      // inset: true,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.grey.shade500
                          : Colors.black54,
                      offset: const Offset(5, 5),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      // inset: true,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : Colors.grey.shade800,
                      offset: const Offset(-3, -3),
                      blurRadius: 15,
                      spreadRadius: 1,
                    )
                  ],
                ),
                // color: Colors.white, // Card background color
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Image above the text
                    Image.asset(
                      imagePaths[
                          index], // Get the corresponding image for the current index
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      titles[
                          index], // Get the corresponding title for the current index
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
