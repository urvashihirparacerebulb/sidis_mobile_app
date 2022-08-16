class AbnormalityResponseModel {
  AbnormalityResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  AbnormalityLists? data;

  factory AbnormalityResponseModel.fromJson(Map<String, dynamic> json) => AbnormalityResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: AbnormalityLists.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class AbnormalityLists {
  AbnormalityLists({
    this.data,
  });

  List<Abnormality>? data;

  factory AbnormalityLists.fromJson(Map<String, dynamic> json) => AbnormalityLists(
    data: List<Abnormality>.from(json["data"].map((x) => Abnormality.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Abnormality {
  Abnormality({
    this.abnormalityId,
    this.requestNo,
    this.companyShortName,
    this.bussinessName,
    this.plantShortName,
    this.departmentName,
    this.machineDetail,
    this.partsName,
    this.abnormalityTitle,
    this.createdAt,
    this.abnormalityStatus,
  });

  int? abnormalityId;
  String? requestNo;
  String? companyShortName;
  String? bussinessName;
  String? plantShortName;
  String? departmentName;
  String? machineDetail;
  String? partsName;
  String? abnormalityTitle;
  String? createdAt;
  int? abnormalityStatus;

  factory Abnormality.fromJson(Map<String, dynamic> json) => Abnormality(
    abnormalityId: json["abnormality_id"],
    requestNo: json["request_no"],
    companyShortName: json["company_short_name"],
    bussinessName: json["bussiness_name"],
    plantShortName: json["plant_short_name"],
    departmentName: json["department_name"],
    machineDetail: json["machine_detail"],
    partsName: json["parts_name"],
    abnormalityTitle: json["abnormality_title"],
    createdAt: json["created_at"],
    abnormalityStatus: json["abnormality_status"],
  );

  Map<String, dynamic> toJson() => {
    "abnormality_id": abnormalityId,
    "request_no": requestNo,
    "company_short_name": companyShortName,
    "bussiness_name": bussinessName,
    "plant_short_name": plantShortName,
    "department_name": departmentName,
    "machine_detail": machineDetail,
    "parts_name": partsName,
    "abnormality_title": abnormalityTitle,
    "created_at": createdAt,
    "abnormality_status": abnormalityStatus,
  };
}
