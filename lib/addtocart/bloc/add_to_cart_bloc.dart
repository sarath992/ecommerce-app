import 'package:ecomm_app/addtocart/bloc/add_to_cart_event.dart';
import 'package:ecomm_app/addtocart/bloc/add_to_cart_state.dart';
import 'package:ecomm_app/addtocart/repository/add_to_cart_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToCartBloc extends Bloc<AddToCartEvent, AddToCartState> {
  final AddToCartRepository repository;

  AddToCartBloc({required this.repository}) : super(AddToCartInitial());

  Stream<AddToCartState> mapEventToState(AddToCartEvent event) async* {
    if (event is AddToCartRequested) {
      yield AddToCartLoading();

      try {
        final response = await repository.addToCart(event.request);
        yield AddToCartSuccess(message: response.message);
      } catch (e) {
        yield AddToCartFailure(errorMessage: e.toString());
      }
    }
  }
}
