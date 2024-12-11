import 'dart:convert';
import 'package:fashion_assistant/models/brand.dart';
import 'package:fashion_assistant/tap_map.dart';
import 'package:http/http.dart' as http;

class BrandService {
  static const String baseUrl = '$baseURL/api/brand';

  Future<BrandsResponse> fetchBrands() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      return BrandsResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load brands: ${response.body}');
    }
  }
}
