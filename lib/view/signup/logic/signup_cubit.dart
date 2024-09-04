import 'package:dio/dio.dart';
import 'package:e_vital/configs/api_config.dart';
import 'package:e_vital/utils/dio_http.dart';
import 'package:e_vital/view/signup/model/otp_model.dart';
import 'package:e_vital/view/signup/model/signup_model.dart';
import 'package:e_vital/widgest/common_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignUpInitial());
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController referralCode = TextEditingController();
  TextEditingController pinCode = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController pinPut = TextEditingController();

  var globalKey = GlobalKey<FormState>();

  changeNumber() {
    emit(SignUpChangeNumber(number: false));
  }

  bool passwordShow = true;

  toggleShow() {
    passwordShow = !passwordShow;
    emit(SignUpPassword());
  }

  bool otpSend = false;
  List signupDataList = [];

    Future<void> signUpOtp() async {
      final apiClient = ApiClient();

      final data = {
        "mobile": mobile.text,
        "firstname": firstName.text,
        "lastname": lastName.text,
        "referral_code": "",
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

      try {
        final response = await apiClient.post(ApiConfig.signupOtp, data: data);

        print(response.statusCode);
        if (response.statusCode == 200) {
          // Parse the response
          final otpModel = OtpModel.fromJson(response.data);
          print(otpModel.data?.mobile);
          print(otpModel.statusCode);
          if (otpModel.statusCode == "1") {
            emit(SignUpApiMessage(message: true));
            showSnackbar(message: "Otp Send Successfully.");
            // emit(SignUpApiOtp());
          } else {
            emit(SignUpApiError(error: "${otpModel.statusMessage}"));
          }
        } else {
          print("Error: ${response.statusMessage}");
          emit(SignUpApiError(error: "${response.statusMessage}"));
        }
      } catch (e) {
        print('Error: $e');
      }
    }

  Future<void> signUp() async {
    final apiClient = ApiClient();

    final data = {
      "mobile": mobile.text,
      "firstname": firstName.text,
      "lastname": lastName.text,
      "password": password.text,
      "otp": pinPut.text,
      "pincode": pinCode.text,
      "referral_code": referralCode.text.isNotEmpty ? referralCode.text : "",
      "platform": "android",
      "utm_source": "C00NC",
      "utm_medium": "android",
      "utm_campaign": "white_label",
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

    try {
      final response = await apiClient.post(ApiConfig.signup, data: data);

      print(response.statusCode);
      if (response.statusCode == 200) {
        // Parse the response
        final otpModel = SignUpModel.fromJson(response.data);
        if (otpModel.statusCode != "0") {
          // print(otpModel.statusCode!="0")
          emit(SignUpSuccess());
          showSnackbar(message: "Signup Successfully.");
        } else {
          emit(SignUpApiError(error: "${otpModel.statusMessage}"));
        }
      } else {
        print("Error: ${response.statusMessage}");
        emit(SignUpApiError(error: "${response.statusMessage}"));
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
