import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> sendDataToBackend(Map<String, dynamic> data) async {
  final url = Uri.parse(
      'https://your-backend-url.com/api/endpoint'); // Replace with your backend URL

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(data), // Convert the data to JSON
    );
  } catch (error) {
    // Handle any errors during the request
  }
}
