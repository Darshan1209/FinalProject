import 'package:apt3065/src/screens/biologyLabs/photosynthesisLab.dart';
import 'package:apt3065/src/screens/biology_labspage.dart';
import 'package:apt3065/src/widgets/labCards.dart';
import 'package:flutter/material.dart';

class LabsBiologyTopicsPage extends StatelessWidget {
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
      'Mitosis and Meiosis',
      'Skeletal System',
      'Organ Systems',
      'Photosynthesis'
    ];
    List<Widget> labs = [
      const AcidBaseLabsPage(),
      const AcidBaseLabsPage(),
      const AcidBaseLabsPage(),
      const AcidBaseLabsPage(),
      const AcidBaseLabsPage(),
      PhotosynthesisSimulator(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biology Lab Topics'),
      ),
      backgroundColor: Colors.white,
      body: LabCards(titles: titles, labs: labs, imagePaths: imagePaths),
    );
  }
}
