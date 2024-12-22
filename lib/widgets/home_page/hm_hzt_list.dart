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
  List<ProductCardModel> _filteredProducts = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchProducts();
    _searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _fetchProducts() {
    try {
      _products = ProductService().getAllProducts(widget.endpouint);
      _products.then((products) {
        setState(() {
          _filteredProducts = products;
        });
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred. Please try again.')),
      );
    }
  }

  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        // If the search input is empty, reset the filtered products to the full product list
        _products.then((products) {
          _filteredProducts = products;
        });
      } else {
        // Filter the products based on the search query
        _filteredProducts = _filteredProducts
            .where((product) => product.name.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search Bar
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search for a product',
              prefixIcon: const Icon(Icons.search, color: OurColors.textColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: OurColors.textColor),
              ),
            ),
          ),
        ),
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
              } else if (_filteredProducts.isEmpty) {
                return const Center(child: Text('No products found'));
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
