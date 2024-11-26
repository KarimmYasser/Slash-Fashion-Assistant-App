import 'package:flutter/material.dart';

class ColorCircle extends StatelessWidget {
  const ColorCircle({super.key, required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: color.withOpacity(0.4), // Dynamic border color
      radius: 25, // Size of the circular image container
      child: CircleAvatar(
        radius: 20, // Inner circle size (smaller for border effect)

        backgroundColor: color,
      ),
    );
  }
}
