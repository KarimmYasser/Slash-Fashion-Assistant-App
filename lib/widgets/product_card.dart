import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/widgets/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(
      {super.key,
      required this.brandShowcase,
      required this.description,
      required this.height,
      required this.width,
      required this.discount,
      required this.price,
      required this.coin,
      required this.image});
  final String brandShowcase;
  final String description;
  final String discount, price, coin;
  final double height, width;
  final String image;
  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isHovered = true),
        onTapUp: (_) => setState(() => _isHovered = false),
        onTapCancel: () => setState(() => _isHovered = false),
        child: AnimatedScale(
          scale: _isHovered ? 1.05 : 1,
          duration: const Duration(microseconds: 200),
          child: Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: OurColors.containerBackgroundColor,
              borderRadius: BorderRadius.circular(40.r),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 248, 243, 243),
                  blurRadius: 10.r,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40.r),
                      child: Image.network(
                        widget.image,
                        height: widget.height / 3,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: OurColors.containerBackgroundColor,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: const Text(
                          'Buy now',
                          style: TextStyle(
                            color: OurColors.secondaryTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.brandShowcase,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      widget.price + ' ' + widget.coin,
                      style: TextStyle(
                          color: OurColors.primaryButtonBackgroundColor),
                    )
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.description,
                      style: TextStyle(
                        color: OurColors.secondaryTextColor,
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(
                      '-' + widget.discount + '%',
                      style: TextStyle(color: OurColors.secondaryColor),
                    )
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.label, color: OurColors.textColor),
                        SizedBox(width: 4.w),
                        const Text(
                          'Browse',
                          style: TextStyle(
                            color: OurColors.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const FavoriteButton(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
