import 'dart:convert';

import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/data/authentication.repository/login_data.dart';
import 'package:fashion_assistant/tap_map.dart';
import 'package:fashion_assistant/utils/http/http_client.dart';
import 'package:fashion_assistant/widgets/brand_mode/products_list.dart';
import 'package:fashion_assistant/widgets/product_details/five_stars.dart';
import 'package:fashion_assistant/widgets/product_details/row_aboutbrand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;

class BrandModeScreen extends StatefulWidget {
  const BrandModeScreen({super.key});

  @override
  State<BrandModeScreen> createState() => _BrandModeScreenState();
}

class _BrandModeScreenState extends State<BrandModeScreen> {
  String brandName = '';
  String? brandLogoUrl;
  double rating = 0;
  @override
  void initState() {
    super.initState();
    fetchBrandData();
  }

  Future<void> fetchBrandData() async {
    final response = await http.get(Uri.parse(
        '$baseURL/api/brand/get-single-brand/${BrandData.brandData!.id}'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        brandName = data['brand']['name'];
        brandLogoUrl = data['brand']['logo'];
        rating = data['brand']['rating'] ?? 0;
      });
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 252, 254),
      appBar: AppBar(
        toolbarHeight: Sizes.appBarHeight,
        backgroundColor: OurColors.backgroundColor,
        elevation: 0,
        title: const Text(
          'Slash Hub.',
          style: TextStyle(
            color: OurColors.textColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          // Points Container

          // Notification Icon with Red Dot
          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Iconsax.notification,
                  color: Colors.black,
                  size: Sizes.iconMd,
                ),
                onPressed: () {
                  // Handle notification click
                },
              ),
              Positioned(
                right: 15,
                top: 15,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 8,
                    minHeight: 8,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BrandDetails(
              brandName: brandName,
              logo: brandLogoUrl,
              rating: rating,
            )
          ],
        ),
      ),
    );
  }
}

class BrandDetails extends StatelessWidget {
  const BrandDetails(
      {super.key,
      required this.brandName,
      required this.logo,
      required this.rating});
  final String brandName;
  final String? logo;
  final double rating;
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
              'About Your Brand',
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
                  backgroundImage:
                      logo != null ? NetworkImage(logo!) : NetworkImage(''),
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      brandName,
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        FiveStarRating(filledStars: rating.toInt()),
                        SizedBox(
                          width: 6.w,
                        ),
                        Text(
                          '($rating/5)',
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Center(
                    child: Text(
                      '1k Followers',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.sp),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  // Search Bar
                  Container(
                    width: 300.w,
                    decoration: BoxDecoration(
                      color: OurColors.containerBackgroundColor,
                      borderRadius:
                          BorderRadius.circular(16.r), // Circular shape
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Search here..',
                        prefixIcon: Icon(Iconsax.search_favorite,
                            color: OurColors.grey),
                        border: InputBorder.none, // Remove default border
                        enabledBorder:
                            InputBorder.none, // Remove enabled border
                        focusedBorder:
                            InputBorder.none, // Remove focused border
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 14), // Center text
                      ),
                    ),
                  ),
                ],
              ),
            ),
            HorizontalListBrand(
              title: 'your products',
              brandid: BrandData.brandData!.id!,
            )
          ],
        ),
      ),
    );
  }
}
