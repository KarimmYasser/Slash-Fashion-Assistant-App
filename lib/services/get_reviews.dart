import 'package:fashion_assistant/utils/http/http_client.dart';

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
