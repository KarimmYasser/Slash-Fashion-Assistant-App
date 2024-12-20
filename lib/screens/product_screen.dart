import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/models/product.dart';
import 'package:fashion_assistant/screens/reviews_screen.dart';
import 'package:fashion_assistant/services/get_products.dart';
import 'package:fashion_assistant/services/get_reviews.dart';
import 'package:fashion_assistant/widgets/home_page/hm_hzt_list.dart';
import 'package:fashion_assistant/widgets/product_details/about_brand.dart';
import 'package:fashion_assistant/widgets/product_details/add_cart_widget.dart';
import 'package:fashion_assistant/widgets/product_details/description.dart';
import 'package:fashion_assistant/widgets/product_details/material_list.dart';
import 'package:fashion_assistant/widgets/product_details/policy.dart';
import 'package:fashion_assistant/widgets/product_details/reviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.productID});
  final String productID;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late Future<Product> _product;
  bool isTrustedWithVideoReviews = true;
  bool? liked;
  Product? product;
  late Future<List<Map<String, dynamic>>> _reviews;

  @override
  void initState() {
    super.initState();
    _product = ProductService().getProductById(widget.productID);
    _product.then((value) {
      setState(() {
        product = value;
        liked = product!.isInWishlist;
      });
    });
    _reviews = ReviewService().getReviews(widget.productID);
  }

  Future<bool> fetchLikedStatus() async {
    return liked ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OurColors.secondaryBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: OurColors.grey,
            size: Sizes.iconMd,
          ),
          onPressed: () {
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
                              CircleAvatar(
                                radius: 14,
                                backgroundImage: NetworkImage(
                                  product.brand.logo ?? '',
                                ),
                                backgroundColor: Colors.transparent,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                product.brand.name,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                16.0), // Adjust the radius as needed
                            child: Image.network(
                              product.image,
                              width: double.infinity,
                              // Adjust the height as needed
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            product.name,
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${product.price - (product.price * product.discount) / 100}",
                                        style: TextStyle(
                                          fontSize: 22.sp,
                                          color: OurColors.textColor,
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
                                      SizedBox(width: 4.w),
                                      Padding(
                                        padding: EdgeInsets.only(top: 10.h),
                                        child: Text(
                                          "${product.discount}% off",
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
                                        '${product.price}',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: product.colours.keys.map((color) {
                              return Text(
                                color,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: OurColors.textColor,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        if (product.sizes.isNotEmpty)
                          SizedBox(
                            height: 170.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: product.sizes.length,
                              itemBuilder: (context, index) {
                                final size = product.sizes[index];
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Size: ${size.size}',
                                            style: TextStyle(fontSize: 14.sp)),
                                        if (size.waist != null)
                                          Text('Waist: ${size.waist}',
                                              style:
                                                  TextStyle(fontSize: 12.sp)),
                                        Text('Length: ${size.length}',
                                            style: TextStyle(fontSize: 12.sp)),
                                        Text('Chest: ${size.chest}',
                                            style: TextStyle(fontSize: 12.sp)),
                                        Text('Arm Length: ${size.armLength}',
                                            style: TextStyle(fontSize: 12.sp)),
                                        Text('Bicep: ${size.bicep}',
                                            style: TextStyle(fontSize: 12.sp)),
                                        if (size.footLength != null)
                                          Text(
                                              'Foot Length: ${size.footLength}',
                                              style:
                                                  TextStyle(fontSize: 12.sp)),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        SizedBox(
                          height: 20.h,
                        ),
                        MaterialList(name: product.material),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Description(
                    description: product.description ?? '',
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Policy(),
                  SizedBox(
                    height: 20.h,
                  ),
                  AboutBrand(
                    rate: product.brand.rating,
                    name: product.brand.name,
                    description: product.brand.description,
                    logo: product.brand.logo ?? '',
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return FutureBuilder<List<Map<String, dynamic>>>(
                              future: _reviews,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return Center(
                                      child: Text('No reviews available'));
                                }

                                final reviews = snapshot.data!;
                                return ReviewsScreen(
                                  reviews: reviews,
                                  productId: product.id,
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                    child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: _reviews,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(child: Text('No reviews available'));
                        }

                        final reviews = snapshot.data!;
                        return ReviewsWidget(
                          rate: product.rating,
                          reviews: reviews,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  HorizontalList(
                    title: 'You may also like',
                    endpouint: 'api/product',
                  ),
                ],
              ),
            );
          }),
      bottomNavigationBar: FutureBuilder<bool>(
        future: fetchLikedStatus(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (product != null) {
            return AddCartAppBar(
              productId: widget.productID,
              liked: snapshot.data!,
              variants: product!.variants,
            );
          }
          return Text('no response');
        },
      ),
    );
  }
}
