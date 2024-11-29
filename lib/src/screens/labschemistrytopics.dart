import 'package:apt3065/src/screens/chemistry_labspage.dart';
import 'package:apt3065/src/widgets/labCards.dart';
import 'package:flutter/material.dart';

class LabsChemistryTopicsPage extends StatelessWidget {
  const LabsChemistryTopicsPage({super.key});

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
      'Chemical Bonding',
      'Diffusion Experiment',
      'Acid-Base Reactions',
      'Periodic Table',
      'Atomic Structure'
    ];
    List<Widget> labs = [
      const ChemistryLabsPage(),
      const ChemistryLabsPage(),
      const ChemistryLabsPage(),
      const ChemistryLabsPage(),
      const ChemistryLabsPage(),
      const ChemistryLabsPage(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chemistry Lab Topics'),
      ),
      backgroundColor: Colors.white, // Set background color to blue
      body: LabCards(titles: titles, labs: labs, imagePaths: imagePaths),
    );
  }
}
