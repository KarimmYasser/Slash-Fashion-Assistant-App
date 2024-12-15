import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/main.dart';
import 'package:fashion_assistant/screens/create_avatar/male_or_female.dart';
import 'package:fashion_assistant/screens/product_screen.dart';
import 'package:fashion_assistant/widgets/home_page/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

class ProductCardBrand extends StatelessWidget {
  const ProductCardBrand({
    super.key,
    required this.brandName,
    required this.brandImage,
    required this.brandShowcase,
    required this.price,
    required this.coin,
    required this.discound,
    required this.prevprice,
    required this.sold,
    required this.stars,
    required this.numReviewers,
    required this.productId,
    required this.likes,
    required this.image,
  });
  final String brandName,
      brandImage,
      brandShowcase,
      coin,
      sold,
      numReviewers,
      productId;
  final double prevprice, price, stars;
  final int likes, discound;

  final String image;

  String formatLikes(int likes) {
    if (likes >= 1000) {
      return '${(likes / 1000).toStringAsFixed(1)}k';
    }
    return likes.toString();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 180.w,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 252, 252, 254),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Product Image Placeholder
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    image, //"https://media.istockphoto.com/id/1401899435/photo/image-of-young-asian-girl-posing-on-blue-background.jpg?s=2048x2048&w=is&k=20&c=PUMy-lxrA9ufa0_yjtk1_YEcj3bxd86fjD7_jCcTE3A=",
                    // Replace with actual image URL
                    width: double.infinity,
                    height: 200.h,
                    fit: BoxFit.cover,
                  ),
                ),
                // Heart Icon
                Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                        height: 35.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: OurColors.white.withOpacity(0.6),
                        ),
                        child: Row(
                          children: [
                            Center(
                              child: Icon(
                                Iconsax.heart5,
                                color: OurColors.primaryColor,
                                size: Sizes.iconMd,
                              ),
                            ),
                            Text(formatLikes(likes))
                          ],
                        ))),
                SizedBox(height: 8.h),
                // Rating and Review Count
                Positioned(
                  left: 8.w,
                  bottom: 8.h,
                  child: Container(
                    height: 20.h,
                    width: 62.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: OurColors.white.withOpacity(0.6),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 4.w),
                        Text(
                          "$stars",
                          style: const TextStyle(
                            color: OurColors.textColor,
                          ),
                        ),
                        Icon(Iconsax.star1,
                            color: OurColors.primaryColor, size: 16.sp),
                        Text(
                          "5",
                          style: TextStyle(
                            color: OurColors.textColor,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 4),
            // Product Title
            Text(
              brandShowcase,
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
            const SizedBox(height: 4),
            // Brand Name

            // Price and Discount
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${prevprice - (prevprice * discound) / 100}",
                          style: TextStyle(
                            fontSize: 22.sp,
                            color: OurColors.textColor,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: Text(
                            coin,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: OurColors.textColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: Text(
                            "$discound% off",
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: OurColors.primaryColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "$prevprice",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Cart Icon
              ],
            ),
            const SizedBox(height: 8),
            // Sold Recently Text
            Row(
              children: [
                Image.asset(
                  'assets/icons/add_cartred.png',
                  scale: 2,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  "$sold+ Sold Recently",
                  style: const TextStyle(
                    fontSize: 12,
                    color: OurColors.textColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
