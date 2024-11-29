import 'package:flutter/material.dart';

class ChemistryTitrationQuiz extends StatefulWidget {
  const ChemistryTitrationQuiz({super.key});

  @override
  State<ChemistryTitrationQuiz> createState() => _ChemistryTitrationQuizState();
}

class _ChemistryTitrationQuizState extends State<ChemistryTitrationQuiz> {
  Map<String, String> _answers = {};
  int _totalCorrect = 0;

  void _submitQuiz() {
    // Calculate total correct answers
    _totalCorrect = 0;
    _answers.forEach((question, selectedOption) {
      if (selectedOption.trim() == _correctAnswers[question]?.trim()) {
        _totalCorrect++;
      }
    });

    // Show dialog with improved UI
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Column(
            children: [
              Icon(
                Icons.quiz_outlined,
                size: 60,
                color: Colors.blueAccent,
              ),
              const SizedBox(height: 10),
              Text(
                "Quiz Results",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "You got $_totalCorrect out of ${_questions.length} questions correct!",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[800],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              LinearProgressIndicator(
                value: _totalCorrect / _questions.length,
                backgroundColor: Colors.grey[300],
                color: Colors.blueAccent,
                minHeight: 8,
              ),
              const SizedBox(height: 10),
              Text(
                "${((_totalCorrect / _questions.length) * 100).toStringAsFixed(1)}% Score",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Reset answers after closing dialog
                setState(() {
                  _answers = {};
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
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
    "1. What defines an acid according to the Brønsted-Lowry theory?": [
      "A substance that donates protons",
      "A substance that accepts protons",
      "A substance that increases hydroxide ion concentration",
      "A substance that decreases hydrogen ion concentration"
    ],
    "2. What is the pH of a neutral solution at 25°C?": [
      "0",
      "7",
      "14",
      "Depends on the concentration of ions"
    ],
    "3. What is formed when an acid reacts with a base in a neutralization reaction?":
        [
      "Salt and water",
      "Salt and hydrogen gas",
      "Water and carbon dioxide",
      "Hydrogen gas and oxygen"
    ],
    "4. What type of acid is hydrochloric acid (HCl)?": [
      "Weak acid",
      "Strong acid",
      "Organic acid",
      "Amphoteric acid"
    ],
    "5. Which of the following is an example of a weak base?": [
      "Sodium hydroxide (NaOH)",
      "Ammonia (NH₃)",
      "Calcium hydroxide (Ca(OH)₂)",
      "Potassium hydroxide (KOH)"
    ],
  };

  final Map<String, String> _correctAnswers = {
    "1. What defines an acid according to the Brønsted-Lowry theory?":
        "A substance that donates protons",
    "2. What is the pH of a neutral solution at 25°C?": "7",
    "3. What is formed when an acid reacts with a base in a neutralization reaction?":
        "Salt and water",
    "4. What type of acid is hydrochloric acid (HCl)?": "Strong acid",
    "5. Which of the following is an example of a weak base?": "Ammonia (NH₃)",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chemistry Titration Quiz"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: _questions.keys.map((question) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.grey[300], // Lighter shade of blue
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        question,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // Text color black
                      ),
                    ),
                    ..._questions[question]!.map((option) {
                      return RadioListTile(
                        title: Text(
                          option,
                          style: const TextStyle(
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
        label: const Text("Submit",
            style: TextStyle(color: Colors.white)), // Text color white
        backgroundColor: Colors.blue.shade900, // Darker shade of blue
      ),
    );
  }
}
