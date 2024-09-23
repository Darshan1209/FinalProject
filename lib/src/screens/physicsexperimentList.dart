import 'package:flutter/material.dart';
import 'physics_notespage.dart';
import 'physics_videospage.dart';
import 'physics_labspage.dart';
import 'physics_labspage_redirect.dart';

class PhysicsExperimentsList extends StatefulWidget {
  const PhysicsExperimentsList({Key? key}) : super(key: key);

  @override
  _PhysicsExperimentsListState createState() => _PhysicsExperimentsListState();
}

class _PhysicsExperimentsListState extends State<PhysicsExperimentsList> {
  late String selectedTab;

  @override
  void initState() {
    super.initState();
    selectedTab = 'Notes'; // Default selected tab
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pendulum Experiment'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: _buildTabs(),
        ),
      ),
      body: _buildTabContent(),
    );
  }

  Widget _buildTabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildTabButton('Notes', Icons.note),
        _buildTabButton('Videos', Icons.video_library),
        _buildTabButton('Labs', Icons.science),
      ],
    );
  }

  Widget _buildTabButton(String tabName, IconData icon) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon),
          onPressed: () {
            setState(() {
              selectedTab = tabName;
            });
          },
        ),
        Text(
          tabName,
          style: TextStyle(
            color: selectedTab == tabName ? Colors.blue : Colors.black,
            fontWeight: selectedTab == tabName ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        // Add a bottom border for the selected tab
        if (selectedTab == tabName)
          Container(
            height: 2.0, // Adjust the height of the underline
            width: 20.0, // Adjust the width of the underline
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0), // Optional: for rounded corners
              color: Colors.black, // Set the color of the underline
            ),
          ),
      ],
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case 'Notes':
        return PhysicsNotesPage();
      case 'Videos':
        return PhysicsVideosPage();
      case 'Labs':
        return PhysicsLabsPageRedirect();
      default:
        return Container(); // Handle other cases if needed
    }
  }
}
