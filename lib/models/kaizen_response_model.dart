
import 'dart:io';

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

class KaizenResultAreaModel {
  KaizenResultAreaModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  KaizenResultArea? data;

  factory KaizenResultAreaModel.fromJson(Map<String, dynamic> json) => KaizenResultAreaModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: KaizenResultArea.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class KaizenResultArea {
  KaizenResultArea({
    this.resultdata,
  });

  List<List<String>>? resultdata;

  factory KaizenResultArea.fromJson(Map<String, dynamic> json) => KaizenResultArea(
    resultdata: List<List<String>>.from(json["resultdata"].map((x) => List<String>.from(x.map((x) => x)))),
  );

  Map<String, dynamic> toJson() => {
    "resultdata": List<dynamic>.from(resultdata!.map((x) => List<dynamic>.from(x.map((x) => x)))),
  };
}

class KaizenAnalysisModel {
  KaizenAnalysisModel({
    this.statusCode,
    this.status,
    this.res,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  int? res;
  String? message;
  KaizenAnalysis? data;

  factory KaizenAnalysisModel.fromJson(Map<String, dynamic> json) => KaizenAnalysisModel(
    statusCode: json["statusCode"],
    status: json["status"],
    res: json["res"],
    message: json["message"],
    data: KaizenAnalysis.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "res": res,
    "message": message,
    "data": data?.toJson(),
  };
}

class KaizenAnalysis {
  KaizenAnalysis({
    this.kaizenId,
    this.why,
    this.answer,
    this.modifiedAt,
  });

  int? kaizenId;
  String? why;
  String? answer;
  DateTime? modifiedAt;

  factory KaizenAnalysis.fromJson(Map<String, dynamic> json) => KaizenAnalysis(
    kaizenId: json["kaizen_id"],
    why: json["why"],
    answer: json["answer"],
    modifiedAt: DateTime.parse(json["modified_at"]),
  );

  Map<String, dynamic> toJson() => {
    "kaizen_id": kaizenId,
    "why": why,
    "answer": answer,
    "modified_at": modifiedAt?.toIso8601String(),
  };
}


class AddKaizenModelRequest{
  String? soleId;
  String? pillarCategoryId;
  String? lossNoStep;
  String? departmentId;
  String? subDepartmentId;
  String? machineId;
  String? resultArea;
  String? kaizenTheme;
  String? kaizenIdea;
  String? presentProblem;
  String? countermeasure;
  String? benchMark;
  String? target;
  String? startDate;
  List<String>? teamMemberId;
  String? rootCause;
  String? remarks;
  String? finishStatus;
  String? manageUserId;
  String? editKaizenId;
  File? presentProblemImage;
  File? countermeasureImage;
}