// To parse this JSON data, do
//
//     final dashBoardModel = dashBoardModelFromJson(jsonString);

import 'dart:convert';

DashBoardModel dashBoardModelFromJson(String str) => DashBoardModel.fromJson(json.decode(str));

String dashBoardModelToJson(DashBoardModel data) => json.encode(data.toJson());

class DashBoardModel {
  String? statusCode;
  String? statusMessage;
  DateTime? datetime;
  Data? data;

  DashBoardModel({
    this.statusCode,
    this.statusMessage,
    this.datetime,
    this.data,
  });

  factory DashBoardModel.fromJson(Map<String, dynamic> json) => DashBoardModel(
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
  List<dynamic>? offerResults;
  List<HealthCareCategory>? healthCareCategories;
  List<dynamic>? orderReviews;
  bool? trackFlag;
  bool? loyaltyFlag;
  List<dynamic>? membershipDetails;
  List<dynamic>? chemistMemberships;
  String? searchPharmacyPlaceholder;
  int? chemistCount;
  List<dynamic>? chemistDashboardImages;
  bool? isPreferredChemist;

  Data({
    this.offerResults,
    this.healthCareCategories,
    this.orderReviews,
    this.trackFlag,
    this.loyaltyFlag,
    this.membershipDetails,
    this.chemistMemberships,
    this.searchPharmacyPlaceholder,
    this.chemistCount,
    this.chemistDashboardImages,
    this.isPreferredChemist,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    offerResults: json["offer_results"] == null ? [] : List<dynamic>.from(json["offer_results"]!.map((x) => x)),
    healthCareCategories: json["health_care_categories"] == null ? [] : List<HealthCareCategory>.from(json["health_care_categories"]!.map((x) => HealthCareCategory.fromJson(x))),
    orderReviews: json["order_reviews"] == null ? [] : List<dynamic>.from(json["order_reviews"]!.map((x) => x)),
    trackFlag: json["track_flag"],
    loyaltyFlag: json["loyalty_flag"],
    membershipDetails: json["membership_details"] == null ? [] : List<dynamic>.from(json["membership_details"]!.map((x) => x)),
    chemistMemberships: json["chemist_memberships"] == null ? [] : List<dynamic>.from(json["chemist_memberships"]!.map((x) => x)),
    searchPharmacyPlaceholder: json["search_pharmacy_placeholder"],
    chemistCount: json["chemist_count"],
    chemistDashboardImages: json["chemist_dashboard_images"] == null ? [] : List<dynamic>.from(json["chemist_dashboard_images"]!.map((x) => x)),
    isPreferredChemist: json["is_preferred_chemist"],
  );

  Map<String, dynamic> toJson() => {
    "offer_results": offerResults == null ? [] : List<dynamic>.from(offerResults!.map((x) => x)),
    "health_care_categories": healthCareCategories == null ? [] : List<dynamic>.from(healthCareCategories!.map((x) => x.toJson())),
    "order_reviews": orderReviews == null ? [] : List<dynamic>.from(orderReviews!.map((x) => x)),
    "track_flag": trackFlag,
    "loyalty_flag": loyaltyFlag,
    "membership_details": membershipDetails == null ? [] : List<dynamic>.from(membershipDetails!.map((x) => x)),
    "chemist_memberships": chemistMemberships == null ? [] : List<dynamic>.from(chemistMemberships!.map((x) => x)),
    "search_pharmacy_placeholder": searchPharmacyPlaceholder,
    "chemist_count": chemistCount,
    "chemist_dashboard_images": chemistDashboardImages == null ? [] : List<dynamic>.from(chemistDashboardImages!.map((x) => x)),
    "is_preferred_chemist": isPreferredChemist,
  };
}





class HealthCareCategory {
  String? image;
  String? searchKey;
  String? categoryId;

  HealthCareCategory({
    this.image,
    this.searchKey,
    this.categoryId,
  });

  factory HealthCareCategory.fromJson(Map<String, dynamic> json) => HealthCareCategory(
    image: json["image"],
    searchKey: json["search_key"],
    categoryId: json["category_id"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "search_key": searchKey,
    "category_id": categoryId,
  };
}

