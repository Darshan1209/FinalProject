import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:iconsax/iconsax.dart';

class FirstLawSimulationPage extends StatefulWidget {
  @override
  State<FirstLawSimulationPage> createState() => _FirstLawSimulationPageState();
}

class _FirstLawSimulationPageState extends State<FirstLawSimulationPage>
    with SingleTickerProviderStateMixin {
  double friction = 0.1;
  double mass = 1.0; // Mass in kilograms
  double initialPosition = 0.0;
  double position = 0.0;
  double velocity = 0.0;
  bool isPushed = false;
  late AnimationController controller;
  double screenWidth = 0.0;
  late FlutterTts _flutterTts;
  List<Map> _voices = [];
  Map? _currentVoice;

  int? _currentWordStart, _currentWordEnd;
  @override
  void initState() {
    super.initState();
    _flutterTts = FlutterTts();
    initTTS();
    updateWords();

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5))
          ..addListener(() {
            setState(() {
              if (isPushed) {
                velocity -= friction * mass * 0.01;
                if (velocity < 0) {
                  velocity = 0;
                  isPushed = false;
                }
                position += velocity;
                if (position > screenWidth) {
                  position =
                      -50; // Reset position to left edge after leaving screen
                }
              }
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

  void setVoice(Map voice) {
    _flutterTts.setVoice({"name": voice["name"], "locale": voice["locale"]});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenWidth = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    controller.dispose();
    _flutterTts.stop();
    super.dispose();
  }

  void applyPush() {
    setState(() {
      velocity = 5.0;
      isPushed = true;
      controller.forward(from: 0.0);
    });
  }

  // Updated method to calculate friction force with rounding to three decimal places
  String calculateFrictionForce() {
    double frictionForce = friction * mass * 9.8; // F = μ * m * g
    return frictionForce.toStringAsFixed(3);
  }

  final String _experimentExplanation =
      "Newton's First Law of Motion, also known as the Law of Inertia, states that an object will remain in a state of rest or uniform motion unless acted upon by a net external force. This fundamental principle of classical mechanics was first formulated by Sir Isaac Newton in the late 17th century, and it forms the cornerstone of classical physics. The law is often summarized as 'An object in motion stays in motion, and an object at rest stays at rest, unless acted upon by an outside force.' This means that without an external influence, an object will not change its state of motion.\n\n\n"
      "Inertia: The Tendency of Objects to Resist Changes in Motion\n\n"
      "The concept of inertia is central to the First Law of Motion. Inertia is the property of matter that resists changes in its state of motion. If an object is stationary, inertia keeps it at rest. If an object is in motion, inertia keeps it moving at a constant velocity in a straight line. The more massive an object is, the greater its inertia. For example, a car moving at a constant speed on a flat surface will continue to move unless forces like friction or air resistance slow it down, or the brakes are applied. Similarly, a stationary car will not start moving unless an external force, such as someone pushing it or the engine providing force, acts upon it.\n\n\n"
      "Real-World Applications of Newton's First Law\n\n"
      "One of the most visible demonstrations of Newton’s First Law can be observed in everyday life. For example, when a car abruptly stops, the passengers inside continue moving forward, even though the car has stopped. This happens because their bodies, which were in motion with the car, want to continue moving forward due to inertia. Similarly, if a ball is kicked into the air, it will continue in motion until external forces such as gravity or air resistance alter its trajectory. These real-world examples show how Newton’s First Law governs the motion of objects around us.\n\n\n"
      "The Role of External Forces in Changing Motion\n\n"
      "While inertia explains why objects continue their motion, it is the external forces that cause changes in motion. The law emphasizes that a change in an object’s velocity—whether it’s a change in speed or direction—requires an external force. For example, when a soccer ball is kicked, the force of the kick changes its velocity. If a car is moving at a steady speed, an external force such as the brakes or a collision will cause the car to decelerate or stop. This highlights the importance of understanding how forces interact with objects to modify their motion, which is a foundational concept in both mechanics and engineering.\n\n\n"
      "Understanding Inertia Through Experiments\n\n"
      "In experiments, we can observe how inertia plays a role in the behavior of objects. One common demonstration of the First Law involves placing a coin on a piece of cloth over a cup. When the cloth is quickly pulled, the coin remains in place for a brief moment due to inertia, as it resists the sudden change in motion. Similarly, a sled moving on ice will continue its motion with minimal resistance, as ice reduces friction, allowing the sled to demonstrate Newton’s First Law.\n\n\n"
      "These simple experiments help solidify the understanding that objects will not change their motion unless acted upon by a force. It is important to note that while external forces, such as friction or gravity, can slow down or accelerate objects, the law asserts that objects at rest or in motion without these forces will continue indefinitely without any need for additional force.\n\n\n"
      "Conclusion\n\n"
      "In conclusion, Newton's First Law of Motion provides a crucial insight into how objects behave in the absence of external forces. By understanding the principle of inertia, we can better explain why objects continue their motion and why changes in motion require forces. The First Law not only lays the groundwork for classical mechanics but also serves as the basis for understanding more complex phenomena in physics. Whether it’s the motion of planets, the movement of vehicles, or the behavior of everyday objects, Newton’s First Law is fundamental in explaining the natural world.";

  int _currentWordIndex = 0;
  List<String> _words = [];
  bool _isSpeaking = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: const Text("First Law of Motion Lab")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Adjust Surface Friction & Mass",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 120),
              Container(
                height: 5,
                color: Colors.brown, // Floor line
              ),
              AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return Transform.translate(
                    offset:
                        Offset(position, -53), // Ball touches the floor line
                    child: child,
                  );
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.red.shade900,
                        Colors.red.shade600,
                        Colors.red.shade300,
                      ],
                      stops: [0.3, 0.7, 1.0],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(3, 3),
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        spreadRadius: -2,
                        blurRadius: 10,
                        offset: const Offset(-2, -2),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: applyPush,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: const Text(
                        "Push",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: resetBallPosition,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: const Text(
                        "Reset",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              RichText(
                text: const TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  children: <TextSpan>[
                    TextSpan(
                      text: "Force due to Friction: F = μ * m * g , where:",
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    TextSpan(
                      text: "\nμ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    TextSpan(
                      text: ": is friction coefficient,",
                    ),
                    TextSpan(
                      text: "\nm",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    TextSpan(
                      text: ": is mass of the object,",
                    ),
                    TextSpan(
                      text: "\ng",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    TextSpan(
                      text: ": is acceleration due to gravity.\n",
                    ),
                  ],
                ),
              ),
              Text(
                "F = ${friction.toStringAsFixed(3)}(μ) * ${mass.toStringAsFixed(3)}(m) * 9.8(g) = ${calculateFrictionForce()} N",
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Text("Friction (μ)",
                          style: TextStyle(fontSize: 16)),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Slider(
                          value: friction,
                          min: 0,
                          max: 1,
                          divisions: 10,
                          label: friction.toStringAsFixed(3),
                          onChanged: (value) {
                            setState(() {
                              friction = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    children: [
                      const Text("Mass (m)", style: TextStyle(fontSize: 16)),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Slider(
                          value: mass,
                          min: 0.5,
                          max: 5.0,
                          divisions: 10,
                          label: mass.toStringAsFixed(1),
                          onChanged: (value) {
                            setState(() {
                              mass = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildHighlightedExplanation(),
            ],
          ),
        ),
      ),
    );
  }

  void resetBallPosition() {
    setState(() {
      position = initialPosition;
      velocity = 0.0;
      isPushed = false;
      controller.reset();
    });
  }

  Widget _buildHighlightedExplanation() {
    return Row(
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
                  : _flutterTts.speak(_experimentExplanation); // Start TTS
              // _flutterTts.speak(_experimentExplanation); // Start TTS
              setState(() {
                _isSpeaking = !_isSpeaking;
              });
            },
            icon: Icon(_isSpeaking ? Iconsax.stop : Iconsax.volume_high),
            iconSize: 25,
            color: Colors.white,
          ),
        ),
        Expanded(
          child: RichText(
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            maxLines: 40,
            text: TextSpan(
              children: _words.asMap().entries.map((entry) {
                int idx = entry.key;
                String word = entry.value;

                return TextSpan(
                  text: "$word ",
                  style: TextStyle(
                    fontFamily: 'Balsamiq Sans',
                    color:
                        idx <= _currentWordIndex ? Colors.blue : Colors.black,
                    fontSize: 18,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
