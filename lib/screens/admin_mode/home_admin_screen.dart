import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/models/productcard.dart';
import 'package:fashion_assistant/services/get_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HomeAdminScreen extends StatelessWidget {
  const HomeAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Sizes.appBarHeight,
        backgroundColor: OurColors.backgroundColor,
        elevation: 0,
        title: const Text(
          'Slash Hub.',
          style: TextStyle(
            color: OurColors.textColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductSelectionScreen(endpoint: '/offer-list-1'),
                    ),
                  );
                },
                child: Center(child: Text('Add Offer List 1')),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductSelectionScreen(endpoint: '/offer-list-2'),
                    ),
                  );
                },
                child: Center(child: Text('Add Offer List 2')),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeleteOfferScreen(),
                    ),
                  );
                },
                child: Center(child: Text('Delete Offer')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//=================================================================================================================================

class ProductSelectionScreen extends StatefulWidget {
  final String endpoint;

  ProductSelectionScreen({required this.endpoint});

  @override
  _ProductSelectionScreenState createState() => _ProductSelectionScreenState();
}

class _ProductSelectionScreenState extends State<ProductSelectionScreen> {
  final ProductService _productService = ProductService();
  List<ProductCardModel> products = [];
  List<ProductCardModel> filteredProducts = [];
  String? selectedProduct;
  File? coverImage;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final productList = await _productService.getAllProducts('api/product');
      setState(() {
        products = productList;
        filteredProducts = productList; // Initialize filtered products
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load products: $e')),
      );
    }
  }

  void _searchProducts(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredProducts = products; // Reset to full list when query is empty
      });
      return;
    }

    setState(() {
      filteredProducts = products
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> _uploadCoverImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        coverImage = File(image.path);
      });
    }
  }

  void _createOffer() {
    if (selectedProduct == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select exactly one product.')),
      );
      return;
    }
    if (coverImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please upload a cover image.')),
      );
      return;
    }
    // Perform backend call to create the offer with selectedProduct and coverImage
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Offer created successfully!')),
    );
    Navigator.pop(context); // Return to home page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Offer'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Upload Cover Image Button

                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: _searchProducts,
                      decoration: InputDecoration(
                        labelText: 'Search by product name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  // Product List
                  SizedBox(
                    height: 500.h,
                    child: ListView.builder(
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return ListTile(
                          leading: Image.network(
                            product.image,
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(product.name),
                          subtitle: Text('${product.price.toString()} EGP'),
                          trailing: Radio<String>(
                            value: product.id,
                            groupValue: selectedProduct,
                            onChanged: (value) {
                              setState(() {
                                selectedProduct = value!;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.w),
                    child: ElevatedButton(
                      onPressed: _uploadCoverImage,
                      child: Center(
                        child: Text(coverImage == null
                            ? 'Upload Cover Image'
                            : 'Change Cover Image'),
                      ),
                    ),
                  ),
                  // Cover Image Preview
                  if (coverImage != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        coverImage!,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  // Create Offer Button
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: _createOffer,
                      child: Center(child: Text('Create Offer')),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

//=================================================================================================================================

class DeleteOfferScreen extends StatefulWidget {
  @override
  _DeleteOfferScreenState createState() => _DeleteOfferScreenState();
}

class _DeleteOfferScreenState extends State<DeleteOfferScreen> {
  List<String> offers = [];
  String? selectedOffer;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchOffers();
  }

  Future<void> _fetchOffers() async {
    // Simulate fetching offers from the backend
    await Future.delayed(Duration(seconds: 2)); // Replace with actual API call
    setState(() {
      offers = ['Offer A', 'Offer B', 'Offer C']; // Replace with fetched data
      isLoading = false;
    });
  }

  void _deleteOffer() async {
    if (selectedOffer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an offer to delete.')),
      );
      return;
    }
    // Simulate deleting the offer on the backend
    await Future.delayed(Duration(seconds: 1)); // Replace with actual API call
    setState(() {
      offers.remove(selectedOffer);
      selectedOffer = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Offer deleted successfully.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Offer'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: offers.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(offers[index]),
                        trailing: Radio<String>(
                          value: offers[index],
                          groupValue: selectedOffer,
                          onChanged: (value) {
                            setState(() {
                              selectedOffer = value;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _deleteOffer,
                    child: Text('Delete Offer'),
                  ),
                ),
              ],
            ),
    );
  }
}
