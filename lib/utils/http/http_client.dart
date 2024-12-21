import 'dart:convert';
import 'package:fashion_assistant/tap_map.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  static const String _baseUrl = baseURL;
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
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  // Helper method to make a DELETE request
  static Future<Map<String, dynamic>> delete(
      String endpoint, dynamic data) async {
    if (data == {}) {
      final response = await http.delete(
        Uri.parse('$_baseUrl/$endpoint'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
      );
      return _handleResponse(response);
    } else {
      final response = await http.delete(
        Uri.parse('$_baseUrl/$endpoint'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: json.encode(data),
      );
      return _handleResponse(response);
    }
  }

  // Handle the HTTP response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode < 400) {
      return json.decode(response.body);
    } else {
      final responseBody = json.decode(response.body);
      if (responseBody['message'] == 'Size already exists') {
        // Handle the specific case where the size already exists
        return responseBody;
      } else {
        throw Exception('${responseBody['message']}');
      }
    }
  }

  static void setToken(String tokeen) {
    token = tokeen;
  }
}
