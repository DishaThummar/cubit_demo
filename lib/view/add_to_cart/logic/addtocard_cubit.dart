import 'dart:convert';

import 'package:e_vital/utils/dio_http.dart';
import 'package:e_vital/view/home/model/dashboard_model.dart';
import 'package:e_vital/view/search/model/search_model.dart';
import 'package:e_vital/widgest/common_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'addtocart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  List<SearchData> cartItems = [];

  AddToCartCubit() : super(AddToCartInitial()) {
    _loadCartFromSharedPreferences();
  }

  List<SearchData> getCartItems() {
    return cartItems;
  }

  void addToCart(SearchData item) {
    cartItems.add(item);
    _saveCartToSharedPreferences();
    emit(AddToCartSuccess(dataList: cartItems));
    showSnackbar(message: "Item Added Successfully");
  }

  void removeFromCart(SearchData item) {
    cartItems.remove(item);
    _saveCartToSharedPreferences();
    emit(AddToCartSuccess(dataList: cartItems));
    showSnackbar(message: "Item Remove Successfully");
  }

  void incrementQuantity(int index) {
    if (index >= 0 && index < cartItems.length) {
      cartItems[index].quantity += 1;
      _saveCartToSharedPreferences();
      emit(AddToCartSuccess(dataList: cartItems));
    }
  }

  void decrementQuantity(int index) {
    if (index >= 0 &&
        index < cartItems.length &&
        cartItems[index].quantity > 1) {
      cartItems[index].quantity -= 1;
      _saveCartToSharedPreferences();
      emit(AddToCartSuccess(dataList: cartItems));
    }
  }

  Future<void> _saveCartToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonList =
        cartItems.map((item) => json.encode(item.toJson())).toList();
    await prefs.setStringList('cartItems', jsonList);
  }

  Future<void> _loadCartFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList('cartItems');
    if (jsonList != null) {
      cartItems = jsonList
          .map((item) => SearchData.fromJson(json.decode(item)))
          .toList();
      emit(
          AddToCartSuccess(dataList: cartItems));
    }
  }
}
