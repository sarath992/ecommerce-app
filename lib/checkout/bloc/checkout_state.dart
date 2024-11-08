
import 'package:equatable/equatable.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object?> get props => [];
}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutSuccess extends CheckoutState {
  final String message;
  final int? orderId;

  CheckoutSuccess(this.message, this.orderId);

  @override
  List<Object?> get props => [message, orderId];
}

class CheckoutFailure extends CheckoutState {
  final String error;

  CheckoutFailure(this.error);

  @override
  List<Object> get props => [error];
}
