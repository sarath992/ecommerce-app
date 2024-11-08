// Model for Add to Cart API request and response
class AddToCartRequest {
  final int productId;
  final int quantity;

  AddToCartRequest({
    required this.productId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
    };
  }
}

class AddToCartResponse {
  final String message;

  AddToCartResponse({required this.message});

  factory AddToCartResponse.fromJson(Map<String, dynamic> json) {
    return AddToCartResponse(message: json['message']);
  }
}
