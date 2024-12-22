import 'package:fashion_assistant/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionPubble extends StatelessWidget {
  final String message;

  const QuestionPubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.r),
        margin: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: OurColors.lightGrey,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r)),
        ),
        child: Text(
          message,
          style: TextStyle(fontSize: 16.sp, color: OurColors.textColor),
        ),
      ),
    );
  }
}
