import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Theme toggle maintains consistency', (WidgetTester tester) async {
    // Define a widget with a theme toggle
    final testWidget = MaterialApp(
      home: ThemeToggleWidget(),
    );

    await tester.pumpWidget(testWidget);

    // Verify initial theme (Light)
    expect(find.text("Light Theme"), findsOneWidget);

    // Toggle to Dark Theme
    await tester.tap(find.byKey(Key('themeToggleButton')));
    await tester.pump();

    // Verify updated theme (Dark)
    expect(find.text("Dark Theme"), findsOneWidget);

    // Toggle back to Light Theme
    await tester.tap(find.byKey(Key('themeToggleButton')));
    await tester.pump();

    // Verify it goes back to Light Theme
    expect(find.text("Light Theme"), findsOneWidget);
  });
}

class ThemeToggleWidget extends StatefulWidget {
  @override
  _ThemeToggleWidgetState createState() => _ThemeToggleWidgetState();
}

class _ThemeToggleWidgetState extends State<ThemeToggleWidget> {
  bool isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(isDarkTheme ? "Dark Theme" : "Light Theme", key: Key('themeText')),
        ElevatedButton(
          key: Key('themeToggleButton'),
          onPressed: () => setState(() => isDarkTheme = !isDarkTheme),
          child: Text("Toggle Theme"),
        ),
      ],
    );
  }
}
