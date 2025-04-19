import 'package:apt3065/src/screens/QuizPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Quiz Score Updates: Take quiz → Verify score update',
      (WidgetTester tester) async {
    // Mock quiz provider
    final quizProvider = QuizProvider();

    // Build the app with mocked providers
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<QuizProvider>.value(value: quizProvider),
        ],
        child: MaterialApp(
          home: QuizPage(subject: 'Physics', topic: 'Waves'),
        ),
      ),
    );

    // Step 1: Take quiz
    final answerOption = find.byKey(Key('answerOption1')); // Mock answer option
    final submitButton = find.byKey(Key('submitButton')); // Mock submit button

    // Simulate selecting an answer and submitting
    await tester.tap(answerOption);
    await tester.tap(submitButton);
    await tester.pumpAndSettle();

    // Step 2: Verify quiz score is updated
    expect(quizProvider.quizScore, greaterThan(0),
        reason:
            'Quiz score should increase after submitting a correct answer.');
  });
}

class QuizProvider extends ChangeNotifier {
  int _quizScore = 0;

  int get quizScore => _quizScore;

  void updateScore(int score) {
    _quizScore += score;
    notifyListeners();
  }
}
