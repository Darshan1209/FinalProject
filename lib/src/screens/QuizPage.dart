import 'dart:developer';

import 'package:apt3065/src/constants/colors.dart';
import 'package:apt3065/src/utils/FlashCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  Map<String, dynamic> _userAnswers = {};

  @override
  void initState() {
    super.initState();
    _loadQuestions();
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

      log("Fetched Quiz Documents");

      setState(() {
        _questions = querySnapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          log("Processing question: ${doc.id}");

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

        log('Questions loaded: ${_questions.length}');
      });
    } catch (e) {
      log("Error fetching quiz questions: $e");
    }
  }

  void _onCardSwipe(bool isCorrect) {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _userAnswers[_questions[_currentQuestionIndex].id] =
            isCorrect ? _questions[_currentQuestionIndex].correctAnswer : null;
        _currentQuestionIndex++;
      });
    } else {
      _showResultDialog();
    }
  }

  void _showResultDialog() {
    int correctAnswers =
        _userAnswers.values.where((answer) => answer != null).length;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Quiz Result'),
          content: Text(
              'You got $correctAnswers out of ${_questions.length} questions correct.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
