import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/widgets/product_details/five_stars.dart';
import 'package:fashion_assistant/widgets/product_details/row_aboutbrand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class AboutBrand extends StatelessWidget {
  const AboutBrand(
      {super.key,
      required this.logo,
      required this.name,
      required this.description,
      required this.rate});
  final String logo, name, description;
  final double rate;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: OurColors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About the Brand',
              style: TextStyle(
                  fontSize: Sizes.fontSizeLg,
                  color: OurColors.textColor,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 16.h,
            ),
            Row(
              children: [
                // Size of the circular image container
                CircleAvatar(
                  radius: 28, // Inner circle size (smaller for border effect)
                  backgroundImage: NetworkImage(logo),
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$name",
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        FiveStarRating(filledStars: 3),
                        SizedBox(
                          width: 6.w,
                        ),
                        Text(
                          '($rate/5)',
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Container(
                      height: 40.h,
                      width: 70.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: const Color.fromARGB(255, 228, 223, 223),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Center(
                          child: Text(
                            'Follow',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward_ios,
                    size: 16.sp, color: OurColors.textColor),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RowAboutbrand(
                    icon: Iconsax.like_tag, text: '98% Positive Reviews'),
                RowAboutbrand(
                    icon: Icons.handshake_outlined,
                    text: 'Partner since 2+ years'),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                RowAboutbrand(
                    row: true,
                    perc: 0.84,
                    icon: Icons.handshake_outlined,
                    text: 'Items as Described'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
