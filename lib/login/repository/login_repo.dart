import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterSecureStorage storage = FlutterSecureStorage();

class AuthRepository {
  Future<void> loginUser(String username, String password) async {
    final response = await http.post(
      Uri.parse('https://globosoft.co.uk/ecommerce-api/api/auth/login.php'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      String body = response.body;
      int jsonStartIndex = body.indexOf('{');
      if (jsonStartIndex != -1) {
        body = body.substring(jsonStartIndex); 
      }
      final Map<String, dynamic> data = json.decode(body);

      if (data.containsKey('token') && data['token'] != null) {
        await storage.write(key: 'auth_token', value: data['token']);
        print('Login successful, token saved.');
      } else {
        throw Exception('Token not found in the response');
      }
    } else {
      final Map<String, dynamic> errorData = json.decode(response.body);
      throw Exception(errorData['error'] ?? 'Invalid credentials');
    }
  }
}
