import 'dart:convert';
import 'package:ecomm_app/signup/model/signup_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String _baseUrl = 'https://globosoft.co.uk/ecommerce-api/api/auth/register.php';

  Future<String> registerUser(RegisterRequest request) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(request.toJson()),
    );
      print('status : ${response.statusCode}');
      print('body:${response.body}');
    if (response.statusCode == 201 || response.statusCode == 200) {
      return 'User registered successfully';
    } else if (response.statusCode == 400) {
      final error = json.decode(response.body)['error'];
      return error;
    } else {
      return 'Registration failed';
    }
  }
}
