import 'package:fashion_assistant/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FiveStarRating extends StatelessWidget {
  final int filledStars; // Number of stars to fill
  final String filledStarAsset; // Path to the filled star asset
  final String unfilledStarAsset; // Path to the unfilled star asset
  final double starSize; // Size of each star

  const FiveStarRating({
    Key? key,
    required this.filledStars,
    this.filledStarAsset = 'assets/icons/star.png',
    this.unfilledStarAsset = 'assets/icons/borderstar.png',
    this.starSize = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, // Adjust row width to content
      children: List.generate(5, (index) {
        return SizedBox(
          width: starSize, // Explicit size for each star
          height: starSize, // Explicit size for each star
          child: Image.asset(
            index < filledStars ? filledStarAsset : unfilledStarAsset,
            fit: BoxFit.contain, // Ensure the image scales properly
          ),
        );
      }),
    );
  }
}
