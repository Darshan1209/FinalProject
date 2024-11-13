import 'package:flutter/material.dart';
import 'dart:math';

class ThermalExpansionDemo extends StatefulWidget {
  const ThermalExpansionDemo({super.key});

  @override
  State<ThermalExpansionDemo> createState() => _ThermalExpansionDemoState();
}

class _ThermalExpansionDemoState extends State<ThermalExpansionDemo>
    with SingleTickerProviderStateMixin {
  double _temperature = 20.0; // Initial temperature
  double _maxExpansion = 100.0;
  double _minThickness = 30.0;
  double _baseThickness = 50.0;
  double _containerSize = 300.0;
  late AnimationController _controller;
  late Random random;
  late List<Particle> particles;

  @override
  void initState() {
    super.initState();
    random = Random();
    particles = List.generate(50, (index) {
      return Particle(
        position: Offset(random.nextDouble() * _containerSize,
            random.nextDouble() * _containerSize),
        velocity:
            Offset(random.nextDouble() * 4 - 2, random.nextDouble() * 4 - 2),
      );
    });

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3), // Default speed
      lowerBound: 0.0,
      upperBound: 1.0,
    )..repeat();

    _controller.addListener(() {
      setState(() {
        _moveParticles();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double wallThickness = _baseThickness + (_temperature - 20) * 0.7;
    wallThickness = wallThickness.clamp(_minThickness, _maxExpansion);
    _containerSize = 300.0 + (_temperature - 20) * 2;

    Color temperatureColor = Color.lerp(
      Colors.blue,
      Colors.red,
      (_temperature / 100).clamp(0.0, 1.0),
    )!;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Thermal Expansion Lab"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Temperature: ${_temperature.toStringAsFixed(1)} °C",
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              "Wall Thickness: ${wallThickness.toStringAsFixed(1)} units",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 30),
            Container(
              width: _containerSize,
              height: _containerSize,
              decoration: BoxDecoration(
                color: temperatureColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: temperatureColor, width: 2),
              ),
              child: Stack(
                children: [
                  _buildParticles(),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: _containerSize,
                      height: _containerSize,
                      color: temperatureColor.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Slider(
              min: 20.0,
              max: 100.0,
              value: _temperature,
              label: "${_temperature.toStringAsFixed(1)} °C",
              onChanged: (newTemp) {
                setState(() {
                  _temperature = newTemp;
                  _updateParticleSpeed();
                });
              },
            ),
            const Text(
              "Slide to Increase/Decrease Temperature",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  // Build particles with continuous movement and increased size
  Widget _buildParticles() {
    List<Widget> particleWidgets = [];
    for (int i = 0; i < particles.length; i++) {
      double particleSize = 20.0 +
          (_temperature - 20) * 0.2; // Bigger particles with higher temperature
      particleWidgets.add(
        Positioned(
          top: particles[i].position.dy,
          left: particles[i].position.dx,
          child: Container(
            width: particleSize,
            height: particleSize,
            decoration: const BoxDecoration(
              color: Colors.blueGrey,
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    }
    return Stack(children: particleWidgets);
  }

  // Move the particles continuously based on their velocities
  void _moveParticles() {
    for (var particle in particles) {
      particle.position += particle.velocity;

      // Boundary clamping
      if (particle.position.dx < 0) {
        particle.position = Offset(0, particle.position.dy);
        particle.velocity = Offset(-particle.velocity.dx, particle.velocity.dy);
      } else if (particle.position.dx > _containerSize) {
        particle.position = Offset(_containerSize, particle.position.dy);
        particle.velocity = Offset(-particle.velocity.dx, particle.velocity.dy);
      }

      if (particle.position.dy < 0) {
        particle.position = Offset(particle.position.dx, 0);
        particle.velocity = Offset(particle.velocity.dx, -particle.velocity.dy);
      } else if (particle.position.dy > _containerSize) {
        particle.position = Offset(particle.position.dx, _containerSize);
        particle.velocity = Offset(particle.velocity.dx, -particle.velocity.dy);
      }
    }
  }

  // Adjust particle speed based on temperature
  void _updateParticleSpeed() {
    particles.forEach((particle) {
      particle.velocity = particle.velocity * 1.5; // Randomize velocity
    });
    int speed =
        ((_temperature - 20) ~/ 5) * 2; // Calculate speed based on temperature
    _controller.duration =
        Duration(seconds: speed); // Adjust the animation speed
    _controller.forward(from: 0); // Restart the animation with new speed
  }
}

class Particle {
  Offset position;
  Offset velocity;

  Particle({required this.position, required this.velocity});
}
