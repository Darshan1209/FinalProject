import 'package:flutter/material.dart';

class ContinuousScrollingBackground extends StatefulWidget {
  @override
  _ContinuousScrollingBackgroundState createState() =>
      _ContinuousScrollingBackgroundState();
}

class _ContinuousScrollingBackgroundState
    extends State<ContinuousScrollingBackground>
    with SingleTickerProviderStateMixin {
  double _offset1 = 0.0;
  double _offset2 = 300.0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
    )..repeat(reverse: true);
    _controller.addListener(() {
      setState(() {
        _offset1 -= 1.0;
        _offset2 -= 1.0;
        if (_offset1 <= -300.0) {
          _offset1 = 300.0;
        }
        if (_offset2 <= -300.0) {
          _offset2 = 300.0;
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Cancel the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 50),
            curve: Curves.linear,
            transform: Matrix4.translationValues(0.0, _offset1, 0.0),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/landingbg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 50),
            curve: Curves.linear,
            transform: Matrix4.translationValues(0.0, _offset2, 0.0),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/landingbg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
