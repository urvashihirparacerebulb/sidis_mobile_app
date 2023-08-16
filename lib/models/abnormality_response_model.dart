import 'package:my_projects/models/activities_response_model.dart';
import 'package:my_projects/models/department_response_model.dart';

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
    this.companyId,
    this.bussinessId,
    this.plantId,
    this.departmentId,
    this.subDepartmentId,
    this.requestNo,
    this.companyShortName,
    this.businessName,
    this.plantShortName,
    this.departmentName,
    this.subDepartmentName,
    this.machineDetail,
    this.partsName,
    this.abnormalityTitle,
    this.abnormalityType,
    this.abnormalityTag,
    this.findUserName,
    this.findUserId,
    this.assignUserData,
    this.assignId,
    this.assignUserId,
    this.completeData,
    this.createdAt,
    this.abnormalityStatus,
  });

  int? abnormalityId;
  int? companyId;
  int? bussinessId;
  int? plantId;
  int? departmentId;
  int? subDepartmentId;
  String? requestNo;
  String? companyShortName;
  String? businessName;
  String? plantShortName;
  String? departmentName;
  String? subDepartmentName;
  String? machineDetail;
  String? partsName;
  String? abnormalityTitle;
  String? abnormalityType;
  String? abnormalityTag;
  String? findUserName;
  int? findUserId;
  dynamic? assignId;
  String? assignUserData;
  String? assignUserId;
  String? completeData;
  String? createdAt;
  int? abnormalityStatus;

  factory Abnormality.fromJson(Map<String, dynamic> json) => Abnormality(
    abnormalityId: json["abnormality_id"],
    companyId: json["company_id"],
    bussinessId: json["bussiness_id"],
    plantId: json["plant_id"],
    departmentId: json["department_id"],
    subDepartmentId: json["subdepartment_id"],
    requestNo: json["request_no"],
    companyShortName: json["company_short_name"],
    businessName: json["bussiness_name"],
    plantShortName: json["plant_short_name"],
    departmentName: json["department_name"],
    subDepartmentName: json["sub_department_name"],
    machineDetail: json["machine_detail"],
    partsName: json["parts_name"],
    abnormalityTitle: json["abnormality_title"],
    abnormalityType: json["abnormality_type"],
    abnormalityTag: json["abnormality_tag"],
    findUserName: json["find_user_name"],
    findUserId: json["find_user_id"],
    assignId: json["assign_id"],
    assignUserData: json["assign_user_data"],
    assignUserId: json["assign_user_id"],
    completeData: json["complete_data"],
    createdAt: json["created_at"],
    abnormalityStatus: json["abnormality_status"],
  );

  Map<String, dynamic> toJson() => {
    "abnormality_id": abnormalityId,
    "company_id": companyId,
    "bussiness_id": bussinessId,
    "plant_id": plantId,
    "department_id": departmentId,
    "subdepartment_id": subDepartmentId,
    "request_no": requestNo,
    "company_short_name": companyShortName,
    "bussiness_name": businessName,
    "plant_short_name": plantShortName,
    "department_name": departmentName,
    "sub_department_name": subDepartmentName,
    "machine_detail": machineDetail,
    "parts_name": partsName,
    "abnormality_title": abnormalityTitle,
    "abnormality_type": abnormalityType,
    "abnormality_tag": abnormalityTag,
    "find_user_name": findUserName,
    "find_user_id": findUserId,
    "assign_id": assignId,
    "assign_user_data": assignUserData,
    "assign_user_id": assignUserId,
    "complete_data": completeData,
    "created_at": createdAt,
    "abnormality_status": abnormalityStatus,
  };
}

