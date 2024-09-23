import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:chart_sparkline/chart_sparkline.dart';

class PhysicsLabsPage extends StatefulWidget {
  @override
  _PendulumExperimentState createState() => _PendulumExperimentState();
}

class _PendulumExperimentState extends State<PhysicsLabsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _pendulumLength = 100.0; // Initial length of the pendulum
  int _oscillationCount = 0; // Number of completed oscillations
  List<double> _pendulumLengthData = [100.0]; // List to store pendulum length data
  List<double> _periodData = [0.0]; // List to store period data
  late Stopwatch _stopwatch; // Stopwatch for measuring period
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: false);
    _controller.addListener(_updateGraphs); // Listen for animation updates
    _stopwatch = Stopwatch();
  }

  @override
  void dispose() {
    _controller.removeListener(_updateGraphs);
    _controller.dispose();
    _stopwatch.stop();
    super.dispose();
  }

  void _updateGraphs() {
    setState(() {
      // _pendulumLengthData.add(_pendulumLength);
      // _periodData.add(_stopwatch.elapsedMilliseconds / (_oscillationCount * 1000));
      _pendulumLengthData.add(_pendulumLength);
      double period = calculatePeriod(_pendulumLength); // Calculate period using the length
      _periodData.add(period);

    });
  }

  void _startPendulum() {
    _stopwatch.reset();
    _stopwatch.start();
    _oscillationCount = 0;
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (_stopwatch.isRunning) {
        setState(() {
          _oscillationCount++;
        });
      }
    });
  }

  void _stopPendulum() {
    _stopwatch.stop();
    _timer.cancel();
  }

  double calculatePeriod(double length) {
    // Assuming standard gravity of 9.81 m/s^2
    const double g = 9.81;
    return 2 * pi * sqrt(length / g);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pendulum Experiment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Container(
                  width: 2.0,
                  height: _pendulumLength,
                  child: Transform.translate(
                    offset: Offset(0, 0),
                    child: Transform.rotate(
                      angle: sin(_controller.value * pi * 2) * pi / 4, // Adjust the amplitude as needed
                      child: Container(
                        width: 2.0,
                        height: _pendulumLength,
                        color: Colors.black,
                        child: CustomPaint(
                          painter: CirclePainter(),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Slider(
              value: _pendulumLength,
              min: 50.0,
              max: 200.0,
              divisions: 30, // Adjust based on your preference for increments
              onChanged: (newValue) {
                setState(() {
                  _pendulumLength = newValue;
                });
              },
              label: _pendulumLength.round().toString(), // Display the current value of the slider as the label
            ),

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _startPendulum();
                  },
                  child: Text('Start'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _stopPendulum();
                  },
                  child: Text('Stop'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Sparkline(
                data: _pendulumLengthData,
                lineColor: Colors.blue,
                lineWidth: 3.0, // Adjust the thickness as needed
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Sparkline(
                data: _periodData,
                lineColor: Colors.red,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Length: ${(_pendulumLength.round() ~/ 5 * 5).toString()}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Period: ${(_periodData.isNotEmpty ? _periodData.last.toStringAsFixed(2) : '0.00')} seconds',
              style: TextStyle(fontSize: 16),
            ),

            Text(
              'Oscillation Count: $_oscillationCount',
              style: TextStyle(fontSize: 16),
            ),
          ],
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

