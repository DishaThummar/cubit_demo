import 'package:e_vital/configs/app_colors.dart';
import 'package:e_vital/configs/app_text_style.dart';
import 'package:flutter/material.dart';

commonButton({
  String? title,
  IconData? icon,
  Function()? onTap,
  bool isExpand = false,
  double? buttonWidth,
  double? borderWidth,
  double? borderRadius,
  double? textSize,
  Color? backColor,
  Color? textColor,
  TextStyle? textStyle,
  Color? borderColor,
  // double? borderRadius,
  double? height,
  double? frontImageHeight,
  bool isFront = false,
  bool isShadow = false,
  Widget? iconWidget,
  EdgeInsets? buttonPadding,
  EdgeInsetsGeometry? margin,
  String? frontImage,
  Color? frontImageColor,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: margin,
      width: buttonWidth,
      padding: buttonPadding ??
          const EdgeInsets.only(top: 12, bottom: 12, right: 16, left: 16),
      decoration: BoxDecoration(
        color: backColor ?? AppColors.primaryColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        border: Border.all(color: borderColor ?? AppColors.whiteColor),
      ),
      child: Row(
        mainAxisSize: isExpand ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null && isFront)
            Image.asset(
              frontImage!,
              color: frontImageColor,
              height: frontImageHeight,
            ),
          if (icon != null && isFront)
            const SizedBox(
              width: 8,
            ),
          Flexible(
            child: Text(
              "$title",
              style: textStyle ??
                  AppTextStyle.regular500.copyWith(
                      fontSize: textSize ?? 16,
                      color: textColor ?? AppColors.whiteColor,
                      letterSpacing: 0.75),
            ),
          ),
        ],
      ),
    ),
  );
}
