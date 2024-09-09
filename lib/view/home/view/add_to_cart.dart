import 'package:e_vital/view/home/logic/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cartItems = homeCubit.getCartItems();

          if (cartItems.isEmpty) {
            return const Center(
              child: Text("Your cart is empty"),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final cartItem = cartItems[index];
              return ListTile(
                leading: Image.network(cartItem.image!, height: 30, width: 30),
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
                            homeCubit.incrementQuantity(index);
                          },
                        ),
                        Text(cartItem.quantity.toString()),
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            homeCubit.decrementQuantity(index);
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
                        homeCubit.removeFromCart(cartItem);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
