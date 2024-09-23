import 'package:apt3065/src/screens/chemistry_notespage.dart';
import 'package:apt3065/src/screens/chemistry_videospage.dart';
import 'package:apt3065/src/screens/videos_page.dart';
import 'package:apt3065/src/utils/consumers_helper.dart';
import 'package:flutter/material.dart';
import 'notes_page.dart';
import 'videos_page.dart';
import 'chemistry_labspage_redirect.dart';
import 'biology_labspageredirect.dart';

class BiologyExperimentsList extends StatefulWidget {
  final String topicName;
  const BiologyExperimentsList({Key? key, required this.topicName})
      : super(key: key);

  @override
  _BiologyExperimentsListState createState() => _BiologyExperimentsListState();
}

class _BiologyExperimentsListState extends State<BiologyExperimentsList> {
  late String selectedTab;

  @override
  void initState() {
    super.initState();
    selectedTab = 'Notes';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.topicName), //CHANGE THIS
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
        return BiologyNotesPage(
            topicName: widget.topicName); // Navigate to the BiologyNotesPage
      case 'Videos':
        return VideosPage(topicName: widget.topicName);
      case 'Labs':
        return ChemistryLabsPageRedirect();
      default:
        return Container(); // Handle other cases if needed
    }
  }
}
