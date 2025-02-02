import 'package:fashion_assistant/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class TrustedWithVideoReviews extends StatelessWidget {
  const TrustedWithVideoReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        color: OurColors.primaryColor.withOpacity(0.07),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 10.w,
          ),
          Icon(
            Iconsax.star1,
            color: const Color.fromARGB(255, 135, 84, 255),
            size: 30.sp,
          ),
          SizedBox(
            width: 5.w,
          ),
          const Text('You\'ll get 100 points for completing your review'),
        ],
      ),
    );
  }
}
