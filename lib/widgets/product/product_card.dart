import 'package:fashion_assistant/constants.dart';
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
    required this.stars,
    required this.numReviewers,
    required this.productId,
    required this.liked,
    required this.image,
    required this.instock,
    required this.rating,
  });

  final String brandName,
      brandImage,
      brandShowcase,
      price,
      coin,
      sold,
      stars,
      numReviewers,
      productId,
      image;
  final double prevprice, rating;
  final int discound;
  final bool liked, instock;

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
                    image,
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
                        child: Center(
                            child: FavoriteButton(
                          productId: productId,
                          isLiked: liked,
                        )))),
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
                        Icon(Iconsax.star1,
                            color: OurColors.primaryColor, size: 16.sp),
                        Text(
                          "$rating",
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
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      color: OurColors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: instock
                        ? const Text(
                            'In Stock',
                            style: TextStyle(color: Colors.green),
                          )
                        : const Text(
                            'Out Of Stock',
                            style: TextStyle(color: Colors.red),
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

            const SizedBox(height: 8),
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
                        if (discound != 0)
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
                    if (discound != 0)
                      Row(
                        children: [
                          Text(
                            '$prevprice',
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
          ],
        ),
      ),
    );
  }
}
