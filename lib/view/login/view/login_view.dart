import 'package:e_vital/view/home/logic/home_cubit.dart';
import 'package:e_vital/view/home/view/home_view.dart';
import 'package:e_vital/view/login/logic/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return LoginCubit();
      },
      child: Builder(
        builder: (context) {
          LoginCubit loginCubit = BlocProvider.of<LoginCubit>(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  TextFormField(controller: loginCubit.name),
                  TextFormField(controller: loginCubit.password),
                  BlocListener<LoginCubit, LoginState>(
                    listener: (_, state) {
                      if (state is LoginError) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(state.error),
                          backgroundColor: Colors.red,
                        ));
                      }
                      if (state is LoginSuccess) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => HomeCubit(),
                                child: const HomeView(),
                              ),
                            ),
                            (route) => false);
                      }
                    },
                    child: Container(),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
                    return ElevatedButton(onPressed: () {
                      loginCubit.login();

                    }, child: Text("Login"));
                  })
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
