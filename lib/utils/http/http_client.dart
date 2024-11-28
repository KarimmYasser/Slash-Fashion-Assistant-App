import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpHelper {
  static const String _baseUrl =
      'https://hhynshsbih.us-east-1.awsapprunner.com';
  static String? token;

  // Helper method to make a GET request
  static Future<Map<String, dynamic>> get(String endpoint) async {
    // final response = await http.get(Uri.parse('$_baseUrl/$endpoint'));
    // return _handleResponse(response);
    final response = await http.get(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    return _handleResponse(response);
  }

  // Helper method to make a POST request
  static Future<Map<String, dynamic>> post(
      String endpoint, dynamic data) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  // Helper method to make a PUT request
  static Future<Map<String, dynamic>> put(String endpoint, dynamic data) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  // Helper method to make a DELETE request
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$endpoint'));
    return _handleResponse(response);
  }

  // Handle the HTTP response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode < 400) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.body}');
    }
  }

  static void setToken(String tokeen) {
    token = tokeen;
  }
}
