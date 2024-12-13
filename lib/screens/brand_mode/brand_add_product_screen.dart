import 'dart:io';
import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/screens/brand_mode/add_color_sizes_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BrandAddProductScreen extends StatefulWidget {
  const BrandAddProductScreen({super.key});

  @override
  State<BrandAddProductScreen> createState() => _BrandAddProductScreenState();
}

class _BrandAddProductScreenState extends State<BrandAddProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  String? _selectedCategory;
  List<File> _selectedImages = [];
  bool _areImagesValid = true;

  final ImagePicker _imagePicker = ImagePicker();

  List<Map<String, dynamic>> _colors = [];
  Map<String, dynamic>? _sizes;

  Future<void> _pickImages() async {
    final List<XFile>? pickedImages = await _imagePicker.pickMultiImage(
      maxWidth: 800,
      maxHeight: 800,
    );

    if (pickedImages != null && pickedImages.isNotEmpty) {
      setState(() {
        _selectedImages =
            pickedImages.map((image) => File(image.path)).toList();
        _areImagesValid = true;
      });
    }
  }

  Future<void> _navigateToAddColors() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddColorsScreen(colors: _colors),
      ),
    );

    if (result != null) {
      setState(() {
        _colors = result;
      });
    }
  }

  Future<void> _navigateToAddSizes() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddSizesScreen(sizes: _sizes),
      ),
    );

    if (result != null) {
      setState(() {
        _sizes = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OurColors.secondaryBackgroundColor,
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Name
                const Text("Product Name"),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _productNameController,
                  decoration: InputDecoration(
                    hintText: "Enter product name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the product name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Description
                const Text("Description"),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Enter product description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the product description";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Price
                const Text("Price"),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Enter price",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the product price";
                    }
                    if (double.tryParse(value) == null) {
                      return "Please enter a valid numeric value";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Category
                const Text("Category"),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  items: ["Home", "Classic", "Casual"]
                      .map((category) => DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          ))
                      .toList(),
                  onChanged: (value) {
                    _selectedCategory = value;
                  },
                  decoration: InputDecoration(
                    hintText: "Select category",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select a category";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Product Images
                const Text("Product Images"),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: _pickImages,
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _areImagesValid
                            ? OurColors.primaryColor
                            : Colors.red,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: _selectedImages.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.cloud_upload,
                                  color: _areImagesValid
                                      ? OurColors.primaryColor
                                      : Colors.red),
                              Text(
                                "Upload Images",
                                style: TextStyle(
                                  color: _areImagesValid
                                      ? Colors.black
                                      : Colors.red,
                                ),
                              ),
                            ],
                          )
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _selectedImages.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Image.file(
                                  _selectedImages[index],
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                  ),
                ),
                if (!_areImagesValid)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Please upload at least one image",
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                const SizedBox(height: 20),

                // Add Colors Button
                Center(
                  child: ElevatedButton(
                    onPressed: _navigateToAddColors,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: OurColors.containerBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: const Text(
                        "Add Colors",
                        style: TextStyle(color: OurColors.black),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Add Sizes Button
                Center(
                  child: ElevatedButton(
                    onPressed: _navigateToAddSizes,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: OurColors.containerBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: const Text(
                        "Add Sizes",
                        style: TextStyle(color: OurColors.black),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Publish Product Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          _selectedImages.isNotEmpty) {
                        // Example logic for publishing product
                        final productData = {
                          "name": _productNameController.text.trim(),
                          "description": _descriptionController.text.trim(),
                          "price": double.parse(_priceController.text.trim()),
                          "category": _selectedCategory,
                          "images": _selectedImages,
                          "colors": _colors,
                          "sizes": _sizes,
                        };

                        // Add backend integration or database upload logic here
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Product published successfully!"),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else {
                        setState(() {
                          _areImagesValid = _selectedImages.isNotEmpty;
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Please fill all fields and upload images."),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: OurColors.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Publish Product",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