class AbnormalityDetailResponse {
  AbnormalityDetailResponse({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  AbnormalityDetail? data;

  factory AbnormalityDetailResponse.fromJson(Map<String, dynamic> json) => AbnormalityDetailResponse(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: AbnormalityDetail.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class AbnormalityDetail {
  AbnormalityDetail({
    this.id,
    this.companyId,
    this.pillarCategoryId,
    this.pillarStep,
    this.bussinessId,
    this.plantId,
    this.departmentId,
    this.subdepartmentId,
    this.machineId,
    this.submachineId,
    this.partsId,
    this.abnormalityTypeId,
    this.requestNo,
    this.abnormalityTitle,
    this.abnormalityText,
    this.solutionText,
    this.assignStatus,
    this.status,
    this.manageUserId,
    this.partName,
    this.typeName,
    this.companyShortName,
    this.bussinessName,
    this.departmentShortName,
    this.subdepartmentShortName,
    this.machineName,
    this.createdAt,
    this.submachine,
  });

  int? id;
  int? companyId;
  int? pillarCategoryId;
  int? pillarStep;
  int? bussinessId;
  int? plantId;
  int? departmentId;
  int? subdepartmentId;
  int? machineId;
  String? submachineId;
  int? partsId;
  int? abnormalityTypeId;
  String? requestNo;
  String? abnormalityTitle;
  String? abnormalityText;
  String? solutionText;
  int? assignStatus;
  int? status;
  int? manageUserId;
  String? partName;
  String? typeName;
  String? companyShortName;
  String? bussinessName;
  String? departmentShortName;
  String? subdepartmentShortName;
  String? machineName;
  String? createdAt;
  List<SubMachineDetail>? submachine;

  factory AbnormalityDetail.fromJson(Map<String, dynamic> json) => AbnormalityDetail(
    id: json["id"],
    companyId: json["company_id"],
    pillarCategoryId: json["pillar_category_id"],
    pillarStep: json["pillar_step"],
    bussinessId: json["bussiness_id"],
    plantId: json["plant_id"],
    departmentId: json["department_id"],
    subdepartmentId: json["subdepartment_id"],
    machineId: json["machine_id"],
    submachineId: json["submachine_id"],
    partsId: json["parts_id"],
    abnormalityTypeId: json["abnormality_type_id"],
    requestNo: json["request_no"],
    abnormalityTitle: json["abnormality_title"],
    abnormalityText: json["abnormality_text"],
    solutionText: json["solution_text"],
    assignStatus: json["assign_status"],
    status: json["status"],
    manageUserId: json["manage_user_id"],
    partName: json["part_name"],
    typeName: json["type_name"],
    companyShortName: json["company_short_name"],
    bussinessName: json["bussiness_name"],
    departmentShortName: json["department_short_name"],
    subdepartmentShortName: json["subdepartment_short_name"],
    machineName: json["machine_name"],
    createdAt: json["created_at"],
    submachine: List<SubMachineDetail>.from(json["submachine"].map((x) => SubMachineDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company_id": companyId,
    "pillar_category_id": pillarCategoryId,
    "pillar_step": pillarStep,
    "bussiness_id": bussinessId,
    "plant_id": plantId,
    "department_id": departmentId,
    "subdepartment_id": subdepartmentId,
    "machine_id": machineId,
    "submachine_id": submachineId,
    "parts_id": partsId,
    "abnormality_type_id": abnormalityTypeId,
    "request_no": requestNo,
    "abnormality_title": abnormalityTitle,
    "abnormality_text": abnormalityText,
    "solution_text": solutionText,
    "assign_status": assignStatus,
    "status": status,
    "manage_user_id": manageUserId,
    "part_name": partName,
    "type_name": typeName,
    "company_short_name": companyShortName,
    "bussiness_name": bussinessName,
    "department_short_name": departmentShortName,
    "subdepartment_short_name": subdepartmentShortName,
    "machine_name": machineName,
    "created_at": createdAt,
    "submachine": submachine == null ? [] : List<dynamic>.from(submachine!.map((x) => x.toJson())),
  };
}

class SubMachineDetail {
  SubMachineDetail({
    this.id,
    this.businessId,
    this.companyId,
    this.plantsId,
    this.parentId,
    this.name,
    this.serialNo,
    this.status,
    this.manageUserId,
  });

  int? id;
  int? businessId;
  int? companyId;
  int? plantsId;
  int? parentId;
  String? name;
  String? serialNo;
  int? status;
  int? manageUserId;

  factory SubMachineDetail.fromJson(Map<String, dynamic> json) => SubMachineDetail(
    id: json["id"],
    businessId: json["business_id"],
    companyId: json["company_id"],
    plantsId: json["plants_id"],
    parentId: json["parent_id"],
    name: json["name"],
    serialNo: json["serial_no"],
    status: json["status"],
    manageUserId: json["manage_user_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "business_id": businessId,
    "company_id": companyId,
    "plants_id": plantsId,
    "parent_id": parentId,
    "name": name,
    "serial_no": serialNo,
    "status": status,
    "manage_user_id": manageUserId,
  };
}


class AssignAbnormalityResponseModel {
  AssignAbnormalityResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  AssignAbnormalityResponse? data;

  factory AssignAbnormalityResponseModel.fromJson(Map<String, dynamic> json) => AssignAbnormalityResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: AssignAbnormalityResponse.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class AssignAbnormalityResponse {
  AssignAbnormalityResponse({
    this.departmentData,
    this.userData,
    this.subdepartmentData,
  });

  List<Department>? departmentData;
  List<UserFilterResponse>? userData;
  List<SubDepartment>? subdepartmentData;

  factory AssignAbnormalityResponse.fromJson(Map<String, dynamic> json) => AssignAbnormalityResponse(
    departmentData: List<Department>.from(json["department_data"].map((x) => Department.fromJson(x))),
    userData: List<UserFilterResponse>.from(json["user_data"].map((x) => UserFilterResponse.fromJson(x))),
    subdepartmentData: List<SubDepartment>.from(json["subdepartment_data"].map((x) => SubDepartment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "department_data": departmentData == null ? [] : List<dynamic>.from(departmentData!.map((x) => x.toJson())),
    "user_data": userData == null ? [] : List<dynamic>.from(userData!.map((x) => x.toJson())),
    "subdepartment_data": subdepartmentData == null ? [] : List<dynamic>.from(subdepartmentData!.map((x) => x.toJson())),
  };
}