import 'dart:convert';
import 'package:fashion_assistant/tap_map.dart';
import 'package:fashion_assistant/utils/http/http_client.dart';
import 'package:http/http.dart' as http;

class ReviewService {
  Future<List<Map<String, dynamic>>> getReviews(String productId) async {
    final response = await http.get(
      Uri.parse('$baseURL/api/review/$productId'),
      headers: {
        'Authorization': 'Bearer ${HttpHelper.token}',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load reviews ${response.body}');
    }
  }
}
