import 'package:fashion_assistant/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChooseCard extends StatelessWidget {
  const ChooseCard({super.key, required this.data, this.selected = false});

  final String data;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      decoration: BoxDecoration(
        color: selected
            ? OurColors.containerBackgroundColor
            : OurColors.backgroundColor,
        border: Border.all(
          color: OurColors.containerBackgroundColor,
          width: 2.w,
        ),
        borderRadius: BorderRadius.circular(36.r),
      ),
      child: Center(
        child: Text(
          data,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
