part of "login_cubit.dart";

@immutable
sealed class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginPassword extends LoginState {}

class LoginApiSuccess extends LoginState {}

class LoginApiSError extends LoginState {
  String error;

  LoginApiSError({required this.error});
}

class LoginError extends LoginState {
  String error;

  LoginError({required this.error});
}
