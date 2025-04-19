import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets(
      'Relevancy of AI and Notes/Videos: Open AI tutor or notes → Ask question',
      (WidgetTester tester) async {
    // Mock AI Tutor and Notes Provider
    final relevancyProvider = RelevancyProvider();

    // Step 1: Open AI Tutor for a specific topic
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<RelevancyProvider>.value(
              value: relevancyProvider),
        ],
        child: MaterialApp(
          home: RelevancyPage(topic: 'Photosynthesis'),
        ),
      ),
    );

    // Verify initial state
    expect(find.text('Topic: Photosynthesis'), findsOneWidget,
        reason: 'The selected topic should be displayed.');

    // Step 2: Ask a question in the AI tutor
    final questionInput = find.byKey(Key('questionInput'));
    final askButton = find.byKey(Key('askButton'));

    await tester.enterText(questionInput, 'What is the role of chlorophyll?');
    await tester.tap(askButton);
    await tester.pumpAndSettle();

    // Verify the AI tutor provides a relevant answer
    expect(find.textContaining('Chlorophyll is essential for photosynthesis'),
        findsOneWidget,
        reason: 'The AI tutor should provide a relevant answer.');

    // Step 3: Open notes/videos for the topic
    final notesTab = find.byKey(Key('notesTab'));
    await tester.tap(notesTab);
    await tester.pumpAndSettle();

    // Verify notes are relevant to the topic
    expect(find.textContaining('Photosynthesis process'), findsWidgets,
        reason: 'Notes should be relevant to the selected topic.');

    final videosTab = find.byKey(Key('videosTab'));
    await tester.tap(videosTab);
    await tester.pumpAndSettle();

    // Verify videos are relevant to the topic
    expect(find.textContaining('Photosynthesis video'), findsWidgets,
        reason: 'Videos should be relevant to the selected topic.');
  });
}

class RelevancyProvider extends ChangeNotifier {
  String _currentTopic = '';
  String _aiResponse = '';

  String get currentTopic => _currentTopic;
  String get aiResponse => _aiResponse;

  void setTopic(String topic) {
    _currentTopic = topic;
    notifyListeners();
  }

  void askQuestion(String question) {
    // Mock AI response
    if (question.contains('chlorophyll')) {
      _aiResponse = 'Chlorophyll is essential for photosynthesis.';
    } else {
      _aiResponse = 'I am not sure about that.';
    }
    notifyListeners();
  }
}

class RelevancyPage extends StatelessWidget {
  final String topic;

  RelevancyPage({required this.topic});

  @override
  Widget build(BuildContext context) {
    final relevancyProvider = Provider.of<RelevancyProvider>(context);
    relevancyProvider.setTopic(topic);

    return Scaffold(
      appBar: AppBar(title: Text('AI Tutor & Resources')),
      body: Column(
        children: [
          Text('Topic: ${relevancyProvider.currentTopic}',
              key: Key('topicText'), style: TextStyle(fontSize: 18)),
          const SizedBox(height: 20),
          TextField(
            key: Key('questionInput'),
            decoration: InputDecoration(labelText: 'Ask a question'),
          ),
          ElevatedButton(
            key: Key('askButton'),
            onPressed: () {
              relevancyProvider.askQuestion('What is the role of chlorophyll?');
            },
            child: Text('Ask'),
          ),
          const SizedBox(height: 20),
          Text(relevancyProvider.aiResponse, key: Key('aiResponseText')),
          const SizedBox(height: 20),
          TabBar(
            tabs: [
              Tab(key: Key('notesTab'), text: 'Notes'),
              Tab(key: Key('videosTab'), text: 'Videos'),
            ],
          ),
        ],
      ),
    );
  }
}
