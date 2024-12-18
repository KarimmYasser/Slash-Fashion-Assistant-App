import 'dart:io';
import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/screens/brand_mode/brand_total_screens.dart';
import 'package:fashion_assistant/tap_map.dart';
import 'package:fashion_assistant/utils/http/http_client.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'add_size.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BrandAddProductScreen extends StatefulWidget {
  const BrandAddProductScreen(
      {super.key, required this.sizes, required this.catID});

  final List<Size> sizes;
  final String catID;
  @override
  State<BrandAddProductScreen> createState() => _BrandAddProductScreenState();
}

class _BrandAddProductScreenState extends State<BrandAddProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  final TextEditingController _materialController = TextEditingController();

  List<File> _selectedImages = [];
  List<Map<String, dynamic>> _availableColors = [];
  List<Map<String, dynamic>> _selectedColors = [];
  Map<String, double> _colorPercentages = {};

  List<String> _tags = [];
  bool _areImagesValid = true;
  bool _isLoading = true;

  final ImagePicker _imagePicker = ImagePicker();

  String? _productId;

  @override
  void initState() {
    super.initState();
    _fetchAvailableColors();
  }

  Future<void> _fetchAvailableColors() async {
    setState(() => _isLoading = true);
    try {
      final response = await HttpHelper.get('api/constants/colours');
      final List<dynamic> data = response['colours'];
      setState(() {
        _availableColors = data.map((color) {
          return {
            'id': color['id'],
            'name': color['name'],
            'hex': color['hex'].replaceFirst('#', ''),
          };
        }).toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching colors: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

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

  void _addTag() {
    final tag = _tagController.text.trim();
    if (tag.isNotEmpty && !_tags.contains(tag)) {
      setState(() {
        _tags.add(tag);
        _tagController.clear();
      });
    } else if (_tags.contains(tag)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tag already exists!')),
      );
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }

  Future<void> _publishProduct() async {
    if (_formKey.currentState!.validate() && _selectedImages.isNotEmpty) {
      final productData = {
        "name": _productNameController.text.trim(),
        "description": _descriptionController.text.trim(),
        "price": double.parse(_priceController.text.trim()),
        "category_id": widget.catID,
        "sizes": widget.sizes
            .map((size) => {
                  "size": size.tag,
                  "quantity": size.quantity,
                })
            .toList(),
        "colours": _selectedColors
            .map((color) => {
                  "name": color['name'],
                  "percentage": _colorPercentages[color['id']] ??
                      0, // User-entered percentage
                })
            .toList(),
        "tags": _tags,
        "discount": 0, // Default or user-provided value
        "material": _materialController.text.trim(),
      };

      try {
        final response =
            await HttpHelper.post('api/brand/product', productData);
        _productId = response['product']['id']; // Save the product ID
        String? uploadedImageUrl;
        if (_selectedImages.isNotEmpty) {
          final imageFile =
              File(_selectedImages[0].path); // Take the first image

          final imageUploadRequest = http.MultipartRequest(
            'POST',
            Uri.parse('$baseURL/api/brand/product/upload-image/$_productId'),
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
              uploadedImageUrl = imageData['image'];
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
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product published successfully.')),
        );
        //Navigator.of(context).pushReplacementNamed('/totalscreens');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Fill all fields and upload images.')),
      );
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BrandTotalScreens(),
      ),
    );
  }

  void _addColor(Map<String, dynamic> color) {
    if (!_selectedColors.contains(color)) {
      setState(() {
        _selectedColors.add(color);
        _colorPercentages[color['id']] = 0.0; // Initialize percentage
      });
    }
  }

  void _removeColor(Map<String, dynamic> color) {
    setState(() {
      _selectedColors.remove(color);
      _colorPercentages.remove(color['id']); // Remove percentage
    });
  }

  Color getColorFromHex(String hexColor) {
    return Color(int.parse(hexColor, radix: 16) + 0xFF000000);
  }

  void _validatePercentages() {
    double totalPercentage = _selectedColors.fold(
        0, (sum, color) => sum + (color['percentage'] ?? 0));
    if (totalPercentage != 100) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OurColors.secondaryBackgroundColor,
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: _selectedImages.isEmpty
                              ? const Center(
                                  child: Text(
                                    "Tap to upload images",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                )
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _selectedImages.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        children: [
                                          Image.file(
                                            _selectedImages[index],
                                            height: 140,
                                            width: 100,
                                            fit: BoxFit.cover,
                                          ),
                                          Positioned(
                                            right: 0,
                                            top: 0,
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _selectedImages
                                                      .removeAt(index);
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.red,
                                                ),
                                                child: const Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text("Colors"),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: _availableColors.map((color) {
                          return Column(
                            children: [
                              FilterChip(
                                label: Text(color['name']),
                                backgroundColor: getColorFromHex(color['hex']),
                                selected: _selectedColors.contains(color),
                                onSelected: (selected) {
                                  if (selected) {
                                    _addColor(color);
                                  } else {
                                    _removeColor(color);
                                  }
                                },
                              ),
                              if (_selectedColors.contains(color))
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Percentage',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.number,
                                    initialValue: _colorPercentages[color['id']]
                                            ?.toString() ??
                                        '0',
                                    onChanged: (value) {
                                      setState(() {
                                        _colorPercentages[color['id']] =
                                            double.tryParse(value) ?? 0;
                                        _validatePercentages();
                                      });
                                    },
                                  ),
                                ),
                            ],
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      const Text("Tags"),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: _tags.map((tag) {
                          return Chip(
                            label: Text(tag),
                            onDeleted: () => _removeTag(tag),
                          );
                        }).toList(),
                      ),
                      TextFormField(
                        controller: _tagController,
                        decoration: InputDecoration(
                          hintText: "Enter a tag",
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: _addTag,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text("Material"),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _materialController,
                        decoration: InputDecoration(
                          hintText: "Enter material",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the product material";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _publishProduct,
                        child: const Center(child: Text("Publish Product")),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
