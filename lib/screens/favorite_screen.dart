import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/models/productcard.dart';
import 'package:fashion_assistant/tap_map.dart';
import 'package:fashion_assistant/utils/http/http_client.dart';
import 'package:fashion_assistant/widgets/product/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTopButton = false;
  late Future<List<ProductCardModel>> _products;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _products = fetchProducts();
    _scrollController.addListener(() {
      setState(() {
        _showScrollToTopButton = _scrollController.offset >= 200;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<List<ProductCardModel>> fetchProducts() async {
    try {
      final response = await HttpHelper.get(
        'api/wishlist',
      );

      final List<dynamic> data = response['products'] as List<dynamic>;

      setState(() {
        _isLoading = false;

        ;
      });
      return data.map((json) => ProductCardModel.fromJson(json)).toList();
    } catch (e) {
      print('Error: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
    return [];
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OurColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Favorites',
          style: TextStyle(
            color: OurColors.primaryColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: OurColors.backgroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : FutureBuilder<List<ProductCardModel>>(
              future: _products,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18.sp,
                      ),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      'No items in your favorites list.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18.sp,
                      ),
                    ),
                  );
                } else {
                  return SafeArea(
                    child: ListView(
                      controller: _scrollController,
                      children: [
                        // Search Bar
                        Container(
                          decoration: BoxDecoration(
                            color: OurColors.containerBackgroundColor,
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              prefixIcon: Icon(Iconsax.search_favorite,
                                  color: OurColors.primaryColor),
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 14.h),
                            ),
                          ),
                        ),
                        // Product List
                        ...snapshot.data!.map((product) {
                          return Row(
                            children: [
                              Expanded(
                                child: ProductCard(
                                  productId: product.id,
                                  brandImage: product.image,
                                  brandName: product.name,
                                  brandShowcase: product.name,
                                  prevprice: product.price,
                                  price: '',
                                  discound: product.discount,
                                  sold: '130',
                                  numReviewers:
                                      5.toString(), // Number of reviewers
                                  stars: '5',
                                  coin: 'EGP',
                                  liked: product.isInWishlist,
                                  image: product.image,
                                  instock: product.inStock,
                                  rating: product.rating,
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  );
                }
              },
            ),
      floatingActionButton: _showScrollToTopButton
          ? FloatingActionButton(
              onPressed: _scrollToTop,
              shape: const CircleBorder(),
              backgroundColor: OurColors.primaryColor,
              child: const Icon(
                Iconsax.arrow_circle_up,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}
