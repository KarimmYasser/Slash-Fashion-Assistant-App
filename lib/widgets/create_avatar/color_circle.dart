import 'package:fashion_assistant/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorCircle extends StatelessWidget {
  const ColorCircle({super.key, required this.color, this.isSelected = false});
  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: isSelected
          ? OurColors.primaryColor
          : color.withOpacity(0.4), // Dynamic border color
      radius: 25.r, // Size of the circular image container
      child: CircleAvatar(
        radius: 20.r, // Inner circle size (smaller for border effect)
        backgroundColor: color,
      ),
    );
  }
}
