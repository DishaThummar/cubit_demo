// To parse this JSON data, do


import 'dart:convert';

OtpModel otpModelFromJson(String str) => OtpModel.fromJson(json.decode(str));

String otpModelToJson(OtpModel data) => json.encode(data.toJson());

class OtpModel {
  String? statusCode;
  String? statusMessage;
  DateTime? datetime;
  Data? data;

  OtpModel({
    this.statusCode,
    this.statusMessage,
    this.datetime,
    this.data,
  });

  factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
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
  String? mobile;
  ReferralData? referralData;

  Data({
    this.mobile,
    this.referralData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mobile: json["mobile"],
    referralData: json["referral_data"] == null ? null : ReferralData.fromJson(json["referral_data"]),
  );

  Map<String, dynamic> toJson() => {
    "mobile": mobile,
    "referral_data": referralData?.toJson(),
  };
}

class ReferralData {
  ReferralData();

  factory ReferralData.fromJson(Map<String, dynamic> json) => ReferralData(
  );

  Map<String, dynamic> toJson() => {
  };
}
