import 'dart:ui';

import 'package:apt3065/src/constants/colors.dart';
import 'package:apt3065/src/screens/QuizPage.dart';
import 'package:flutter/material.dart';

class QuizFlashCard extends StatefulWidget {
  final Question question;
  final Function(bool) onSwipe;
  final String subject;

  const QuizFlashCard({
    super.key,
    required this.question,
    required this.onSwipe,
    required this.subject,
  });

  @override
  State<QuizFlashCard> createState() => _QuizFlashCardState();
}

class _QuizFlashCardState extends State<QuizFlashCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _positionAnimation;
  late Animation<double> _rotationAnimation;
  Color changeColor = Colors.grey.shade300;
  Color changeTextColor = Colors.black;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _positionAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  void _swipeCard(bool isCorrect) {
    setState(() {
      changeColor = isCorrect ? Colors.green : Colors.red;
      changeTextColor = Colors.white;
    });

    _positionAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: isCorrect
          ? const Offset(2.0, -0.5) // Swipe right
          : const Offset(-2.0, -0.5), // Swipe left
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: isCorrect ? 0.2 : -0.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward().then(
      (_) {
        _controller.reset();
        widget.onSwipe(isCorrect);
        setState(
          () {
            changeColor = Colors.grey.shade300;
            changeTextColor = Colors.black;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Color bgcolor = GeneralAppColors.chemistryColor;
    if (widget.subject == 'Chemistry') {
      bgcolor = GeneralAppColors.chemistryColor;
    } else if (widget.subject == 'Physics') {
      bgcolor = GeneralAppColors.physicsColor;
    } else if (widget.subject == 'Biology') {
      bgcolor = GeneralAppColors.biologyColor;
    }
    return Scaffold(
      backgroundColor: bgcolor,
      body: SafeArea(
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.translate(
                    offset: _positionAnimation.value *
                        MediaQuery.of(context).size.width,
                    child: Transform.rotate(
                      angle: _rotationAnimation.value,
                      child: child,
                    ),
                  );
                },
                child: GestureDetector(
                  onHorizontalDragEnd: (details) {
                    if (details.primaryVelocity! > 0) {
                      _swipeCard(true); // Swiped right
                    } else {
                      _swipeCard(false); // Swiped left
                    }
                  },
                  child: Card(
                    color: changeColor,
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Container(
                      width: 300,
                      height: 400,
                      padding: EdgeInsets.all(16.0),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.question.question,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: changeTextColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                              childAspectRatio: 1.3, // Adjust ratio as needed
                              children:
                                  widget.question.options.entries.map((entry) {
                                return GestureDetector(
                                  onTap: () {
                                    _swipeCard(entry.key ==
                                        widget.question.correctAnswer);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(3.0),
                                    decoration: BoxDecoration(
                                        color: changeColor,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: const Offset(0, 1),
                                          ),
                                        ]),
                                    child: Text(
                                      entry.key,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: changeTextColor),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
