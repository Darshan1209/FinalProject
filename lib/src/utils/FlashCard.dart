import 'package:flutter/material.dart';

class QuizFlashCard extends StatefulWidget {
  @override
  _QuizFlashCardState createState() => _QuizFlashCardState();
}

class _QuizFlashCardState extends State<QuizFlashCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _positionAnimation;
  late Animation<double> _rotationAnimation;
  Color changeColor = Colors.grey;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _positionAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(2.0, 0.5), // Moves slightly diagonally
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.2, // Slight rotation
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  void _swipeCard(
    bool isCorrect,
  ) {
    setState(() {
      changeColor = isCorrect ? Colors.green : Colors.red;
    });

    _positionAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: isCorrect
          ? const Offset(2.0, -0.5) // Swipe right with curve
          : const Offset(-2.0, -0.5), // Swipe left with curve
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: isCorrect ? 0.2 : -0.2, // Rotate based on swipe direction
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward().then((_) {
      _controller.reset();
      setState(() {
        changeColor = Colors.grey; // Reset color after swipe
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                    // Swiped right
                    _swipeCard(true);
                  } else {
                    // Swiped left
                    _swipeCard(false);
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
                    alignment: Alignment.center,
                    child: Text(
                      "Question goes here",
                      style: TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
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
