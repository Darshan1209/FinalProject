import 'package:apt3065/src/screens/physicsLabs/newtonsLawLab.dart';
import 'package:apt3065/src/screens/physicsLabs/ohmsLawLab.dart';
import 'package:apt3065/src/screens/physicsLabs/projectileMotion.dart';
import 'package:apt3065/src/screens/physicsLabs/firstLawOfMotionLab.dart';
import 'package:apt3065/src/screens/physicsLabs/thermalExpansionLab1.dart';
import 'package:apt3065/src/screens/physics_labspage.dart';
import 'package:apt3065/src/widgets/labCards.dart';
import 'package:flutter/material.dart';

class LabsPhysicsTopicsPage extends StatelessWidget {
  const LabsPhysicsTopicsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Physics Labs Topics'),
        backgroundColor: Colors.grey[300],
      ),
      backgroundColor: Colors.grey[300], // Set background color to deep orange
      body: LabCards(titles: titles, labs: labs, imagePaths: imagePaths),
    );
  }
}
