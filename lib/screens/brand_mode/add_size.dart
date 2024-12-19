import 'package:fashion_assistant/data/authentication.repository/login_data.dart';
import 'package:fashion_assistant/screens/brand_mode/brand_add_product_screen.dart';
import 'package:fashion_assistant/utils/http/http_client.dart';
import 'package:flutter/material.dart';

class Size {
  final String tag;
  final int? chest;
  final int? armLength;
  final int? bicep;
  final int? length;
  final int? waist;
  final int? footLength;
  int quantity;

  Size({
    required this.tag,
    this.chest,
    this.armLength,
    this.bicep,
    this.length,
    this.waist,
    this.footLength,
    required this.quantity,
  });

  @override
  String toString() {
    return 'Tag: $tag, Quantity: $quantity';
  }
}

class AddSizesScreen extends StatefulWidget {
  final String category; // Category ID passed from CategorySelectionScreen
  final String categoryName; // Category name for display

  AddSizesScreen({required this.category, required this.categoryName});

  @override
  State<AddSizesScreen> createState() => _AddSizesScreenState();
}

class _AddSizesScreenState extends State<AddSizesScreen> {
  final Map<String, List<String>> categoryFields = {
    "Shirts": ["chest", "armLength", "bicep", "length"],
    "Pants": ["waist", "length"],
    "Jackets": ["chest", "armLength", "bicep", "length"],
    "Shoes": ["footLength"],
  };

  final Map<String, TextEditingController> controllers = {};
  final TextEditingController tagController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  final List<Size> sizes = [];

  @override
  void initState() {
    super.initState();
    // Initialize controllers for dynamic fields
    for (var field in categoryFields[widget.categoryName] ?? []) {
      controllers[field] = TextEditingController();
    }
  }

  @override
  void dispose() {
    // Clean up controllers
    for (var controller in controllers.values) {
      controller.dispose();
    }
    tagController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  Future<void> _addSizeToBackend(Size size) async {
    const String apiUrl = "api/brand/category";
    String categoryId = widget.category;

    final Map<String, dynamic> payload = {
      "category_id": categoryId,
      "brand_id": BrandData.brandData!.id,
      "sizeTag": size.tag,
      "waist": size.waist,
      "length": size.length,
      "chest": size.chest,
      "arm_length": size.armLength,
      "bicep": size.bicep,
      "foot_length": size.footLength,
    };

    try {
      final response = await HttpHelper.post(apiUrl, payload);
      print('Response: $response');
    } catch (e) {
      print('Error occurred while sending size to backend: $e');
    }
  }

  void _addSize() async {
    if (!_areFieldsValid()) return;

    final newSize = Size(
      tag: tagController.text.trim().toUpperCase(),
      chest: _parseField("chest"),
      armLength: _parseField("armLength"),
      bicep: _parseField("bicep"),
      length: _parseField("length"),
      waist: _parseField("waist"),
      footLength: _parseField("footLength"),
      quantity: int.tryParse(quantityController.text.trim()) ?? 0,
    );

    await _addSizeToBackend(newSize);

    setState(() {
      sizes.add(newSize);
    });

    _clearFields();
  }

  bool _areFieldsValid() {
    if (tagController.text.trim().isEmpty) {
      _showError("Please enter a size tag.");
      return false;
    }

    if (quantityController.text.trim().isEmpty ||
        int.tryParse(quantityController.text.trim()) == null) {
      _showError("Please enter a valid quantity.");
      return false;
    }

    for (var field in categoryFields[widget.categoryName] ?? []) {
      if (controllers[field]?.text.trim().isEmpty ?? true) {
        _showError("Please enter a valid value for ${_capitalize(field)}.");
        return false;
      }

      if (int.tryParse(controllers[field]?.text.trim() ?? "") == null) {
        _showError(
            "Invalid value for ${_capitalize(field)}. Only numbers are allowed.");
        return false;
      }
    }

    return true;
  }

  int? _parseField(String field) {
    final text = controllers[field]?.text.trim();
    return text != null && text.isNotEmpty ? int.tryParse(text) : null;
  }

  void _clearFields() {
    tagController.clear();
    quantityController.clear();
    controllers.forEach((key, controller) => controller.clear());
  }

  void _submitSizes() {
    if (sizes.isEmpty) {
      _showError("Please add at least one size before submitting.");
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BrandAddProductScreen(
          sizes: sizes,
          catID: widget.category,
        ),
      ),
    );

    print("Submitting sizes: $sizes");
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dynamicFields = categoryFields[widget.categoryName] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Sizes (${widget.categoryName})'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: tagController,
                decoration:
                    InputDecoration(labelText: 'Tag (e.g., Small, Medium)'),
              ),
              TextField(
                controller: quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
              ),
              ...dynamicFields.map((field) {
                return TextField(
                  controller: controllers[field],
                  decoration:
                      InputDecoration(labelText: '${_capitalize(field)}'),
                  keyboardType: TextInputType.number,
                );
              }).toList(),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _addSize,
                child: Text('Add Size'),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: sizes.length,
                itemBuilder: (context, index) {
                  final size = sizes[index];
                  return Card(
                    child: ListTile(
                      title: Text('Tag: ${size.tag}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (size.chest != null) Text('Chest: ${size.chest}'),
                          if (size.armLength != null)
                            Text('Arm Length: ${size.armLength}'),
                          if (size.bicep != null) Text('Bicep: ${size.bicep}'),
                          if (size.length != null)
                            Text('Length: ${size.length}'),
                          if (size.waist != null) Text('Waist: ${size.waist}'),
                          if (size.footLength != null)
                            Text('Foot Length: ${size.footLength}'),
                          Text('Quantity: ${size.quantity}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _submitSizes,
                child: Text('Submit Sizes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _capitalize(String text) {
    return "${text[0].toUpperCase()}${text.substring(1)}".replaceAll("_", " ");
  }
}
