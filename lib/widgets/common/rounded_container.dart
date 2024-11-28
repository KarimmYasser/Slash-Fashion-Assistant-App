import 'package:fashion_assistant/constants.dart';
import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    super.key,
    this.child,
    this.width = 400,
    this.height = 400,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(0),
    this.showBorder = false,
    this.radius = Sizes.cardRadiusLg,
    this.backgroundColor = OurColors.white,
    this.borderColor = OurColors.borderPrimary,
  });

  final double? width;
  final double? height;
  final double? radius;
  final Widget? child;
  final bool? showBorder;
  final Color? borderColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius!),
        border: showBorder!
            ? Border.all(
                color: borderColor!,
              )
            : null,
      ),
      child: child,
    );
  }
}
