import 'dart:io';
import 'package:e_vital/view/search/model/search_model.dart';
import 'package:e_vital/widgest/common_snackbar.dart';
import 'package:e_vital/widgest/hive_initialize.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
part 'addtocart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  AddToCartCubit() : super(AddToCartInitial()) {
    initializeHive();
  }

  List<SearchData> cartItems = [];
  List<File> images = [];
  List<bool> addCart = [];

 ///===================================database===================================================

  Future<void> initializeHive() async {
    HiveDb.cartBox = Hive.box('cart');
    loadCartFromHive();
  }

  Future<void> saveCartToHive() async {
    List<Map<String, dynamic>> jsonList =
        cartItems.map((item) => item.toJson()).toList();
    await HiveDb.cartBox.put('cart', jsonList);
  }

  void loadCartFromHive() {
    List<dynamic>? jsonList = HiveDb.cartBox.get('cart') as List<dynamic>?;
    if (jsonList != null) {
      cartItems = jsonList
          .map((item) => SearchData.fromJson(Map<String, dynamic>.from(item)))
          .toList();
      emit(AddToCartSuccess(dataList: cartItems));
    }
  }

  ///===================================cart screen===================================
  List<SearchData> getCartItems() {
    return cartItems;
  }

  void addToCart(SearchData item) {
    final index = cartItems
        .indexWhere((cartItem) => cartItem.medicineId == item.medicineId);
    if (index != -1) {
      cartItems[index].isInCart = true;
    } else {
      item.isInCart = true;
      cartItems.add(item);
      emit(AddToCartSuccess(dataList: cartItems));
    }
    saveCartToHive();
    emit(AddToCartSuccess(dataList: cartItems));
    showSnackbar(message: "Item Added to Cart Successfully");
  }

  void removeFromCart(SearchData item) {
    final index = cartItems
        .indexWhere((cartItem) => cartItem.medicineId == item.medicineId);
    if (index != -1) {
      cartItems[index].isInCart = false;
      cartItems.removeAt(index);
      saveCartToHive();
      emit(AddToCartSuccess(dataList: cartItems));
      showSnackbar(message: "Item Removed Successfully");
    }
  }

  void incrementQuantity(int index) {
    if (index >= 0 && index < cartItems.length) {
      cartItems[index].quantity += 1;
      saveCartToHive();
      emit(AddToCartSuccess(dataList: cartItems));
    }
  }

  void decrementQuantity(int index) {
    if (index >= 0 &&
        index < cartItems.length &&
        cartItems[index].quantity > 1) {
      cartItems[index].quantity -= 1;
      saveCartToHive();
      emit(AddToCartSuccess(dataList: cartItems));
    }
  }

  ///===================================bar code========================================
  String scanBarcode = 'Unknown';

  Future<void> scanQR() async {
    emit(ScanLoading());
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      if (barcodeScanRes != '-1') {
        scanBarcode = barcodeScanRes;
        emit(ScanSuccess(scan: barcodeScanRes));
      } else {
        emit(AddToCartInitial());
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
      emit(AddToCartInitial());
    } catch (e) {
      emit(AddToCartInitial());
    }
  }

  ///===================================image======================================================================
  Future<void> requestPermission() async {
    const permission = Permission.camera;
    if (await permission.isDenied) {
      await permission.request();
    }
  }

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
}


///===================================shared_preferences database======================================================================

// import 'dart:convert';
// import 'dart:io';
// import 'package:e_vital/view/search/logic/search_cubit.dart';
// import 'package:e_vital/view/search/model/search_model.dart';
// import 'package:e_vital/widgest/common_snackbar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// part 'addtocart_state.dart';
//
// class AddToCartCubit extends Cubit<AddToCartState> {
//   List<SearchData> cartItems = [];
//
//   List<bool> addCart = [];
//
//   cartStatus(success) {
//     emit(CartSuccess(success: success));
//   }
//
//   AddToCartCubit() : super(AddToCartInitial()) {
//     _loadCartFromSharedPreferences();
//   }
//
//   List<SearchData> getCartItems() {
//     return cartItems;
//   }
//
//   List<File> images = [];
//
//   Future<void> requestPermission() async {
//     const permission = Permission.camera;
//
//     if (await permission.isDenied) {
//       await permission.request();
//     }
//   }
//
//   Future pickImage({source, context}) async {
//     requestPermission().then((v) async {
//       try {
//         final image = await ImagePicker().pickImage(source: source);
//         if (image == null) return;
//         final imageTemp = File(image.path);
//         images.add(imageTemp);
//         emit(ImageSuccess(images: images));
//         Navigator.pop(context);
//       } on PlatformException catch (e) {
//         print('Failed to pick image: $e');
//       }
//     });
//   }
//
//   removeImage(int index) {
//     images.removeAt(index);
//     emit(ImageSuccess(images: images));
//   }
//
//   void addToCart(SearchData item) {
//     final index = cartItems
//         .indexWhere((cartItem) => cartItem.medicineId == item.medicineId);
//     if (index != -1) {
//       cartItems[index].isInCart = true;
//     } else {
//       item.isInCart = true;
//       cartItems.add(item);
//     }
//     _saveCartToSharedPreferences();
//     emit(AddToCartSuccess(dataList: cartItems));
//     showSnackbar(message: "Item Added to Cart Successfully");
//   }
//
//   void removeFromCart(SearchData item) {
//     final index = cartItems
//         .indexWhere((cartItem) => cartItem.medicineId == item.medicineId);
//
//     if (index != -1) {
//       cartItems[index].isInCart = false;
//       cartItems.removeAt(index);
//       _saveCartToSharedPreferences();
//       emit(AddToCartSuccess(dataList: cartItems));
//       showSnackbar(message: "Item Removed Successfully");
//     }
//   }
//
//   void incrementQuantity(int index) {
//     if (index >= 0 && index < cartItems.length) {
//       cartItems[index].quantity += 1;
//       _saveCartToSharedPreferences();
//       emit(AddToCartSuccess(dataList: cartItems));
//     }
//   }
//
//   void decrementQuantity(int index) {
//     if (index >= 0 &&
//         index < cartItems.length &&
//         cartItems[index].quantity > 1) {
//       cartItems[index].quantity -= 1;
//       _saveCartToSharedPreferences();
//       emit(AddToCartSuccess(dataList: cartItems));
//     }
//   }
//
//   Future<void> _saveCartToSharedPreferences() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> jsonList =
//         cartItems.map((item) => json.encode(item.toJson())).toList();
//     await prefs.setStringList('cartItems', jsonList);
//   }
//
//   Future<void> _loadCartFromSharedPreferences() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String>? jsonList = prefs.getStringList('cartItems');
//     if (jsonList != null) {
//       cartItems = jsonList
//           .map((item) => SearchData.fromJson(json.decode(item)))
//           .toList();
//       emit(AddToCartSuccess(dataList: cartItems));
//     }
//   }
//
//   String scanBarcode = 'Unknown';
//
//   Future<void> scanQR() async {
//     emit(ScanLoading());
//     String barcodeScanRes;
//     try {
//       barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//           '#ff6666', 'Cancel', true, ScanMode.QR);
//       if (barcodeScanRes != '-1') {
//         scanBarcode = barcodeScanRes;
//         emit(ScanSuccess(scan: barcodeScanRes));
//       } else {
//         emit(AddToCartInitial());
//       }
//     } on PlatformException {
//       barcodeScanRes = 'Failed to get platform version.';
//       emit(AddToCartInitial());
//     } catch (e) {
//       emit(AddToCartInitial());
//     }
//   }
// }
