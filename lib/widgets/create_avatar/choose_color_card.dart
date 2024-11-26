import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/widgets/create_avatar/color_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChooseColorCard extends StatelessWidget {
  const ChooseColorCard(
      {super.key,
      required this.color,
      required this.data,
      this.selected = false});
  final Color color;
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
      child: Row(
        children: [
          SizedBox(
            width: 20.w,
          ),
          ColorCircle(color: color),
          SizedBox(
            width: 20.w,
          ),
          SizedBox(
            width: 20.w,
          ),
          Text(
            data,
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
