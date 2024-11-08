import 'package:ecomm_app/signup/bloc/signup_event.dart';
import 'package:ecomm_app/signup/bloc/signup_state.dart';
import 'package:ecomm_app/signup/repository/signup_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthService authService;

  RegisterBloc({required this.authService}) : super(RegisterInitial()) {
    on<RegisterUser>((event, emit) async {
      emit(RegisterLoading());
      try {
        final message = await authService.registerUser(event.request);
        if (message == 'User registered successfully') {
          emit(RegisterSuccess(message));
        } else {
          emit(RegisterFailure(message));
        }
      } catch (e) {
        emit(RegisterFailure('An error occurred. Please try again.'));
      }
    });
  }
}
