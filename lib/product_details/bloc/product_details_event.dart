abstract class ProductDetailsEvent {}

class LoadProductDetails extends ProductDetailsEvent {
  final int productId;

  LoadProductDetails({required this.productId});
}
