import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/widgets/home_page/brands_status.dart';
import 'package:fashion_assistant/widgets/home_page/carousel_sliders.dart';
import 'package:fashion_assistant/widgets/home_page/categories_section.dart';
import 'package:fashion_assistant/widgets/home_page/flash_counterdown.dart';
import 'package:fashion_assistant/widgets/home_page/hm_hzt_list.dart';

// import 'package:fashion_assistant/widgets/custom_button.dart';
// import 'package:fashion_assistant/widgets/custom_navbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

final List<String> imagesPaths = [
  "https://media.istockphoto.com/id/1398610798/photo/young-woman-in-linen-shirt-shorts-and-high-heels-pointing-to-the-side-and-talking.jpg?s=1024x1024&w=is&k=20&c=IdY440I0pLdmANsNZRXhjSS7K9Q-Xxvnwf4YzH9qQbQ=",
  "https://media.istockphoto.com/id/1401899435/photo/image-of-young-asian-girl-posing-on-blue-background.jpg?s=2048x2048&w=is&k=20&c=PUMy-lxrA9ufa0_yjtk1_YEcj3bxd86fjD7_jCcTE3A=",
  "https://media.istockphoto.com/id/2090871623/photo/photo-of-young-asian-woman-on-purple-background.jpg?s=2048x2048&w=is&k=20&c=lBP5Ai4G_jFo9qyYvkqkBfIWY8bFOqsNGT5oFMmyYkI=",
  "https://media.istockphoto.com/id/1330861728/photo/asian-woman-looking-through-magnifying-glass-searching-or-investigating-something.jpg?s=2048x2048&w=is&k=20&c=I8vNRSuxc_iVlrl3HnZISMXBcuKltHpMr5C72Tkbog8=",
  "https://media.istockphoto.com/id/2105695547/photo/photo-of-young-asian-girl-on-purple-background.jpg?s=2048x2048&w=is&k=20&c=SgL1NDoeaqYTUgryZSL9Qev1sR_TT_eZUw45N6JRcL4=",
];
final List<Map<String, String>> brands = [
  {
    'name': 'Nike',
    'image':
        "https://media.istockphoto.com/id/1398610798/photo/young-woman-in-linen-shirt-shorts-and-high-heels-pointing-to-the-side-and-talking.jpg?s=1024x1024&w=is&k=20&c=IdY440I0pLdmANsNZRXhjSS7K9Q-Xxvnwf4YzH9qQbQ=",
  },
  {
    'name': 'Adidas',
    'image':
        "https://media.istockphoto.com/id/1401899435/photo/image-of-young-asian-girl-posing-on-blue-background.jpg?s=2048x2048&w=is&k=20&c=PUMy-lxrA9ufa0_yjtk1_YEcj3bxd86fjD7_jCcTE3A=",
  },
  {
    'name': 'Puma',
    'image':
        "https://media.istockphoto.com/id/2090871623/photo/photo-of-young-asian-woman-on-purple-background.jpg?s=2048x2048&w=is&k=20&c=lBP5Ai4G_jFo9qyYvkqkBfIWY8bFOqsNGT5oFMmyYkI=",
  },
  {
    'name': 'Nike',
    'image':
        "https://media.istockphoto.com/id/1330861728/photo/asian-woman-looking-through-magnifying-glass-searching-or-investigating-something.jpg?s=2048x2048&w=is&k=20&c=I8vNRSuxc_iVlrl3HnZISMXBcuKltHpMr5C72Tkbog8=",
  },
  {
    'name': 'Adidas',
    'image':
        "https://media.istockphoto.com/id/2105695547/photo/photo-of-young-asian-girl-on-purple-background.jpg?s=2048x2048&w=is&k=20&c=SgL1NDoeaqYTUgryZSL9Qev1sR_TT_eZUw45N6JRcL4=",
  },
  {
    'name': 'Pumammmmmmmmmmm',
    'image':
        "https://media.istockphoto.com/id/1401899435/photo/image-of-young-asian-girl-posing-on-blue-background.jpg?s=2048x2048&w=is&k=20&c=PUMy-lxrA9ufa0_yjtk1_YEcj3bxd86fjD7_jCcTE3A=",
  },
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: OurColors.containerBackgroundColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.card_giftcard,
                  color: OurColors.secondaryColor,
                  size: 20,
                ),
                SizedBox(width: 4),
                Text(
                  '1,000 Points',
                  style: TextStyle(
                    color: OurColors.secondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  // Search Bar
                  Container(
                    width: 290.w,
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
                  SizedBox(
                    width: 5.w,
                  ),
                  Container(
                    width: 50.w,
                    height: 50,
                    decoration: BoxDecoration(
                      color: OurColors.containerBackgroundColor,
                      borderRadius:
                          BorderRadius.circular(16.r), // Circular shape
                    ),
                    child: Image.asset(
                      'assets/icons/filter.png',
                      scale: 2,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: const Text('Special Offers',
                  style: TextStyle(
                      color: OurColors.textColor,
                      fontWeight: FontWeight.w500,
                      fontSize: Sizes.fontSizeLg)),
            ),
            SizedBox(
              height: 16.h,
            ),
            CustomCarousalSliders(
              imagesPaths: imagesPaths,
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: const Text('Events This Month',
                  style: TextStyle(
                      color: OurColors.textColor,
                      fontWeight: FontWeight.w500,
                      fontSize: Sizes.fontSizeLg)),
            ),
            SizedBox(
              height: 16.h,
            ),
            CustomCarousalSliders(
              imagesPaths: imagesPaths,
            ),
            SizedBox(
              height: 16.h,
            ),
            BrandCarousel(),
            SizedBox(
              height: 16.h,
            ),
            CategoriesSection(
              categories: brands,
            ),
            SizedBox(
              height: 16.h,
            ),
            const FlashSaleCountdown(
              days: 2,
              hours: 3,
              minutes: 51,
            ),
            SizedBox(
              height: 16.h,
            ),
            HorizontalList(
              title: 'Special for You',
              endpouint: 'api/product',
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }
}
// CustomScrollView(
//       slivers: [
//         SliverAppBar(
//           expandedHeight: 300.h,
//           pinned: true,
//           toolbarHeight: Sizes.appBarHeight,
//           backgroundColor: OurColors.backgroundColor,
//           actions: [
//             IconButton(
//               onPressed: () {},
//               icon: Icon(
//                 Iconsax.search_favorite,
//                 color: OurColors.iconPrimary,
//               ),
//             ),
//           ],
//           flexibleSpace: FlexibleSpaceBar(
//             titlePadding: EdgeInsets.only(left: 16, bottom: 16),
//             title: Text(
//               'Slash Styliest',
//               style: TextStyle(
//                 color: OurColors.primaryColor,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             background: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Expanded(
//                     child: CustomCarousalSliders(
//                   imagesPaths: imagesPaths,
//                 )),
//               ],
//             ),
//           ),
//         ),
//         SliverToBoxAdapter(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 SizedBox(height: 16.h),
//                 HorizontalList(
//                     title: 'Your Style',
//                     brandSHowcase: 'brandSHowcase',
//                     description: 'description',
//                     discount: '30',
//                     image:
//                         'https://media.istockphoto.com/id/1398610798/photo/young-woman-in-linen-shirt-shorts-and-high-heels-pointing-to-the-side-and-talking.jpg?s=1024x1024&w=is&k=20&c=IdY440I0pLdmANsNZRXhjSS7K9Q-Xxvnwf4YzH9qQbQ=',
//                     price: '300',
//                     coin: 'EGP',
//                     height: 250.h,
//                     width: 250.w),
//                 SizedBox(height: 16.h),
//                 HorizontalList(
//                     title: 'Trendy',
//                     brandSHowcase: 'brandSHowcase',
//                     description: 'description',
//                     discount: '30',
//                     image:
//                         'https://media.istockphoto.com/id/1398610798/photo/young-woman-in-linen-shirt-shorts-and-high-heels-pointing-to-the-side-and-talking.jpg?s=1024x1024&w=is&k=20&c=IdY440I0pLdmANsNZRXhjSS7K9Q-Xxvnwf4YzH9qQbQ=',
//                     price: '300',
//                     coin: 'EGP',
//                     height: 250.h,
//                     width: 250.w),
//                 SizedBox(height: 16.h),
//                 HorizontalList(
//                     title: 'Casual',
//                     brandSHowcase: 'brandSHowcase',
//                     description: 'description',
//                     discount: '30',
//                     image:
//                         'https://media.istockphoto.com/id/1398610798/photo/young-woman-in-linen-shirt-shorts-and-high-heels-pointing-to-the-side-and-talking.jpg?s=1024x1024&w=is&k=20&c=IdY440I0pLdmANsNZRXhjSS7K9Q-Xxvnwf4YzH9qQbQ=',
//                     price: '300',
//                     coin: 'EGP',
//                     height: 250.h,
//                     width: 250.w),
//                 SizedBox(height: 16.h),
//                 HorizontalList(
//                     title: 'Formal',
//                     brandSHowcase: 'brandSHowcase',
//                     description: 'description',
//                     discount: '30',
//                     image:
//                         'https://media.istockphoto.com/id/1398610798/photo/young-woman-in-linen-shirt-shorts-and-high-heels-pointing-to-the-side-and-talking.jpg?s=1024x1024&w=is&k=20&c=IdY440I0pLdmANsNZRXhjSS7K9Q-Xxvnwf4YzH9qQbQ=',
//                     price: '300',
//                     coin: 'EGP',
//                     height: 250.h,
//                     width: 250.w),
//                 SizedBox(height: 16.h),
//                 HorizontalList(
//                     title: 'Classical',
//                     brandSHowcase: 'brandSHowcase',
//                     description: 'description',
//                     discount: '30',
//                     image:
//                         'https://media.istockphoto.com/id/1398610798/photo/young-woman-in-linen-shirt-shorts-and-high-heels-pointing-to-the-side-and-talking.jpg?s=1024x1024&w=is&k=20&c=IdY440I0pLdmANsNZRXhjSS7K9Q-Xxvnwf4YzH9qQbQ=',
//                     price: '300',
//                     coin: 'EGP',
//                     height: 250.h,
//                     width: 250.w),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );