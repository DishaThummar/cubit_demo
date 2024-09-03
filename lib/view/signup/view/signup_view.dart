// ignore_for_file: prefer_const_constructors

import 'package:e_vital/configs/app_colors.dart';
import 'package:e_vital/configs/app_text_style.dart';
import 'package:e_vital/view/home/logic/home_cubit.dart';
import 'package:e_vital/view/home/view/home_view.dart';
import 'package:e_vital/view/login/view/login_view.dart';
import 'package:e_vital/view/signup/logic/signup_cubit.dart';
import 'package:e_vital/widgest/app_button.dart';
import 'package:e_vital/widgest/common_snackbar.dart';
import 'package:e_vital/widgest/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignupCubit(),
      child: Builder(builder: (context) {
        var signUpCubit = BlocProvider.of<SignupCubit>(context);
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16, top: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close)),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 32, right: 32, top: 16),
                  child: SingleChildScrollView(
                    child: Form(
                      key: signUpCubit.globalKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sign up",
                            style:
                                AppTextStyle.regular600.copyWith(fontSize: 20),
                          ),
                          Text(
                            "To access your orders,offers & more !",
                            style: AppTextStyle.regular500.copyWith(
                                fontSize: 15,
                                color: AppColors.blackColor.withOpacity(0.6)),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          CommonTextField(
                            textInputType: TextInputType.name,
                            controller: signUpCubit.firstName,
                            hintText: "First Name",
                            needValidation: true,
                            validationMessage: "First Name",
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          CommonTextField(
                            needValidation: true,
                            validationMessage: "Last Name",
                            textInputType: TextInputType.name,
                            controller: signUpCubit.lastName,
                            hintText: "Last Name",
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          BlocBuilder<SignupCubit, SignupState>(
                              builder: (cubit, state) {
                            return CommonTextField(
                              needValidation: true,
                              validationMessage: "Mobile Number",
                              isPhoneValidation: true,
                              maxLength: 10,
                              textInputType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              widgest: signUpCubit.otpSend == true
                                  ? GestureDetector(
                                      onTap: () {
                                        signUpCubit.changeNumber();
                                      },
                                      child: Text(
                                        "Change Number",
                                        style: AppTextStyle.regular500.copyWith(
                                            fontSize: 14,
                                            color: AppColors.primaryColor),
                                      ))
                                  : SizedBox(),
                              hintText: "Mobile",
                              controller: signUpCubit.mobile,
                            );
                          }),
                          SizedBox(
                            height: 16,
                          ),
                          CommonTextField(
                            controller: signUpCubit.referralCode,
                            hintText: "Referral Code (Optional)",
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          // signUpCubit.otpSend==true?Column(
                          //   children: [
                          //     Align(
                          //       alignment: Alignment.centerLeft,
                          //       child: Text(
                          //         "You will receive OTP shortly.",
                          //         style: TextStyle(
                          //             fontWeight: FontWeight.w400,
                          //             fontSize: 14,
                          //             color:
                          //             AppColors.primaryColor.withOpacity(0.7)),
                          //       ),
                          //     ),
                          //     const SizedBox(
                          //       height: 12,
                          //     ),
                          //     Row(
                          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         Pinput(
                          //           controller: signUpCubit.pinPut,
                          //           defaultPinTheme: PinTheme(
                          //               width: 40,
                          //               height: 40,
                          //               decoration: BoxDecoration(
                          //                   borderRadius: BorderRadius.circular(5),
                          //                   border: Border.all(
                          //                       color: AppColors.blackColor
                          //                           .withOpacity(0.3),
                          //                       width: 2))),
                          //           errorPinTheme: PinTheme(
                          //               width: 40,
                          //               height: 40,
                          //               decoration: BoxDecoration(
                          //                   borderRadius: BorderRadius.circular(5),
                          //                   border: Border.all(
                          //                     color: AppColors.redColor,
                          //                     width: 2,
                          //                   ))),
                          //           focusedPinTheme: PinTheme(
                          //               width: 40,
                          //               height: 40,
                          //               decoration: BoxDecoration(
                          //                   borderRadius: BorderRadius.circular(5),
                          //                   border: Border.all(
                          //                     color: AppColors.primaryColor,
                          //                     width: 2,
                          //                   ))),
                          //           onCompleted: (pin) => print(pin),
                          //           validator: (value) {
                          //             if (value == null || value.isEmpty) {
                          //               return 'Otp is Required';
                          //             }
                          //             return null;
                          //           },
                          //         ),
                          //         const Text(
                          //           "Resend",
                          //           style: TextStyle(
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 16,
                          //             color: AppColors.blueColor,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //     SizedBox(
                          //       height: 20,
                          //     ),
                          //     CommonTextField(
                          //       maxLength: 6,
                          //       controller: signUpCubit.pinCode,
                          //       hintText: "Pincode",
                          //       needValidation: true,
                          //       validationMessage: "Pincode Name",
                          //     ),
                          //     SizedBox(
                          //       height: 16,
                          //     ),
                          //     BlocBuilder<SignupCubit, SignupState>(
                          //         builder: (cubit, state) {
                          //           return CommonTextField(
                          //             needValidation: true,
                          //             maxLine: 1,
                          //             obscureText: signUpCubit.passwordShow,
                          //             textInputType: TextInputType.visiblePassword,
                          //             suffixIcon: GestureDetector(
                          //                 onTap: () {
                          //                   signUpCubit.toggleShow();
                          //                 },
                          //                 child: signUpCubit.passwordShow == true
                          //                     ? const Icon(
                          //                   Icons.visibility,
                          //                   color: AppColors.blackColor,
                          //                 )
                          //                     : const Icon(Icons.visibility_off,
                          //                     color: AppColors.blackColor)),
                          //             validationMessage: "Password",
                          //             isPasswordValidation: true,
                          //             controller: signUpCubit.password,
                          //             hintText: "Password",
                          //           );
                          //         }),
                          //   ],
                          // ):SizedBox(),

                          BlocBuilder<SignupCubit, SignupState>(
                              builder: (cubbit, state) {
                            return signUpCubit.otpSend == true
                                ? Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "You will receive OTP shortly.",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: AppColors.primaryColor
                                                  .withOpacity(0.7)),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Pinput(
                                            controller: signUpCubit.pinPut,
                                            defaultPinTheme: PinTheme(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                        color: AppColors
                                                            .blackColor
                                                            .withOpacity(0.3),
                                                        width: 2))),
                                            errorPinTheme: PinTheme(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                      color: AppColors.redColor,
                                                      width: 2,
                                                    ))),
                                            focusedPinTheme: PinTheme(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                      color: AppColors
                                                          .primaryColor,
                                                      width: 2,
                                                    ))),
                                            onCompleted: (pin) => print(pin),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Otp is Required';
                                              }
                                              return null;
                                            },
                                          ),
                                          const Text(
                                            "Resend",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: AppColors.blueColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      CommonTextField(
                                        maxLength: 6,
                                        controller: signUpCubit.pinCode,
                                        hintText: "Pincode",
                                        needValidation: true,
                                        validationMessage: "Pincode Name",
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      BlocBuilder<SignupCubit, SignupState>(
                                          builder: (cubit, state) {
                                        return CommonTextField(
                                          needValidation: true,
                                          maxLine: 1,
                                          obscureText: signUpCubit.passwordShow,
                                          textInputType:
                                              TextInputType.visiblePassword,
                                          suffixIcon: GestureDetector(
                                              onTap: () {
                                                signUpCubit.toggleShow();
                                              },
                                              child: signUpCubit.passwordShow ==
                                                      true
                                                  ? const Icon(
                                                      Icons.visibility,
                                                      color:
                                                          AppColors.blackColor,
                                                    )
                                                  : const Icon(
                                                      Icons.visibility_off,
                                                      color: AppColors
                                                          .blackColor)),
                                          validationMessage: "Password",
                                          isPasswordValidation: true,
                                          controller: signUpCubit.password,
                                          hintText: "Password",
                                        );
                                      }),
                                    ],
                                  )
                                : SizedBox();
                          }),
                          commonButton(
                              margin: EdgeInsets.only(top: 25, bottom: 16),
                              title: "Continue",
                              onTap: () {
                                if (signUpCubit.otpSend == true) {
                                  signUpCubit.signUp();
                                } else {
                                  signUpCubit.signUpOtp();
                                }
                              },
                              buttonWidth: MediaQuery.of(context).size.width),
                          Center(
                              child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => LoginView()));
                            },
                            child: Text(
                              "Back to Login",
                              style: AppTextStyle.regular500.copyWith(
                                  color: AppColors.primaryColor, fontSize: 16),
                            ),
                          )),
                          SizedBox(
                            height: 16,
                          ),
                          BlocListener<SignupCubit, SignupState>(
                            listener: (cubit, state) {
                              if (state is SignUpApiSuccess ||
                                  state is SignUpSuccess) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginView(),
                                    ),
                                    (route) => false);
                              } else if (state is SignUpApiError) {
                                showSnackbar(message: state.error);
                              } else if (state is SignUpApiMessage) {
                                signUpCubit.otpSend = true;
                                // showSnackbar(message: state.message);
                              } else if (state is SignUpChangeNumber) {
                                signUpCubit.otpSend = false;
                              }
                            },
                            child: SizedBox(),
                          ),
                        ],
                      ),
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
