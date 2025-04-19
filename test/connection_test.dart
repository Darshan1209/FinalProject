import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Displays correct connection status', (WidgetTester tester) async {
    final testWidget = MaterialApp(
      home: Scaffold(
        body: ConnectionStatusWidget(),
      ),
    );

    await tester.pumpWidget(testWidget);

    // Check initial status (Disconnected)
    expect(find.text("Disconnected"), findsOneWidget);

    // Simulate connection
    await tester.tap(find.byKey(Key('connectButton')));
    await tester.pump();

    // Check updated status (Connected)
    expect(find.text("Connected"), findsOneWidget);

    // Simulate disconnection
    await tester.tap(find.byKey(Key('disconnectButton')));
    await tester.pump();

    // Check back to Disconnected
    expect(find.text("Disconnected"), findsOneWidget);
  });
}

class ConnectionStatusWidget extends StatefulWidget {
  @override
  _ConnectionStatusWidgetState createState() => _ConnectionStatusWidgetState();
}

class _ConnectionStatusWidgetState extends State<ConnectionStatusWidget> {
  String status = "Disconnected";

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(status, key: Key('statusText')),
        ElevatedButton(
          key: Key('connectButton'),
          onPressed: () => setState(() => status = "Connected"),
          child: Text("Connect"),
        ),
        ElevatedButton(
          key: Key('disconnectButton'),
          onPressed: () => setState(() => status = "Disconnected"),
          child: Text("Disconnect"),
        ),
      ],
    );
  }
}
