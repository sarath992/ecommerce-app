import 'dart:convert';
import 'package:ecomm_app/gotocart/model/view_model.dart';
import 'package:http/http.dart' as http;

class CartRepository {
  final String apiUrl = 'https://globosoft.co.uk/ecommerce-api/api/cart/view.php';

  // Method to fetch cart items
  Future<List<CartItem>> fetchCartItems(String token) async {
    final response = await http.get(
      Uri.parse('$apiUrl/view.php'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['cart'] != null) {
        return (data['cart'] as List)
            .map((item) => CartItem.fromJson(item))
            .toList();
      } else {
        return []; // Return an empty list if no items are found
      }
    } else {
      throw Exception('Failed to load cart items');
    }
  }
}
