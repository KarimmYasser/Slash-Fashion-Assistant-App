import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:fashion_assistant/models/product.dart';

class ProductService {
  final String _baseUrl =
      'https://hhynshsbih.us-east-1.awsapprunner.com/api/product/'; // Change port as needed

  // Method to get all products
  Future<List<Product>> getAllProducts() async {
    final v = Uri.parse(_baseUrl);

    final response = await http.get(v);

    if (response.statusCode == 200) {
      final List<dynamic> productListJson = json.decode(response.body);
      return productListJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  final String _baseUrlone =
      'https://hhynshsbih.us-east-1.awsapprunner.com/api/product/';

  // Method to get a single product by ID
  Future<Product> getProductById(String id) async {
    final url = Uri.parse('$_baseUrlone$id'); // Concatenate ID to the base URL

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final productJson = json.decode(response.body);
      return Product.fromJson(productJson);
    } else {
      throw Exception('Failed to load product with ID $id');
    }
  }
}
