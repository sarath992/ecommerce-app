import 'package:ecomm_app/signup/model/signup_model.dart';

abstract class RegisterEvent {}

class RegisterUser extends RegisterEvent {
  final RegisterRequest request;

  RegisterUser(this.request);
}
