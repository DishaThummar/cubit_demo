// To parse this JSON data, do
//

import 'dart:convert';

SignUpModel otpModelFromJson(String str) => SignUpModel.fromJson(json.decode(str));

String otpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  String? statusCode;
  String? statusMessage;
  DateTime? datetime;
  // Data? data;

  SignUpModel({
    this.statusCode,
    this.statusMessage,
    this.datetime,
    // this.data,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
    statusCode: json["status_code"],
    statusMessage: json["status_message"],
    datetime: json["datetime"] == null ? null : DateTime.parse(json["datetime"]),
    // data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "status_message": statusMessage,
    "datetime": datetime?.toIso8601String(),
    // "data": data?.toJson(),
  };
}
