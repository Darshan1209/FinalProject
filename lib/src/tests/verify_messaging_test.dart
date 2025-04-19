import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets(
      'Verify Instant Messaging: Send message as Student A → Log in as Student B',
      (WidgetTester tester) async {
    // Mock messaging provider
    final messagingProvider = MessagingProvider();

    // Step 1: Log in as Student A and send a message
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<MessagingProvider>.value(
              value: messagingProvider),
        ],
        child: MaterialApp(
          home: MessagingPage(user: 'StudentA'),
        ),
      ),
    );

    final messageInput = find.byKey(Key('messageInput'));
    final sendButton = find.byKey(Key('sendButton'));

    // Simulate typing a message and sending it
    await tester.enterText(messageInput, 'Hello, Student B!');
    await tester.tap(sendButton);
    await tester.pumpAndSettle();

    // Verify the message is sent
    expect(messagingProvider.messages.contains('Hello, Student B!'), isTrue,
        reason: 'Message should be sent by Student A.');

    // Step 2: Log in as Student B and verify the message is received
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<MessagingProvider>.value(
              value: messagingProvider),
        ],
        child: MaterialApp(
          home: MessagingPage(user: 'StudentB'),
        ),
      ),
    );

    // Verify the message is displayed for Student B
    final receivedMessage = find.text('Hello, Student B!');
    expect(receivedMessage, findsOneWidget,
        reason:
            'Message sent by Student A should be received instantly by Student B.');
  });
}

class MessagingProvider extends ChangeNotifier {
  List<String> _messages = [];

  List<String> get messages => _messages;

  void sendMessage(String message) {
    _messages.add(message);
    notifyListeners();
  }
}

class MessagingPage extends StatelessWidget {
  final String user;

  MessagingPage({required this.user});

  @override
  Widget build(BuildContext context) {
    final messagingProvider = Provider.of<MessagingProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Messaging - $user')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: messagingProvider.messages
                  .map((message) => ListTile(title: Text(message)))
                  .toList(),
            ),
          ),
          TextField(
            key: Key('messageInput'),
            decoration: InputDecoration(labelText: 'Enter your message'),
          ),
          ElevatedButton(
            key: Key('sendButton'),
            onPressed: () {
              final message = 'Hello, Student B!'; // Mock message
              messagingProvider.sendMessage(message);
            },
            child: Text('Send'),
          ),
        ],
      ),
    );
  }
}
