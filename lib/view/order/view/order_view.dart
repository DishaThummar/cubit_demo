import 'dart:async';

import 'package:e_vital/configs/app_colors.dart';
import 'package:e_vital/configs/app_text_style.dart';
import 'package:e_vital/view/login/view/login_view.dart';
import 'package:e_vital/view/order/logic/order_cubit.dart';
import 'package:e_vital/view/order/model/order_model.dart';
import 'package:e_vital/widgest/app_button.dart';
import 'package:e_vital/widgest/common_drop_down.dart';
import 'package:e_vital/widgest/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

// class OrderView extends StatelessWidget {
//   const OrderView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => OrderCubit(),
//       child: Builder(builder: (context) {
//         OrderCubit orderCubit = BlocProvider.of<OrderCubit>(context);
//
//         return Scaffold(
//             appBar: AppBar(
//               // centerTitle: true,
//               title: Text(
//                 "My Orders",
//                 style: AppTextStyle.regular400
//                     .copyWith(fontSize: 18, color: AppColors.whiteColor),
//               ),
//               backgroundColor: AppColors.primaryColor,
//               // leading: Padding(s
//               //   padding: const EdgeInsets.all(8.0),
//               //   child: GestureDetector(
//               //     onTap: () async {
//               //       final SharedPreferences prefs =
//               //           await SharedPreferences.getInstance();
//               //       prefs.clear();
//               //       Navigator.pushAndRemoveUntil(
//               //           context,
//               //           MaterialPageRoute(
//               //             builder: (context) => const LoginView(),
//               //           ),
//               //           (route) => false);
//               //     },
//               //     child: const Icon(
//               //       Icons.logout,
//               //       color: AppColors.whiteColor,
//               //     ),
//               //   ),
//               // ),
//               actions: [
//                 GestureDetector(
//                   onTap: () {
//                     showModalBottomSheet<void>(
//                       context: context,
//                       // shape: RoundedRectangleBorder(
//                       //     borderRadius: BorderRadius.circular()),
//                       builder: (BuildContext context) {
//                         return Container(
//                           // height: 200,
//                           width: MediaQuery.of(context).size.width,
//                           decoration: const BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.only(
//                                 topRight: Radius.circular(8),
//                                 topLeft: Radius.circular(8)),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(16),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               mainAxisSize: MainAxisSize.min,
//                               children: <Widget>[
//                                 const Text('Filters'),
//                                 const SizedBox(
//                                   height: 8,
//                                 ),
//                                 const Divider(),
//                                 const SizedBox(
//                                   height: 8,
//                                 ),
//                                 const CommonTextField(
//                                   hintText: "Bill Number",
//                                   labelText: "Bill Number",
//                                 ),
//                                 const SizedBox(
//                                   height: 16,
//                                 ),
//                                 const CommonTextField(
//                                   hintText: "Order Number",
//                                   labelText: "Order Number",
//                                 ),
//                                 BlocProvider(
//                                   create: (BuildContext context) =>
//                                       OrderCubit(),
//                                   child: BlocBuilder<OrderCubit, OrderState>(
//                                       builder: (cubit, state) {
//                                     return Column(
//                                       children: [
//                                         const SizedBox(
//                                           height: 16,
//                                         ),
//                                         CommonDropDown(
//                                           margin: const EdgeInsets.only(
//                                               left: 0, right: 0),
//                                           // topPadding: 20,
//                                           needValidation: true,
//                                           // validationMessage: "memberSelect",
//                                           hintText: "All",
//                                           itemList: orderCubit.member,
//                                           onChange: (value) {
//                                             orderCubit.memberSelect = value!;
//                                           },
//                                           dropDownValue:
//                                               orderCubit.memberSelect == ""
//                                                   ? null
//                                                   : orderCubit.memberSelect,
//                                           // title: "Damage Reason",
//                                         ),
//                                         const SizedBox(
//                                           height: 16,
//                                         ),
//                                         CommonDropDown(
//                                           margin: const EdgeInsets.only(
//                                               left: 0, right: 0),
//                                           // topPadding: 20,
//                                           needValidation: true,
//
//                                           // validationMessage: "memberSelect",
//                                           hintText: "All",
//                                           itemList: orderCubit.status,
//                                           onChange: (value) {
//                                             orderCubit.statusSelect = value!;
//                                           },
//                                           dropDownValue:
//                                               orderCubit.statusSelect == ""
//                                                   ? null
//                                                   : orderCubit.statusSelect,
//                                           // title: "Damage Reason",
//                                         ),
//                                         const SizedBox(
//                                           height: 32,
//                                         ),
//                                         Row(
//                                           children: [
//                                             Expanded(
//                                                 child: commonButton(
//                                                     title: "Reset",
//                                                     onTap: () {
//                                                       Navigator.pop(context);
//                                                     },
//                                                     borderRadius: 8)),
//                                             const SizedBox(
//                                               width: 8,
//                                             ),
//                                             Expanded(
//                                                 child: commonButton(
//                                                     onTap: () {
//                                                       Navigator.pop(context);
//                                                     },
//                                                     title: "Apply",
//                                                     borderRadius: 8)),
//                                           ],
//                                         ),
//                                         const SizedBox(
//                                           height: 8,
//                                         ),
//                                       ],
//                                     );
//                                   }),
//                                 )
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                   child: const Padding(
//                     padding: EdgeInsets.only(right: 8),
//                     child: Icon(
//                       Icons.list,
//                       color: AppColors.whiteColor,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             body: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   BlocBuilder<OrderCubit, OrderState>(
//                     builder: (context, state) {
//                       return orderCubit.orderList.isNotEmpty
//                           ? ListView.builder(
//                               shrinkWrap: true,
//                               physics: const NeverScrollableScrollPhysics(),
//                               padding: const EdgeInsets.only(top: 16),
//                               itemCount: orderCubit.orderList.length,
//                               itemBuilder: (_, index) {
//                                 final order = orderCubit.orderList[index];
//                                 return Container(
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       context.read<OrderCubit>().order();
//                                     },
//                                     child: Column(
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.only(
//                                               left: 16,
//                                               right: 16,
//                                               top: 8,
//                                               bottom: 8),
//                                           child: Row(
//                                             children: [
//                                               Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Text(
//                                                     "${order.billNo.toString().split(".").last == "EMPTY" ? "BillNO. --" : order.billNo}",
//                                                     style: AppTextStyle
//                                                         .regular500
//                                                         .copyWith(fontSize: 14),
//                                                   ),
//                                                   Row(
//                                                     children: [
//                                                       Text(
//                                                         DateFormat("dd MMM yyyy ")
//                                                                 .format(DateTime
//                                                                     .parse(order
//                                                                         .createdDate!
//                                                                         .toString())) ??
//                                                             '',
//                                                         style: AppTextStyle
//                                                             .regular400
//                                                             .copyWith(
//                                                                 fontSize: 13,
//                                                                 color: AppColors
//                                                                     .greyColor),
//                                                       ),
//                                                       Text(
//                                                         DateFormat.jm().format(
//                                                                 DateTime.parse(order
//                                                                     .createdDate!
//                                                                     .toString())) ??
//                                                             '',
//                                                         style: AppTextStyle
//                                                             .regular400
//                                                             .copyWith(
//                                                                 fontSize: 13,
//                                                                 color: AppColors
//                                                                     .greyColor),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   Text(
//                                                     "₹ ${order.amount}",
//                                                     style: AppTextStyle
//                                                         .regular600
//                                                         .copyWith(
//                                                             fontSize: 15,
//                                                             color: AppColors
//                                                                 .primaryColor),
//                                                   ),
//                                                 ],
//                                               ),
//                                               const Spacer(),
//                                               Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.end,
//                                                 children: [
//                                                   Container(
//                                                     padding:
//                                                         const EdgeInsets.all(5),
//                                                     decoration: BoxDecoration(
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(19),
//                                                         color: order.orderStatusDisplayText
//                                                                     .toString()
//                                                                     .split(".")
//                                                                     .last ==
//                                                                 "COMPLETED"
//                                                             ? AppColors.cyan
//                                                             : order.orderStatusDisplayText
//                                                                         .toString()
//                                                                         .split(
//                                                                             ".")
//                                                                         .last ==
//                                                                     "Rejected by Customer"
//                                                                 ? AppColors
//                                                                     .redColor
//                                                                 : order.orderStatusDisplayText
//                                                                             .toString()
//                                                                             .split(
//                                                                                 ".")
//                                                                             .last ==
//                                                                         "Order Confirmed"
//                                                                     ? AppColors
//                                                                         .primaryColor
//                                                                     : order.orderStatusDisplayText.toString().split(".").last ==
//                                                                             "Order Declined"
//                                                                         ? AppColors
//                                                                             .redColor
//                                                                         : order.orderStatusDisplayText.toString().split(".").last ==
//                                                                                 "ASSIGNED_TO_PHARMACY"
//                                                                             ? AppColors.purple.withOpacity(0.7)
//                                                                             : order.orderStatusDisplayText.toString().split(".").last == "Ready for pickup"
//                                                                                 ? AppColors.blueColor
//                                                                                 : order.orderStatusDisplayText.toString().split(".").last == "Order is Ready"
//                                                                                     ? AppColors.cyan
//                                                                                     : AppColors.orangeColor),
//                                                     child: Row(
//                                                       children: [
//                                                         Icon(
//                                                           order.orderStatusDisplayText
//                                                                       .toString()
//                                                                       .split(
//                                                                           ".")
//                                                                       .last ==
//                                                                   "COMPLETED"
//                                                               ? Icons.check
//                                                               : order.orderStatusDisplayText
//                                                                           .toString()
//                                                                           .split(
//                                                                               ".")
//                                                                           .last ==
//                                                                       "Rejected by Customer"
//                                                                   ? Icons.close
//                                                                   : order.orderStatusDisplayText
//                                                                               .toString()
//                                                                               .split(
//                                                                                   ".")
//                                                                               .last ==
//                                                                           "Order Confirmed"
//                                                                       ? Icons
//                                                                           .check
//                                                                       : order.orderStatusDisplayText.toString().split(".").last ==
//                                                                               "Order Declined"
//                                                                           ? Icons
//                                                                               .check
//                                                                           : order.orderStatusDisplayText.toString().split(".").last == "ASSIGNED_TO_PHARMACY"
//                                                                               ? Icons.timelapse_sharp
//                                                                               : order.orderStatusDisplayText.toString().split(".").last == "Ready for pickup"
//                                                                                   ? Icons.check
//                                                                                   : order.orderStatusDisplayText.toString().split(".").last == "Order is Ready"
//                                                                                       ? Icons.check
//                                                                                       : Icons.check,
//                                                           size: 11,
//                                                           color: AppColors
//                                                               .whiteColor,
//                                                         ),
//                                                         const SizedBox(
//                                                           width: 2,
//                                                         ),
//                                                         Text(
//                                                           order.orderStatusDisplayText
//                                                                   .toString()
//                                                                   .split(".")
//                                                                   .last ??
//                                                               '',
//                                                           style: AppTextStyle
//                                                               .regular500
//                                                               .copyWith(
//                                                             fontSize: 11,
//                                                             color: AppColors
//                                                                 .whiteColor,
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Text(
//                                                     order.orderNumber ?? '',
//                                                     style: AppTextStyle
//                                                         .regular500
//                                                         .copyWith(
//                                                       fontSize: 12,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         const Divider(),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             )
//                           : const SizedBox();
//                     },
//                   ),
//                   // BlocListener<OrderCubit, OrderState>(
//                   //   listener: (cubit, state) {
//                   //     if (state is OrderLoading) {
//                   //       orderCubit.order();
//                   //       // orderCubit.orderList.add(state.order!);
//                   //
//                   //       // print(":890-0989");
//                   //     }
//                   //   },
//                   //   child: SizedBox(),
//                   // ),
//                 ],
//               ),
//             ));
//       }),
//     );
//   }
// }

// class OrderView extends StatelessWidget {
//   const OrderView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => OrderCubit(),
//       child: Builder(builder: (context) {
//         final orderCubit = BlocProvider.of<OrderCubit>(context);
//
//         return Scaffold(
//           appBar: AppBar(
//             title: Text(
//               "My Orders",
//               style: AppTextStyle.regular400
//                   .copyWith(fontSize: 18, color: AppColors.whiteColor),
//             ),
//             backgroundColor: AppColors.primaryColor,
//             actions: [
//               GestureDetector(
//                 onTap: () {
//                   showModalBottomSheet<void>(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return Container(
//                         width: MediaQuery.of(context).size.width,
//                         decoration: const BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.only(
//                               topRight: Radius.circular(8),
//                               topLeft: Radius.circular(8)),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(16),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisSize: MainAxisSize.min,
//                             children: <Widget>[
//                               const Text('Filters'),
//                               const SizedBox(height: 8),
//                               const Divider(),
//                               const SizedBox(height: 8),
//                               CommonTextField(
//                                 hintText: "Bill Number",
//                                 labelText: "Bill Number",
//                                 onChange: (value) {
//                                   orderCubit.billNumberFilter = value!;
//                                 },
//                               ),
//                               const SizedBox(height: 16),
//                               CommonTextField(
//                                 hintText: "Order Number",
//                                 labelText: "Order Number",
//
//                                 onChange: (value) {
//                                   orderCubit.orderNumberFilter = value!;
//                                 },
//                               ),
//                               const SizedBox(height: 16),
//                               CommonDropDown(
//                                 margin:
//                                     const EdgeInsets.only(left: 0, right: 0),
//                                 hintText: "All",
//                                 itemList: orderCubit.member,
//                                 onChange: (value) {
//                                   orderCubit.memberSelect = value!;
//                                 },
//                                 dropDownValue: orderCubit.memberSelect,
//                               ),
//                               const SizedBox(height: 16),
//                               CommonDropDown(
//                                 margin:
//                                     const EdgeInsets.only(left: 0, right: 0),
//                                 hintText: "All",
//                                 itemList: orderCubit.status,
//                                 onChange: (value) {
//                                   orderCubit.statusSelect = value!;
//                                 },
//                                 dropDownValue: orderCubit.statusSelect,
//                               ),
//                               const SizedBox(height: 32),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: commonButton(
//                                       title: "Reset",
//                                       onTap: () {
//                                         orderCubit.resetFilters();
//
//                                         Navigator.pop(context);
//                                       },
//                                       borderRadius: 8,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 8),
//                                   Expanded(
//                                     child: commonButton(
//                                       title: "Apply",
//                                       onTap: () {
//                                         orderCubit.applyFilters();
//                                         Navigator.pop(context);
//                                       },
//                                       borderRadius: 8,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 8),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//                 child: const Padding(
//                   padding: EdgeInsets.only(right: 8),
//                   child: Icon(
//                     Icons.list,
//                     color: AppColors.whiteColor,
//                   ),
//                 ),
//               )
//             ],
//           ),
//           body: SingleChildScrollView(
//             child: Column(
//               children: [
//                 BlocBuilder<OrderCubit, OrderState>(
//                   builder: (context, state) {
//                     if (state is OrderLoading) {
//                       return const Center(child: CircularProgressIndicator());
//                     } else if (state is OrderList) {
//                       return orderCubit.filteredOrderList.isNotEmpty
//                           ? ListView.builder(
//                               shrinkWrap: true,
//                               physics: const NeverScrollableScrollPhysics(),
//                               padding: const EdgeInsets.only(top: 16),
//                               itemCount: orderCubit.filteredOrderList.length,
//                               itemBuilder: (_, index) {
//                                 final order =
//                                     orderCubit.filteredOrderList[index];
//                                 return Container(
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       context.read<OrderCubit>().fetchOrders();
//                                     },
//                                     child: Column(
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.only(
//                                               left: 16,
//                                               right: 16,
//                                               top: 8,
//                                               bottom: 8),
//                                           child: Row(
//                                             children: [
//                                               Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Text(
//                                                     "${order.billNo.toString().split(".").last == "EMPTY" ? "BillNO. --" : order.billNo}",
//                                                     style: AppTextStyle
//                                                         .regular500
//                                                         .copyWith(fontSize: 14),
//                                                   ),
//                                                   Row(
//                                                     children: [
//                                                       Text(
//                                                         DateFormat("dd MMM yyyy ")
//                                                                 .format(DateTime
//                                                                     .parse(order
//                                                                         .createdDate!
//                                                                         .toString())) ??
//                                                             '',
//                                                         style: AppTextStyle
//                                                             .regular400
//                                                             .copyWith(
//                                                                 fontSize: 13,
//                                                                 color: AppColors
//                                                                     .greyColor),
//                                                       ),
//                                                       Text(
//                                                         DateFormat.jm().format(
//                                                                 DateTime.parse(order
//                                                                     .createdDate!
//                                                                     .toString())) ??
//                                                             '',
//                                                         style: AppTextStyle
//                                                             .regular400
//                                                             .copyWith(
//                                                                 fontSize: 13,
//                                                                 color: AppColors
//                                                                     .greyColor),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   Text(
//                                                     "₹ ${order.amount}",
//                                                     style: AppTextStyle
//                                                         .regular600
//                                                         .copyWith(
//                                                             fontSize: 15,
//                                                             color: AppColors
//                                                                 .primaryColor),
//                                                   ),
//                                                 ],
//                                               ),
//                                               const Spacer(),
//                                               Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.end,
//                                                 children: [
//                                                   Container(
//                                                     padding:
//                                                         const EdgeInsets.all(5),
//                                                     decoration: BoxDecoration(
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(19),
//                                                         color: order.orderStatusDisplayText
//                                                                     .toString()
//                                                                     .split(".")
//                                                                     .last ==
//                                                                 "COMPLETED"
//                                                             ? AppColors.cyan
//                                                             : order.orderStatusDisplayText
//                                                                         .toString()
//                                                                         .split(
//                                                                             ".")
//                                                                         .last ==
//                                                                     "Rejected by Customer"
//                                                                 ? AppColors
//                                                                     .redColor
//                                                                 : order.orderStatusDisplayText
//                                                                             .toString()
//                                                                             .split(
//                                                                                 ".")
//                                                                             .last ==
//                                                                         "Order Confirmed"
//                                                                     ? AppColors
//                                                                         .primaryColor
//                                                                     : order.orderStatusDisplayText.toString().split(".").last ==
//                                                                             "Order Declined"
//                                                                         ? AppColors
//                                                                             .redColor
//                                                                         : order.orderStatusDisplayText.toString().split(".").last ==
//                                                                                 "ASSIGNED_TO_PHARMACY"
//                                                                             ? AppColors.purple.withOpacity(0.7)
//                                                                             : order.orderStatusDisplayText.toString().split(".").last == "Ready for pickup"
//                                                                                 ? AppColors.blueColor
//                                                                                 : order.orderStatusDisplayText.toString().split(".").last == "Order is Ready"
//                                                                                     ? AppColors.cyan
//                                                                                     : AppColors.orangeColor),
//                                                     child: Row(
//                                                       children: [
//                                                         Icon(
//                                                           order.orderStatusDisplayText
//                                                                       .toString()
//                                                                       .split(
//                                                                           ".")
//                                                                       .last ==
//                                                                   "COMPLETED"
//                                                               ? Icons.check
//                                                               : order.orderStatusDisplayText
//                                                                           .toString()
//                                                                           .split(
//                                                                               ".")
//                                                                           .last ==
//                                                                       "Rejected by Customer"
//                                                                   ? Icons.close
//                                                                   : order.orderStatusDisplayText
//                                                                               .toString()
//                                                                               .split(
//                                                                                   ".")
//                                                                               .last ==
//                                                                           "Order Confirmed"
//                                                                       ? Icons
//                                                                           .check
//                                                                       : order.orderStatusDisplayText.toString().split(".").last ==
//                                                                               "Order Declined"
//                                                                           ? Icons
//                                                                               .check
//                                                                           : order.orderStatusDisplayText.toString().split(".").last == "ASSIGNED_TO_PHARMACY"
//                                                                               ? Icons.timelapse_sharp
//                                                                               : order.orderStatusDisplayText.toString().split(".").last == "Ready for pickup"
//                                                                                   ? Icons.check
//                                                                                   : order.orderStatusDisplayText.toString().split(".").last == "Order is Ready"
//                                                                                       ? Icons.check
//                                                                                       : Icons.check,
//                                                           size: 11,
//                                                           color: AppColors
//                                                               .whiteColor,
//                                                         ),
//                                                         const SizedBox(
//                                                             width: 5),
//                                                         Text(
//                                                           order.orderStatusDisplayText
//                                                                   .toString()
//                                                                   .split(".")
//                                                                   .last ??
//                                                               '',
//                                                           style: AppTextStyle
//                                                               .regular400
//                                                               .copyWith(
//                                                                   fontSize: 11,
//                                                                   color: AppColors
//                                                                       .whiteColor),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   const SizedBox(height: 10),
//                                                   Text(
//                                                     order.orderNumber ?? '',
//                                                     style: AppTextStyle
//                                                         .regular500
//                                                         .copyWith(
//                                                             fontSize: 13,
//                                                             color: AppColors
//                                                                 .blackColor),
//                                                   ),
//                                                 ],
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                         const Divider(thickness: 1),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             )
//                           : const Center(child: Text("No data found"));
//                     } else if (state is OrderError) {
//                       return Center(child: Text(state.error));
//                     } else {
//                       return const SizedBox();
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderCubit(),
      child: Builder(builder: (context) {
        final orderCubit = BlocProvider.of<OrderCubit>(context);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Your state update or fetch logic here
          BlocProvider.of<OrderCubit>(context).fetchOrders();
        });
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: AppColors.whiteColor
            ),
            title: Text(
              "My Orders",
              style: AppTextStyle.regular400
                  .copyWith(fontSize: 18, color: AppColors.whiteColor),
            ),
            backgroundColor: AppColors.primaryColor,
            actions: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              topLeft: Radius.circular(8)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Text('Filters'),
                              const SizedBox(height: 8),
                              const Divider(),
                              const SizedBox(height: 8),
                              CommonTextField(
                                hintText: "Bill Number",
                                labelText: "Bill Number",
                                onChange: (value) {
                                  orderCubit.billNumberFilter = value!;
                                },
                              ),
                              const SizedBox(height: 16),
                              CommonTextField(
                                hintText: "Order Number",
                                labelText: "Order Number",
                                onChange: (value) {
                                  orderCubit.orderNumberFilter = value!;
                                },
                              ),
                              const SizedBox(height: 16),
                              CommonDropDown(
                                margin:
                                    const EdgeInsets.only(left: 0, right: 0),
                                hintText: "All",
                                itemList: orderCubit.member,
                                onChange: (value) {
                                  orderCubit.memberSelect = value!;
                                },
                                dropDownValue: orderCubit.memberSelect,
                              ),
                              const SizedBox(height: 16),
                              CommonDropDown(
                                margin:
                                    const EdgeInsets.only(left: 0, right: 0),
                                hintText: "All",
                                itemList: orderCubit.status,
                                onChange: (value) {
                                  orderCubit.statusSelect = value!;
                                },
                                dropDownValue: orderCubit.statusSelect,
                              ),
                              const SizedBox(height: 32),
                              Row(
                                children: [
                                  Expanded(
                                    child: commonButton(
                                      title: "Reset",
                                      onTap: () {
                                        orderCubit.resetFilters();

                                        Navigator.pop(context);
                                      },
                                      borderRadius: 8,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: commonButton(
                                      title: "Apply",
                                      onTap: () {
                                        orderCubit.applyFilters();
                                        Navigator.pop(context);
                                      },
                                      borderRadius: 8,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.list,
                    color: AppColors.whiteColor,
                  ),
                ),
              )
            ],
          ),
          body: BlocBuilder<OrderCubit, OrderState>(
            builder: (context, state) {
              if (state is OrderLoading && state.isFirstFetch) {
                return Center(child: CircularProgressIndicator());
              }

              List<Result> orders = [];
              bool isLoading = false;

              if (state is OrderLoading) {
                orders = state.order ?? [];
                isLoading = true;
              } else if (state is OrderList) {
                orders = state.order ?? [];
              } else if (state is OrderError) {
                return Center(child: Text(state.error));
              } else {
                return const SizedBox();
              }
              return ListView.builder(
                controller: orderCubit.scrollController,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 16),
                itemCount: orders.length + (isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < orders.length) {
                    return orderWidgest(context, orders[index]);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              );
            },
          ),
        );
      }),
    );
  }

  orderWidgest(BuildContext context, var order) {
    return Container(
      child: GestureDetector(
        onTap: () {
          context.read<OrderCubit>().fetchOrders();
        },
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${order.billNo.toString().split(".").last == "EMPTY" ? "BillNO. --" : order.billNo}",
                        style: AppTextStyle.regular500.copyWith(fontSize: 14),
                      ),
                      Row(
                        children: [
                          Text(
                            DateFormat("dd MMM yyyy ").format(DateTime.parse(
                                    order.createdDate!.toString())) ??
                                '',
                            style: AppTextStyle.regular400.copyWith(
                                fontSize: 13, color: AppColors.greyColor),
                          ),
                          Text(
                            DateFormat.jm().format(DateTime.parse(
                                    order.createdDate!.toString())) ??
                                '',
                            style: AppTextStyle.regular400.copyWith(
                                fontSize: 13, color: AppColors.greyColor),
                          ),
                        ],
                      ),
                      Text(
                        "₹ ${order.amount}",
                        style: AppTextStyle.regular600.copyWith(
                            fontSize: 15, color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(19),
                            color: order.orderStatusDisplayText
                                        .toString()
                                        .split(".")
                                        .last ==
                                    "COMPLETED"
                                ? AppColors.cyan
                                : order.orderStatusDisplayText
                                            .toString()
                                            .split(".")
                                            .last ==
                                        "Rejected by Customer"
                                    ? AppColors.redColor
                                    : order.orderStatusDisplayText
                                                .toString()
                                                .split(".")
                                                .last ==
                                            "Order Confirmed"
                                        ? AppColors.primaryColor
                                        : order.orderStatusDisplayText
                                                    .toString()
                                                    .split(".")
                                                    .last ==
                                                "Order Declined"
                                            ? AppColors.redColor
                                            : order.orderStatusDisplayText
                                                        .toString()
                                                        .split(".")
                                                        .last ==
                                                    "ASSIGNED_TO_PHARMACY"
                                                ? AppColors.purple
                                                    .withOpacity(0.7)
                                                : order.orderStatusDisplayText
                                                            .toString()
                                                            .split(".")
                                                            .last ==
                                                        "Ready for pickup"
                                                    ? AppColors.blueColor
                                                    : order.orderStatusDisplayText
                                                                .toString()
                                                                .split(".")
                                                                .last ==
                                                            "Order is Ready"
                                                        ? AppColors.cyan
                                                        : AppColors
                                                            .orangeColor),
                        child: Row(
                          children: [
                            Icon(
                              order.orderStatusDisplayText
                                          .toString()
                                          .split(".")
                                          .last ==
                                      "COMPLETED"
                                  ? Icons.check
                                  : order.orderStatusDisplayText
                                              .toString()
                                              .split(".")
                                              .last ==
                                          "Rejected by Customer"
                                      ? Icons.close
                                      : order.orderStatusDisplayText
                                                  .toString()
                                                  .split(".")
                                                  .last ==
                                              "Order Confirmed"
                                          ? Icons.check
                                          : order.orderStatusDisplayText
                                                      .toString()
                                                      .split(".")
                                                      .last ==
                                                  "Order Declined"
                                              ? Icons.check
                                              : order.orderStatusDisplayText
                                                          .toString()
                                                          .split(".")
                                                          .last ==
                                                      "ASSIGNED_TO_PHARMACY"
                                                  ? Icons.timelapse_sharp
                                                  : order.orderStatusDisplayText
                                                              .toString()
                                                              .split(".")
                                                              .last ==
                                                          "Ready for pickup"
                                                      ? Icons.check
                                                      : order.orderStatusDisplayText
                                                                  .toString()
                                                                  .split(".")
                                                                  .last ==
                                                              "Order is Ready"
                                                          ? Icons.check
                                                          : Icons.check,
                              size: 11,
                              color: AppColors.whiteColor,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              order.orderStatusDisplayText
                                      .toString()
                                      .split(".")
                                      .last ??
                                  '',
                              style: AppTextStyle.regular400.copyWith(
                                  fontSize: 11, color: AppColors.whiteColor),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        order.orderNumber ?? '',
                        style: AppTextStyle.regular500.copyWith(
                            fontSize: 13, color: AppColors.blackColor),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Divider(thickness: 1),
          ],
        ),
      ),
    );
  }
}
