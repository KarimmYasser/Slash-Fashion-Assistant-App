import 'dart:convert';

import 'package:fashion_assistant/models/productcard.dart';
import 'package:fashion_assistant/tap_map.dart';
import 'package:fashion_assistant/utils/http/http_client.dart';
import 'package:fashion_assistant/widgets/product/product_card.dart';
import 'package:http/http.dart' as http;
import 'package:fashion_assistant/models/product.dart';

class ProductService {
  final String _baseUrl = '$baseURL/'; // Change port as needed

  // Method to get all products
  Future<List<ProductCardModel>> getAllProducts(String endpoint) async {
    final v = Uri.parse("$_baseUrl$endpoint");

    final response = await http.get(
      v,
      headers: {
        'Authorization': 'Bearer ${HttpHelper.token}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> productListJson = json.decode(response.body);
      return productListJson
          .map((json) => ProductCardModel.fromJson(json))
          .toList();
    } else {
      throw Exception(
          'Failed to load products ${response.statusCode} ${response.body}');
    }
  }

  final String _baseUrlone = '$baseURL/api/product/details';

  // Method to get a single product by ID
  Future<Product> getProductById(String id) async {
    // Concatenate ID to the base URL

    final response = await HttpHelper.post('api/product/details', {"id": id});

    return Product.fromJson(response);
  }
}
