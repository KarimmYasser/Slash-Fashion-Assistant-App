import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/models/productcard.dart';
import 'package:fashion_assistant/screens/brand_mode/product_details_screen_brand.dart';
import 'package:fashion_assistant/services/get_products.dart';
import 'package:fashion_assistant/tap_map.dart';
import 'package:fashion_assistant/utils/http/http_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class HomeAdminScreen extends StatefulWidget {
  const HomeAdminScreen({super.key});

  @override
  State<HomeAdminScreen> createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  List<dynamic> offers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchOffers();
  }

  Future<void> _fetchOffers() async {
    try {
      final response = await HttpHelper.get('api/user/offers');
      setState(() {
        offers = response['offers'];
        isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load offers: $e')),
        );
      }
    }
  }

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
        child: Column(
          children: [
            // Buttons in Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(70.r),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductSelectionScreen(listNumber: 1),
                        ),
                      );
                    },
                    child: Center(child: Text('Add Offer List 1')),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: OurColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(70.r),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductSelectionScreen(listNumber: 2),
                        ),
                      );
                    },
                    child: Center(
                      child: Text('Add Offer List 2',
                          style: TextStyle(
                            color: OurColors.primaryColor,
                          )),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            // Display Offer Cards
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : offers.isEmpty
                      ? Center(child: Text('No offers available.'))
                      : ListView.builder(
                          itemCount: offers.length,
                          itemBuilder: (context, index) {
                            final offer = offers[index];
                            return OfferCard(
                              offer: offer,
                              onDelete:
                                  _fetchOffers, // Refresh the list after deletion
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

// Offer Card Widget
class OfferCard extends StatelessWidget {
  final dynamic offer;
  final VoidCallback
      onDelete; // Pass a callback to refresh the list after deletion

  const OfferCard({required this.offer, required this.onDelete, Key? key})
      : super(key: key);

  Future<void> _deleteOffer(BuildContext context) async {
    final String offerId = offer['id'];
    try {
      // Delete offer image
      await HttpHelper.delete('api/admin/offer/image/$offerId', {});

      // Delete offer
      await HttpHelper.delete('api/admin/offer/$offerId', {});

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Offer deleted successfully.')),
      );

      // Refresh the list
      onDelete();
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete offer: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = offer['product'];
    return Card(
      color: OurColors.white,
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        children: [
          // Offer Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
            child: Image.network(
              offer['image'],
              height: 150.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name'],
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  product['description'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${product['price']} EGP',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    Text(
                      '${offer['discount']}% Off',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Start: ${offer['start_date'].substring(0, 10)}',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                    Text(
                      'End: ${offer['end_date'].substring(0, 10)}',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                // Delete Button
                ElevatedButton.icon(
                  onPressed: () => _deleteOffer(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: OurColors.primaryColor,
                  ),
                  label: Center(child: Text('Delete')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//=================================================================================================================================
class ProductSelectionScreen extends StatefulWidget {
  final int listNumber;

  ProductSelectionScreen({required this.listNumber});

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

  final TextEditingController _discountController =
      TextEditingController(); // Controller for discount
  final TextEditingController _startDateController =
      TextEditingController(); // Controller for start date
  final TextEditingController _endDateController =
      TextEditingController(); // Controller for end date

  DateTime? startDate;
  DateTime? endDate;

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

  Future<void> _selectDate(BuildContext context,
      TextEditingController controller, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }
        controller.text = "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }

  void _createOffer() async {
    setState(() {
      isLoading = true;
    });
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
    if (_discountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a discount value.')),
      );
      return;
    }
    if (_startDateController.text.isEmpty || _endDateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select both start and end dates.')),
      );
      return;
    }
    if (startDate != null && endDate != null && startDate!.isAfter(endDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('End date must be after the start date.')),
      );
      return;
    }

    final discountValue = int.tryParse(_discountController.text);
    if (discountValue == null || discountValue <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid numeric discount.')),
      );
      return;
    }

    try {
      // Create the offer without the image
      final response = await HttpHelper.post('api/admin/offer', {
        'discount': discountValue,
        'listNumber': widget.listNumber,
        'startDate':
            startDate!.toUtc().toIso8601String(), // Convert to UTC and format
        'endDate': endDate!.toUtc().toIso8601String(),
        'productId': selectedProduct
      });

      final offerId = response['offer']['id'];
      print('Offer created successfully: $offerId');
      String? uploadedImageUrl;

      // Upload the image separately
      if (coverImage != null) {
        final imageFile = File(coverImage!.path);

        final imageUploadRequest = http.MultipartRequest(
          'POST',
          Uri.parse('$baseURL/api/admin/offer/image/$offerId'),
        );
        imageUploadRequest.headers['Authorization'] =
            'Bearer ${HttpHelper.token}';

        imageUploadRequest.files.add(await http.MultipartFile.fromPath(
          'image', // Key name for image in your backend
          imageFile.path,
        ));

        try {
          final imageResponse = await imageUploadRequest.send();

          if (imageResponse.statusCode == 200) {
            final imageResponseBody =
                await imageResponse.stream.bytesToString();
            final imageData = json.decode(imageResponseBody);
            uploadedImageUrl = imageData['imageUrl'];
            print('Image uploaded successfully: $uploadedImageUrl');
          } else {
            print(
                'Failed to upload image. Status code: ${imageResponse.statusCode}');
            final responseBody = await imageResponse.stream.bytesToString();
            print('Response body: $responseBody');
          }
        } catch (e) {
          print('Error uploading image: $e');
        }
      } else {
        print('No image file provided.');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Offer created successfully!')),
      );
      Navigator.pop(context); // Return to home page
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (e.toString().contains('The product already has an offer')) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('The product already has an offer.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create offer: $e')),
        );
      }
    }
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
                            height: 100,
                            width: 100,
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
                  // Upload Cover Image Button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.w),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(70.r),
                        ),
                        backgroundColor: OurColors.secondaryBackgroundColor,
                      ),
                      onPressed: _uploadCoverImage,
                      child: Center(
                        child: Text(
                          coverImage == null
                              ? 'Upload Cover Image'
                              : 'Change Cover Image',
                          style: TextStyle(color: Colors.black),
                        ),
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
                  // Discount TextField
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _discountController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        labelText: 'Add Discount (%)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  // Start Date TextField
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _startDateController,
                      readOnly: true,
                      onTap: () =>
                          _selectDate(context, _startDateController, true),
                      decoration: InputDecoration(
                        labelText: 'Start Date',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                  // End Date TextField
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _endDateController,
                      readOnly: true,
                      onTap: () =>
                          _selectDate(context, _endDateController, false),
                      decoration: InputDecoration(
                        labelText: 'End Date',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
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
