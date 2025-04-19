import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:apt3065/src/screens/physicsexperimentList.dart';


void main() {
  testWidgets('Default tab is Notes', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(MaterialApp(
      home: PhysicsExperimentsList(),
    ));

    // Wait for the widget to settle
    await tester.pumpAndSettle();

    // Check if the "Notes" tab is selected
    expect(find.text('Notes'), findsOneWidget);
    expect(find.byIcon(Icons.note), findsOneWidget);
  });
}
