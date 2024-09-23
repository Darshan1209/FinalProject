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
          content: Text("You got $_totalCorrect out of ${_questions.length} questions correct."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Reset answers after closing dialog
                setState(() {
                  _answers = {};
                });
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  final Map<String, List<String>> _questions = {
    "1. Which type of wave requires a medium for propagation?": [
      "Transverse wave",
      "Longitudinal wave ",
      "Electromagnetic wave",
      "Standing wave"
    ],
    "2. What property of a wave determines its loudness?": [
      "Frequency",
      "Amplitude ",
      "Wavelength",
      "Speed"
    ],
    "3. Which type of wave exhibits a particle motion parallel to the direction of wave propagation?": [
      "Sound wave",
      "Light wave",
      "Longitudinal wave ",
      "Transverse wave"
    ],
    "4. What is the phenomenon where two waves combine to form a new wave with a larger amplitude called?": [
      "Reflection",
      "Diffraction",
      "Interference",
      "Refraction"
    ],
    "5. What property of a wave determines its pitch?": [
      "Amplitude",
      "Frequency",
      "Wavelength",
      "Speed"
    ],
  };

  final Map<String, String> _correctAnswers = {
    "Which type of wave requires a medium for propagation?": "Longitudinal wave (Correct Answer)",
    "What property of a wave determines its loudness?": "Amplitude (Correct Answer)",
    "Which type of wave exhibits a particle motion parallel to the direction of wave propagation?": "Longitudinal wave (Correct Answer)",
    "What is the phenomenon where two waves combine to form a new wave with a larger amplitude called?": "Interference (Correct Answer)",
    "What property of a wave determines its pitch?": "Frequency (Correct Answer)",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Physics Waves Quiz"),
      ),
      backgroundColor: Colors.orange.shade400, // Darker shade of orange
      body: SingleChildScrollView(
        child: Column(
          children: _questions.keys.map((question) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.orange.shade200, // Lighter shade of orange
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        question,
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black), // Text color black
                      ),
                    ),
                    ..._questions[question]!.map((option) {
                      return RadioListTile(
                        title: Text(
                          option,
                          style: TextStyle(color: Colors.black), // Text color black
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
        label: Text("Submit", style: TextStyle(color: Colors.white)), // Text color white
        backgroundColor: Colors.orange.shade900, // Darker shade of orange
      ),
    );
  }
}
