import 'package:e_vital/configs/app_colors.dart';
import 'package:e_vital/configs/app_text_style.dart';
import 'package:flutter/material.dart';

class CommonDropDown extends StatelessWidget {
  final String? title;
  final List<String>? itemList;
  final String? dropDownValue;
  final String? validationMessage;
  final String? hintText;
  final double? topPadding;
  final Color? fillColor;
  final bool isTransparentColor;
  final EdgeInsets? margin;
  final bool needValidation;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final Function(String?)? onChange;
  final List<String> disabledItems;
  final List<Map<String, dynamic>>? itemsWithIcons;
  final double? width; // Added width parameter

  const CommonDropDown({
    Key? key,
    this.title,
    this.itemList,
    this.dropDownValue,
    this.onChange,
    this.disabledItems = const [],
    this.validator,
    this.validationMessage,
    this.topPadding,
    this.hintText,
    this.fillColor,
    this.margin,
    this.onTap,
    this.isTransparentColor = false,
    this.needValidation = false,
    this.itemsWithIcons,
    this.width, // Optional width parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: topPadding ?? 0),
        if (title != null)
          Text(
            title!,
            style: AppTextStyle.regular400.copyWith(
              fontSize: 15
            )
          ),
        if (title != null) const SizedBox(height: 20),
        Center(
          child: Container(
            margin: margin,
            width: MediaQuery.of(context).size.width,
            child: DropdownButtonFormField<String>(
              onTap: onTap,
              decoration: InputDecoration(
                filled: true,
                // labelText: hintText,
                isDense: true,
                fillColor: fillColor ?? Colors.white,
                // hintText: hintText,
                labelStyle: TextStyle(
                    color: Colors.black.withOpacity(0.6), fontSize: 16),
                hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.6), fontSize: 12),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.1), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black.withOpacity(0.1)),
                  borderRadius: BorderRadius.circular(8),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              validator: needValidation
                  ? (v) {
                      if (v == null) {
                        return "$validationMessage is required!";
                      }
                      return null;
                    }
                  : null,
              value: dropDownValue,
              items: itemsWithIcons?.map((item) {
                    return DropdownMenuItem<String>(
                      value: item['value'],
                      enabled: !disabledItems.contains(item['value']),
                      child: Row(
                        children: [
                          Text(
                            item['text'],
                            style: TextStyle(
                                fontSize: 17,
                                color: AppColors.primaryColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  }).toList() ??
                  itemList!.map((selectedType) {
                    return DropdownMenuItem<String>(
                      value: selectedType,
                      enabled: !disabledItems.contains(selectedType),
                      child: Text(
                        selectedType,
                        style: TextStyle(
                            fontSize: 17, color: Colors.black.withOpacity(0.9)),
                      ),
                    );
                  }).toList(),
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down_sharp),
              onChanged: (Object? newValue) {
                onChange?.call(newValue as String?);
              },
            ),
          ),
        ),
      ],
    );
  }
}
