class CartItem {
  final int id;
  final int productId;
  final String productName;
  final double price;
  final int quantity;
  final String image;
  final String createdAt;

  CartItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.image,
    required this.createdAt,
  });

  // Factory constructor to parse the JSON response
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      productId: json['product_id'],
      productName: json['product_name'],
      price: double.parse(json['price'].toString()),
      quantity: json['quantity'],
      image: json['image'],
      createdAt: json['created_at'],
    );
  }
}
