import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:iconsax/iconsax.dart'; // Import the TTS package

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PhotosynthesisSimulator(),
    );
  }
}

class PhotosynthesisSimulator extends StatefulWidget {
  @override
  _PhotosynthesisSimulatorState createState() =>
      _PhotosynthesisSimulatorState();
}

class _PhotosynthesisSimulatorState extends State<PhotosynthesisSimulator> {
  double lightIntensity = 1.0;
  double co2Concentration = 1.0;
  double plantHeight = 150.0;
  double stemWidth = 2.0;
  int leafLayers = 3;
  FlutterTts flutterTts = FlutterTts(); // TTS instance
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

  void calculateGrowth() {
    setState(() {
      plantHeight = 150.0 + (lightIntensity * co2Concentration * 5);
      stemWidth = max(2.0, plantHeight * 0.02);
      leafLayers = min(7, (plantHeight / 50).floor() + 3);
    });
  }

  // Method to read the experiment explanation

  String _experimentExplanation = """
      The photosynthesis simulator demonstrates how plants grow based on light intensity and CO2 concentration, 
      the key factors in photosynthesis. As light and CO2 levels increase, the plant grows taller, develops a thicker stem, 
      and forms more leaf layers. Adjusting these parameters helps understand how plants respond to environmental conditions.
      Photosynthesis is the process where plants use light, carbon dioxide, and water to produce glucose and oxygen.
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Realistic Plant Growth Simulation"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              CustomPaint(
                size: Size(200, plantHeight),
                painter: PlantPainter(plantHeight, stemWidth, leafLayers),
              ),
              const SizedBox(height: 20),
              Text("Light Intensity: ${lightIntensity.toStringAsFixed(1)}"),
              Slider(
                value: lightIntensity,
                min: 1.0,
                max: 10.0,
                divisions: 9,
                onChanged: (double newValue) {
                  setState(() {
                    lightIntensity = newValue;
                  });
                  calculateGrowth();
                },
              ),
              const SizedBox(height: 20),
              Text("CO2 Concentration: ${co2Concentration.toStringAsFixed(1)}"),
              Slider(
                value: co2Concentration,
                min: 1.0,
                max: 10.0,
                divisions: 9,
                onChanged: (double newValue) {
                  setState(() {
                    co2Concentration = newValue;
                  });
                  calculateGrowth();
                },
              ),
              const SizedBox(height: 40),
              Text("Plant Height: ${plantHeight.toStringAsFixed(1)}"),
              const SizedBox(height: 20),
              // Explanation section
              const Text(
                'Experiment Explanation',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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

class PlantPainter extends CustomPainter {
  final double plantHeight;
  final double stemWidth;
  final int leafLayers;

  PlantPainter(this.plantHeight, this.stemWidth, this.leafLayers);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.green
      ..strokeWidth = stemWidth;

    canvas.drawLine(Offset(size.width / 2, size.height),
        Offset(size.width / 2, size.height * 0.3), paint);

    for (int layer = 0; layer < leafLayers; layer++) {
      double leafSize = 20.0 - layer * 2.0;
      double leafYOffset = size.height * 0.3 + (layer * 20.0);

      for (int i = 0; i < 5; i++) {
        double leafAngle = i * pi / 4;
        double leafX = size.width / 2 + leafSize * cos(leafAngle);
        double leafY = leafYOffset + leafSize * sin(leafAngle);

        canvas.drawOval(
          Rect.fromCenter(
            center: Offset(leafX, leafY),
            width: leafSize,
            height: leafSize * 0.7,
          ),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
