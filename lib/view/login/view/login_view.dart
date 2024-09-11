import 'package:e_vital/configs/app_colors.dart';
import 'package:e_vital/configs/app_text_style.dart';
import 'package:e_vital/view/login/logic/login_cubit.dart';
import 'package:e_vital/view/order/order_screen.dart';
import 'package:e_vital/view/signup/view/signup_view.dart';
import 'package:e_vital/widgest/app_button.dart';
import 'package:e_vital/widgest/common_snackbar.dart';
import 'package:e_vital/widgest/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return LoginCubit();
      },
      child: Builder(builder: (context) {
        LoginCubit loginCubit = BlocProvider.of<LoginCubit>(context);
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16, top: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.close)),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 32, right: 32, top: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login",
                          style: AppTextStyle.regular600.copyWith(fontSize: 20),
                        ),
                        Text(
                          "To access your orders,offers & more !",
                          style: AppTextStyle.regular500.copyWith(
                              fontSize: 15,
                              color: AppColors.blackColor.withOpacity(0.6)),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CommonTextField(
                          needValidation: true,
                          validationMessage: "Mobile Number",
                          isPhoneValidation: true,
                          maxLength: 10,
                          textInputType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          hintText: "Mobile",
                          controller: loginCubit.mobile,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        BlocBuilder<LoginCubit, LoginState>(
                            builder: (cubit, state) {
                          return CommonTextField(
                            needValidation: true,
                            maxLine: 1,
                            obscureText: loginCubit.passwordShow,
                            textInputType: TextInputType.visiblePassword,
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  loginCubit.toggleShow();
                                },
                                child: loginCubit.passwordShow == true
                                    ? const Icon(
                                        Icons.visibility,
                                        color: AppColors.blackColor,
                                      )
                                    : const Icon(Icons.visibility_off,
                                        color: AppColors.blackColor)),
                            validationMessage: "Password",
                            isPasswordValidation: true,
                            controller: loginCubit.password,
                            hintText: "Password",
                          );
                        }),
                        BlocListener<LoginCubit, LoginState>(
                          listener: (_, state) {
                            if (state is LoginApiSError) {

                              showSnackbar(message: state.error);
                            }
                            if (state is LoginApiSuccess) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OrderScreen(),
                                  ),
                                  (route) => false);
                            }
                          },
                          child: Container(),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        BlocBuilder<LoginCubit, LoginState>(
                            builder: (context, state) {
                          return commonButton(
                              margin:
                                  const EdgeInsets.only(top: 25, bottom: 16),
                              title: "Submit",
                              onTap: () {
                                loginCubit.login();
                              },
                              buttonWidth: MediaQuery.of(context).size.width);
                        }),
                        Center(
                            child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Forgot Password?",
                            style: AppTextStyle.regular500.copyWith(
                                color: AppColors.primaryColor, fontSize: 16),
                          ),
                        )),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Container(width: 80, child: const Divider()),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                            child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Dont't have an account?",
                            style: AppTextStyle.regular500.copyWith(
                                color: AppColors.blackColor, fontSize: 16),
                          ),
                        )),
                        commonButton(
                            margin: const EdgeInsets.only(top: 6, bottom: 16),
                            title: "Sign up Now",
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const SignupView()));
                            },
                            buttonWidth: MediaQuery.of(context).size.width)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
