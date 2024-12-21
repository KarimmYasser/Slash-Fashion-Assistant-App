import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/models/productcard.dart';
import 'package:fashion_assistant/screens/product_screen.dart';
import 'package:fashion_assistant/widgets/product/product_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fashion_assistant/services/get_products.dart';

class HorizontalList extends StatefulWidget {
  const HorizontalList(
      {super.key, required this.title, required this.endpouint});

  final String title;
  final String endpouint;
  @override
  State<HorizontalList> createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  late Future<List<ProductCardModel>> _products;
  @override
  void initState() {
    super.initState();
    _products = ProductService().getAllProducts(widget.endpouint);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(
            widget.title,
            style: TextStyle(
                color: OurColors.textColor,
                fontWeight: FontWeight.w500,
                fontSize: Sizes.fontSizeLg),
          ),
        ),
        SizedBox(
          height: 410.h,
          child: FutureBuilder<List<ProductCardModel>>(
            future:
                _products, // Make sure _products is defined elsewhere in the code
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No products available'));
              }

              final products = snapshot.data!;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductScreen(
                            productID: product.id,
                          ),
                        ),
                      );
                    },
                    child: ProductCard(
                      productId: product.id,
                      brandImage: product.image,
                      brandName: 'Fashoni',
                      brandShowcase: product.name,
                      prevprice: product.price,
                      price: '300',
                      discound: product.discount,
                      sold: '130',
                      numReviewers: '132',
                      stars: '5',
                      coin: 'EGP',
                      liked: product.isInWishlist,
                      image: product.image,
                      instock: product.inStock,
                      rating: product.rating,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
