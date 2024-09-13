// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  String? statusCode;
  String? statusMessage;
  DateTime? datetime;
  Data? data;

  SearchModel({
    this.statusCode,
    this.statusMessage,
    this.datetime,
    this.data,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    statusCode: json["status_code"],
    statusMessage: json["status_message"],
    datetime: json["datetime"] == null ? null : DateTime.parse(json["datetime"]),
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
  String? title;
  String? type;
  List<SearchData>? data;

  Data({
    this.title,
    this.type,
    this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    title: json["title"],
    type: json["type"],
    data: json["data"] == null ? [] : List<SearchData>.from(json["data"]!.map((x) => SearchData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "type": type,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SearchData {
  String? dosageType;
  AcceptOnlineOrder? availableForPatient;
  int? cessPercentage;
  RequestedByEntity? requestedByEntity;
  String? content;
  int? gstPercentage;
  String? hsnCode;
  String? image;
  String? manufacturerName;
  String? medicineId;
  String? medicineName;
  MedicineType? medicineType;
  double? mrp;
  String? packingSize;
  double? price;
  dynamic saltContentId;
  ScheduleType? scheduleType;
  int? size;
  String? slug;
  int? popularityCount;
  Discontinued? discontinued;
  AcceptOnlineOrder? acceptOnlineOrder;
  int? inventoryId;
  int? discountPercentage;
  int quantity;
  String? thumbImage;
  int? isRxRequired;
  bool isInCart;
  SearchData({
    this.dosageType,
    this.availableForPatient,
    this.isInCart = false,
    this.cessPercentage,
    this.requestedByEntity,
    this.content,
    this.gstPercentage,
    this.hsnCode,
    this.image,
    this.manufacturerName,
    this.medicineId,
    this.medicineName,
    this.medicineType,
    this.mrp,
    this.packingSize,
    this.price,
    this.saltContentId,
    this.scheduleType,
    this.size,
    this.slug,
    this.popularityCount,
    this.discontinued,
    this.acceptOnlineOrder,
    this.inventoryId,
    this.discountPercentage,
    this.quantity=1,
    this.thumbImage,
    this.isRxRequired,
  });

  factory SearchData.fromJson(Map<String, dynamic> json) => SearchData(
    dosageType: json["dosage_type"],
    availableForPatient: acceptOnlineOrderValues.map[json["available_for_patient"]]!,
    cessPercentage: json["cess_percentage"],
    requestedByEntity: requestedByEntityValues.map[json["requested_by_entity"]]!,
    content: json["content"],
    gstPercentage: json["gst_percentage"],
    hsnCode: json["hsn_code"],
    image: json["image"],
    isInCart: json['isInCart'] ?? false,
    manufacturerName: json["manufacturer_name"],
    medicineId: json["medicine_id"],
    medicineName: json["medicine_name"],
    medicineType: medicineTypeValues.map[json["medicine_type"]]!,
    mrp: json["mrp"]?.toDouble(),
    packingSize: json["packing_size"],
    price: json["price"]?.toDouble(),
    saltContentId: json["salt_content_id"],
    scheduleType: scheduleTypeValues.map[json["schedule_type"]]!,
    size: json["size"],
    slug: json["slug"],
    popularityCount: json["popularity_count"],
    discontinued: discontinuedValues.map[json["discontinued"]]!,
    acceptOnlineOrder: acceptOnlineOrderValues.map[json["accept_online_order"]]!,
    inventoryId: json["inventory_id"],
    discountPercentage: json["discount_percentage"],
    quantity: json["quantity"],
    thumbImage: json["thumb_image"],
    isRxRequired: json["is_rx_required"],
  );

  Map<String, dynamic> toJson() => {
    "dosage_type": dosageType,
    "available_for_patient": acceptOnlineOrderValues.reverse[availableForPatient],
    "cess_percentage": cessPercentage,
    "requested_by_entity": requestedByEntityValues.reverse[requestedByEntity],
    "content": content,
    "gst_percentage": gstPercentage,
    "hsn_code": hsnCode,
    "image": image,
    'isInCart': isInCart,
    "manufacturer_name": manufacturerName,
    "medicine_id": medicineId,
    "medicine_name": medicineName,
    "medicine_type": medicineTypeValues.reverse[medicineType],
    "mrp": mrp,
    "packing_size": packingSize,
    "price": price,
    "salt_content_id": saltContentId,
    "schedule_type": scheduleTypeValues.reverse[scheduleType],
    "size": size,
    "slug": slug,
    "popularity_count": popularityCount,
    "discontinued": discontinuedValues.reverse[discontinued],
    "accept_online_order": acceptOnlineOrderValues.reverse[acceptOnlineOrder],
    "inventory_id": inventoryId,
    "discount_percentage": discountPercentage,
    "quantity": quantity,
    "thumb_image": thumbImage,
    "is_rx_required": isRxRequired,
  };
}

enum AcceptOnlineOrder {
  YES
}

final acceptOnlineOrderValues = EnumValues({
  "yes": AcceptOnlineOrder.YES
});

enum Discontinued {
  NO
}

final discontinuedValues = EnumValues({
  "no": Discontinued.NO
});

enum MedicineType {
  DRUG,
  OTC
}

final medicineTypeValues = EnumValues({
  "drug": MedicineType.DRUG,
  "otc": MedicineType.OTC
});

enum RequestedByEntity {
  CHEMIST,
  DISTRIBUTOR
}

final requestedByEntityValues = EnumValues({
  "chemist": RequestedByEntity.CHEMIST,
  "distributor": RequestedByEntity.DISTRIBUTOR
});

enum ScheduleType {
  EMPTY,
  H
}

final scheduleTypeValues = EnumValues({
  "": ScheduleType.EMPTY,
  "H": ScheduleType.H
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
