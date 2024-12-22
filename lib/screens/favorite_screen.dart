import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/models/productcard.dart';
import 'package:fashion_assistant/screens/product_screen.dart';
import 'package:fashion_assistant/utils/http/http_client.dart';
import 'package:fashion_assistant/widgets/product/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  bool _showScrollToTopButton = false;
  late Future<List<ProductCardModel>> _products;
  List<ProductCardModel> _filteredProducts = [];
  List<ProductCardModel> _productsList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _products = fetchProducts();
    _products.then((products) {
      setState(() {
        _productsList = products; // Store the full product list
        _filteredProducts = products; // Initialize the filtered list
        _isLoading = false;
      });
    });
    _scrollController.addListener(() {
      setState(() {
        _showScrollToTopButton = _scrollController.offset >= 200;
      });
    });
    _searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<List<ProductCardModel>> fetchProducts() async {
    try {
      final response = await HttpHelper.get('api/wishlist');
      final List<dynamic> data = response['products'] as List<dynamic>;

      return data.map((json) => ProductCardModel.fromJson(json)).toList();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again.')),
      );
    }
    return [];
  }

  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        // Reset the filtered list to the original list of products
        _filteredProducts = _productsList;
      } else {
        // Filter the products based on the query
        _filteredProducts = _productsList
            .where((product) => product.name.toLowerCase().contains(query))
            .toList();
      }
    });
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
          : SafeArea(
              child: Column(
                children: [
                  // Search Bar
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: OurColors.containerBackgroundColor,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: Icon(
                          Iconsax.search_favorite,
                          color: OurColors.primaryColor,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                      ),
                    ),
                  ),
                  // Product List
                  Expanded(
                    child: _filteredProducts.isEmpty
                        ? Center(
                            child: Text(
                              'No items found.',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18.sp,
                              ),
                            ),
                          )
                        : ListView.builder(
                            controller: _scrollController,
                            itemCount: _filteredProducts.length,
                            itemBuilder: (context, index) {
                              final product = _filteredProducts[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductScreen(productID: product.id),
                                    ),
                                  );
                                },
                                child: ProductCard(
                                  productId: product.id,
                                  brandImage: product.image,
                                  brandName: product.name,
                                  brandShowcase: product.name,
                                  prevprice: product.price,
                                  price: '',
                                  discound: product.discount,
                                  sold: '130',
                                  numReviewers: 5.toString(),
                                  stars: '5',
                                  coin: 'EGP',
                                  liked: product.isInWishlist,
                                  image: product.image,
                                  instock: product.inStock,
                                  rating: product.rating,
                                ),
                              );
                            },
                          ),
                  ),
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
