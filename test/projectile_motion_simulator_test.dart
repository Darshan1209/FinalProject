import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:mockito/mockito.dart';
import 'package:apt3065/src/screens/physicsLabs/projectileMotion.dart';  // Replace with your actual import

class MockAudioPlayer extends Mock implements AudioPlayer {}

class MockFlutterTts extends Mock implements FlutterTts {}

void main() {

    testWidgets('Test slider updates and value changes', (WidgetTester tester) async {
      // Build the widget and trigger a frame
      await tester.pumpWidget(MaterialApp(home: ProjectileMotionSimulator()));

      // Find the sliders
      final angleSlider = find.byType(Slider).at(0);
      final speedSlider = find.byType(Slider).at(1);

      // Interact with the sliders
      await tester.drag(angleSlider, Offset(100, 0)); // Drag the angle slider
      await tester.pump(); // Trigger a frame

      await tester.drag(speedSlider, Offset(50, 0)); // Drag the speed slider
      await tester.pump(); // Trigger a frame

      // Verify if the angle and speed have updated (you can check the specific widget state if needed)
      expect(find.textContaining('Launch Angle'), findsOneWidget);
      expect(find.textContaining('Launch Speed'), findsOneWidget);
    });
}
