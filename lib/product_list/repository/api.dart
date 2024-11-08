// import 'dart:convert';
// import 'package:ecomm_app/product_list/model/model.dart';
// // import 'package:http/http.dart' as http;
// import 'package:http/http.dart' as http;

// Future<List<Product>> fetchProducts() async {
//   final response = await http.get(
//     Uri.parse('https://globosoft.co.uk/ecommerce-api/api/products/list.php'),
//     // headers: {
//     //   'Authorization': 'Bearer <token>', // Optional, include if needed
//     // },
//   );
// print('Response status: ${response.statusCode}');
// print('Response body: ${response.body}');
//   if (response.statusCode == 200) {
//   //   final data = json.decode(response.body);
//   //   final products = (data['products'] as List)
//   //       .map((json) => Product.fromJson(json))
//   //       .toList();
//   //   return products;
//   // } else {
//   //   throw Exception('Failed to load products');
//   // }
//    // Find the index of the first "{" and ignore anything before it
//     String body = response.body;
//     int jsonStartIndex = body.indexOf('{');
    
//     // Ensure we found the starting point of JSON
//     if (jsonStartIndex != -1) {
//       body = body.substring(jsonStartIndex);
//     }

//     // Parse the cleaned JSON
//     final data = json.decode(body);
//     final products = (data['products'] as List)
//         .map((json) => Product.fromJson(json))
//         .toList();
//     return products;
//   } else {
//     throw Exception('Failed to load products');
//   }
// }
// product_repository.dart
import 'dart:convert';
import 'package:ecomm_app/product_list/model/model.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(
      Uri.parse('https://globosoft.co.uk/ecommerce-api/api/products/list.php'),
    );

    if (response.statusCode == 200) {
    
      String body = response.body;
      int jsonStartIndex = body.indexOf('{');

      if (jsonStartIndex != -1) {
        body = body.substring(jsonStartIndex); 
      }

      final data = json.decode(body); 
      final products = (data['products'] as List)  
          .map((json) => Product.fromJson(json))
          .toList();

      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
