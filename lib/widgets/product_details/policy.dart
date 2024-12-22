import 'package:fashion_assistant/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Policy extends StatelessWidget {
  const Policy({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: OurColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 18.h, left: 16.w, right: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Refund and exchange policy',
                  style: TextStyle(
                      fontSize: Sizes.fontSizeLg,
                      color: OurColors.textColor,
                      fontWeight: FontWeight.bold),
                ),
                Icon(Icons.arrow_forward_ios,
                    size: 16.sp, color: OurColors.textColor),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'This item cannot be exchanged or returned',
              style: TextStyle(
                fontSize: Sizes.fontSizeMd,
                color: OurColors.darkGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
