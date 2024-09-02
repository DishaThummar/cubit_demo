import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  login() {
    if (name.text == "Abc" && password.text == "1234") {
      emit(LoginSuccess());
    } else {
      emit(LoginError(error: "Email id was wrong!"));
    }
  }
}
