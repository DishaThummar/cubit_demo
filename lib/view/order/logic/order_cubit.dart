import 'dart:convert';

import 'package:e_vital/configs/api_config.dart';
import 'package:e_vital/utils/dio_http.dart';
import 'package:e_vital/view/order/model/order_model.dart';
import 'package:e_vital/widgest/common_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_state.dart';
//
// class OrderCubit extends Cubit<OrderState> {
//   OrderCubit() : super(OrderInitial()) {
//     order();
//     emit(OrderLoading());
//   }
//
//   List<Result> orderList = [];
//   OrderModel orderModel = OrderModel();
//   List<String> member = [
//     "All",
//     "Raj",
//     "Abc",
//   ];
//   List<String> status = [
//     "All",
//     "Pending",
//     "Confirmed",
//     "Completed",
//     "Shipped",
//     "Ready for pickup",
//     "Cancelled"
//   ];
//   String memberSelect = "All";
//   String statusSelect = "All";
//
//   void order() async {
//     emit(OrderLoading());
//     final apiClient = ApiClient();
//     try {
//       final data = {
//         "user_id": "W0aOYGdy+bP0mmK7dysUBQ==",
//         "patient_id": "",
//         "device_id": "465d4664c7ea102f",
//         "accesstoken": "Ol9afMJ5vSAuMFz5",
//         "fcmtoken":
//             "cUzBqyx5SoiE25F5ew9rsr:APA91bFEDPYNjrQOWlXI4wkmXA_-SQP3YzhRATm-ADYrFJjwlbHycCFb6nhqKvQDyMzSidEKO9_APpegHuFTKQbOAGd-ByU7SnvttStoFJX3kfc_ozsBeYCf1H6qoqPA_3e-szEPqhKE",
//         "app_version": "12",
//         "os": "android",
//         "apikey": "32ratvKzvbA0dPwk7VT3v2bzJzgPFJdt",
//         "page": "1",
//         "order_status": "",
//         "order_number": "",
//         "bill_no": ""
//       };
//       final response = await apiClient.post(ApiConfig.order, data: data);
//       print(response.statusCode);
//       if (response.statusCode == 200) {
//         final orderModel = OrderModel.fromJson(response.data);
//         orderList = orderModel.data!.results!;
//
//         print(orderModel.statusCode);
//         if (orderModel.statusCode == "1") {
//           showSnackbar(message: "${orderModel.statusMessage}");
//           emit(OrderSuccess());
//           emit(OrderList(order: orderList));
//
//           emit(OrderLoading());
//         } else {
//           emit(OrderError(error: "${orderModel.statusMessage}"));
//         }
//       } else {
//         print("Error: ${response.statusMessage}");
//         emit(OrderError(error: "${response.statusMessage}"));
//       }
//     } catch (e) {
//       print('Error: $e');
//       emit(OrderError(error: "$e"));
//     }
//   }
// }
class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial()) {

