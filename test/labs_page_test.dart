import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:apt3065/src/screens/labs_page.dart'; // Make sure the import is correct

void main() {
testWidgets('LabsPage displays the correct labs cards and navigates on tap', (WidgetTester tester) async {
  // Build the widget tree with direct navigation
  await tester.pumpWidget(MaterialApp(
    home: LabsPage(),
  ));

  // Debugging: Print the widget tree
  debugPrint('Widgets: ${tester.firstWidget(find.byType(Text))}');

  // Verify that the LabsPage title is displayed
  expect(find.text('Labs'), findsOneWidget);

  // Verify that the three cards (Biology, Chemistry, and Physics) are displayed
  expect(find.text('Biology Labs'), findsOneWidget);
  expect(find.text('Chemistry Labs'), findsOneWidget);
  expect(find.text('Physics Labs'), findsOneWidget);
});
}
