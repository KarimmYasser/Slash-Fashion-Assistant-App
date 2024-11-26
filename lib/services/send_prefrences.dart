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

    if (response.statusCode == 200) {
      // Handle successful response
      print('Data sent successfully: ${response.body}');
    } else {
      // Handle error response
      print('Failed to send data: ${response.statusCode}');
    }
  } catch (error) {
    // Handle any errors during the request
    print('Error sending data: $error');
  }
}
