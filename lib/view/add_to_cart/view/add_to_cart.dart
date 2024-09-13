import 'package:e_vital/configs/app_colors.dart';
import 'package:e_vital/configs/app_text_style.dart';
import 'package:e_vital/view/add_to_cart/logic/addtocard_cubit.dart';
import 'package:e_vital/view/home/logic/home_cubit.dart';
import 'package:e_vital/view/search/view/search_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddToCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddToCartCubit(),
      child: Builder(builder: (context) {
        var addToCubit = BlocProvider.of<AddToCartCubit>(context);
        return Scaffold(
          appBar: AppBar(
            // backgroundColor: AppColors.primaryColor,
            iconTheme: IconThemeData(color: AppColors.blackColor),
            title: Text(
              "Cart",
              style: AppTextStyle.regular500
                  .copyWith(color: AppColors.blackColor, fontSize: 20),
            ),
            actions: [
              BlocBuilder<AddToCartCubit, AddToCartState>(
                  builder: (cubit, state) {
                return GestureDetector(
                  onTap: () {
                    addToCubit.scanQR();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Icon(Icons.document_scanner_outlined),
                  ),
                );
              })
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                BlocBuilder<AddToCartCubit, AddToCartState>(
                  builder: (context, state) {
                    final cartItems =
                        context.read<AddToCartCubit>().getCartItems();
                    if (cartItems.isEmpty) {
                      return Center(
                          child: Column(
                            children: [
                              SizedBox(height: 32,),
                              Text("Your Cart is Empty"),
                              Text("Add some products to your cart before\nyou checkout",textAlign: TextAlign.center,),
                              GestureDetector(
                                                      onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => SearchView()));
                                                      },
                                                      child: Container(
                              margin: EdgeInsets.only(top: 8,bottom: 32),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Text("Add Medicine",style: AppTextStyle.regular600.copyWith(
                                fontSize: 16,
                                color: AppColors.whiteColor
                              ),),
                                                      ),
                                                    ),
                            ],
                          ));
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: cartItems.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final cartItem = cartItems[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.network(
                                    cartItem.image!,
                                    height: 40,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${cartItem.packingSize}',
                                            style: AppTextStyle.regular600
                                                .copyWith(fontSize: 16),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.25,
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete),
                                            onPressed: () {
                                              context
                                                  .read<AddToCartCubit>()
                                                  .removeFromCart(cartItem);
                                            },
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '${cartItem.manufacturerName}',
                                        style: AppTextStyle.regular400.copyWith(
                                            color: AppColors.blackColor),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '₹ ${cartItem.price}',
                                            style: AppTextStyle.regular500
                                                .copyWith(
                                                    color:
                                                        AppColors.primaryColor),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.43,
                                          ),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  context
                                                      .read<AddToCartCubit>()
                                                      .incrementQuantity(index);
                                                },
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      AppColors.primaryColor,
                                                  radius: 10,
                                                  child: Icon(Icons.add,
                                                      size: 15,
                                                      color:
                                                          AppColors.whiteColor),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                  cartItem.quantity.toString()),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  context
                                                      .read<AddToCartCubit>()
                                                      .decrementQuantity(index);
                                                },
                                                child: CircleAvatar(
                                                  radius: 10,
                                                  backgroundColor:
                                                      AppColors.primaryColor,
                                                  child: Icon(
                                                    Icons.remove,
                                                    size: 15,
                                                    color: AppColors.whiteColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                height: 30,
                                decoration: BoxDecoration(
                                    color:
                                        AppColors.primaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16)),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: AppColors.primaryColor,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                      "Save ₹ 2 with Substitutes",
                                      style: AppTextStyle.regular600.copyWith(
                                          color: AppColors.primaryColor),
                                    ),
                                    Spacer(),
                                    CircleAvatar(
                                      backgroundColor: AppColors.primaryColor,
                                      radius: 8,
                                      child: Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        size: 8,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Divider(),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
                Divider(),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        dialogBox(context: context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 16, top: 8),
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.primaryColor.withOpacity(0.1)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // SizedBox(
                            //   height: 16,
                            // ),
                            Icon(
                              Icons.camera_alt,
                              color: AppColors.primaryColor,
                              size: 30,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Center(
                                child: Text(
                              "Upload Prescription",
                              textAlign: TextAlign.center,
                              style: AppTextStyle.regular400.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: BlocBuilder<AddToCartCubit, AddToCartState>(
                            builder: (cubit, state) {
                          AddToCartCubit cubit =
                              BlocProvider.of<AddToCartCubit>(context);

                          return SizedBox(
                            height: 100,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: cubit.images.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  child: Stack(
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
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
                BlocBuilder<AddToCartCubit, AddToCartState>(
                  builder: (context, state) {
                    if (state is ScanLoading) {
                      return CircularProgressIndicator();
                    } else if (state is ScanSuccess) {
                      return Text('Scan Result: ${state.scan}');
                    } else {
                      return Text('');
                    }
                  },
                ),
              ],
            ),
          ),
        );
      }),
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
                              context.read<AddToCartCubit>().pickImage(
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
                              context.read<AddToCartCubit>().pickImage(
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
}
