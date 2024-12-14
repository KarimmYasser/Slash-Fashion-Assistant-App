import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/screens/brand_mode/product_details_screen_brand.dart';
import 'package:fashion_assistant/screens/product_screen.dart';
import 'package:fashion_assistant/screens/show_list_screen.dart';
import 'package:fashion_assistant/utils/http/http_client.dart';
import 'package:fashion_assistant/widgets/brand_mode/product_card_brand.dart';
import 'package:fashion_assistant/widgets/product/product_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:iconsax/iconsax.dart';
import 'package:fashion_assistant/services/get_products.dart';
import 'package:fashion_assistant/models/product.dart';

class HorizontalListBrand extends StatefulWidget {
  const HorizontalListBrand(
      {super.key, required this.title, required this.brandid});

  final String title;
  final String brandid;
  @override
  State<HorizontalListBrand> createState() => _HorizontalListBrandState();
}

class _HorizontalListBrandState extends State<HorizontalListBrand> {
  late Future<List<Product>> _products;
  List<Product> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _products =
        HttpHelper.get('api/product/get-products-of-brand/${widget.brandid}')
            .then((response) {
      final products = response['products'] as List<dynamic>;
      return products.map((product) => Product.fromJson(product)).toList();
    });
    _products.then((products) {
      setState(() {
        _filteredProducts = products;
      });
    });
  }

  void _filterProducts(String query) {
    _products.then((products) {
      setState(() {
        _filteredProducts = products.where((product) {
          return product.name.toLowerCase().contains(query.toLowerCase());
        }).toList();
      });
    });
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
          child: FutureBuilder<List<Product>>(
            future: _products,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No products available'));
              }

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _filteredProducts.length + 1,
                itemBuilder: (context, index) {
                  if (index == _filteredProducts.length)
                    return SizedBox(
                      width: 100.w,
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ShowListScreen(title: widget.title),
                            ),
                          );
                        },
                        icon: Icon(
                          Iconsax.arrow_circle_right4,
                          color: OurColors.secondaryTextColor,
                          size: 50.sp,
                        ),
                      ),
                    );
                  final product = _filteredProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductScreenBrand(
                            productID: product.id,
                          ),
                        ),
                      );
                    },
                    child: ProductCardBrand(
                      productId: product.id,
                      brandImage: product.image,
                      brandName: 'Fashoni',
                      brandShowcase: product.name,
                      prevprice: product.price,
                      price: '300',
                      discound: '20',
                      sold: '130',
                      numReviewers: '132',
                      stars: '5',
                      coin: 'EGP',
                      likes: 1000,
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
