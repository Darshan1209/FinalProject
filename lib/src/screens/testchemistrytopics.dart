import 'package:apt3065/src/screens/ChemistryTitrationQuiz';
import 'package:apt3065/src/screens/QuizPage.dart';
import 'package:apt3065/src/screens/chemistryTitrationQuiz.dart';
import 'package:apt3065/src/widgets/labCards.dart';
import 'package:flutter/material.dart';

class TestChemistryTopicsPage extends StatelessWidget {
  const TestChemistryTopicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> imagePaths = [
      'assets/images/gasLaws.png',
      'assets/images/chemistry1.png',
      'assets/images/Diffusion.png',
      'assets/images/acidBase.png',
      'assets/images/periodicTable1.png',
      'assets/images/atomicStructure.png'
    ];

    List<String> titles = [
      'Gas Laws',
      'Titration',
      'Diffusion Experiment',
      'Acid-Base Reactions',
      'Periodic Table',
      'Atomic Structure'
    ];
    List<Widget> labs = [
      const QuizPage(subject: 'Chemistry', topic: 'Gas Laws'),
      const QuizPage(subject: 'Chemistry', topic: 'Titration'),
      const ChemistryTitrationQuiz(),
      const ChemistryTitrationQuiz(),
      const ChemistryTitrationQuiz(),
      const ChemistryTitrationQuiz(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chemistry Quiz Topics'),
      ),
      backgroundColor: Colors.white, // Set background color to blue
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LabCards(titles: titles, labs: labs, imagePaths: imagePaths),
      ),
    );
  }
}
