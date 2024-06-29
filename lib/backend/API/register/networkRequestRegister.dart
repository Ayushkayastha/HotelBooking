import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkRequestRegister {
  static const String baseUrl = 'http://localhost:8800/api/auth';

  static Future<String?> register(String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final contentType = response.headers['content-type'];
      if (contentType != null && contentType.contains('application/json')) {
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse['message']; // Adjust this according to your actual JSON response structure
      } else {
        return response.body; // Plain text response
      }
    } else {
      print('Failed to register. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      return null;
    }
  }
}
