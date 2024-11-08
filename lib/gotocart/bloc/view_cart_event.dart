abstract class CartEvent {}

class FetchCartItems extends CartEvent {
  final String token;

  FetchCartItems({required this.token});
}
