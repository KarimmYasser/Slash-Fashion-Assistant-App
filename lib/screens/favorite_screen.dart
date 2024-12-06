import 'package:fashion_assistant/constants.dart';
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
  List<dynamic> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
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

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://f86f-2c0f-fc89-8039-ab0e-10fa-ed2f-b4ae-873b.ngrok-free.app/api/wishlist'),
        headers: {
          'Authorization': 'Bearer ${HttpHelper.token}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _products = data;
          _isLoading = false;
        });
      } else {
        print('Error: ${response.statusCode}');
        setState(() => _isLoading = false);
      }
    } catch (e) {
      print('Error: $e');
      setState(() => _isLoading = false);
    }
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
          : _products.isEmpty
              ? Center(
                  child: Text(
                    'No items in your favorites list.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18.sp,
                    ),
                  ),
                )
              : SafeArea(
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
                      ..._products.map((product) {
                        return Row(
                          children: [
                            Expanded(
                              child: ProductCard(
                                productId: product['id'].toString(),
                                brandImage: product['brandImage'] ?? '',
                                brandName: product['brandName'] ?? '',
                                brandShowcase: product['name'] ?? '',
                                prevprice: product['prevPrice'] ?? 0,
                                price: product['price'].toString(),
                                discound: product['discount'].toString(),
                                sold: product['sold'].toString(),
                                numReviewers:
                                    product['numReviewers'].toString(),
                                stars: product['stars'].toString(),
                                coin: 'EGP',
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
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
