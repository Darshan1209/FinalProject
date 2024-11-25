import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: BiologyQuiz(),
  ));
}

class BiologyQuiz extends StatefulWidget {
  @override
  _BiologyQuizState createState() => _BiologyQuizState();
}

class _BiologyQuizState extends State<BiologyQuiz> {
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
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  final Map<String, List<String>> _questions = {
    "1. What is the powerhouse of the cell?": [
      "Nucleus",
      "Golgi apparatus",
      "Mitochondria",
      "Endoplasmic reticulum"
    ],
    "2. Which organelle is responsible for protein synthesis?": [
      "Golgi apparatus",
      "Ribosome",
      "Lysosome",
      "Vacuole"
    ],
    "3. What is the function of the cell membrane?": [
      "Storage of genetic material",
      "Synthesis of ATP",
      "Regulation of materials entering and exiting the cell",
      "Breakdown of cellular waste"
    ],
    "4. Which organelle contains digestive enzymes and is involved in breaking down cellular waste?":
        ["Nucleus", "Endoplasmic reticulum", "Lysosome", "Chloroplast"],
    "5. Which organelle is responsible for photosynthesis in plant cells?": [
      "Mitochondria",
      "Nucleus",
      "Chloroplast",
      "Ribosome"
    ],
  };

  final Map<String, String> _correctAnswers = {
    "1. What is the powerhouse of the cell?": "Mitochondria",
    "2. Which organelle is responsible for protein synthesis?": "Ribosome",
    "3. What is the function of the cell membrane?":
        "Regulation of materials entering and exiting the cell",
    "4. Which organelle contains digestive enzymes and is involved in breaking down cellular waste?":
        "Lysosome",
    "5. Which organelle is responsible for photosynthesis in plant cells?":
        "Chloroplast",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Biology - Cell Quiz"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: _questions.keys.map((question) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.grey[300], // Lighter shade of green
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        question,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(
                                255, 0, 0, 0)), // Text color white
                      ),
                    ),
                    ..._questions[question]!.map((option) {
                      return RadioListTile(
                        hoverColor: Colors.red,
                        fillColor: MaterialStateProperty.all(Colors.red),
                        title: Text(
                          option,
                          style: TextStyle(
                              color: const Color.fromARGB(
                                  255, 0, 0, 0)), // Text color white
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
        backgroundColor: Colors.green.shade900, // Darker shade of green
      ),
    );
  }
}
