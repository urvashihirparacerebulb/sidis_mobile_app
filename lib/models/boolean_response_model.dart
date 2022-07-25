import 'dart:convert';

BooleanResponseModel welcomeFromJson(String str) =>
    BooleanResponseModel.fromJson(json.decode(str));

String welcomeToJson(BooleanResponseModel data) => json.encode(data.toJson());

class BooleanResponseModel {
  BooleanResponseModel({
    this.status,
    this.message,
  });

  bool? status;
  String? message;

  factory BooleanResponseModel.fromJson(Map<String, dynamic> json) =>
      BooleanResponseModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
