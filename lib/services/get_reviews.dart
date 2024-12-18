import 'dart:convert';
import 'package:fashion_assistant/tap_map.dart';
import 'package:fashion_assistant/utils/http/http_client.dart';
import 'package:http/http.dart' as http;

class ReviewService {
  Future<List<Map<String, dynamic>>> getReviews(String productId) async {
    final response = await HttpHelper.get(
      'api/review/$productId',
    );

    // Debugging: Print the response to inspect its format
    print('Response: $response');

    if (response['reviews'] is List) {
      return (response['reviews'] as List)
          .map((review) => review as Map<String, dynamic>)
          .toList();
    } else {
      throw Exception('Unexpected response format');
    }
  }
}
