import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuizPage extends StatefulWidget {
  final String subject;

  QuizPage({required this.subject});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late List<Question> _questions;
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
          .doc('Cells')
          .collection('Quizzes')
          .get();

      setState(() {
        _questions = querySnapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return Question(
            id: doc.id,
            question: data['question'],
            options: Map<String, dynamic>.from(data['options']),
            correctAnswer: data['correctAnswer'],
          );
        }).toList();
      });
    } catch (e) {
      print("Error fetching quiz questions: $e");
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subject + ' Quiz'),
      ),
      body: _questions == null
          ? Center(child: CircularProgressIndicator()) // Show loading indicator until questions are loaded
          : ListView.builder(
              itemCount: _questions.length,
              itemBuilder: (context, index) {
                return QuestionWidget(
                  question: _questions[index],
                  onChanged: (String answer) {
                    setState(() {
                      _userAnswers[_questions[index].id] = answer;
                    });
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showResultDialog,
        child: Icon(Icons.check),
      ),
    );
  }

  void _showResultDialog() {
    int correctAnswers = 0;
    _questions.forEach((question) {
      if (_userAnswers.containsKey(question.id) &&
          _userAnswers[question.id] == question.correctAnswer) {
        correctAnswers++;
      }
    });

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Quiz Result'),
          content: Text('You got $correctAnswers out of ${_questions.length} questions correct.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
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

typedef void OnAnswerSelected(String answer);

class QuestionWidget extends StatelessWidget {
  final Question question;
  final OnAnswerSelected onChanged;

  QuestionWidget({required this.question, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.question,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ...question.options.entries.map((entry) {
              return RadioListTile(
                title: Text(entry.key),
                value: entry.key,
                groupValue: null,
                onChanged: (value) {
                  onChanged(entry.key);
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
