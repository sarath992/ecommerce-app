// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:ecomm_app/gotocart/bloc/view_cart_event.dart';
import 'package:ecomm_app/gotocart/bloc/view_cart_state.dart';
import 'package:ecomm_app/gotocart/repository/view_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;

  CartBloc({required this.cartRepository}) : super(CartInitial());

   Future<void> fetchCartItems(String token) async {
    emit(CartLoading());
    try {
      final cartItems = await cartRepository.fetchCartItems(token);
      emit(CartLoaded(cartItems: cartItems));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }
}
