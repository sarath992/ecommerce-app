class Products {
  final int id;
  final String name;
  final String description;
  final String price;
  final String? image;
  final String createdAt;

  Products({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.image,
    required this.createdAt,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
      createdAt: json['created_at'],
    );
  }
}
