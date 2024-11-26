import 'package:apt3065/src/screens/BiologyQuiz.dart';
import 'package:apt3065/src/utils/FlashCard.dart';
import 'package:apt3065/src/widgets/labCards.dart';
import 'package:flutter/material.dart';

class TestBiologyTopicsPage extends StatelessWidget {
  const TestBiologyTopicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> imagePaths = [
      'assets/images/cells.png',
      'assets/images/microscopy.png',
      'assets/images/mitosis.png',
      'assets/images/skeletal.png',
      'assets/images/organSystem.png',
      'assets/images/photosynthesis.png'
    ];

    List<String> titles = [
      'Cell Biology',
      'Microscopy',
      'Mitosis ',
      'Skeletal System',
      'Organ Systems',
      'Photosynthesis'
    ];
    List<Widget> labs = [
      BiologyQuiz(),
      BiologyQuiz(),
      BiologyQuiz(),
      BiologyQuiz(),
      BiologyQuiz(),
      BiologyQuiz(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biology Quiz Topics'),
      ),
      backgroundColor: Colors.white,
      body: LabCards(titles: titles, labs: labs, imagePaths: imagePaths),
    );
  }
}
