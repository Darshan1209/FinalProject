import 'package:apt3065/src/screens/chemistry_notespage.dart';
import 'package:apt3065/src/screens/chemistry_videospage.dart';
import 'package:apt3065/src/screens/videos_page.dart';
import 'package:apt3065/src/utils/consumers_helper.dart';
import 'package:apt3065/src/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'notes_page.dart';
import 'videos_page.dart';
import 'chemistry_labspage_redirect.dart';
import 'biology_labspageredirect.dart';

class BiologyExperimentsList extends StatefulWidget {
  final String topicName;
  const BiologyExperimentsList({Key? key, required this.topicName})
      : super(key: key);

  @override
  State<BiologyExperimentsList> createState() => _BiologyExperimentsListState();
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
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Container(
              margin: const EdgeInsets.only(bottom: 10), child: _buildTabs()),
        ),
      ),
      body: _buildTabContent(),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.only(bottom: 0, top: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTabButton('Notes', Iconsax.note_2),
          _buildTabButton('Videos', Iconsax.video),
          _buildTabButton('Labs', const AssetImage('assets/images/beaker.png')),
        ],
      ),
    );
  }

  Widget _buildTabButton(String tabName, dynamic icon) {
    final isSelected = selectedTab == tabName;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = tabName;
        });
      },
      child: AnimatedContainer(
        width: transformWidth(width, 100),
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueAccent : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.transparent, width: 0.5),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.8),
                    spreadRadius: 1,
                    blurRadius: 15,
                    offset: const Offset(2, 2),
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    spreadRadius: 1,
                    blurRadius: 15,
                    offset: Offset(-3, -3),
                  ),
                ]
              : [
                  BoxShadow(
                    // inset: true,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey.shade400
                        : Colors.black54,
                    offset: const Offset(5, 5),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    // inset: true,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : Colors.grey.shade600,
                    offset: const Offset(-3, -3),
                    blurRadius: 15,
                    spreadRadius: 1,
                  )
                ],
        ),
        child: Column(
          children: [
            icon is AssetImage
                ? ImageIcon(
                    icon,
                    size: 30,
                    color: isSelected ? Colors.white : Colors.black54,
                  )
                : Icon(
                    icon,
                    size: 30,
                    color: isSelected ? Colors.white : Colors.black54,
                  ),
            const SizedBox(height: 5),
            Text(
              tabName,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (isSelected)
              Container(
                margin: const EdgeInsets.only(top: 6),
                height: 3,
                width: 24,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
          ],
        ),
      ),
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
