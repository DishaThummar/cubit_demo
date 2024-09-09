import 'package:e_vital/configs/app_colors.dart';
import 'package:e_vital/configs/app_text_style.dart';
import 'package:e_vital/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextField extends StatelessWidget {
  final String? title;
  final String? hintText;
  final String? validationMessage;
  final bool needValidation;
  final bool isEmailValidation;
  final double? topPadding;
  final double? bottomPadding;
  final TextEditingController? controller;
  final bool isPhoneValidation;
  final bool isPasswordValidation;
  final TextInputType? textInputType;
  final int? maxLine;
  final int? maxLength;
  final int? minLine;
  final Widget? widgest;
  final bool readOnly;
  final String? labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final bool isTransparentColorBorder;
  final bool isSmallTitle;
  final Color? fillColor;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String?)? onChange;
  final Function()? onTap;

  const CommonTextField({
    Key? key,
    this.title,
    this.needValidation = false,
    this.isEmailValidation = false,
    this.hintText,
    this.validationMessage,
    this.topPadding,
    this.bottomPadding,
    this.labelText,
    this.controller,
    this.isPhoneValidation = false,
    this.textInputType,
    this.inputFormatters,
    this.maxLine,
    this.maxLength,
    this.isTransparentColorBorder = false,
    this.suffixIcon,
    this.widgest,
    this.isSmallTitle = false,
    this.obscureText = false,
    this.prefixIcon,
    this.fillColor,
    this.validator,
    this.isPasswordValidation = false,
    this.onChange,
    this.onTap,
    this.readOnly = false,
    this.minLine,
    Future<DateTime?> Function(dynamic context, dynamic currentValue)?
        onShowPicker,
    String? Function(dynamic v)? validation,
    TextCapitalization? textCapitalization,
    bool? autocorrect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: topPadding ?? 0),
      if (title != null)
        Text('$title',
            textAlign: TextAlign.start,
            style: isSmallTitle
                ? TextStyle(fontSize: 10, color: AppColors.whiteColor)
                : TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 15,
                    fontFamily: "SF Pro Display",
                    fontWeight: FontWeight.w500,
                  )),
      if (title != null) SizedBox(height: 20),
      TextFormField(
        onTap: onTap,
        textInputAction: TextInputAction.done,
        readOnly: readOnly,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLength: maxLength,
        maxLines: maxLine,
        // maxLines: maxLine ?? 1,
        onChanged: onChange,
        minLines: minLine,

        cursorColor: AppColors.primaryColor,
        style: const TextStyle(color: AppColors.blackColor),
        controller: controller,
        obscureText: obscureText,
        inputFormatters: inputFormatters ?? [],

        // autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: textInputType ?? TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          isDense: true,
          hintText: hintText ?? "",
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          counterText: '',
          labelText: labelText,
          labelStyle: AppTextStyle.regular500.copyWith(
            color: AppColors.primaryColor
          ),
          fillColor: fillColor ?? AppColors.transparentColor,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          suffix: widgest,
          hintStyle: AppTextStyle.regular400
              .copyWith(color: AppColors.primaryColor, fontSize: 16),
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
                color: AppColors.blackColor.withOpacity(0.5), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
                color: AppColors.blackColor.withOpacity(0.5), width: 1),
          ),
        ),
        validator: needValidation
            ? (validator ??
                (v) {
                  return TextFieldValidation.validation(
                      message: validationMessage ?? hintText,
                      value: v,
                      isPasswordValidator: isPasswordValidation,
                      isPhone: isPhoneValidation,
                      isEmailValidator: isEmailValidation);
                })
            : null,
      ),
    ]);
  }
}
