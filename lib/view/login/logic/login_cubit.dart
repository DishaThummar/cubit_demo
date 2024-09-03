import 'package:dio/dio.dart';
import 'package:e_vital/configs/api_config.dart';
import 'package:e_vital/utils/dio_http.dart';
import 'package:e_vital/view/home/model/login_model.dart';
import 'package:e_vital/widgest/common_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  bool passwordShow = true;

  toggleShow() {
    passwordShow = !passwordShow;
    emit(LoginPassword());
  }

  List<Map<String, dynamic>> loginDataList = [];


  void login() async {
    final apiClient = ApiClient();
    try {
      final data = {
        "mobile": mobile.text,
        "password": password.text,
        "platform": "android",
        "user_id": "",
        "patient_id": "",
        "device_id": "9348d663fde2493f",
        "accesstoken": "",
        "fcmtoken":
            "cjGb_15pQCWrrbSqVtu7oV:APA91bEEgVgLOpRKx43ruK4-JI80HGqZ9KUzSwz1zMc8f--rFjyLSl8WyBfL01gNLmhyqkfsF2FWD94CLE-Hfi2q1DMmnOC9apyhF62PH2lqfwussbqfHGnQJX-ODrRk3MU9emOBxTiX",
        "app_version": "33",
        "os": "android",
        "apikey": "adDEWRWEF46546DFDSFsdfsfsdfsdfsl"
      };
      final response = await apiClient.post(ApiConfig.login, data: data);
      if (response.statusCode == 200) {
        final loginModel = LoginModel.fromJson(response.data);
        print(loginModel.data);
        if (loginModel.data != null) {
          loginDataList.add({
            "id": loginModel.data?.id,
            "mobile": loginModel.data?.mobile,
            "patientId": loginModel.data?.patientId,
            "password": loginModel.data?.password,
            "status": loginModel.data?.status,
            "isRegistered": loginModel.data?.isRegistered,
            "balance": loginModel.data?.balance,
            "accesstoken": loginModel.data?.accesstoken,
            "profilePicture": loginModel.data?.profilePicture,
            "firstname": loginModel.data?.firstname,
            "lastname": loginModel.data?.lastname,
            "patientCode": loginModel.data?.patientCode,
            "userType": loginModel.data?.userType,
            "zipcode": loginModel.data?.zipcode,
          });
          emit(LoginApiSuccess());
          showSnackbar(message: "Login Successfully.");
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('login', 'true');
        } else {
          emit(LoginApiSError(error: "${loginModel.statusMessage}"));
        }
      } else {
        emit(LoginApiSError(error: "${response.statusMessage}"));
      }
      print('Data: ${response.data}');
    } catch (e) {
      print('Error: $e');
      emit(LoginApiSError(error: "${e}"));
    }
  }
}
