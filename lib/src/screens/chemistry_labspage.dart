import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ChemistryLabsPage extends StatefulWidget {
  @override
  _DiffusionScreenState createState() => _DiffusionScreenState();
}

class _DiffusionScreenState extends State<ChemistryLabsPage> {
  final int initialParticles = 50;
  int leftParticles = 0;
  int rightParticles = 0;
  bool isExperimentRunning = false;
  bool isHeatOn = false;
  bool isBarrierVisible = true; // New state variable to track barrier visibility

  // Timer for simulating particle movement
  late Timer timer = Timer(Duration(seconds: 0), () {}); // Initialize timer with a dummy value

  // List to store positions and velocities of particles
  List<Particle> leftParticlesList = [];
  List<Particle> rightParticlesList = [];

  // Define the initial update interval
  int updateIntervalMilliseconds = 50;

  @override
  void initState() {
    super.initState();
    leftParticles = initialParticles;
    rightParticles = initialParticles;
    _initializeParticles();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  // Initialize particle positions and velocities
  void _initializeParticles() {
    final random = Random();
    leftParticlesList = List.generate(
      leftParticles,
          (index) =>
          Particle(
            position: Offset(
                random.nextDouble() * 50, random.nextDouble() * 500),
            velocity: Offset(
                random.nextDouble() * 2 - 1, random.nextDouble() * 2 - 1),
          ),
    );
    rightParticlesList = List.generate(
      rightParticles,
          (index) =>
          Particle(
            position: Offset(
                100 + random.nextDouble() * 50, random.nextDouble() * 500),
            velocity: Offset(
                random.nextDouble() * 2 - 1, random.nextDouble() * 2 - 1),
          ),
    );
  }

  // Adjusted _moveParticles method
  void _moveParticles(List<Particle> particles, bool isLeftSide) {
    final random = Random();
    for (int i = 0; i < particles.length; i++) {
      particles[i].position += particles[i].velocity;

      // Check for collisions with container boundaries
      if (particles[i].position.dx < 0 || particles[i].position.dx > 100) {
        particles[i].velocity =
            Offset(-particles[i].velocity.dx, particles[i].velocity.dy);
      }
      if (particles[i].position.dy < 0 || particles[i].position.dy > 550) {
        particles[i].velocity =
            Offset(particles[i].velocity.dx, -particles[i].velocity.dy);
      }

      // Check for collisions with other particles
      for (int j = i + 1; j < particles.length; j++) {
        if ((particles[i].position - particles[j].position).distanceSquared <
            400) {
          // Handle collision by exchanging velocities
          Offset temp = particles[i].velocity;
          particles[i].velocity = particles[j].velocity;
          particles[j].velocity = temp;
        }
      }

      // Check for crossing the barrier
      if (isBarrierVisible) { // Only check for crossing the barrier if it's visible
        if (isLeftSide && particles[i].position.dx > 50) {
          particles[i].position = Offset(50, particles[i].position.dy);
          particles[i].velocity =
              Offset(-particles[i].velocity.dx, particles[i].velocity.dy);
        } else if (!isLeftSide && particles[i].position.dx < 50) {
          particles[i].position = Offset(50, particles[i].position.dy);
          particles[i].velocity =
              Offset(-particles[i].velocity.dx, particles[i].velocity.dy);
        }
      }
    }
  }

  void startExperiment() {
    setState(() {
      isExperimentRunning = true;
    });
    timer = Timer.periodic(
        Duration(milliseconds: updateIntervalMilliseconds), (timer) {
      setState(() {
        // Move particles
        _moveParticles(leftParticlesList, true);
        _moveParticles(rightParticlesList, false);
      });
    });
  }

  void stopExperiment() {
    setState(() {
      isExperimentRunning = false;
    });
    timer.cancel();
  }

  void increaseParticles() {
    setState(() {
      leftParticles++;
      _initializeParticles();
    });
  }

  // Adjusted increaseHeat method
  void increaseHeat() {
    setState(() {
      updateIntervalMilliseconds =
      15; // Decrease the update interval to make particles move faster
      // Increase the speed of each particle
      leftParticlesList.forEach((particle) =>
      particle.velocity = particle.velocity * 1.5);
      rightParticlesList.forEach((particle) =>
      particle.velocity = particle.velocity * 1.5);
    });
  }

  // Method to toggle the barrier's visibility and adjust particle positions
  void toggleBarrierVisibility() {
    setState(() {
      isBarrierVisible = !isBarrierVisible;
      // Adjust the left and top values for the particles based on the barrier's state
      leftParticlesList.forEach((particle) {
        particle.position = Offset(
            isBarrierVisible ? 85 + particle.position.dx : 85 +
                particle.position.dx, 50 + particle.position.dy);
      });
      rightParticlesList.forEach((particle) {
        particle.position = Offset(
            isBarrierVisible ? -30 + particle.position.dx : -30 +
                particle.position.dx, 50 + particle.position.dy);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diffusion Simulation'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 500,
            // color: Colors.black, // Set container background color to black
            padding: EdgeInsets.symmetric(vertical: 10), // Add padding for button layout
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    color: Colors.grey[300],
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                ...leftParticlesList.map((particle) {
                  return Positioned(
                    left: 100 + particle.position.dx,
                    top: 50 + particle.position.dy,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.orange, // Set left particles color to orange
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
                      decoration: BoxDecoration(
                        color: Colors.blue, // Set right particles color to blue
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }).toList(),
                if (isBarrierVisible) // Conditionally draw the barrier
                  Positioned(
                    left: MediaQuery.of(context).size.width / 2 - 1,
                    top: 0,
                    bottom: 0,
                    width: 4,
                    child: Container(color: Colors.white), // Set barrier color to white
                  ),
              ],
            ),
          ),
          SizedBox(height: 50), // Add space between container and buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 150,
                height: 40,
                child: ElevatedButton(
                  onPressed: isExperimentRunning ? null : startExperiment,
                  child: Text('Start'),
                ),
              ),
              SizedBox(
                width: 150,
                height: 40,
                child: ElevatedButton(
                  onPressed: isExperimentRunning ? stopExperiment : null,
                  child: Text('Stop'),
                ),
              ),
            ],
          ),
          SizedBox(height: 60), // Add space between button rows
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 150,
                height: 40,
                child: ElevatedButton(
                  onPressed: increaseHeat,
                  child: Text('Increase Heat'),
                ),
              ),
              SizedBox(
                width: 150,
                height: 40,
                child: ElevatedButton(
                  onPressed: toggleBarrierVisibility, // New button to toggle barrier visibility
                  child: Text('Toggle Barrier'),
                ),
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