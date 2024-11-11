import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: ThermalExpansionAnimation()));
}

class ThermalExpansionAnimation extends StatefulWidget {
  @override
  _ThermalExpansionAnimationState createState() =>
      _ThermalExpansionAnimationState();
}

class _ThermalExpansionAnimationState extends State<ThermalExpansionAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _wallThickness = 50.0; // Initial wall thickness
  double _temperature = 20.0; // Initial temperature in Celsius
  double _maxExpansion = 100.0; // Maximum expansion limit
  double _minThickness = 30.0; // Minimum thickness limit (cooling down)

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
  }

  // Method to increase the heat and expand the particles
  void _increaseHeat() {
    setState(() {
      _temperature += 10.0; // Increase temperature by 10°C
      if (_wallThickness < _maxExpansion) {
        _wallThickness += 5.0; // Increase wall thickness
      }
    });
  }

  // Method to decrease the heat and contract the particles
  void _decreaseHeat() {
    setState(() {
      _temperature -= 10.0; // Decrease temperature by 10°C
      if (_wallThickness > _minThickness) {
        _wallThickness -= 5.0; // Decrease wall thickness
      }
    });
  }

  // Method to show compact particles in the wall of the container
  Widget _buildParticles() {
    List<Widget> particles = [];
    for (int i = 0; i < 30; i++) {
      particles.add(
        Positioned(
          top: (i % 5) * 10.0,
          left: (i ~/ 5) * 10.0,
          child: Container(
            width: 5.0,
            height: 5.0,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    }
    return Stack(children: particles);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thermal Expansion Demonstration"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Temperature: ${_temperature.toStringAsFixed(1)} °C",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Wall Thickness: ${_wallThickness.toStringAsFixed(1)} units",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 30),
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                children: [
                  _buildParticles(), // Show particles inside the wall
                  Positioned(
                    top: 50.0,
                    left: 50.0,
                    child: Container(
                      width: 300,
                      height: _wallThickness, // Dynamic wall thickness
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _increaseHeat,
                  child: Text("Increase Heat"),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _decreaseHeat,
                  child: Text("Decrease Heat"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
