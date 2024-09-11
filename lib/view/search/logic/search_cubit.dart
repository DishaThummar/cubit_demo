import 'dart:io';

import 'package:e_vital/utils/dio_http.dart';
import 'package:e_vital/view/home/model/dashboard_model.dart';
import 'package:e_vital/view/search/model/search_model.dart';
import 'package:e_vital/widgest/common_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial()) {
    status = false;
    emit(SearchStatus(status: status));
    dashBoardApi();
  }

  TextEditingController search = TextEditingController();
  bool status = false;
  List<HealthCareCategory> health = [];
  List<SearchData> searchData = [];

  Future<void> requestPermission() async {
    const permission = Permission.camera;

    if (await permission.isDenied) {
      await permission.request();
    }
  }

  List<File> images = [];

  Future pickImage({source, context}) async {
    requestPermission().then((v) async {
      try {
        final image = await ImagePicker().pickImage(source: source);
        if (image == null) return;
        final imageTemp = File(image.path);
        images.add(imageTemp);
        emit(ImageSuccess(images: images));
        Navigator.pop(context);
      } on PlatformException catch (e) {
        print('Failed to pick image: $e');
      }
    });
  }

  removeImage(int index) {
    images.removeAt(index);
    emit(ImageSuccess(images: images));
  }

  falseStatus() {
    status = false;
    emit(SearchStatus(status: status));
  }

  statusFn(v) {
    status = true;
    emit(SearchStatus(status: status));
    if (v.length == 3) {
      searchApi(v);
    } else {
      status = false;
      emit(SearchStatus(status: status));
      dashBoardApi();
      showSnackbar(message: "Please enter 3 character");
    }
  }

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
            searchData.addAll(searchModel.data!.data!);
            emit(SearchSuccess(dataList: searchModel.data!.data!));
            print("status $status");
          } else {
            emit(SearchError(error: "No Data Found!"));
          }
        } else {
          emit(SearchError(
              error: searchModel.statusMessage ?? "No Data Found!"));
        }
      } else {
        emit(SearchError(error: response.statusMessage ?? "Unknown error"));
      }
    } catch (e) {
      print('Error: $e');
      emit(SearchError(error: "No Data Found"));
    }
  }

  void dashBoardApi() async {
    final apiClient = ApiClient();
    final data = {
      "user_id": "",
      "patient_id": "",
      "device_id": "",
      "accesstoken": "",
      "fcmtoken": "",
      "app_version": "1",
      "os": "android",
      "apikey": "EvhwWTfhTgP85FpnMMg6DGTYVGkqSG83"
    };

    try {
      final response = await apiClient.post(
        "https://api.evitalrx.in/v1/whitelabel/dashboard",
        data: data,
      );

      if (response.statusCode == 200) {
        print('7890-0987890  ${response.data}');
        final searchModel = DashBoardModel.fromJson(response.data);
        if (searchModel.data != null &&
            searchModel.data!.healthCareCategories != null) {
          if (searchModel.data!.healthCareCategories != null) {
            emit(
                CategorySuccess(data: searchModel.data!.healthCareCategories!));
            health.addAll(searchModel.data!.healthCareCategories!);
          } else {
            emit(CategorySuccess(data: "No Data Found"));
          }
        } else {
          emit(SearchError(
              error: searchModel.statusMessage ?? "No Data Found!"));
        }
      } else {
        emit(SearchError(error: response.statusMessage ?? "Unknown error"));
      }
    } catch (e) {
      print('Error: $e');
      emit(SearchError(error: "No Data Found"));
    }
  }
}
