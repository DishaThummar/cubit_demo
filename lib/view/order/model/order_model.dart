// To parse this JSON data, do
//

import 'dart:convert';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  String? statusCode;
  String? statusMessage;
  DateTime? datetime;
  Data? data;

  OrderModel({
    this.statusCode,
    this.statusMessage,
    this.datetime,
    this.data,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        statusCode: json["status_code"],
        statusMessage: json["status_message"],
        datetime:
            json["datetime"] == null ? null : DateTime.parse(json["datetime"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status_message": statusMessage,
        "datetime": datetime?.toIso8601String(),
        "data": data?.toJson(),
      };
}

class Data {
  List<Result>? results;
  int? rpp;
  int? currentPage;

  Data({
    this.results,
    this.rpp,
    this.currentPage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        results: json["results"] == null
            ? []
            : List<Result>.from(
                json["results"]!.map((x) => Result.fromJson(x))),
        rpp: json["rpp"],
        currentPage: json["current_page"],
      );

  Map<String, dynamic> toJson() => {
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
        "rpp": rpp,
        "current_page": currentPage,
      };
}

class Result {
  String? id;
  BillNo? billNo;
  String? orderNumber;
  DateTime? orderDeliveryDatetime;
  DeliveryType? deliveryType;
  OrderStatus? orderStatus;
  DateTime? createdDate;
  int? amount;
  int? deliveryId;
  OrderMode? orderMode;
  OrderStatusDisplayText? orderStatusDisplayText;
  OrderStatus? orderStatusDisplay;

  Result({
    this.id,
    this.billNo,
    this.orderNumber,
    this.orderDeliveryDatetime,
    this.deliveryType,
    this.orderStatus,
    this.createdDate,
    this.amount,
    this.deliveryId,
    this.orderMode,
    this.orderStatusDisplayText,
    this.orderStatusDisplay,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        billNo: billNoValues.map[json["bill_no"]]!,
        orderNumber: json["order_number"],
        orderDeliveryDatetime: json["order_delivery_datetime"] == null
            ? null
            : DateTime.parse(json["order_delivery_datetime"]),
        deliveryType: deliveryTypeValues.map[json["delivery_type"]]!,
        orderStatus: orderStatusValues.map[json["order_status"]]!,
        createdDate: json["created_date"] == null
            ? null
            : DateTime.parse(json["created_date"]),
        amount: json["amount"],
        deliveryId: json["delivery_id"],
        orderMode: orderModeValues.map[json["order_mode"]]!,
        orderStatusDisplayText: orderStatusDisplayTextValues
            .map[json["order_status_display_text"]]!,
        orderStatusDisplay:
            orderStatusValues.map[json["order_status_display"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bill_no": billNoValues.reverse[billNo],
        "order_number": orderNumber,
        "order_delivery_datetime": orderDeliveryDatetime?.toIso8601String(),
        "delivery_type": deliveryTypeValues.reverse[deliveryType],
        "order_status": orderStatusValues.reverse[orderStatus],
        "created_date": createdDate?.toIso8601String(),
        "amount": amount,
        "delivery_id": deliveryId,
        "order_mode": orderModeValues.reverse[orderMode],
        "order_status_display_text":
            orderStatusDisplayTextValues.reverse[orderStatusDisplayText],
        "order_status_display": orderStatusValues.reverse[orderStatusDisplay],
      };
}

enum BillNo { EMPTY, THE_20232427, THE_20232429 }

final billNoValues = EnumValues({
  "": BillNo.EMPTY,
  "2023-24/27": BillNo.THE_20232427,
  "2023-24/29": BillNo.THE_20232429
});

enum DeliveryType { DELIVERY }

final deliveryTypeValues = EnumValues({"delivery": DeliveryType.DELIVERY});

enum OrderMode { OFFLINE, ONLINE }

final orderModeValues =
    EnumValues({"offline": OrderMode.OFFLINE, "online": OrderMode.ONLINE});

enum OrderStatus { COMPLETED, PENDING }

final orderStatusValues = EnumValues(
    {"Completed": OrderStatus.COMPLETED, "Pending": OrderStatus.PENDING});

enum OrderStatusDisplayText {
  ASSIGNED_TO_PHARMACY,
  COMPLETED,
  OUT_FOR_DELIVERY
}

final orderStatusDisplayTextValues = EnumValues({
  "Assigned to Pharmacy": OrderStatusDisplayText.ASSIGNED_TO_PHARMACY,
  "Completed": OrderStatusDisplayText.COMPLETED,
  "Out for Delivery": OrderStatusDisplayText.OUT_FOR_DELIVERY
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
