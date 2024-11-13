import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:iconsax/iconsax.dart';

class PendulumPhysicsLabsPage extends StatefulWidget {
  const PendulumPhysicsLabsPage({super.key});

  @override
  State<PendulumPhysicsLabsPage> createState() => _PendulumExperimentState();
}

class _PendulumExperimentState extends State<PendulumPhysicsLabsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _pendulumLength = 100.0; // Initial length of the pendulum
  int _oscillationCount = 0; // Number of completed oscillations
  List<double> _pendulumLengthData = [
    100.0
  ]; // List to store pendulum length data
  List<double> _periodData = [0.0]; // List to store period data
  late Stopwatch _stopwatch; // Stopwatch for measuring period
  late Timer? _timer;
  final FlutterTts flutterTts = FlutterTts();

  // Text-to-speech properties
  final String _experimentExplanation =
      "This experiment demonstrates the oscillation of a simple pendulum, "
      "showing the relationship between pendulum length and oscillation period. "
      "The period increases as the length of the pendulum increases, "
      "following the formula T equals 2 pi times the square root of length over gravity.";

  int _currentWordIndex = 0;
  List<String> _words = [];
  bool _isSpeaking = false; // Track if TTS is currently speaking

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: false);
    _controller.addListener(_updateGraphs);
    _stopwatch = Stopwatch();

    _words = _experimentExplanation.split(' '); // Split explanation into words

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
    _controller.removeListener(_updateGraphs);
    _controller.dispose();
    _stopwatch.stop();
    flutterTts.stop();
    super.dispose();
  }

  void _updateGraphs() {
    setState(() {
      _pendulumLengthData.add(_pendulumLength);
      double period = calculatePeriod(_pendulumLength);
      _periodData.add(period);
    });
  }

  void _startPendulum() {
    _stopwatch.reset();
    _stopwatch.start();
    _oscillationCount = 0;
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (_stopwatch.isRunning) {
        setState(() {
          _oscillationCount++;
        });
      }
    });
  }

  void _stopPendulum() {
    setState(() {
      // Optional: Reset or update state if necessary
      _stopwatch.stop(); // Stop the stopwatch to prevent time from continuing
      _timer!
          .cancel(); // Stop the timer to prevent further oscillation count updates
      _oscillationCount = 0; // Optionally reset oscillation count on stop
    });
  }

  double calculatePeriod(double length) {
    const double g = 9.81;
    return 2 * pi * sqrt(length / g);
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pendulum Experiment'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.translate(
                    offset: const Offset(0, 0),
                    child: Transform.rotate(
                      angle: sin(_controller.value * pi * 2) * pi / 4,
                      child: Container(
                        width: 2.0,
                        height: _pendulumLength,
                        color: Colors.black,
                        child: CustomPaint(
                          painter: CirclePainter(),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 50),
              Slider(
                value: _pendulumLength,
                min: 50.0,
                max: 200.0,
                divisions: 30,
                onChanged: (newValue) {
                  setState(() {
                    _pendulumLength = newValue;
                  });
                },
                label: _pendulumLength.round().toString(),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _startPendulum,
                    child: const Text('Start'),
                  ),
                  ElevatedButton(
                    onPressed: _stopPendulum,
                    child: const Text('Stop'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Sparkline(
                  data: _pendulumLengthData,
                  lineColor: Colors.blue,
                  lineWidth: 3.0,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Sparkline(
                  data: _periodData,
                  lineColor: Colors.red,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Length: ${(_pendulumLength.round() ~/ 5 * 5).toString()}',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                'Period: ${(_periodData.isNotEmpty ? _periodData.last.toStringAsFixed(2) : '0.00')} seconds',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                'Oscillation Count: $_oscillationCount',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 50),
              const Text(
                'Experiment Explanation',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
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
                        padding: const EdgeInsets.only(
                            left: 8.0,
                            bottom: 50), // Indent just for the first line
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 10
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width / 2, size.height), 10, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
