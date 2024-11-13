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
  late FlutterTts _flutterTts;

  // Constants
  final double gravity = 9.8;
  late AnimationController _controller;
  late AudioPlayer _audioPlayer; // Declare AudioPlayer
  double cannonX = 50; // Position of cannon on the x-axis
  double cannonY = 350; // Position of cannon on the y-axis

  @override
  void initState() {
    super.initState();
    _flutterTts = FlutterTts();
    initTTS();
    updateWords();
    _audioPlayer = AudioPlayer(); // Initialize AudioPlayer
    // Animation Controller to update the position
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
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

  void updateWords() {
    // Split the explanation text into words and store them in _words
    _words = _experimentExplanation.split(" ");
  }

  void initTTS() {
    _flutterTts.setStartHandler(() {
      setState(() {
        _currentWordIndex = 0; // Start highlighting from the first word
      });
    });

    _flutterTts
        .setProgressHandler((String text, int start, int end, String word) {
      setState(() {
        // Update the current word index when TTS progresses
        _currentWordIndex = _words.indexOf(word);
      });
    });

    // Set other TTS configurations (optional)
    _flutterTts.setLanguage("en-US");
    _flutterTts.setPitch(1.0);
    _flutterTts.setSpeechRate(0.5);
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
      "This experiment demonstrates the motion of a projectile launched at an angle to the horizontal. "
      "A projectile is any object that is thrown, fired, or otherwise propelled, and it continues its motion under the influence of gravity alone after launch. "
      "In this case, the projectile follows a parabolic trajectory, a curved path shaped like an arch. "
      "This path is determined by the initial velocity, the angle at which the projectile is launched, and the acceleration due to gravity. "
      "Gravity causes the projectile to accelerate downward, while the horizontal component of the projectile's velocity remains constant throughout its flight.\n\n"
      "The key parameters that determine the projectile's motion include:\n"
      "- Initial Speed: The speed at which the projectile is launched. A higher speed results in a greater range and height.\n"
      "- Launch Angle: The angle at which the projectile is launched relative to the horizontal ground. Angles between 30° and 45° typically result in the greatest range.\n"
      "- Acceleration due to Gravity: The constant force that pulls the projectile downward, causing it to follow a curved trajectory. On Earth, this acceleration is approximately 9.8 m/s².\n\n"
      "The trajectory of the projectile is influenced by two components of motion:\n"
      "- Horizontal Motion: The object moves forward at a constant velocity, as there is no horizontal acceleration (assuming air resistance is negligible). This means the horizontal velocity remains unchanged throughout the flight.\n"
      "- Vertical Motion: The object accelerates downward due to gravity, which causes its vertical velocity to increase as it moves downwards after reaching the peak of its flight.\n\n"
      "The motion can be broken down into several key stages:\n"
      "1. Launch Phase: At the moment of launch, the projectile is given an initial velocity that is divided into two components: horizontal and vertical velocities. "
      "The launch angle dictates the proportions of these velocities.\n"
      "2. Ascent Phase: As the projectile rises, its vertical velocity decreases due to gravity until it reaches the maximum height. "
      "At this point, the vertical velocity becomes zero, and gravity begins to pull the object back down.\n"
      "3. Descent Phase: After reaching its peak height, the projectile begins to fall back to the ground. "
      "During this phase, the vertical velocity increases in the downward direction until it reaches the ground.\n\n"
      "Key variables measured in this experiment are:\n"
      "- Range: The horizontal distance traveled by the projectile before it hits the ground. The range depends on the initial speed and launch angle. "
      "The optimal angle for maximum range, neglecting air resistance, is typically 45°.\n"
      "- Maximum Height: The highest point reached by the projectile during its flight. This is influenced by the vertical component of the initial velocity.\n"
      "- Time of Flight: The total time the projectile is in the air. The time is determined by both the vertical velocity and the acceleration due to gravity.\n\n"
      "The experiment can be conducted by launching a projectile, measuring its range, maximum height, and time of flight, and using the known initial conditions to verify the theoretical predictions of projectile motion. "
      "By analyzing the relationship between launch angle, speed, and the resulting trajectory, we can gain insights into the principles of motion and how different factors affect the path of a projectile.";

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
      appBar: AppBar(title: const Text('Projectile Motion Simulator')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomPaint(
                size: const Size(400, 400),
                painter: TrajectoryPainter(trajectoryPoints, launchAngle),
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
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
                child: const Text('Simulate'),
              ),
              const SizedBox(height: 20),

              // Explanation section
              const Text(
                'Experiment Explanation',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.blue,
                        ),
                        child: IconButton(
                          onPressed: () {
                            _isSpeaking
                                ? _flutterTts.stop() // Stop TTS
                                : _flutterTts
                                    .speak(_experimentExplanation); // Start TTS
                            // _flutterTts.speak(_experimentExplanation); // Start TTS
                            setState(() {
                              _isSpeaking = !_isSpeaking;
                            });
                          },
                          icon: Icon(
                              _isSpeaking ? Iconsax.stop : Iconsax.volume_high),
                          iconSize: 25,
                          color: Colors.white,
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.justify,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 250,
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
                    ],
                  )),
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
      ..addOval(Rect.fromCircle(center: const Offset(0, 0), radius: 20))
      ..close();

    // Draw the trapezoid with rounded bottom corners
    canvas.drawPath(barrelPath, cannonPaint);
    canvas.restore();

    // Draw the wheel
    Paint wheelPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    double wheelRadius = 20.0;
    canvas.drawCircle(const Offset(58, 360), wheelRadius, wheelPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
