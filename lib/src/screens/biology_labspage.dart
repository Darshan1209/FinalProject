import 'dart:async';
import 'dart:math';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AcidBaseLabsPage extends StatefulWidget {
  const AcidBaseLabsPage({super.key});

  @override
  _BouncingBallsScreenState createState() => _BouncingBallsScreenState();
}

class _BouncingBallsScreenState extends State<AcidBaseLabsPage> {
  late Timer timer;
  final List<Ball> balls = [];
  final int numAcidBalls = 10;
  final int numBaseBalls = 2;

  bool showResultants = false;
  FlutterTts flutterTts = FlutterTts(); // TTS instance

  @override
  void initState() {
    super.initState();
    initializeAcidBalls();
    startSimulation();
    _words = _experimentExplanation.split(' ');

    flutterTts.setCompletionHandler(() {
      setState(() {
        _currentWordIndex = 0; // Reset once the reading is complete
        _isSpeaking = false;
      });
    });

    flutterTts
        .setProgressHandler((String text, int start, int end, String word) {
      setState(() {
        _currentWordIndex = _words.indexWhere((w) => w.contains(word));
      });
    });
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

  String _experimentExplanation = """
 This experiment simulates an acid-base reaction. When HCl, a strong acid, reacts with NaOH, a strong base, they neutralize each other to form water (H₂O) and salt (NaCl).The presence of H+ ions (acid) and OH- ions (base) initially represents the reactants. 
After the reaction, the resultant products shown are water molecules and sodium chloride.
""";
  int _currentWordIndex = 0;
  List<String> _words = [];
  bool _isSpeaking = false;

  Future _speak() async {
    if (_isSpeaking) {
      // Stop the reading if it's already in progress
      await flutterTts.stop();
      setState(() {
        _isSpeaking = false;
        _currentWordIndex = 0; // Reset the index when stopping
      });
    } else {
      // Start reading if TTS is not currently active
      setState(() {
        _isSpeaking = true;
      });
      await flutterTts.setLanguage("en-US");
      await flutterTts.setSpeechRate(0.4);
      await flutterTts.speak(_experimentExplanation);
    }
  }

  void startSimulation() {
    timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
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
    Future.delayed(const Duration(seconds: 5), () {
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
        position: const Offset(100, 50),
        velocity: const Offset(0, 1),
        radius: 20,
        color: Colors.orangeAccent, // H2+ with increased intensity
        text: "H2+",
      ),
      Ball(
        position: const Offset(200, 50),
        velocity: const Offset(-1, -1),
        radius: 20,
        color: Colors.blue, // Cl-
        text: "Cl-",
      ),
      Ball(
        position: const Offset(100, 150),
        velocity: const Offset(1, -1),
        radius: 20,
        color: Colors.red, // O- with a different color
        text: "O-",
      ),
      Ball(
        position: const Offset(200, 150),
        velocity: const Offset(-1, 1),
        radius: 20,
        color: Colors.yellow, // Na+
        text: "Na+",
      ),
      Ball(
        position: const Offset(100, 50),
        velocity: const Offset(0, 1),
        radius: 20,
        color: Colors.orangeAccent, // H2+ with increased intensity
        text: "H2+",
      ),
      Ball(
        position: const Offset(200, 50),
        velocity: const Offset(-1, -1),
        radius: 20,
        color: Colors.blue, // Cl-
        text: "Cl-",
      ),
      Ball(
        position: const Offset(100, 150),
        velocity: const Offset(1, -1),
        radius: 20,
        color: Colors.red, // O- with a different color
        text: "O-",
      ),
      Ball(
        position: const Offset(200, 150),
        velocity: const Offset(-1, 1),
        radius: 20,
        color: Colors.yellow, // Na+
        text: "Na+",
      ),
      Ball(
        position: const Offset(100, 50),
        velocity: const Offset(0, 1),
        radius: 20,
        color: Colors.orangeAccent, // H2+ with increased intensity
        text: "H2+",
      ),
      Ball(
        position: const Offset(200, 50),
        velocity: const Offset(-1, -1),
        radius: 20,
        color: Colors.blue, // Cl-
        text: "Cl-",
      ),
      Ball(
        position: const Offset(100, 150),
        velocity: const Offset(1, -1),
        radius: 20,
        color: Colors.red, // O- with a different color
        text: "O-",
      ),
      Ball(
        position: const Offset(200, 150),
        velocity: const Offset(-1, 1),
        radius: 20,
        color: Colors.yellow, // Na+
        text: "Na+",
      ),
    ]);
  }

  void startResultantSimulation() {
    timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
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
        title: const Text('AcidBase Experiment'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 200,
                decoration: const BoxDecoration(
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
                                style: const TextStyle(
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
              const SizedBox(height: 20),
              FloatingActionButton.extended(
                onPressed: () {
                  if (showResultants) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
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
                icon: const Icon(Icons.add),
                label: const Text('Add Base'), // This is where you add the text
              ),
              Column(
                children: [
                  if (!showResultants) // Display the first text if showResultants is false
                    const Padding(
                      padding: EdgeInsets.only(
                          top: 70.0), // Adjust the padding as needed
                      child: Text(
                        'HCl (Acid) + NaOH (Base)',
                        style: TextStyle(
                            fontSize: 30), // Increase the font size here
                      ),
                    ),
                  if (showResultants) // Conditionally display the result text
                    const Padding(
                      padding: EdgeInsets.only(
                          top: 70.0), // Adjust the padding as needed
                      child: Text(
                        'H2O + NaCl + H2',
                        style: TextStyle(
                            fontSize: 30), // Increase the font size here
                      ),
                    ),
                ],
              ),
              Text(
                'Experiment Explanation',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: _speak,
                      icon: Icon(
                          _isSpeaking ? Iconsax.stop : Iconsax.volume_high),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 50),
                        child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            children: _words.asMap().entries.map((entry) {
                              int idx = entry.key;
                              String word = entry.value;
                              return TextSpan(
                                text: "$word ",
                                style: TextStyle(
                                  fontFamily: 'Balsamiq Sans',
                                  color: idx <= _currentWordIndex
                                      ? Colors.blue
                                      : Colors.black,
                                  fontSize: 18,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
      duration: const Duration(seconds: 2),
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
          size: const Size(300, 200),
          painter: LiquidPainter(
            waveOffset: _controller.value,
            color: widget.showResultants
                ? Colors.lightBlueAccent
                : Colors.redAccent,
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
      ..quadraticBezierTo(
          size.width / 4 + 50 * sin(waveOffset * 2 * pi),
          50 + 20 * sin(waveOffset * 2 * pi),
          size.width / 2,
          25 + 20 * sin(waveOffset * 2 * pi))
      ..quadraticBezierTo(
          size.width * 3 / 4 + 50 * sin(waveOffset * 2 * pi),
          50 + 20 * sin(waveOffset * 2 * pi),
          size.width,
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
