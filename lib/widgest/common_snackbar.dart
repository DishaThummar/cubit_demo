import 'package:e_vital/configs/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showSnackbar({ required String message}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.blackColor.withOpacity(0.8),
      textColor: AppColors.whiteColor,
      fontSize: 15.0);
}
