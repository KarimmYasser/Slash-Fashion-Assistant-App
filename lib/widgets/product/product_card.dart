import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/main.dart';
import 'package:fashion_assistant/widgets/home_page/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.brandName,
    required this.brandImage,
    required this.brandShowcase,
    required this.price,
    required this.coin,
    required this.discound,
    required this.prevprice,
    required this.sold,
    required this.starts,
    required this.numReviewers,
  });
  final String brandName,
      brandImage,
      brandShowcase,
      price,
      coin,
      discound,
      prevprice,
      sold,
      starts,
      numReviewers;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 180.w,
        padding: EdgeInsets.all(12),
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
                    'https://s3-alpha-sig.figma.com/img/709b/907e/4e3118132f60e1919c5891c6e22883fe?Expires=1731283200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=qnF7TC5k8yOoJLEs4Ahuiip23Rr0BP3HMCK6U-fRo1nkRiQxaGks3iGPIXTKfduvmvGGcamJ9aKlccNZhnIEvvif2EFsIfgxAiW9kXLEFNyuKOuOoD9YwNRT91DbkkgNZuIZjsjdzhu1JS00bxn778jDGTBnJ3E50vnghuEW3xY1MWFb24-gy88W4ZePae22MM6CwltLndPFkdLziNow5F45jn4ObRhMifbTl5puhUBUDHaLb9xO8srJZS0vJxoOoNbiBz9YT9EK5IhLoFMqcJvd3si6-TVNcD-c75zQlCSuXURnGZ65dPBQVHRWtHSgCTebju1yvjiVaETxQPwtlw__',
                    //"https://media.istockphoto.com/id/1401899435/photo/image-of-young-asian-girl-posing-on-blue-background.jpg?s=2048x2048&w=is&k=20&c=PUMy-lxrA9ufa0_yjtk1_YEcj3bxd86fjD7_jCcTE3A=",
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
                        width: 35.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: OurColors.white.withOpacity(0.6),
                        ),
                        child: Center(child: FavoriteButton()))),
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
                          starts,
                          style: TextStyle(
                            color: OurColors.textColor,
                          ),
                        ),
                        Icon(Iconsax.star1,
                            color: OurColors.primaryColor, size: 16.sp),
                        Text(
                          "(" + numReviewers + ")",
                          style: TextStyle(
                            color: OurColors.textColor,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8.h,
                  right: 8.w,
                  child: Container(
                      height: 30.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                        color: OurColors.white.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset(
                        'assets/icons/add_cart.png',
                      )),
                ),
              ],
            ),

            SizedBox(height: 4),
            // Product Title
            Text(
              brandShowcase,
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 4),
            // Brand Name
            Row(
              children: [
                Text(
                  "By ",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                ),
                // Size of the circular image container
                CircleAvatar(
                  radius: 10.r, // Inner circle size (smaller for border effect)
                  backgroundImage: NetworkImage(brandImage),
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  brandName,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
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
                          price,
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
                            discound + "% off",
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
                          "250 EGP",
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
            SizedBox(height: 8),
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
                  sold + "+ Sold Recently",
                  style: TextStyle(
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