    scrollController.addListener(() {
      // if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          loadOrder();
        }else{
        }
      // }
    });
  }
  final scrollController = ScrollController();

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          loadOrder();
        }
      }
    });
  }

  List<Result> orderList = [];
  List<Result> filteredOrderList = [];
  int page = 1;
  OrderModel orderModel = OrderModel();
  List<String> member = ["All", "Raj", "Abc"];
  List<String> status = [
    "All",
    "Pending",
    "CONFIRMED",
    "COMPLETED",
    "Shipped",
    "Ready for pickup",
    "Cancelled"
  ];
  String memberSelect = "All";
  String statusSelect = "All";
  String billNumberFilter = "";
  String orderNumberFilter = "";

  void loadOrder() {
    if (state is OrderLoading) return;

    final currentState = state;
    var oldOrder = <Result>[];

    if (currentState is OrderLoaded) {
      oldOrder = currentState.order;
    }

    // Emit the loading state with the existing order list (if any)
    emit(OrderLoading(order: oldOrder, isFirstFetch: page == 1));

    fetchOrders().then((newOrders) {

      if (state is OrderLoading) {
        final loadingState = state as OrderLoading;
        final order = loadingState.order;
        order!.addAll(newOrders);

        emit(OrderLoaded(order));
      }
    }).catchError((error) {
      emit(OrderError(error: "$error"));
    });
  }

  Future fetchOrders() async {
    final apiClient = ApiClient();
    try {
      final data = {
        "user_id": "W0aOYGdy+bP0mmK7dysUBQ==",
        "patient_id": "",
        "device_id": "465d4664c7ea102f",
        "accesstoken": "Ol9afMJ5vSAuMFz5",
        "fcmtoken":
            "cUzBqyx5SoiE25F5ew9rsr:APA91bFEDPYNjrQOWlXI4wkmXA_-SQP3YzhRATm-ADYrFJjwlbHycCFb6nhqKvQDyMzSidEKO9_APpegHuFTKQbOAGd-ByU7SnvttStoFJX3kfc_ozsBeYCf1H6qoqPA_3e-szEPqhKE",
        "app_version": "12",
        "os": "android",
        "apikey": "32ratvKzvbA0dPwk7VT3v2bzJzgPFJdt",
        "page": "1",
        "order_status": "",
        "order_number": "",
        "bill_no": ""
      };
      final response = await apiClient.post(ApiConfig.order, data: data);
      if (response.statusCode == 200) {
        final orderModel = OrderModel.fromJson(response.data);
        orderList = orderModel.data?.results ?? [];
        filteredOrderList = orderList;
        emit(OrderSuccess());
        emit(OrderList(order: filteredOrderList));
        page++;

      } else {
        emit(OrderError(error: "${response.statusMessage}"));
      }
    } catch (e) {
      emit(OrderError(error: "$e"));
    }
  }

  void applyFilters() {
    filteredOrderList = orderList.where((order) {
      final matchesBillNumber = billNumberFilter.isEmpty ||
          (order.billNo?.toString() ?? '').contains(billNumberFilter);
      final matchesOrderNumber = orderNumberFilter.isEmpty ||
          (order.orderNumber ?? '').contains(orderNumberFilter);
      final matchesMember = memberSelect == "All" ||
          (order.deliveryType?.toString() ?? '').contains(memberSelect);
      final matchesStatus = statusSelect == "All" ||
          (order.orderStatusDisplayText?.toString() ?? '')
              .contains(statusSelect);

      return matchesBillNumber &&
          matchesOrderNumber &&
          matchesMember &&
          matchesStatus;
    }).toList();

    emit(OrderList(order: filteredOrderList));
  }

  void resetFilters() {
    billNumberFilter = "";
    orderNumberFilter = "";
    memberSelect = "All";
    statusSelect = "All";
    fetchOrders();
  }
}
// class OrderCubit extends Cubit<OrderState> {
//   OrderCubit() : super(OrderInitial()) {
//     fetchOrders();
//     scrollController.addListener(() {
//       if (scrollController.position.pixels ==
//           scrollController.position.maxScrollExtent) {
//         if (hasMore && !isLoading) {
//           fetchOrders(loadMore: true);
//         }
//       } else {
//         isLoading = false;
//         hasMore = false;
//       }
//     });
//   }
//
//   List<Result> orderList = [];
//   List<Result> filteredOrderList = [];
//   OrderModel orderModel = OrderModel();
//   List<String> member = ["All", "Raj", "Abc"];
//   List<String> status = [
//     "All",
//     "Pending",
//     "CONFIRMED",
//     "COMPLETED",
//     "Shipped",
//     "Ready for pickup",
//     "Cancelled"
//   ];
//   String memberSelect = "All";
//   String statusSelect = "All";
//   String billNumberFilter = "";
//   String orderNumberFilter = "";
//   int page = 1;
//   bool hasMore = true;
//   bool isLoading = false;
//
//   void fetchOrders({bool loadMore = false}) async {
//     if (isLoading) return;
//     isLoading = true;
//
//     emit(OrderLoading());
//     final apiClient = ApiClient();
//     try {
//       final data = {
//         "user_id": "W0aOYGdy+bP0mmK7dysUBQ==",
//         "patient_id": "",
//         "device_id": "465d4664c7ea102f",
//         "accesstoken": "Ol9afMJ5vSAuMFz5",
//         "fcmtoken":
//             "cUzBqyx5SoiE25F5ew9rsr:APA91bFEDPYNjrQOWlXI4wkmXA_-SQP3YzhRATm-ADYrFJjwlbHycCFb6nhqKvQDyMzSidEKO9_APpegHuFTKQbOAGd-ByU7SnvttStoFJX3kfc_ozsBeYCf1H6qoqPA_3e-szEPqhKE",
//         "app_version": "12",
//         "os": "android",
//         "apikey": "32ratvKzvbA0dPwk7VT3v2bzJzgPFJdt",
//         "page": page.toString(),
//         "order_status": "",
//         "order_number": "",
//         "bill_no": ""
//       };
//       final response = await apiClient.post(ApiConfig.order, data: data);
//       if (response.statusCode == 200) {
//         final orderModel = OrderModel.fromJson(response.data);
//         if (orderModel.data?.results?.isNotEmpty ?? false) {
//           if (loadMore) {
//             orderList.addAll(orderModel.data?.results ?? []);
//           } else {
//             orderList = orderModel.data?.results ?? [];
//           }
//           filteredOrderList = orderList;
//           emit(OrderSuccess());
//           emit(OrderList(order: filteredOrderList));
//           page++;
//           hasMore = orderModel.data?.results?.length ==
//               10; // Ensure this is a boolean expression
//         } else {
//           hasMore = false;
//         }
//       } else {
//         emit(OrderError(error: "${response.statusMessage}"));
//       }
//     } catch (e) {
//       emit(OrderError(error: "$e"));
//     } finally {
//       isLoading = false;
//     }
//   }
//
//   final ScrollController scrollController = ScrollController();
//
//   void applyFilters() {
//     filteredOrderList = orderList.where((order) {
//       final matchesBillNumber = billNumberFilter.isEmpty ||
//           (order.billNo?.toString() ?? '').contains(billNumberFilter);
//       final matchesOrderNumber = orderNumberFilter.isEmpty ||
//           (order.orderNumber ?? '').contains(orderNumberFilter);
//       final matchesMember = memberSelect == "All" ||
//           (order.deliveryType?.toString() ?? '').contains(memberSelect);
//       final matchesStatus = statusSelect == "All" ||
//           (order.orderStatusDisplayText?.toString() ?? '')
//               .contains(statusSelect);
//
//       return matchesBillNumber &&
//           matchesOrderNumber &&
//           matchesMember &&
//           matchesStatus;
//     }).toList();
//
//     emit(OrderList(order: filteredOrderList));
//   }
//
//   void resetFilters() {
//     billNumberFilter = "";
//     orderNumberFilter = "";
//     memberSelect = "All";
//     statusSelect = "All";
//     page = 1;
//     hasMore = true;
//     orderList.clear();
//     fetchOrders();
//   }
// }
