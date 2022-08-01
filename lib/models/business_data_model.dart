import 'dart:convert';

BusinessDataResponseModel welcomeFromJson(String str) => BusinessDataResponseModel.fromJson(json.decode(str));

String welcomeToJson(BusinessDataResponseModel data) => json.encode(data.toJson());

class BusinessDataResponseModel {
  BusinessDataResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  BusinessDataResponse? data;

  factory BusinessDataResponseModel.fromJson(Map<String, dynamic> json) => BusinessDataResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: BusinessDataResponse.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class BusinessDataResponse {
  BusinessDataResponse({
    this.data,
  });

  List<BusinessData>? data;

  factory BusinessDataResponse.fromJson(Map<String, dynamic> json) => BusinessDataResponse(
    data: List<BusinessData>.from(json["data"].map((x) => BusinessData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class BusinessData {
  BusinessData({
    this.businessId,
    this.businessName,
    this.contactPersonName,
    this.contactPersonEmail,
    this.contactPersonMobileno,
  });

  int? businessId;
  String? businessName;
  String? contactPersonName;
  String? contactPersonEmail;
  String? contactPersonMobileno;

  factory BusinessData.fromJson(Map<String, dynamic> json) => BusinessData(
    businessId: json["business_id"],
    businessName: json["business_name"],
    contactPersonName: json["contact_person_name"],
    contactPersonEmail: json["contact_person_email"],
    contactPersonMobileno: json["contact_person_mobileno"],
  );

  Map<String, dynamic> toJson() => {
    "business_id": businessId,
    "business_name": businessName,
    "contact_person_name": contactPersonName,
    "contact_person_email": contactPersonEmail,
    "contact_person_mobileno": contactPersonMobileno,
  };
}
