import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/widgets/brand_mode/products_list.dart';
import 'package:fashion_assistant/widgets/home_page/hm_hzt_list.dart';
import 'package:fashion_assistant/widgets/product_details/five_stars.dart';
import 'package:fashion_assistant/widgets/product_details/row_aboutbrand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class BrandModeScreen extends StatelessWidget {
  const BrandModeScreen({super.key});

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
          children: [BrandDetails()],
        ),
      ),
    );
  }
}

class BrandDetails extends StatelessWidget {
  const BrandDetails({super.key});
  void _editBrand(BuildContext context) {
    // Show a dialog or navigate to a new screen for editing
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Brand'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Brand Name'),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Brand Photo URL'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Save the changes
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

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
                  backgroundImage: NetworkImage(
                    "https://media.istockphoto.com/id/1398610798/photo/young-woman-in-linen-shirt-shorts-and-high-heels-pointing-to-the-side-and-talking.jpg?s=1024x1024&w=is&k=20&c=IdY440I0pLdmANsNZRXhjSS7K9Q-Xxvnwf4YzH9qQbQ=",
                  ),
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fashoni',
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.w500),
                    ),
                    IconButton(
                      icon: Icon(Iconsax.edit_2),
                      onPressed: () {
                        // Implement the edit functionality here
                        _editBrand(context);
                      },
                    ),
                    Row(
                      children: [
                        FiveStarRating(filledStars: 3),
                        SizedBox(
                          width: 6.w,
                        ),
                        Text(
                          '(4.5/5)',
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
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  // Search Bar
                  Container(
                    width: 310.w,
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
              brandid: 'd83f5614-05e1-4300-9f52-415fa66b2847',
            )
          ],
        ),
      ),
    );
  }
}
