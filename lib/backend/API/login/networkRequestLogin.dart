import 'dart:convert';
import 'package:http/http.dart' as http;
import 'LoginModel.dart';

class NetworkRequestLogin {
  static const String baseUrl = 'http://localhost:8800/api/auth';

  static Future<LoginModel?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return LoginModel.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to login. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      return null;
    }
  }
}
