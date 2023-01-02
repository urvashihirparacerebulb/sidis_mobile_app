
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
    this.analysisId,
    this.why,
    this.answer,
    // this.modifiedAt,
  });

  int? kaizenId;
  int? analysisId;
  String? why;
  String? answer;
  // DateTime? modifiedAt;

  factory KaizenAnalysis.fromJson(Map<String, dynamic> json) => KaizenAnalysis(
    kaizenId: json["kaizen_id"],
    analysisId: json["analysis_id"],
    why: json["why"],
    answer: json["answer"],
    // modifiedAt: DateTime.parse(json["modified_at"]),
  );

  Map<String, dynamic> toJson() => {
    "kaizen_id": kaizenId,
    "analysis_id": analysisId,
    "why": why,
    "answer": answer,
    // "modified_at": modifiedAt?.toIso8601String(),
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
  String? teamMemberId;
  String? rootCause;
  String? remarks;
  String? finishStatus;
  String? manageUserId;
  String? editKaizenId;
  File? presentProblemImage;
  File? countermeasureImage;
}


class OtherBenifitsResponseModel {
  OtherBenifitsResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  OtherBenifitsResponse? data;

  factory OtherBenifitsResponseModel.fromJson(Map<String, dynamic> json) => OtherBenifitsResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: OtherBenifitsResponse.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class OtherBenifitsResponse {
  OtherBenifitsResponse({
    this.benifitsData,
  });

  List<BenifitsData>? benifitsData;

  factory OtherBenifitsResponse.fromJson(Map<String, dynamic> json) => OtherBenifitsResponse(
    benifitsData: List<BenifitsData>.from(json["benifits_data"].map((x) => BenifitsData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "benifits_data": benifitsData == null ? [] : List<dynamic>.from(benifitsData!.map((x) => x.toJson())),
  };
}

class BenifitsData {
  BenifitsData({
    this.otherBenifits,
    this.otherBenifitsId,
  });

  String? otherBenifits;
  int? otherBenifitsId;

  factory BenifitsData.fromJson(Map<String, dynamic> json) => BenifitsData(
    otherBenifits: json["other_benifits"],
    otherBenifitsId: json["other_benifits_id"],
  );

  Map<String, dynamic> toJson() => {
    "other_benifits": otherBenifits,
    "other_benifits_id": otherBenifitsId,
  };
}

class KaizenAnalysisResponse {
  KaizenAnalysisResponse({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  AllKaizenAnalysisModel? data;

  factory KaizenAnalysisResponse.fromJson(Map<String, dynamic> json) => KaizenAnalysisResponse(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: AllKaizenAnalysisModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class AllKaizenAnalysisModel {
  AllKaizenAnalysisModel({
    this.analysisData,
  });

  List<KaizenAnalysis>? analysisData;

  factory AllKaizenAnalysisModel.fromJson(Map<String, dynamic> json) => AllKaizenAnalysisModel(
    analysisData: List<KaizenAnalysis>.from(json["analysis_data"].map((x) => KaizenAnalysis.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "analysis_data": analysisData == null ? [] : List<dynamic>.from(analysisData!.map((x) => x.toJson())),
  };
}

class KaizenDetailResponse {
  KaizenDetailResponse({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  KaizenDetail? data;

  factory KaizenDetailResponse.fromJson(Map<String, dynamic> json) => KaizenDetailResponse(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: KaizenDetail.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class KaizenDetail {
  KaizenDetail({
    this.id,
    this.companyId,
    this.kaizenCategoryId,
    this.pillarCategoryId,
    this.pillarStep,
    this.bussinessId,
    this.plantId,
    this.machineId,
    this.departmentId,
    this.subdepartmentId,
    this.requestNo,
    this.kaizenName,
    this.theme,
    this.idea,
    this.presentProblem,
    this.countermeasure,
    this.presentProblemImage,
    this.countermeasureImage,
    this.benchMark,
    this.target,
    this.startDate,
    this.lossNoStep,
    this.resultArea,
    this.finishDate,
    this.rootCause,
    this.teamMemberId,
    this.remarks,
    this.finishStatus,
    this.textResult,
    this.resultin,
    this.tableResultColoum,
    this.tableResultRows,
    this.showResultTables,
    this.chartTitle,
    this.chartResultX,
    this.chartResultY,
    this.fromKaizenId,
    this.status,
    this.manageUserId,
    this.createdAt,
    this.modifiedAt,
    this.plantShortName,
    this.machineName,
    this.teamMembers,
    this.departmentName,
    this.pillarName,
  });

  int? id;
  int? companyId;
  int? kaizenCategoryId;
  int? pillarCategoryId;
  int? pillarStep;
  int? bussinessId;
  int? plantId;
  int? machineId;
  int? departmentId;
  int? subdepartmentId;
  String? requestNo;
  String? kaizenName;
  String? theme;
  String? idea;
  String? presentProblem;
  String? countermeasure;
  String? presentProblemImage;
  String? countermeasureImage;
  String? benchMark;
  String? target;
  String? startDate;
  String? lossNoStep;
  String? resultArea;
  String? finishDate;
  String? rootCause;
  String? teamMemberId;
  String? remarks;
  int? finishStatus;
  String? textResult;
  String? resultin;
  String? tableResultColoum;
  String? tableResultRows;
  String? showResultTables;
  String? chartTitle;
  String? chartResultX;
  String? chartResultY;
  String? fromKaizenId;
  int? status;
  int? manageUserId;
  DateTime? createdAt;
  DateTime? modifiedAt;
  String? plantShortName;
  String? machineName;
  String? teamMembers;
  String? departmentName;
  String? pillarName;

  factory KaizenDetail.fromJson(Map<String, dynamic> json) => KaizenDetail(
    id: json["id"],
    companyId: json["company_id"],
    kaizenCategoryId: json["kaizen_category_id"],
    pillarCategoryId: json["pillar_category_id"],
    pillarStep: json["pillar_step"],
    bussinessId: json["bussiness_id"],
    plantId: json["plant_id"],
    machineId: json["machine_id"],
    departmentId: json["department_id"],
    subdepartmentId: json["subdepartment_id"],
    requestNo: json["request_no"],
    kaizenName: json["kaizen_name"],
    theme: json["theme"],
    idea: json["idea"],
    presentProblem: json["present_problem"],
    countermeasure: json["countermeasure"],
    presentProblemImage: json["present_problem_image"],
    countermeasureImage: json["countermeasure_image"],
    benchMark: json["bench_mark"],
    target: json["target"],
    startDate:json["start_date"],
    lossNoStep: json["loss_no_step"],
    resultArea: json["result_area"],
    finishDate: json["finish_date"],
    rootCause: json["root_cause"],
    teamMemberId: json["team_member_id"],
    remarks: json["remarks"],
    finishStatus: json["finish_status"],
    textResult: json["text_result"],
    resultin: json["resultin"],
    tableResultColoum: json["table_result_coloum"],
    tableResultRows: json["table_result_rows"],
    showResultTables: json["show_result_tables"],
    chartTitle: json["chart_title"],
    chartResultX: json["chart_result_x"],
    chartResultY: json["chart_result_y"],
    fromKaizenId: json["from_kaizen_id"],
    status: json["status"],
    manageUserId: json["manage_user_id"],
    createdAt: DateTime.parse(json["created_at"]),
    modifiedAt: DateTime.parse(json["modified_at"]),
    plantShortName: json["plant_short_name"],
    machineName: json["machine_name"],
    teamMembers: json["team_members"],
    departmentName: json["department_name"],
    pillarName: json["pillar_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company_id": companyId,
    "kaizen_category_id": kaizenCategoryId,
    "pillar_category_id": pillarCategoryId,
    "pillar_step": pillarStep,
    "bussiness_id": bussinessId,
    "plant_id": plantId,
    "machine_id": machineId,
    "department_id": departmentId,
    "subdepartment_id": subdepartmentId,
    "request_no": requestNo,
    "kaizen_name": kaizenName,
    "theme": theme,
    "idea": idea,
    "present_problem": presentProblem,
    "countermeasure": countermeasure,
    "present_problem_image": presentProblemImage,
    "countermeasure_image": countermeasureImage,
    "bench_mark": benchMark,
    "target": target,
    "start_date": startDate,
    "loss_no_step": lossNoStep,
    "result_area": resultArea,
    "finish_date": finishDate,
    "root_cause": rootCause,
    "team_member_id": teamMemberId,
    "remarks": remarks,
    "finish_status": finishStatus,
    "text_result": textResult,
    "resultin": resultin,
    "table_result_coloum": tableResultColoum,
    "table_result_rows": tableResultRows,
    "show_result_tables": showResultTables,
    "chart_title": chartTitle,
    "chart_result_x": chartResultX,
    "chart_result_y": chartResultY,
    "from_kaizen_id": fromKaizenId,
    "status": status,
    "manage_user_id": manageUserId,
    "created_at": createdAt?.toIso8601String(),
    "modified_at": modifiedAt?.toIso8601String(),
    "plant_short_name": plantShortName,
    "machine_name": machineName,
    "team_members": teamMembers,
    "department_name": departmentName,
    "pillar_name": pillarName,
  };
}
