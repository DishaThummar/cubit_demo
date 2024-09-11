import 'package:e_vital/utils/dio_http.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../search/model/search_model.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  TextEditingController search = TextEditingController();

  void searchApi(String v) async {
    final apiClient = ApiClient();
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
    try {
      final response = await apiClient.post(
        "https://api.evitalrx.in/v1/whitelabel/medicines/search",
        data: data,
      );

      if (response.statusCode == 200) {
        final searchModel = SearchModel.fromJson(response.data);
        print('Response Data: ${response.data}');
        if (searchModel.data != null && searchModel.data!.data != null) {
          if (searchModel.data!.data!.isNotEmpty) {
            emit(HomeSuccess(dataList: searchModel.data!.data!));
          } else {
            emit(HomeError(error: "No Data Found!"));
          }
        } else {
          emit(HomeError(error: searchModel.statusMessage ?? "No Data Found!"));
        }
      } else {
        emit(HomeError(error: response.statusMessage ?? "Unknown error"));
      }
    } catch (e) {
      print('Error: $e');
      emit(HomeError(error: "No Data Found"));
    }
  }
}
