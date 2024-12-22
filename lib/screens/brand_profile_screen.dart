import 'package:fashion_assistant/screens/product_screen.dart';
import 'package:fashion_assistant/utils/http/http_client.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BrandProfilePage extends StatefulWidget {
  final String brandId; // Add the brandId parameter
  final String brandName;
  final String brandImage;
  final String brandDescription;
  final bool isFollowing;
  const BrandProfilePage({
    Key? key,
    required this.brandId,
    required this.brandName,
    required this.brandImage,
    required this.brandDescription,
    required this.isFollowing,
  }) : super(key: key);

  @override
  _BrandProfilePageState createState() => _BrandProfilePageState();
}

class _BrandProfilePageState extends State<BrandProfilePage> {
  bool isFollowing = false;
  List<dynamic> brandProducts = []; // To store products fetched from the API
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    isFollowing = widget.isFollowing; // Initialize with passed value
    fetchBrandProducts();
  }

  Future<void> toggleFollow() async {
    final String endpoint =
        isFollowing ? 'api/user/unfollow-brand' : 'api/user/follow-brand';

    final body = {
      "brandId": widget.brandId,
    };

    try {
      final response = await HttpHelper.post(endpoint, body);

      setState(() {
        isFollowing = !isFollowing; // Toggle local state
      });
    } catch (e) {
      print('Error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: Unable to update follow status.')),
        );
      }
    }
  }

  Future<void> fetchBrandProducts() async {
    final String endpoint =
        'api/product/get-products-of-brand/${widget.brandId}';

    try {
      final response = await HttpHelper.get(endpoint);

      setState(() {
        brandProducts = response['products'];
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: Unable to fetch brand products.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.brandName),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(widget.brandImage),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  widget.brandName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: ElevatedButton(
                  onPressed: toggleFollow,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 12.0,
                    ),
                  ),
                  child: Text(
                    isFollowing ? 'Following' : 'Follow',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "About the Brand",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.brandDescription,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Products",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : brandProducts.isEmpty
                      ? const Center(
                          child: Text(
                            "No products found for this brand.",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: brandProducts.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemBuilder: (context, index) {
                            final product = brandProducts[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductScreen(
                                      productID: product['id'],
                                    ),
                                  ),
                                ); // Navigate to product details
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                    image: NetworkImage(product['image']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
