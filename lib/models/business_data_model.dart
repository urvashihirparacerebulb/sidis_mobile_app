
class BusinessDataResponse {
  BusinessDataResponse({
    this.bussinessData,
  });

  List<BusinessData>? bussinessData;

  factory BusinessDataResponse.fromJson(Map<String, dynamic> json) => BusinessDataResponse(
    bussinessData: List<BusinessData>.from(json["bussiness_data"].map((x) => BusinessData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "bussiness_data": bussinessData == null ? [] : List<dynamic>.from(bussinessData!.map((x) => x.toJson())),
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
