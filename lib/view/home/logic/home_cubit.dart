import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_vital/configs/api_config.dart';
import 'package:e_vital/utils/dio_http.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/search_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  TextEditingController search = TextEditingController();

  void searchApi(v) async {
    final apiClient = ApiClient();
    try {
      final data = {
        "searchstring": v,
        "show_sale_rate": "yes",
        "search_inventory_only": "no",
        "accept_in_stock_order": "no",
        "user_id": "",
        "patient_id": "",
        "device_id": "aea2bd5eeccda0d3",
        "accesstoken": "",
        "fcmtoken":
            "dNpnmTvpQqiyg3Q4NwIdxM:APA91bHlS4TH2RZtLRGXta2doLrZXh9XO14FhSPIBTkJYXyJYGZHwxbqlTwNQDvf8DW4aF6K4cIg5FaO7LDDNuGpL8ljnJX-cnZetF6KNBwKAV3sVMvJZeBzBIHnFbQh6tqI2TPkRzdu",
        "app_version": "22",
        "os": "android",
        "apikey": "EvhwWTfhTgP85FpnMMg6DGTYVGkqSG83"
      };

      final response = await apiClient.post(
          "https://api.evitalrx.in/v1/whitelabel/medicines/search",
          data: data);
      if (response.statusCode == 200) {
        final searchModel = SearchModel.fromJson(response.data);
        print(searchModel.data);
        print("7890-0987890 s${searchModel.data!.data}");
        if (searchModel.data != null) {
          print('Success: ${searchModel.statusMessage}');

          if (searchModel.data!.data != null) {
            // print('Data: ${searchModel.data!.data!.first.dosageType}');
            print("67890-098767890");
            emit(HomeSuccess(dataList: searchModel.data!.data!));
          }else{
            emit(HomeError(error: "${"No Data Found"}"));print("No Data Found!");
          }

        } else {
          emit(HomeError(error: "${searchModel.statusMessage}"));
        }
      } else {
        emit(HomeError(error: "${response.statusMessage}"));
      }
      print('Data: ${response.data}');
    } catch (e) {
      print('Error: $e');
      // print("No Data Found!");
      emit(HomeError(error: "${"No Data Found!"}"));
    }
  }
  final List<SearchData> cartItems = [];

  void addToCart(SearchData item) {
    cartItems.add(item);
    emit(AddSuccess( data: cartItems));
  }

  List<SearchData> getCartItems() {
    return cartItems;
  }
  void removeFromCart(SearchData item) {
    cartItems.remove(item);
    emit(HomeSuccess(dataList: cartItems));
  }
  void incrementQuantity(int index) {
    if (index >= 0 && index < cartItems.length) {
      cartItems[index].quantity += 1;
      emit(HomeSuccess(dataList: cartItems));
    }
  }

  void decrementQuantity(int index) {
    if (index >= 0 && index < cartItems.length && cartItems[index].quantity > 1) {
      cartItems[index].quantity -= 1;
      emit(HomeSuccess(dataList: cartItems));
    }
  }
}

