// To parse this JSON data, do

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? statusCode;
  String? statusMessage;
  DateTime? datetime;
  Data? data;

  LoginModel({
    this.statusCode,
    this.statusMessage,
    this.datetime,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
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
  String? id;
  String? mobile;
  String? patientId;
  String? password;
  String? status;
  String? isRegistered;
  int? balance;
  String? accesstoken;
  String? profilePicture;
  String? firstname;
  String? lastname;
  String? patientCode;
  int? userType;
  String? zipcode;

  Data({
    this.id,
    this.mobile,
    this.patientId,
    this.password,
    this.status,
    this.isRegistered,
    this.balance,
    this.accesstoken,
    this.profilePicture,
    this.firstname,
    this.lastname,
    this.patientCode,
    this.userType,
    this.zipcode,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    mobile: json["mobile"],
    patientId: json["patient_id"],
    password: json["password"],
    status: json["status"],
    isRegistered: json["is_registered"],
    balance: json["balance"],
    accesstoken: json["accesstoken"],
    profilePicture: json["profile_picture"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    patientCode: json["patient_code"],
    userType: json["user_type"],
    zipcode: json["zipcode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mobile": mobile,
    "patient_id": patientId,
    "password": password,
    "status": status,
    "is_registered": isRegistered,
    "balance": balance,
    "accesstoken": accesstoken,
    "profile_picture": profilePicture,
    "firstname": firstname,
    "lastname": lastname,
    "patient_code": patientCode,
    "user_type": userType,
    "zipcode": zipcode,
  };
}
