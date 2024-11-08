abstract class LoginEvent {}

class LoginSubmitEvent extends LoginEvent {
  final String username;
  final String password;

  LoginSubmitEvent({required this.username, required this.password});
}
