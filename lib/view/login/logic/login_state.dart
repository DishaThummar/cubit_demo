part of "login_cubit.dart";
@immutable
sealed class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}

 class LoginError extends LoginState {
  String error;

  LoginError({required this.error});
}
