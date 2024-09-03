import 'package:e_vital/configs/app_colors.dart';
import 'package:e_vital/configs/app_text_style.dart';
import 'package:e_vital/view/home/logic/home_cubit.dart';
import 'package:e_vital/view/login/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Home Page",
            style: AppTextStyle.regular400
                .copyWith(fontSize: 18, color: AppColors.whiteColor),
          ),
          backgroundColor: AppColors.primaryColor,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.clear();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginView(),
                      ),
                      (route) => false);
                },
                child: const Icon(
                  Icons.logout,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ],
        ),
        body: Center(
            child: Text(
          "Home Page",
          style: AppTextStyle.regular400
              .copyWith(fontSize: 20, color: AppColors.primaryColor),
        )),
      ),
    );
  }
}
