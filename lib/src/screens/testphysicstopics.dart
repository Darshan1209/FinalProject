import 'package:apt3065/src/screens/PhysicsWavesQuiz.dart';
import 'package:apt3065/src/widgets/labCards.dart';
import 'package:flutter/material.dart';

class TestPhysicsTopicsPage extends StatelessWidget {
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
      PhysicsWavesQuiz(),
      PhysicsWavesQuiz(),
      PhysicsWavesQuiz(),
      PhysicsWavesQuiz(),
      PhysicsWavesQuiz(),
      PhysicsWavesQuiz(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Physics Quiz Topics'),
        backgroundColor: Colors.grey[300],
      ),
      backgroundColor: Colors.grey[300], // Set background color to deep orange
      body: LabCards(titles: titles, labs: labs, imagePaths: imagePaths),
    );
  }
}
