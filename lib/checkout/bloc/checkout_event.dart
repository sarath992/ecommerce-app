// bloc/checkout_event.dart
import 'package:ecomm_app/checkout/model/buy_model.dart';
import 'package:equatable/equatable.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

class StartCheckout extends CheckoutEvent {
  final String token;
  final CheckoutRequest request;

  StartCheckout(this.token, this.request);

  @override
  List<Object> get props => [token, request];
}
