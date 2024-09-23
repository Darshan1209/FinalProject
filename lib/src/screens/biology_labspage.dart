import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';


class BiologyLabsPage extends StatefulWidget {
  @override
  _BouncingBallsScreenState createState() => _BouncingBallsScreenState();
}

class _BouncingBallsScreenState extends State<BiologyLabsPage> {
  late Timer timer;
  final List<Ball> balls = [];
  final int numAcidBalls = 10;
  final int numBaseBalls = 2;

  bool showResultants = false;

  @override
  void initState() {
    super.initState();
    initializeAcidBalls();
    startSimulation();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void initializeAcidBalls() {
    final random = Random();
    balls.clear();
    bool isOrange = true;
    for (int i = 0; i < numAcidBalls; i++) {
      double x = (i % 3) * 100 + 50;
      double y = (i < 3) ? 50 : 150;
      balls.add(Ball(
        position: Offset(
          x + random.nextDouble() * 50,
          y + random.nextDouble() * 50,
        ),
        velocity: Offset(
          random.nextDouble() * 2 - 1,
          random.nextDouble() * 2 - 1,
        ),
        radius: 20,
        color: isOrange ? Colors.orange : Colors.blue,
        text: isOrange ? "H+" : "Cl-",
      ));
      isOrange = !isOrange;
    }
  }

  void startSimulation() {
    timer = Timer.periodic(Duration(milliseconds: 16), (timer) {
      setState(() {
        for (var ball in balls) {
          ball.move();
          ball.bounce(300, 200);
        }
      });
    });
  }

  void addBase() {
    setState(() {
      final random = Random();
      bool isNaPlus = true;
      for (int i = 0; i < numBaseBalls; i++) {
        double x = (i % 3) * 100 + 50;
        double y = (i < 3) ? 50 : 150;
        balls.add(Ball(
          position: Offset(
            x + random.nextDouble() * 50,
            y + random.nextDouble() * 50,
          ),
          velocity: Offset(
            random.nextDouble() * 2 - 1,
            random.nextDouble() * 2 - 1,
          ),
          radius: 20,
          color: isNaPlus ? Colors.yellow : Colors.green,
          text: isNaPlus ? "Na+" : "OH-",
        ));
        isNaPlus = !isNaPlus;
      }
    });
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        showResultants = true;
        initializeResultBalls();
        startResultantSimulation();
      });
    });
  }
  //


  void initializeResultBalls() {
    balls.clear();
    balls.addAll([
      Ball(
        position: Offset(100, 50),
        velocity: Offset(0, 1),
        radius: 20,
        color: Colors.orangeAccent, // H2+ with increased intensity
        text: "H2+",
      ),
      Ball(
        position: Offset(200, 50),
        velocity: Offset(-1, -1),
        radius: 20,
        color: Colors.blue, // Cl-
        text: "Cl-",
      ),
      Ball(
        position: Offset(100, 150),
        velocity: Offset(1, -1),
        radius: 20,
        color: Colors.red, // O- with a different color
        text: "O-",
      ),
      Ball(
        position: Offset(200, 150),
        velocity: Offset(-1, 1),
        radius: 20,
        color: Colors.yellow, // Na+
        text: "Na+",
      ),
      Ball(
        position: Offset(100, 50),
        velocity: Offset(0, 1),
        radius: 20,
        color: Colors.orangeAccent, // H2+ with increased intensity
        text: "H2+",
      ),
      Ball(
        position: Offset(200, 50),
        velocity: Offset(-1, -1),
        radius: 20,
        color: Colors.blue, // Cl-
        text: "Cl-",
      ),
      Ball(
        position: Offset(100, 150),
        velocity: Offset(1, -1),
        radius: 20,
        color: Colors.red, // O- with a different color
        text: "O-",
      ),
      Ball(
        position: Offset(200, 150),
        velocity: Offset(-1, 1),
        radius: 20,
        color: Colors.yellow, // Na+
        text: "Na+",
      ),
      Ball(
        position: Offset(100, 50),
        velocity: Offset(0, 1),
        radius: 20,
        color: Colors.orangeAccent, // H2+ with increased intensity
        text: "H2+",
      ),
      Ball(
        position: Offset(200, 50),
        velocity: Offset(-1, -1),
        radius: 20,
        color: Colors.blue, // Cl-
        text: "Cl-",
      ),
      Ball(
        position: Offset(100, 150),
        velocity: Offset(1, -1),
        radius: 20,
        color: Colors.red, // O- with a different color
        text: "O-",
      ),
      Ball(
        position: Offset(200, 150),
        velocity: Offset(-1, 1),
        radius: 20,
        color: Colors.yellow, // Na+
        text: "Na+",
      ),
    ]);
  }
  void startResultantSimulation() {
    timer = Timer.periodic(Duration(milliseconds: 16), (timer) {
      setState(() {
        for (var ball in balls) {
          ball.move();
          ball.bounce(300, 200);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AcidBase Experiment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(width: 2.0, color: Colors.black),
                  right: BorderSide(width: 2.0, color: Colors.black),
                  bottom: BorderSide(width: 2.0, color: Colors.black),
                ),
              ),
              child: Stack(
                children: [
                  LiquidContainer(showResultants: showResultants),
                  Stack(
                    children: balls.map((ball) {
                      return Positioned(
                        left: ball.position.dx - ball.radius,
                        top: ball.position.dy - ball.radius,
                        child: Container(
                          width: ball.radius * 2,
                          height: ball.radius * 2,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ball.color,
                          ),
                          child: Center(
                            child: Text(
                              ball.text,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            FloatingActionButton.extended(
              onPressed: () {
                if (showResultants) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Invalid action"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  // Your existing logic for when the results are not shown
                  addBase();
                }
              },
              tooltip: 'Add Base',
              icon: Icon(Icons.add),
              label: Text('Add Base'), // This is where you add the text
            ),
            Column(
              children: [
                if (!showResultants) // Display the first text if showResultants is false
                  Padding(
                    padding: EdgeInsets.only(top: 70.0), // Adjust the padding as needed
                    child: Text(
                      'HCl (Acid) + NaOH (Base)',
                      style: TextStyle(fontSize: 30), // Increase the font size here
                    ),
                  ),
                if (showResultants) // Conditionally display the result text
                  Padding(
                    padding: EdgeInsets.only(top: 70.0), // Adjust the padding as needed
                    child: Text(
                      'H2O + NaCl + H2',
                      style: TextStyle(fontSize: 30), // Increase the font size here
                    ),
                  ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

class Ball {
  Offset position;
  Offset velocity;
  final double radius;
  final Color color;
  final String text;

  Ball({
    required this.position,
    required this.velocity,
    required this.radius,
    required this.color,
    required this.text,
  });

  void move() {
    position += velocity;
  }

  void bounce(double containerWidth, double containerHeight) {
    if (position.dx + radius >= containerWidth || position.dx - radius <= 0) {
      velocity = Offset(-velocity.dx, velocity.dy);
    }
    if (position.dy + radius >= containerHeight || position.dy - radius <= 0) {
      velocity = Offset(velocity.dx, -velocity.dy);
    }
  }
}

class LiquidContainer extends StatefulWidget {
  final bool showResultants;

  LiquidContainer({required this.showResultants});

  @override
  _LiquidContainerState createState() => _LiquidContainerState();
}

class _LiquidContainerState extends State<LiquidContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(300, 200),
          painter: LiquidPainter(
            waveOffset: _controller.value,
            color: widget.showResultants ? Colors.lightBlueAccent : Colors.redAccent,
          ),
        );
      },
    );
  }
}

class LiquidPainter extends CustomPainter {
  final double waveOffset;
  final Color color;

  LiquidPainter({required this.waveOffset, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(size.width / 4 + 50 * sin(waveOffset * 2 * pi), 50 + 20 * sin(waveOffset * 2 * pi), size.width / 2,
          25 + 20 * sin(waveOffset * 2 * pi))
      ..quadraticBezierTo(size.width * 3 / 4 + 50 * sin(waveOffset * 2 * pi), 50 + 20 * sin(waveOffset * 2 * pi), size.width,
          25 + 20 * sin(waveOffset * 2 * pi))
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
