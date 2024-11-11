import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:iconsax/iconsax.dart';

class ProjectileMotionSimulator extends StatefulWidget {
  @override
  _ProjectileMotionSimulatorState createState() =>
      _ProjectileMotionSimulatorState();
}

class _ProjectileMotionSimulatorState extends State<ProjectileMotionSimulator>
    with TickerProviderStateMixin {
  double launchAngle = 45.0; // Launch angle in degrees
  double launchSpeed = 20.0; // Launch speed in m/s
  double time = 0.0;
  double x = 0.0;
  double y = 0.0;
  List<Offset> trajectoryPoints = [];

  // Constants
  final double gravity = 9.8;
  late AnimationController _controller;
  late AudioPlayer _audioPlayer; // Declare AudioPlayer
  double cannonX = 50; // Position of cannon on the x-axis
  double cannonY = 350; // Position of cannon on the y-axis

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer(); // Initialize AudioPlayer
    // Animation Controller to update the position
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..addListener(() {
        setState(() {
          time += 0.05;
          calculateProjectile();
        });
      });
    // Split the explanation into words
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

  void calculateProjectile() {
    double angleRad = launchAngle * pi / 180; // Convert angle to radians
    double vX = launchSpeed * cos(angleRad);
    double vY = launchSpeed * sin(angleRad);

    // Calculate new position based on time
    x = vX * time;
    y = (vY * time) - (0.5 * gravity * time * time);

    if (y < 0) {
      // Reset when the projectile hits the ground
      if (_controller.isAnimating) {
        _controller.stop();
      }
      time = 0;
      x = 0;
      y = 0;
    }

    // Calculate the cannon mouth position (end of barrel)
    double cannonMouthX =
        cannonX + cos(angleRad) * 100; // Adjusting for barrel length
    double cannonMouthY =
        cannonY - sin(angleRad) * 100; // Adjusting for barrel length

    // Set the starting position of the ball at the cannon's mouth
    trajectoryPoints.add(Offset(cannonMouthX + x, cannonMouthY - y));
  }

  final FlutterTts flutterTts = FlutterTts();

  // Experiment explanation for projectile motion
  String _experimentExplanation =
      "This experiment demonstrates the motion of a projectile launched at an angle. "
      "The projectile follows a parabolic trajectory influenced by gravity. "
      "The range, maximum height, and time of flight depend on the initial speed and angle of launch.";

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

  // Method to play the cannon sound
  void _playCannonSound() async {
    await _audioPlayer.play(AssetSource('sounds/cannon.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Projectile Motion Simulator')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomPaint(
                size: Size(400, 400),
                painter: TrajectoryPainter(trajectoryPoints, launchAngle),
              ),
              SizedBox(height: 20),
              Text('Launch Angle: ${launchAngle.toStringAsFixed(1)}°'),
              Slider(
                value: launchAngle,
                min: 0,
                max: 90,
                onChanged: (value) {
                  setState(() {
                    launchAngle = value;
                  });
                  // Reset for the new simulation
                  trajectoryPoints.clear();
                  time = 0;
                  x = 0;
                  y = 0;
                  _controller.reset();
                },
              ),
              SizedBox(height: 20),
              Text('Launch Speed: ${launchSpeed.toStringAsFixed(1)} m/s'),
              Slider(
                value: launchSpeed,
                min: 5,
                max: 50,
                onChanged: (value) {
                  setState(() {
                    launchSpeed = value;
                  });
                  // Reset for the new simulation
                  trajectoryPoints.clear();
                  time = 0;
                  x = 0;
                  y = 0;
                  _controller.reset();
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  trajectoryPoints.clear();
                  time = 0;
                  x = 0;
                  y = 0;
                  _controller.reset();
                  _controller.forward();
                  _playCannonSound(); // Play sound when simulation starts
                },
                child: Text('Simulate'),
              ),
              SizedBox(height: 20),

              // Explanation section
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

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose(); // Dispose of the audio player when done
    super.dispose();
  }
}

class TrajectoryPainter extends CustomPainter {
  final List<Offset> trajectoryPoints;
  final double angle;

  TrajectoryPainter(this.trajectoryPoints, this.angle);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    // Draw the cannon
    drawCannon(canvas, size);

    // Draw the projectile trajectory
    for (var point in trajectoryPoints) {
      canvas.drawCircle(point, 7, paint); // Adjust the size of the projectile
    }
  }

  void drawCannon(Canvas canvas, Size size) {
    Paint cannonPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    // Draw the cannon barrel (rotates based on launch angle)
    canvas.save();
    canvas.translate(55, 350); // Position the barrel at the cannon base
    canvas.rotate(-angle * pi / 180); // Rotate the barrel

    // Define the points for the trapezoid with an extruding curved bottom
    Path barrelPath = Path()
      ..moveTo(0, -20) // Bottom left
      ..lineTo(100, -7) // Bottom right
      ..lineTo(100, 7) // Top right (thinner muzzle)
      ..lineTo(0, 20) // Top left
      ..quadraticBezierTo(50, 40, 0, 20) // Extruding curved bottom
      ..addOval(Rect.fromCircle(center: Offset(0, 0), radius: 20))
      ..close();

    // Draw the trapezoid with rounded bottom corners
    canvas.drawPath(barrelPath, cannonPaint);
    canvas.restore();

    // Draw the wheel
    Paint wheelPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    double wheelRadius = 20.0;
    canvas.drawCircle(Offset(58, 360), wheelRadius, wheelPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
