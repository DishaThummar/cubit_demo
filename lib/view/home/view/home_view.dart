import 'package:e_vital/configs/app_colors.dart';
import 'package:e_vital/configs/app_text_style.dart';
import 'package:e_vital/view/home/logic/home_cubit.dart';
import 'package:e_vital/view/home/view/add_to_cart.dart';
import 'package:e_vital/view/order/view/order_view.dart';
import 'package:e_vital/widgest/common_snackbar.dart';
import 'package:e_vital/widgest/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: Builder(builder: (context) {
        var homeCubit = BlocProvider.of<HomeCubit>(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(left: 16, top: 30, right: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Text("data"),
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: AppColors.primaryColor,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
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
                                  builder: (_) => const OrderView()));
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
                  BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
                    return CommonTextField(
                      controller: homeCubit.search,
                      hintText: "Search Item",
                      fillColor: AppColors.primaryColor.withOpacity(0.1),
                      prefixIcon: const Icon(Icons.search_rounded),
                      onTap: (){
                        // homeCubit.status();
                      },
                      onChange: (value) {
                        if (value!.isNotEmpty) {
                          homeCubit.searchApi(value);
                        } else {
                          print("087890-0987890");
                        }
                      },
                    );
                  }),

                  BlocListener<HomeCubit, HomeState>(
                    listener: (context, state) {
                      if (state is HomeSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Data Fetched Successfully")),
                        );
                      } else if (state is HomeError) {
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(content: Text(state.error)),
                        // );
                      }
                    },
                    child: BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        if (state is HomeSuccess) {
                          if (state.dataList.isEmpty) {
                            // No data found
                            return const Center(
                              child: Column(
                                children: [
                                  Spacer(),
                                  Text("No Data Found"),
                                  Spacer(),
                                ],
                              ),
                            );
                          } else {
                            // Data available, show in a ListView
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.dataList.length,
                              itemBuilder: (context, index) {
                                final item = state.dataList[index];
                                return Container(
                                  margin: EdgeInsets.only(left: 16, right: 16),
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 16),
                                            child: Image.network(
                                              item.image!,
                                              height: 30,
                                              width: 30,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 16,
                                                right: 16,
                                                top: 8,
                                                bottom: 8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 250,
                                                  child: Text(
                                                    item.medicineName!,
                                                    style: AppTextStyle
                                                        .regular500
                                                        .copyWith(
                                                      fontSize: 18,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  item.packingSize!,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    item.manufacturerName!,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "₹ ${item.price}",
                                                      style: AppTextStyle
                                                          .regular500
                                                          .copyWith(
                                                              color: AppColors
                                                                  .primaryColor),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.3,
                                                    ),
                                                    // Spacer(),
                                                    // Text("data")
                                                    GestureDetector(
                                                      onTap: (){
                                                        homeCubit.addToCart(item);
                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                          const SnackBar(content: Text("Item added to cart")),
                                                        );
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                            builder: (_) => BlocProvider.value(
                                                          value: BlocProvider.of<HomeCubit>(context),
                                                          child: AddToCartScreen(),
                                                        ),
                                                        ));
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(5),
                                                            border: Border.all(
                                                                color: AppColors
                                                                    .blackColor
                                                                    .withOpacity(
                                                                        0.5))),
                                                        height: 30,
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        child: Text("Add Cart"),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Divider(),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                        } else if (state is HomeError) {
                          return Center(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 250,
                                ),
                                Text(
                                  state.error,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          );
                        } else {
                          // Default view (loading or initial state)
                          return const Center(
                              child: Column(
                            children: [
                              SizedBox(
                                height: 250,
                              ),
                              Text("Please Search Item!"),
                            ],
                          ));
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
