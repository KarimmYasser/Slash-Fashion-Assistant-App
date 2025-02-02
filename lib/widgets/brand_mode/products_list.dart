import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/models/productcard.dart';
import 'package:fashion_assistant/screens/brand_mode/product_details_screen_brand.dart';
import 'package:fashion_assistant/utils/http/http_client.dart';
import 'package:fashion_assistant/widgets/brand_mode/product_card_brand.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizontalListBrand extends StatefulWidget {
  const HorizontalListBrand(
      {super.key, required this.title, required this.brandid});

  final String title;
  final String brandid;
  @override
  State<HorizontalListBrand> createState() => _HorizontalListBrandState();
}

class _HorizontalListBrandState extends State<HorizontalListBrand> {
  late Future<List<ProductCardModel>> _products;
  List<ProductCardModel> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _products =
        HttpHelper.get('api/product/get-products-of-brand/${widget.brandid}')
            .then((response) {
      final products = response['products'] as List<dynamic>;
      return products
          .map((product) => ProductCardModel.fromJson(product))
          .toList();
    });
    _products.then((products) {
      setState(() {
        _filteredProducts = products;
      });
    });
  }

  // void _filterProducts(String query) {
  //   _products.then((products) {
  //     setState(() {
  //       _filteredProducts = products.where((product) {
  //         return product.name.toLowerCase().contains(query.toLowerCase());
  //       }).toList();
  //     });
  //   });
  // }

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
            style: const TextStyle(
                color: OurColors.textColor,
                fontWeight: FontWeight.w500,
                fontSize: Sizes.fontSizeLg),
          ),
        ),
        SizedBox(
          height: 410.h,
          child: FutureBuilder<List<ProductCardModel>>(
            future: _products,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No products available'));
              }

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = _filteredProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsScreenBrand(
                            productID: product.id,
                          ),
                        ),
                      );
                    },
                    child: ProductCardBrand(
                      image: product.image,
                      productId: product.id,
                      brandImage: '',
                      brandName: '',
                      brandShowcase: product.name,
                      prevprice: product.price,
                      discound: product.discount,
                      sold: '130',
                      stars: product.rating,
                      likes: 1000,
                      price: product.price,
                      coin: 'EGP',
                      numReviewers: '132',
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
