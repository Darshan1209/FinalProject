import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:apt3065/src/screens/BiologyQuiz.dart'; // Ensure correct import path
void main() {
  testWidgets('Quiz displays correct title in AppBar', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(MaterialApp(
      home: BiologyQuiz(),
    ));
    // Wait for the widget to settle
    await tester.pumpAndSettle();
    // Verify if the AppBar contains the title
    expect(find.text('Biology - Cell Quiz'), findsOneWidget);
  });
    testWidgets('Quiz displays questions correctly', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(MaterialApp(
      home: BiologyQuiz(),
    ));
    // Wait for the widget to settle
    await tester.pumpAndSettle();
    // Verify if questions are displayed
    expect(find.text('1. What is the powerhouse of the cell?'), findsOneWidget);
    expect(find.text('2. Which organelle is responsible for protein synthesis?'), findsOneWidget);
    expect(find.text('3. What is the function of the cell membrane?'), findsOneWidget);
  });
  ;
}


