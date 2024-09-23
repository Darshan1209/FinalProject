import 'package:flutter/material.dart';

class ChemistryNotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back arrow
        title: Container(), // Empty container to remove the title
      ),
      body: Scrollbar(
        controller: _scrollController, // Use the same controller for Scrollbar and SingleChildScrollView
        thumbVisibility: true, // Always show the scrollbar
        child: SingleChildScrollView(
          controller: _scrollController, // Use the same controller as the Scrollbar
          physics: AlwaysScrollableScrollPhysics(), // Ensures the scrollbar is always shown
          padding: EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20), // Add space before the title
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1), // Light blue background color
                  borderRadius: BorderRadius.circular(10.0), // Rounded corners
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Introduction',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Acid-base reactions involve the transfer of protons from an acid to a base, resulting in the formation of water and a salt.',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1), // Light blue background color
                  borderRadius: BorderRadius.circular(10.0), // Rounded corners
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Steps',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '1. Prepare acid and base solutions.\n'
                          '2. Add pH indicator to one of the solutions.\n'
                          '3. Mix the solutions together while stirring.\n'
                          '4. Observe any changes in the solution.\n'
                          '5. Record observations and cleanup.',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.yellow.withOpacity(0.1), // Light yellow background color
                  borderRadius: BorderRadius.circular(10.0), // Rounded corners
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.warning, color: Colors.red, size: 24),
                        SizedBox(width: 10),
                        Text(
                          'Safety Precautions',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                        '1. Wear PPE: Always wear lab coats, gloves, and goggles.\n'
                         '2. Handle acids with care: Use proper techniques to prevent spills and contamination.\n'
                    '3. Dispose waste properly: Never dispose of acids or bases down the drain without proper neutralization and authorization.\n'
                    '4. React promptly: Notify your instructor immediately in case of accidents or spills.\n',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        },
        child: Icon(Icons.arrow_downward),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
