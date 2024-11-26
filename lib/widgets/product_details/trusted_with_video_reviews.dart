import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/main.dart';
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
          const Text('This item is trusted by '),
          const Text(
            'Video Reviews',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(
            icon: Icon(
              Icons.question_mark,
              size: 18.sp,
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
