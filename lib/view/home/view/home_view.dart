import 'package:e_vital/configs/app_colors.dart';
import 'package:e_vital/configs/app_text_style.dart';
import 'package:e_vital/view/home/logic/home_cubit.dart';
import 'package:e_vital/view/order/order_screen.dart';
import 'package:e_vital/view/search/view/search_view.dart';
import 'package:e_vital/widgest/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: Builder(
        builder: (context) {
          var homeCubit = BlocProvider.of<HomeCubit>(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(left: 16, top: 30, right: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: AppColors.primaryColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "eVital",
                        style: AppTextStyle.regular500.copyWith(
                            fontSize: 30, color: AppColors.primaryColor),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>  OrderScreen()),
                          );
                        },
                        child: Text(
                          "My Order",
                          style: AppTextStyle.regular500.copyWith(
                              fontSize: 15, color: AppColors.blackColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CommonTextField(
                    controller: homeCubit.search,
                    hintText: "Search for medicines (3+ Characters)",
                    fillColor: AppColors.primaryColor.withOpacity(0.1),
                    prefixIcon: const Icon(Icons.search_rounded),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SearchView(),
                        ),
                      );
                    },
                    suffixIcon: const Icon(
                      Icons.document_scanner_outlined,
                      color: AppColors.transparentColor,
                    ),
                    onChange: (value) {
                      if (value!.isNotEmpty) {
                        homeCubit.searchApi(value);
                      } else {
                        print("087890-0987890");
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
