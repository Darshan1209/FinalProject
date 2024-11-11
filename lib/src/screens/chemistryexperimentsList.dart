import 'package:apt3065/src/screens/biology_labspageredirect.dart';
import 'package:apt3065/src/screens/labs_page.dart';
import 'package:apt3065/src/screens/notes_page.dart';
import 'package:apt3065/src/screens/videos_page.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'chemistry_notespage.dart';
import 'chemistry_labspage.dart';
import 'chemistry_videospage.dart';
import 'chemistry_labspage_redirect.dart';

class ChemistryExperimentsList extends StatefulWidget {
  const ChemistryExperimentsList({Key? key}) : super(key: key);

  @override
  State<ChemistryExperimentsList> createState() =>
      _ChemistryExperimentsListState();
}

class _ChemistryExperimentsListState extends State<ChemistryExperimentsList> {
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
        title: const Text('Chemistry Experiments'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
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
        _buildTabButton('Note', Icons.note),
        _buildTabButton('Video', Iconsax.video),
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
            fontWeight:
                selectedTab == tabName ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        // Add a bottom border for the selected tab
        if (selectedTab == tabName)
          Container(
            height: 2.0, // Adjust the height of the underline
            width: 20.0, // Adjust the width of the underline
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(2.0), // Optional: for rounded corners
              color: Colors.black, // Set the color of the underline
            ),
          ),
      ],
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case 'Notes':
        return ChemistryNotesPage();
      case 'Videos':
        return const ChemistryVideosPage();
      case 'Labs':
        return const BiologyLabsPageRedirect();
      default:
        return Container(); // Handle other cases if needed
    }
  }
}
