import 'dart:developer' as yap;
import 'dart:math';

import 'package:apt3065/src/constants/colors.dart';
import 'package:apt3065/src/utils/FlashCard.dart';
import 'package:apt3065/src/utils/responsive_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  final String subject;
  final String topic;

  const QuizPage({
    super.key,
    required this.subject,
    required this.topic,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late ConfettiController _confettiController;
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  Map<String, dynamic> _userAnswers = {};

  @override
  void initState() {
    super.initState();
    _loadQuestions();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 5));
  }

  void _loadQuestions() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Subjects')
          .doc(widget.subject)
          .collection('Topics')
          .doc(widget.topic)
          .collection('Quizzes')
          .get();

      yap.log("Fetched Quiz Documents");

      setState(() {
        _questions = querySnapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          yap.log("Processing question: ${doc.id}");

          // Extract the options and sort them alphabetically by key
          Map<String, bool> options = {};
          String correctAnswer = "";

          data.forEach((key, value) {
            options[key] = value as bool;
            if (value == true) {
              correctAnswer = key; // Store the correct answer
            }
          });

          // Sort options by their keys (e.g., A, B, C, D)
          final sortedOptions = Map.fromEntries(
            options.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
          );

          return Question(
            id: doc.id,
            question: doc.id, // The question is the document ID
            options: sortedOptions,
            correctAnswer: correctAnswer,
          );
        }).toList();

        yap.log('Questions loaded: ${_questions.length}');
      });
    } catch (e) {
      yap.log("Error fetching quiz questions: $e");
    }
  }

  void _onCardSwipe(bool isCorrect) {
    setState(() {
      // Record the user's answer
      _userAnswers[_questions[_currentQuestionIndex].id] =
          isCorrect ? _questions[_currentQuestionIndex].correctAnswer : null;

      // If it's not the last question, move to the next
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        // Show the result dialog for the last question
        _showResultDialog();
      }
    });
  }

  void _restartQuiz() {
    setState(() {
      _currentQuestionIndex = 0; // Reset question index
      _userAnswers.clear(); // Clear user answers
    });
  }

  void _showResultDialog() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    Color subjectColor;
    if (widget.subject == 'Physics') {
      subjectColor = GeneralAppColors.physicsColor;
    } else if (widget.subject == 'Chemistry') {
      subjectColor = GeneralAppColors.chemistryColor;
    } else {
      subjectColor = GeneralAppColors.biologyColor;
    }
    _confettiController.play();
    int correctAnswers =
        _userAnswers.values.where((answer) => answer != null).length;
    double progress = correctAnswers / _questions.length;

    showDialog(
      context: context,
      builder: (context) {
        return Stack(
          children: [
            AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: Colors.grey[850],
              title: Column(
                children: [
                  Icon(
                    correctAnswers == _questions.length
                        ? Icons.emoji_events_rounded
                        : Icons.quiz_rounded,
                    color: subjectColor,
                    size: 50,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Quiz Results!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'You answered $correctAnswers out of ${_questions.length} questions correctly.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Circular Progress Bar
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.white.withOpacity(0.2),
                          valueColor:
                              AlwaysStoppedAnimation<Color>(subjectColor),
                          strokeWidth: 8,
                        ),
                      ),
                      Text(
                        '${(progress * 100).toStringAsFixed(0)}%',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (correctAnswers == _questions.length)
                    const Text(
                      '🎉 Amazing job! You aced it!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                      ),
                      textAlign: TextAlign.center,
                    )
                  else if (correctAnswers >= _questions.length / 2)
                    const Text(
                      '👏 Good effort! Keep practicing!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                      textAlign: TextAlign.center,
                    )
                  else
                    const Text(
                      '💪 Don\'t worry, you’ll get better!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                ],
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop(); // Exit the quiz
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: transformWidth(width, 17),
                            vertical: transformHeight(height, 8)),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red),
                        child: Text(
                          'Exit',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: transformWidth(width, 16)),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(); // Close the dialog
                        _restartQuiz(); // Restart the quiz
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: transformWidth(width, 17),
                            vertical: transformHeight(height, 8)),
                        decoration: BoxDecoration(
                          border: Border.all(color: subjectColor),
                          borderRadius: BorderRadius.circular(10),
                          color: subjectColor,
                        ),
                        child: Text(
                          'Restart',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: transformWidth(width, 16)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirection: pi / 4,
                emissionFrequency: 0.05,
                numberOfParticles: 15,
                gravity: 0.1,
                shouldLoop: false,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple,
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirection: 3 * pi / 4,
                emissionFrequency: 0.05,
                numberOfParticles: 15,
                gravity: 0.1,
                shouldLoop: false,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple,
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Color subjectColor;
    if (widget.subject == 'Physics') {
      subjectColor = GeneralAppColors.physicsColor;
    } else if (widget.subject == 'Chemistry') {
      subjectColor = GeneralAppColors.chemistryColor;
    } else {
      subjectColor = GeneralAppColors.biologyColor;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: subjectColor,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        title: Text('${widget.subject} Quiz'),
      ),
      body: _questions.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : QuizFlashCard(
              question: _questions[_currentQuestionIndex],
              onSwipe: _onCardSwipe,
              subject: widget.subject,
            ),
    );
  }
}

class Question {
  final String id;
  final String question;
  final Map<String, dynamic> options;
  final String correctAnswer;

  Question({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
  });
}
