import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpHelper {
  static const String _baseUrl =
      'https://113d-2c0f-fc89-8032-d65f-6179-900b-c52f-3aeb.ngrok-free.app';
  //static const String _baseUrl = 'http://localhost:3300';
  //static const String _baseUrl = 'https://c9b8-2c0f-fc89-8039-92bb-40a7-a57c-bbd6-a0e3.ngrok-free.app';
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
