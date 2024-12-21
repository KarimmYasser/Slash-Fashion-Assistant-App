import 'dart:convert';
import 'package:fashion_assistant/screens/create_avatar/get_preferences.dart';
import 'package:fashion_assistant/tap_map.dart';
import 'package:fashion_assistant/utils/http/http_client.dart';
import 'package:fashion_assistant/widgets/create_avatar/question_pubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttermoji/fluttermojiFunctions.dart';

class ChooseStyle extends StatefulWidget {
  const ChooseStyle({super.key});

  @override
  State<ChooseStyle> createState() => _ChooseStyleState();
}

class _ChooseStyleState extends State<ChooseStyle>
    with AutomaticKeepAliveClientMixin {
  bool isLoading = true;

  Map<String, dynamic> getMap() {
    if (isMale) {
      return avatarsMap['male']!;
    } else {
      return avatarsMap['female']!;
    }
  }

  late Map<String, dynamic> avatarMap;

  @override
  void initState() {
    super.initState();
    avatarMap = getMap();
    fetchProducts();
  }

  Future<String> loadAvatar() async {
    try {
      // Convert the avatar map to JSON, then decode it to SVG string
      String avatarJson = json.encode(avatarMap);
      return await FluttermojiFunctions()
          .decodeFluttermojifromString(avatarJson);
    } catch (error) {
      throw Exception("Error loading avatar SVG");
    }
  }

  /// Fetch product objects from the backend

  late List<dynamic> products = [];
  String? errorMessage;

  Future<void> fetchProducts() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // Call the existing `get` function
      final response = await HttpHelper.get('api/product/random-products');

      // Process the response
      if (response.containsKey("Shirts")) {
        products = (response["Shirts"] as List<dynamic>).map((item) {
          return {
            'id': item['id'],
            'name': item['name'],
            'price': item['price'],
            'discount': item['discount'],
            'rating': item['rating'],
            'material': item['material'],
            'returnPeriod': item['returnPeriod'],
            'image': item['image'],
            'category': item['category']['name'],
          };
        }).toList();
      } else {
        throw Exception('No products found under "Shirts"');
      }
    } catch (error) {
      errorMessage = 'Error fetching products: $error';
      products = [];
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  /// Toggle product selection
  void toggleProductSelection(Map<String, dynamic> product) {
    setState(() {
      final existingIndex = selectedProducts
          .indexWhere((selected) => selected['id'] == product['id']);
      if (existingIndex >= 0) {
        selectedProducts.removeAt(existingIndex);
        print('Removed product with ID: ${product['id']}');
      } else {
        selectedProducts.add(product);
        print('Added product with ID: ${product['id']}');
      }
    });
  }

  /// Save selected products to backend/// Save selected products to backend in the format { "shirts": selectedItems }
  /// Save selected products to backend in the format { "generalProduct": "shirts", "selectedIds": [list of selected product ids] }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity, // Give the Row a defined width
              child: Padding(
                padding: EdgeInsets.only(top: 100.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FutureBuilder<String>(
                      future: loadAvatar(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text("Error loading avatar");
                        } else if (snapshot.hasData &&
                            snapshot.data!.isNotEmpty) {
                          return SvgPicture.string(
                            snapshot.data!,
                            width: 80,
                            height: 80,
                            placeholderBuilder: (BuildContext context) =>
                                CircularProgressIndicator(),
                          );
                        } else {
                          return Text("Error loading avatar");
                        }
                      },
                    ),
                    SizedBox(
                      width: 230.w,
                      child: QuestionPubble(
                          message: 'Choose your favorite styles!'),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 30.h,
            ),

            // Display selected product photos
            Wrap(
              spacing: 10,
              children: selectedProducts.map((product) {
                return ProductCircle(
                  imageUrl: product['image'],
                  isSelected: true,
                  small: true, // Make the selected product photos smaller
                  onTap: () => toggleProductSelection(product),
                );
              }).toList(),
            ),

            // Product options
            SizedBox(
              height: 30.h,
            ),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : errorMessage != null
                    ? Center(child: Text(errorMessage!))
                    : products.isNotEmpty
                        ? GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75,
                              crossAxisSpacing: 20.w,
                              mainAxisSpacing: 20.h,
                            ),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              final product = products[index];
                              return ProductCircle(
                                imageUrl: product['image'],
                                isSelected: selectedProducts.any((selected) =>
                                    selected['id'] == product['id']),
                                onTap: () => toggleProductSelection(product),
                              );
                            },
                          )
                        : Center(child: Text('No products available'))
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

/// Widget to display product photo with selection state
class ProductCircle extends StatelessWidget {
  final String imageUrl;
  final bool isSelected;
  final VoidCallback onTap;
  final bool small; // Add this parameter

  const ProductCircle({
    Key? key,
    required this.imageUrl,
    required this.isSelected,
    required this.onTap,
    this.small = false, // Default is false for normal size
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = small ? 20.0 : 150.0; // Adjust size based on `small`

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: size.w,
            height:
                size.h * (small ? 1 : 1.33), // Adjust aspect ratio for small
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: isSelected ? Colors.green : Colors.grey,
                width: small ? 1 : 3, // Thinner border for small
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) => Center(
                  child: Icon(
                    Icons.error,
                    color: Colors.red,
                    size: size * 0.4, // Scale error icon
                  ),
                ),
              ),
            ),
          ),
          if (isSelected && !small)
            Positioned(
              right: 8,
              bottom: 8,
              child: Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 24.w,
              ),
            ),
        ],
      ),
    );
  }
}
