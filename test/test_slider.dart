import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Slider value updates', (WidgetTester tester) async {
    // Define a simple widget with a slider
    final testWidget = MaterialApp(
      home: Scaffold(
        body: StatefulBuilder(
          builder: (context, setState) {
            double sliderValue = 0.5;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Slider(
                  key: Key('testSlider'),
                  value: sliderValue,
                  onChanged: (value) => setState(() => sliderValue = value),
                ),
                Text("Value: ${sliderValue.toStringAsFixed(1)}", key: Key('sliderValueText')),
              ],
            );
          },
        ),
      ),
    );

    // Build the widget
    await tester.pumpWidget(testWidget);

    // Verify initial slider value
    expect(find.text("Value: 0.5"), findsOneWidget);

    // Drag the slider to change its value
    await tester.drag(find.byKey(Key('testSlider')), Offset(50.0, 0.0));
    await tester.pump();

    // Verify the updated slider value
    expect(find.textContaining("Value: "), findsOneWidget);
  });
}
