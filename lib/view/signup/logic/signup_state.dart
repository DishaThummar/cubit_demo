part of 'signup_cubit.dart';

@immutable
sealed class SignupState {}

class SignUpInitial extends SignupState {}

class SignUpSuccess extends SignupState {}

class SignUpPassword extends SignupState {}

class SignUpApiSuccess extends SignupState {}

class SignUpApiMessage extends SignupState {
  bool message;

  SignUpApiMessage({required this.message});
}
class SignUpChangeNumber extends SignupState {
  bool number;

  SignUpChangeNumber({required this.number});
}


class SignUpApiError extends SignupState {
  String error;

  SignUpApiError({required this.error});
}

class SignUpError extends SignupState {
  String error;

  SignUpError({required this.error});
}
