import 'dart:convert';
import 'package:ecomm_app/addtocart/model/add_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AddToCartRepository {
  final String baseUrl;
  final FlutterSecureStorage storage;

  AddToCartRepository({this.baseUrl = 'https://globosoft.co.uk/ecommerce-api/api', required this.storage});

  Future<AddToCartResponse> addToCart(AddToCartRequest request) async {
    // Get the token from secure storage
    String? token = await storage.read(key: 'auth_token');
    if (token == null) {
      throw Exception('No token found');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/cart/add.php'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(request.toJson()),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return AddToCartResponse.fromJson(data);
    } else {
      final data = json.decode(response.body);
      throw Exception(data['error'] ?? 'An error occurred');
    }
  }
}
