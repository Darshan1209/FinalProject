import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_player/video_player.dart';
import 'package:apt3065/src/screens/physics_videospage.dart'; // Update with the correct path

void main() {
  testWidgets('PhysicsVideosPage has a video player and play/pause button', (WidgetTester tester) async {
    // Build the widget tree
    await tester.pumpWidget(MaterialApp(
      home: PhysicsVideosPage(),
    ));

    // Verify that the CircularProgressIndicator is displayed initially
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Wait for the video player to initialize (simulating async behavior)
    await tester.pumpAndSettle();

    // Verify that the VideoPlayer widget is displayed after initialization
    expect(find.byType(VideoPlayer), findsOneWidget);

    // Verify that the FloatingActionButton is present (the play/pause button)
    expect(find.byType(FloatingActionButton), findsOneWidget);

    // Tap the play/pause button to play the video
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    // Verify that the play/pause button toggles correctly (i.e., the icon changes)
    expect(find.byIcon(Icons.pause), findsOneWidget);

    // Tap again to pause the video
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    // Verify the icon has changed back to play
    expect(find.byIcon(Icons.play_arrow), findsOneWidget);
  });
}
