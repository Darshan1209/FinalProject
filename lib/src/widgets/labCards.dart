import 'dart:ui';

import 'package:apt3065/src/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class LabCards extends StatelessWidget {
  const LabCards({
    super.key,
    required this.titles,
    required this.labs,
    required this.imagePaths,
  });

  final List<String> titles;
  final List<Widget> labs;
  final List<String> imagePaths;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of items per row
          crossAxisSpacing: 20.0, // Space between items horizontally
          mainAxisSpacing: 30.0, // Space between items vertically
          childAspectRatio: 1.0, // Maintain aspect ratio for cards
        ),
        itemCount:
            titles.length, // Total number of cards (6 titles and 6 images)
        itemBuilder: (context, index) {
          // Define the list of images and titles

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => labs[index],
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300], // Card background color
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    // inset: true,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey.shade500
                        : Colors.black54,
                    offset: const Offset(5, 5),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    // inset: true,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : Colors.grey.shade800,
                    offset: const Offset(-3, -3),
                    blurRadius: 15,
                    spreadRadius: 1,
                  )
                ],
              ),
              // color: Colors.white, // Card background color
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Image above the text
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Image.asset(
                      imagePaths[
                          index], // Get the corresponding image for the current index
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      titles[
                          index], // Get the corresponding title for the current index
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: transformWidth(width, 17)),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
