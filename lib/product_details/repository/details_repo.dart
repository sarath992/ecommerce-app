import 'dart:convert';
import 'package:ecomm_app/product_details/model/prd_details.dart';
import 'package:http/http.dart' as http;

class ProductService {
  final String _baseUrl = 'https://globosoft.co.uk/ecommerce-api/api/products/details.php';

  Future<Products> fetchProductDetails(int productId) async {
    final response = await http.get(Uri.parse('$_baseUrl?id=$productId'));

    if (response.statusCode == 200) {
       String body = response.body;
      int jsonStartIndex = body.indexOf('{');

      if (jsonStartIndex != -1) {
        body = body.substring(jsonStartIndex); 
      }
      final productJson = json.decode(body)['product'];
      return Products.fromJson(productJson);
    } else if (response.statusCode == 404) {
      throw Exception('Product not found');
    } else {
      throw Exception('Failed to load product details');
    }
  }
}
