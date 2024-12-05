import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/models/product.dart';
import 'package:fashion_assistant/screens/reviews_screen.dart';
import 'package:fashion_assistant/services/get_products.dart';
import 'package:fashion_assistant/widgets/home_page/hm_hzt_list.dart';
import 'package:fashion_assistant/widgets/product_details/about_brand.dart';
import 'package:fashion_assistant/widgets/product_details/add_cart_widget.dart';
import 'package:fashion_assistant/widgets/product_details/colors_list.dart';
import 'package:fashion_assistant/widgets/product_details/description.dart';
import 'package:fashion_assistant/widgets/product_details/images_container.dart';
import 'package:fashion_assistant/widgets/product_details/material_list.dart';
import 'package:fashion_assistant/widgets/product_details/policy.dart';
import 'package:fashion_assistant/widgets/product_details/reviews.dart';
import 'package:fashion_assistant/widgets/product_details/sizes_list.dart';
import 'package:fashion_assistant/widgets/product_details/trusted_with_video_reviews.dart';
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

final List<Map<String, String>> colors = [
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

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.productID});
  final String productID;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late Future<Product> _product;
  bool isTrustedWithVideoReviews = true;

  @override
  void initState() {
    super.initState();
    _product = ProductService().getProductById(widget.productID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OurColors.secondaryBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: OurColors.grey, // Match your text color
            size: Sizes.iconMd,
          ),
          onPressed: () {
            // Navigate back to the home page
            Navigator.pop(context);
          },
        ),
        toolbarHeight: Sizes.appBarHeight,
        backgroundColor: OurColors.secondaryBackgroundColor,
        elevation: 0,
        title: Text(
          'Slash Hub.',
          style: TextStyle(
            color: OurColors.textColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(
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
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: BoxConstraints(
                    minWidth: 8,
                    minHeight: 8,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: FutureBuilder<Product>(
          future: _product,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return Center(child: Text('Product not found'));
            }

            final product = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Row(
                            children: [
                              // Size of the circular image container
                              CircleAvatar(
                                radius:
                                    14, // Inner circle size (smaller for border effect)
                                backgroundImage: NetworkImage(
                                  "https://media.istockphoto.com/id/1398610798/photo/young-woman-in-linen-shirt-shorts-and-high-heels-pointing-to-the-side-and-talking.jpg?s=1024x1024&w=is&k=20&c=IdY440I0pLdmANsNZRXhjSS7K9Q-Xxvnwf4YzH9qQbQ=",
                                ),
                                backgroundColor: Colors.transparent,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                'Fashoni',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        ImagesContainer(
                          imageUrls: imagesPaths,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            product.brandShowcase,
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              Text(
                                "${product.prevprice}",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color: OurColors.textColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.h),
                                child: Text(
                                  "EGP",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: OurColors.textColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        if (isTrustedWithVideoReviews)
                          TrustedWithVideoReviews(),
                        SizedBox(
                          height: 20.h,
                        ),
                        ColorsList(colorsList: colors),
                        SizedBox(
                          height: 20.h,
                        ),
                        SizesList(),
                        SizedBox(
                          height: 20.h,
                        ),
                        MaterialList(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Description(
                    description:
                        "This is a detailed description of the product. It provides all the necessary information users need to know before making a purchase decision. The description includes features, benefits, and usage guidelines.",
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Policy(),
                  SizedBox(
                    height: 20.h,
                  ),
                  AboutBrand(),
                  SizedBox(
                    height: 20.h,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ReviewsScreen();
                        }));
                      },
                      child: ReviewsWidget()),
                  SizedBox(
                    height: 20.h,
                  ),
                  HorizontalList(title: 'You may also like'),
                ],
              ),
            );
          }),
      bottomNavigationBar: AddCartAppBar(),
    );
  }
}
