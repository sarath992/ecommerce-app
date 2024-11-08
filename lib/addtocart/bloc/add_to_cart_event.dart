import 'package:ecomm_app/addtocart/model/add_model.dart';

abstract class AddToCartEvent {}

class AddToCartRequested extends AddToCartEvent {
  final AddToCartRequest request;

  AddToCartRequested({required this.request});
}
