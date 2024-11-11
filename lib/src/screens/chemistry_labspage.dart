import 'dart:async';
import 'dart:math';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';

class ChemistryLabsPage extends StatefulWidget {
  const ChemistryLabsPage({super.key});

  @override
  _DiffusionScreenState createState() => _DiffusionScreenState();
}

class _DiffusionScreenState extends State<ChemistryLabsPage> {
  final int initialParticles = 50;
  int leftParticles = 0;
  int rightParticles = 0;
  bool isExperimentRunning = false;
  bool isHeatOn = false;
  bool isBarrierVisible = true; // Track barrier visibility
  late Timer timer;
  List<Particle> leftParticlesList = [];
  List<Particle> rightParticlesList = [];
  int updateIntervalMilliseconds = 50;

  @override
  void initState() {
    super.initState();
    leftParticles = initialParticles;
    rightParticles = initialParticles;
    _initializeParticles();
    timer = Timer(const Duration(seconds: 0), () {});
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void _initializeParticles() {
    final random = Random();
    leftParticlesList = List.generate(
      leftParticles,
      (index) => Particle(
        position: Offset(random.nextDouble() * 50, random.nextDouble() * 500),
        velocity:
            Offset(random.nextDouble() * 2 - 1, random.nextDouble() * 2 - 1),
      ),
    );
    rightParticlesList = List.generate(
      rightParticles,
      (index) => Particle(
        position:
            Offset(100 + random.nextDouble() * 50, random.nextDouble() * 500),
        velocity:
            Offset(random.nextDouble() * 2 - 1, random.nextDouble() * 2 - 1),
      ),
    );
  }

  // Method to move particles and interact with the wall
  void _moveParticles(List<Particle> particles, bool isLeftSide) {
    for (int i = 0; i < particles.length; i++) {
      particles[i].position += particles[i].velocity;

      // Collision with the left and right wall
      if (particles[i].position.dx < 0 || particles[i].position.dx > 100) {
        particles[i].velocity = Offset(
            -particles[i].velocity.dx, particles[i].velocity.dy); // Reflect
      }

      // Collision with top and bottom
      if (particles[i].position.dy < 0 || particles[i].position.dy > 550) {
        particles[i].velocity = Offset(
            particles[i].velocity.dx, -particles[i].velocity.dy); // Reflect
      }

      // Reflect off the barrier if visible
      if (isBarrierVisible) {
        if (isLeftSide && particles[i].position.dx > 50) {
          particles[i].position = Offset(50, particles[i].position.dy);
          particles[i].velocity = Offset(
              -particles[i].velocity.dx, particles[i].velocity.dy); // Reflect
        } else if (!isLeftSide && particles[i].position.dx < 50) {
          particles[i].position = Offset(50, particles[i].position.dy);
          particles[i].velocity = Offset(
              -particles[i].velocity.dx, particles[i].velocity.dy); // Reflect
        }
      }
    }
  }

  void startExperiment() {
    setState(() {
      isExperimentRunning = true;
    });
    timer = Timer.periodic(
      Duration(milliseconds: updateIntervalMilliseconds),
      (timer) {
        setState(() {
          _moveParticles(leftParticlesList, true);
          _moveParticles(rightParticlesList, false);
        });
      },
    );
  }

  void stopExperiment() {
    setState(() {
      isExperimentRunning = false;
    });
    timer.cancel();
  }

  void increaseHeat() {
    setState(() {
      updateIntervalMilliseconds = 15;
      leftParticlesList.forEach((particle) {
        particle.velocity = particle.velocity * 1.5;
      });
      rightParticlesList.forEach((particle) {
        particle.velocity = particle.velocity * 1.5;
      });
    });
  }

  void toggleBarrierVisibility() {
    setState(() {
      isBarrierVisible = !isBarrierVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diffusion Simulation'),
      ),
      body: Column(
        children: [
          Container(
            height: 500,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    color: Colors.grey[300],
                  ),
                ),
                ...leftParticlesList.map((particle) {
                  return Positioned(
                    left: 100 + particle.position.dx,
                    top: 50 + particle.position.dy,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }).toList(),
                ...rightParticlesList.map((particle) {
                  return Positioned(
                    left: 150 + particle.position.dx,
                    top: 50 + particle.position.dy,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }).toList(),
                if (isBarrierVisible)
                  Positioned(
                    left: MediaQuery.of(context).size.width / 2 - 1,
                    top: 0,
                    bottom: 0,
                    width: 4,
                    child: Container(color: Colors.white),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: isExperimentRunning ? null : startExperiment,
                child: const Text('Start'),
              ),
              ElevatedButton(
                onPressed: isExperimentRunning ? stopExperiment : null,
                child: const Text('Stop'),
              ),
            ],
          ),
          const SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: increaseHeat,
                child: const Text('Increase Heat'),
              ),
              ElevatedButton(
                onPressed: toggleBarrierVisibility,
                child: const Text('Toggle Barrier'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Particle {
  Offset position;
  Offset velocity;

  Particle({required this.position, required this.velocity});
}
