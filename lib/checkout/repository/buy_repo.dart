// repositories/checkout_repository.dart
import 'dart:convert';
import 'package:ecomm_app/checkout/model/buy_model.dart';
import 'package:http/http.dart' as http;


class CheckoutRepository {
  final String baseUrl;

  CheckoutRepository({required this.baseUrl});

  Future<CheckoutResponse> checkout(String token, CheckoutRequest request) async {
    final url = Uri.parse('$baseUrl/api/checkout/checkout.php');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return CheckoutResponse.fromJson(jsonDecode(response.body));
    } else {
      final error = jsonDecode(response.body)['error'];
      throw Exception(error ?? 'Checkout failed');
    }
  }
}
