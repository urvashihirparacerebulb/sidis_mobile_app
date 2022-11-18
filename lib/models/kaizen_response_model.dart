
class KaizenResponseModel {
  KaizenResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  KaizenListModel? data;

  factory KaizenResponseModel.fromJson(Map<String, dynamic> json) => KaizenResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: KaizenListModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class KaizenListModel {
  KaizenListModel({
    this.data,
  });

  List<KaizenList>? data;

  factory KaizenListModel.fromJson(Map<String, dynamic> json) => KaizenListModel(
    data: List<KaizenList>.from(json["data"].map((x) => KaizenList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class KaizenList {
  KaizenList({
    this.kaizenId,
    this.requestNo,
    this.pillarName,
    this.companyShortName,
    this.plantShortName,
    this.machineDetail,
    this.theme,
    this.finishStatus,
    this.createdAt,
  });

  int? kaizenId;
  String? requestNo;
  String? pillarName;
  String? companyShortName;
  String? plantShortName;
  String? machineDetail;
  String? theme;
  String? finishStatus;
  String? createdAt;

  factory KaizenList.fromJson(Map<String, dynamic> json) => KaizenList(
    kaizenId: json["kaizen_id"],
    requestNo: json["request_no"],
    pillarName: json["pillar_name"],
    companyShortName: json["company_short_name"],
    plantShortName: json["plant_short_name"],
    machineDetail: json["machine_detail"],
    theme: json["theme"],
    finishStatus: json["finish_status"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "kaizen_id": kaizenId,
    "request_no": requestNo,
    "pillar_name": pillarName,
    "company_short_name": companyShortName,
    "plant_short_name": plantShortName,
    "machine_detail": machineDetail,
    "theme": theme,
    "finish_status": finishStatus,
    "created_at": createdAt,
  };
}
