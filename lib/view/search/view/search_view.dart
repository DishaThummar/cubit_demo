import 'dart:io';
import 'package:shimmer/shimmer.dart';
import 'package:e_vital/configs/app_colors.dart';
import 'package:e_vital/configs/app_text_style.dart';
import 'package:e_vital/view/add_to_cart/logic/addtocard_cubit.dart';
import 'package:e_vital/view/add_to_cart/view/add_to_cart.dart';
import 'package:e_vital/view/search/logic/search_cubit.dart';
import 'package:e_vital/widgest/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        // create: (cubit) => SearchCubit(),
        providers: [
          BlocProvider<SearchCubit>(
            create: (context) => SearchCubit(),
          ),
          BlocProvider<AddToCartCubit>(
            create: (context) => AddToCartCubit(),
          ),
        ],
        child: Builder(builder: (context) {
          var searchCubit = BlocProvider.of<SearchCubit>(context);

          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 30),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildStatus(context, searchCubit),
                  ],
                ),
              ),
            ),
            bottomSheet: bottomCard(context),
          );
        }));
  }

  bottomCard(BuildContext context) {
    return Card(
      color: AppColors.whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Container(
        // height: 30,
        padding: const EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width,
        // color: AppColors.primaryColor,
        child: Row(
          children: [
            Text(
              "Items in your card",
              style: AppTextStyle.regular500
                  .copyWith(color: AppColors.primaryColor),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddToCartScreen(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "GO TO CART",
                  style: AppTextStyle.regular500
                      .copyWith(color: AppColors.whiteColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  dialogBox({BuildContext? context}) {
    showDialog(
        context: context!,
        builder: (_) {
          return Center(
            child: Material(
              color: AppColors.blackColor.withOpacity(0.2),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(8)),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.close,
                                color: AppColors.blackColor,
                                size: 20,
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Center(
                        child: Text(
                          "Choose your profile",
                          style: AppTextStyle.regular600.copyWith(fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: GestureDetector(
                            onTap: () {
                              context.read<SearchCubit>().pickImage(
                                  source: ImageSource.camera, context: context);
                            },
                            child: Card(
                              child: Container(
                                height: 120,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppColors.blackColor.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Center(
                                        child: Icon(
                                      Icons.camera_alt_outlined,
                                      color: AppColors.whiteColor,
                                    )),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Take from Camera",
                                      style: AppTextStyle.regular400.copyWith(
                                        fontSize: 14,
                                        color: AppColors.whiteColor,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                              child: GestureDetector(
                            onTap: () {
                              context.read<SearchCubit>().pickImage(
                                  source: ImageSource.gallery,
                                  context: context);
                            },
                            child: Card(
                              child: Container(
                                height: 120,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppColors.blackColor.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Center(
                                        child: Icon(
                                      Icons.photo_camera_back,
                                      color: AppColors.whiteColor,
                                    )),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Take from Gallery",
                                      style: AppTextStyle.regular400.copyWith(
                                        fontSize: 14,
                                        color: AppColors.whiteColor,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  buildStatus(BuildContext context, SearchCubit searchCubit) {
    return BlocBuilder<SearchCubit, SearchState>(builder: (cubit, state) {
      SearchCubit cubit = BlocProvider.of<SearchCubit>(context);
      if (searchCubit.status == false) {
        return medicineSearchStatusFalse(searchCubit, context);
      } else {
        SearchCubit cubit = BlocProvider.of<SearchCubit>(context);
        return medicineSearchStatusTrue(searchCubit, context, cubit);
      }
    });
  }

  medicineSearchStatusTrue(
      SearchCubit searchCubit, BuildContext context, SearchCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonTextField(
          controller: searchCubit.search,
          hintText: "Search for medicines (3+ Characters)",
          fillColor: AppColors.primaryColor.withOpacity(0.1),
          prefixIcon: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_rounded)),
          onTap: () {
            print("7890-098767890-");
          },
          suffixIcon: GestureDetector(
            onTap: () {
              cubit.falseStatus();
              cubit.search.clear();
            },
            child: const Icon(
              Icons.close,
              color: AppColors.primaryColor,
            ),
          ),
          onChange: (value) {
            context.read<SearchCubit>().statusFn(value);
          },
        ),
        BlocBuilder<SearchCubit, SearchState>(
          builder: (context, searchState) {
            final searchCubit = BlocProvider.of<SearchCubit>(context);

            return searchCubit.searchData.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: searchCubit.searchData.length,
                    itemBuilder: (context, index) {
                      final item = searchCubit.searchData[index];
                      return Container(
                        margin: const EdgeInsets.only(left: 16, right: 16),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Image.network(
                                    item.image ?? '',
                                    height: 30,
                                    width: 30,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, top: 8, bottom: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 250,
                                        child: Text(
                                          item.medicineName ??
                                              'Unknown Medicine',
                                          style: AppTextStyle.regular500
                                              .copyWith(fontSize: 18),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(item.packingSize ?? 'Unknown Size'),
                                      const SizedBox(height: 5),
                                      SizedBox(
                                        width: 200,
                                        child: Text(
                                          item.manufacturerName ??
                                              'Unknown Manufacturer',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      BlocBuilder<AddToCartCubit,
                                          AddToCartState>(
                                        builder: (context, cartState) {
                                          final cartCubit =
                                              BlocProvider.of<AddToCartCubit>(
                                                  context);
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "₹ ${item.price ?? 'N/A'}",
                                                style: AppTextStyle.regular500
                                                    .copyWith(
                                                        color: AppColors
                                                            .primaryColor),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.25,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  if (item.isInCart == true) {
                                                    // Navigator.push(
                                                    //   context,
                                                    //   MaterialPageRoute(
                                                    //     builder: (_) =>
                                                    //         AddToCartScreen(),
                                                    //   ),
                                                    // );
                                                    cartCubit
                                                        .removeFromCart(item);
                                                  } else {
                                                    cartCubit.addToCart(item);
                                                  }
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                      color: AppColors
                                                          .blackColor
                                                          .withOpacity(0.5),
                                                    ),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        item.isInCart == true
                                                            ? Icons
                                                                .add_shopping_cart_outlined
                                                            : Icons.add,
                                                        size: 18,
                                                      ),
                                                      SizedBox(width: 4),
                                                      Text(item.isInCart
                                                          ? "Added Cart"
                                                          : "Add Cart"),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                          ],
                        ),
                      );
                    },
                  )
                : const Center(child: Text("No Data Found!"));
          },
        )
      ],
    );
  }

  medicineSearchStatusFalse(SearchCubit searchCubit, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonTextField(
          controller: searchCubit.search,
          hintText: "Search for medicines (3+ Characters)",
          fillColor: AppColors.primaryColor.withOpacity(0.1),
          prefixIcon: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_rounded)),
          onTap: () {
            print("7890-098767890-");
          },
          suffixIcon: const Icon(
            Icons.document_scanner_outlined,
            color: AppColors.transparentColor,
          ),
          onChange: (value) {
            context.read<SearchCubit>().statusFn(value);
          },
        ),
        const SizedBox(
          height: 16,
        ),
        const Text("Recent Search"),
        BlocBuilder<SearchCubit, SearchState>(builder: (cubit, state) {
          SearchCubit cubit = BlocProvider.of<SearchCubit>(context);
          return SizedBox(
            height: 50,
            child: GridView.builder(
              itemCount: cubit.recentSearches.length,
              itemBuilder: (context, index) {
                print(cubit.recentSearches);
                return Container(
                  // color: Colors.green,
                  child: Text(
                    cubit.recentSearches[index],
                    style: AppTextStyle.regular500
                        .copyWith(fontSize: 16, color: AppColors.blackColor),
                  ),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisExtent: 30),
            ),
          );
        }),

        const SizedBox(
          height: 16,
        ),
        GestureDetector(
          onTap: () {
            print("=-0987890-=-987=-0989");
            dialogBox(context: context);
          },
          child: Card(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Quick Order",
                        style: AppTextStyle.regular500
                            .copyWith(color: AppColors.primaryColor),
                      ),
                      Text(
                        "Upload Prescription",
                        style: AppTextStyle.regular500
                            .copyWith(color: AppColors.blueColor, fontSize: 16),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.picture_as_pdf,
                    color: AppColors.primaryColor,
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, bottom: 8, top: 18),
          child: Text(
            "Explore Category",
            style: AppTextStyle.regular400.copyWith(fontSize: 16),
          ),
        ),
        // BlocBuilder<SearchCubit, SearchState>(builder: (cubit, state) {
        //   if (context.read<SearchCubit>().health.isNotEmpty)
        //   {
        //     return SizedBox(
        //       height: 90,
        //       child: ListView.builder(
        //         shrinkWrap: true,
        //         scrollDirection: Axis.horizontal,
        //         // physics: const NeverScrollableScrollPhysics(),
        //         itemCount: context.read<SearchCubit>().health.length,
        //         itemBuilder: (context, index) {
        //           final item = context.read<SearchCubit>().health[index];
        //           return Container(
        //             // color: AppColors.primaryColor,
        //             margin: const EdgeInsets.only(left: 5, right: 5),
        //             // width: 200,
        //             // height: 100,
        //             child: Image.network(
        //               item.image ?? '',
        //               fit: BoxFit.fill,
        //             ),
        //           );
        //         },
        //       ),
        //     );
        //   } else {
        //     const Text("No Data Found!");
        //   }
        //   return const SizedBox();
        // }),
        BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            if (context.read<SearchCubit>().isLoading==true) {
              return SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        width: 200,
                        height: 100,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              );
            }
            else
            {
              final items = context.read<SearchCubit>().health;
              if (items.isNotEmpty) {
                return SizedBox(
                  height: 90,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Container(
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        child: Image.network(
                          item.image ?? '',
                          fit: BoxFit.fill,
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const Center(child: Text("No Data Found!"));
              }
            }
          },
        ),

        ///images list
        BlocBuilder<SearchCubit, SearchState>(builder: (cubit, state) {
          SearchCubit cubit = BlocProvider.of<SearchCubit>(context);
          return SizedBox(
            height: 90,
            child: GridView.builder(
              itemCount: cubit.images.length,
              itemBuilder: (context, index) {
                return Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.file(cubit.images[index]),
                    GestureDetector(
                        onTap: () {
                          cubit.removeImage(index);
                        },
                        child: Icon(
                          Icons.close,
                          color: AppColors.whiteColor,
                        ))
                  ],
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, mainAxisExtent: 80),
            ),
          );
        }),
      ],
    );
  }
}
