import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: PhysicsWavesQuiz(),
  ));
}

class PhysicsWavesQuiz extends StatefulWidget {
  @override
  _PhysicsWavesQuizState createState() => _PhysicsWavesQuizState();
}

class _PhysicsWavesQuizState extends State<PhysicsWavesQuiz> {
  Map<String, String> _answers = {};
  int _totalCorrect = 0;

  void _submitQuiz() {
    // Calculate total correct answers
    _totalCorrect = 0;
    _answers.forEach((question, selectedOption) {
      if (selectedOption == _correctAnswers[question]) {
        _totalCorrect++;
      }
    });

    // Show dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Quiz Results"),
          content: Text(
              "You got $_totalCorrect out of ${_questions.length} questions correct."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Reset answers after closing dialog
                setState(() {
                  _answers = {};
                });
              },
              child: Text(
                "Close",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  final Map<String, List<String>> _questions = {
    "1. Which of Newton's laws explains the concept of inertia?": [
      "First law",
      "Second law",
      "Third law",
      "Universal law of gravitation"
    ],
    "2. What is the formula stated by Newton's second law of motion?": [
      "F = ma",
      "F = G(m₁m₂/r²)",
      "v = u + at",
      "P = mv"
    ],
    "3. What is the action-reaction pair according to Newton's third law?": [
      "Equal in magnitude, opposite in direction",
      "Equal in magnitude, same in direction",
      "Proportional to mass",
      "Independent of direction"
    ],
    "4. What is the net force acting on an object in uniform motion?": [
      "Greater than zero",
      "Less than zero",
      "Zero",
      "Depends on the mass of the object"
    ],
    "5. What does Newton's first law of motion state about a body at rest?": [
      "It will move with constant acceleration",
      "It will remain at rest unless acted upon by an external force",
      "It will come to rest eventually",
      "It will gain velocity over time"
    ],
  };

  final Map<String, String> _correctAnswers = {
    "1. Which of Newton's laws explains the concept of inertia?": "First law ",
    "2. What is the formula stated by Newton's second law of motion?":
        "F = ma ",
    "3. What is the action-reaction pair according to Newton's third law?":
        "Equal in magnitude, opposite in direction ",
    "4. What is the net force acting on an object in uniform motion?": "Zero ",
    "5. What does Newton's first law of motion state about a body at rest?":
        "It will remain at rest unless acted upon by an external force ",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Physics Waves Quiz"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: _questions.keys.map((question) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.grey[300], // Lighter shade of orange
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        question,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // Text color black
                      ),
                    ),
                    ..._questions[question]!.map((option) {
                      return RadioListTile(
                        title: Text(
                          option,
                          style: TextStyle(
                              color: Colors.black), // Text color black
                        ),
                        groupValue: _answers[question],
                        value: option,
                        onChanged: (selectedOption) {
                          setState(() {
                            _answers[question] = selectedOption.toString();
                          });
                        },
                      );
                    }).toList(),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _submitQuiz,
        label: Text("Submit",
            style: TextStyle(color: Colors.white)), // Text color white
        backgroundColor: Colors.orange.shade900, // Darker shade of orange
      ),
    );
  }
}
