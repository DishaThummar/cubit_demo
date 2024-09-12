import 'package:e_vital/configs/app_colors.dart';
import 'package:e_vital/configs/app_text_style.dart';
import 'package:e_vital/view/add_to_cart/logic/addtocard_cubit.dart';
import 'package:e_vital/view/home/logic/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddToCartCubit(),
      child: Builder(builder: (context) {
        var addToCubit = BlocProvider.of<AddToCartCubit>(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            iconTheme: IconThemeData(color: AppColors.whiteColor),
            title: Text(
              "Cart",
              style: AppTextStyle.regular500
                  .copyWith(color: AppColors.whiteColor, fontSize: 20),
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
              children: [
                BlocBuilder<AddToCartCubit, AddToCartState>(
                  builder: (context, state) {
                    final cartItems =
                    context.read<AddToCartCubit>().getCartItems();
                    if (cartItems.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text("Your cart is empty"),
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: cartItems.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final cartItem = cartItems[index];
                        return Column(
                          children: [
                            ListTile(
                              leading: Image.network(cartItem.image!,
                                  height: 30, width: 30),
                              title: Text(cartItem.medicineName!),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${cartItem.packingSize} '),
                                  Text('${cartItem.manufacturerName} '),
                                  Text('₹${cartItem.price} '),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () {
                                          context
                                              .read<AddToCartCubit>()
                                              .incrementQuantity(index);
                                        },
                                      ),
                                      Text(cartItem.quantity.toString()),
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () {
                                          context
                                              .read<AddToCartCubit>()
                                              .decrementQuantity(index);
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              trailing: Column(
                                children: [
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
                            ),
                            Divider(),
                          ],
                        );
                      },
                    );
                  },
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
}
