import 'package:fashion_assistant/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key, required this.categories});
  final List<Map<String, String>> categories;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Categories',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 16.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CategoryCard(
                  image: 'assets/images/category.png',
                  name: 'Category',
                  width: 140.w,
                ),
                SizedBox(
                  width: 10.w,
                ),
                CategoryCard(
                  image: 'assets/images/category.png',
                  name: 'Category',
                  width: 140.w,
                ),
                SizedBox(
                  width: 10.w,
                ),
                CategoryCard(
                  image: 'assets/images/category.png',
                  name: 'Category',
                  width: 160.w,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CategoryCard(
                  image: 'assets/images/category.png',
                  name: 'Category',
                  width: 90.w,
                ),
                SizedBox(
                  width: 10.w,
                ),
                CategoryCard(
                  image: 'assets/images/category.png',
                  name: 'Category',
                  width: 120.w,
                ),
                SizedBox(
                  width: 10.w,
                ),
                CategoryCard(
                  image: 'assets/images/category.png',
                  name: 'Category',
                  width: 120.w,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {super.key,
      required this.name,
      required this.image,
      required this.width});
  final String name;
  final String image;
  final double width;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 120.h,
        width: width,
        decoration: BoxDecoration(
          color: OurColors.grey,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Positioned(
                top: 24.h,
                left: 8.w,
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Positioned(
                bottom: 8.h,
                right: 8.w,
                child: Image.asset(
                  image,
                  scale: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
