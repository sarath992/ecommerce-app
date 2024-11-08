// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:ecomm_app/checkout/repository/buy_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'checkout_event.dart';
import 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CheckoutRepository checkoutRepository;

  CheckoutBloc({required this.checkoutRepository}) : super(CheckoutInitial());

  @override
  void onTransition(Transition<CheckoutEvent, CheckoutState> transition) {
    super.onTransition(transition);
    print('Transition: $transition');
  }

  Stream<CheckoutState> mapEventToState(CheckoutEvent event) async* {
    if (event is StartCheckout) {
      emit(CheckoutLoading());  

      try {
        final response = await checkoutRepository.checkout(event.token, event.request);
        emit(CheckoutSuccess(response.message, response.orderId)); 
      } catch (error) {
        emit(CheckoutFailure(error.toString()));  
      }
    }
  }
}
