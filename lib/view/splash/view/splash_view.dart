import 'package:e_vital/view/login/view/login_view.dart';
import 'package:e_vital/view/order/view/order_view.dart';
import 'package:e_vital/view/splash/logic/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: Scaffold(
        body: BlocListener<SplashCubit, SplashState>(
          listener: (_, state) async {
            if (state is SplashProcess) {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              var status = prefs.getString('login');
              if (status != null) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const OrderView()),
                    (route) => false);
              } else {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginView()),
                    (route) => false);
              }
            }
          },
          child: const Center(
            child: Text("Welcome"),
          ),
        ),
      ),
    );
  }
}
