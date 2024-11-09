import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// A circular loader widget with customizable foreground and background colors.
class LoaderAnimation extends StatelessWidget {
  const LoaderAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Lottie.asset("assets/animations/default-loader-animation.json",
            height: 200, width: 200));
  }
}
