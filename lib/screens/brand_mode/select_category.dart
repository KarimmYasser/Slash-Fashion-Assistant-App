import 'package:fashion_assistant/screens/brand_mode/add_size.dart';
import 'package:fashion_assistant/utils/http/http_client.dart';
import 'package:flutter/material.dart';

class SelectCategory extends StatefulWidget {
  const SelectCategory({super.key});

  @override
  _SelectCategoryState createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  List<dynamic> categories = [];
  String? selectedCategory;
  bool isLoading = true; // Add this variable

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    setState(() {
      isLoading = true; // Start loading
    });
    try {
      final response = await HttpHelper.get('api/constants/categories');
      categories = response['categories'];
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch categories: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false; // Stop loading
        });
      }
    }
  }

  void navigateToAddCategorySize() {
    if (selectedCategory != null) {
      // Find the category name based on the selected ID
      final selectedCategoryName = categories.firstWhere(
        (category) => category['id'] == selectedCategory,
        orElse: () => {'name': ''},
      )['name'];

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddSizesScreen(
            category: selectedCategory!,
            categoryName: selectedCategoryName,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a category')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Category')),
      body: Center(
        child: isLoading // Check the loading state
            ? CircularProgressIndicator() // Show loader if loading
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                    hint: Text('Select a category'),
                    value: selectedCategory,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCategory = newValue;
                      });
                    },
                    items: categories.map<DropdownMenuItem<String>>((category) {
                      return DropdownMenuItem<String>(
                        value: category['id'],
                        child:
                            Text('${category['name']}, ${category['style']}'),
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(50),
                    child: ElevatedButton(
                      onPressed: navigateToAddCategorySize,
                      child: Center(child: Text('Continue')),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
