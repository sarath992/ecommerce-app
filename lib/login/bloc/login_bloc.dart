// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:ecomm_app/login/bloc/login_event.dart';
import 'package:ecomm_app/login/bloc/login_state.dart';
import 'package:ecomm_app/login/repository/login_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterSecureStorage storage = FlutterSecureStorage();

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginInitialState());

  @override
  void onTransition(Transition<LoginEvent, LoginState> transition) {
    super.onTransition(transition); 
  }

  void login(String username, String password) {
    emit(LoginLoadingState());  
    authRepository.loginUser(username, password).then((_) async {
      final token = await storage.read(key: 'auth_token') ?? '';
      emit(LoginSuccessState(token: token));
    }).catchError((error) {
      emit(LoginFailureState(error: error.toString()));
    });
  }
}
