import 'package:fashion_assistant/models/productcard.dart';
import 'package:fashion_assistant/tap_map.dart';
import 'package:fashion_assistant/utils/http/http_client.dart';
import 'package:fashion_assistant/models/product.dart';

class ProductService {
  // ignore: unused_field
  final String _baseUrl = '$baseURL/'; // Change port as needed

  // Method to get all products
  Future<List<ProductCardModel>> getAllProducts(String endpoint) async {
    final v = endpoint;

    final response = await HttpHelper.get(
      v,
    );

    final List<dynamic> productListJson = response['products'] as List<dynamic>;
    return productListJson
        .map((json) => ProductCardModel.fromJson(json))
        .toList();
  }

  // ignore: unused_field
  final String _baseUrlone = '$baseURL/api/product/details';

  // Method to get a single product by ID
  Future<Product> getProductById(String id) async {
    // Concatenate ID to the base URL

    final response = await HttpHelper.post('api/product/details', {"id": id});

    return Product.fromJson(response);
  }
}
