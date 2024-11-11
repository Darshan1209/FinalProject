import 'package:flutter/material.dart';
import '../constants/sizes.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;

  const ResponsiveWidget(
      {Key? key, required this.mobile, required this.desktop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < mobileSize) {
        return mobile;
      } else {
        return desktop;
      }
    });
  }
}

transformWidth(width, double w) {
  return width * w / width;
}

transformHeight(height, double h) {
  return height * h / height;
}
