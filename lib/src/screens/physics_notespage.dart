import 'package:flutter/material.dart';

class PhysicsNotesPage extends StatelessWidget {
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
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20), // Add space before the title
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1), // Light blue background color
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
                      'Pendulum is a weight suspended from a pivot so that it can swing freely. When displaced from its initial position, it undergoes periodic motion. The time period of this motion depends on the length of the pendulum and the acceleration due to gravity.',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1), // Light blue background color
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
                      '1. Set up the pendulum apparatus.\n'
                          '2. Measure the length of the pendulum.\n'
                          '3. Displace the pendulum from its equilibrium position and release it.\n'
                          '4. Measure the time taken for a certain number of oscillations.\n'
                          '5. Calculate the period of the pendulum using the measured values.',
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
                      '1. Ensure the pendulum setup is stable and secure to prevent accidents.\n'
                          '2. Handle the pendulum weight carefully to avoid injury.\n'
                          '3. Keep the pendulum apparatus away from fragile objects to prevent damage.\n',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                ],
              ),
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
        backgroundColor: Colors.orange,
      ),
    );
  }
}
