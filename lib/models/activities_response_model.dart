class ActivityResponse {
  ActivityResponse({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  ActivityResponseModel? data;

  factory ActivityResponse.fromJson(Map<String, dynamic> json) => ActivityResponse(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: ActivityResponseModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class ActivityResponseModel {
  ActivityResponseModel({
    this.activitydata,
  });

  List<ActivityData>? activitydata;

  factory ActivityResponseModel.fromJson(Map<String, dynamic> json) => ActivityResponseModel(
    activitydata: List<ActivityData>.from(json["activitydata"].map((x) => ActivityData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "activitydata": activitydata == null ? [] : List<dynamic>.from(activitydata!.map((x) => x.toJson())),
  };
}

class ActivityData {
  ActivityData({
    this.activityId,
    this.activityMstId,
    this.activityFor,
    this.activityQuestion,
    this.isSelected = false
  });

  int? activityId;
  int? activityMstId;
  String? activityFor;
  String? activityQuestion;

  //Developer Purpose
  bool isSelected;

  factory ActivityData.fromJson(Map<String, dynamic> json) => ActivityData(
    activityId: json["activity_id"],
    activityMstId: json["activity_mst_id"],
    activityFor: json["activity_for"],
    activityQuestion: json["activity_question"],
  );

  Map<String, dynamic> toJson() => {
    "activity_id": activityId,
    "activity_mst_id": activityMstId,
    "activity_for": activityFor,
    "activity_question": activityQuestion,
  };
}

class IntervalResponse {
  IntervalResponse({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  IntervalResponseModel? data;

  factory IntervalResponse.fromJson(Map<String, dynamic> json) => IntervalResponse(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: IntervalResponseModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}


class IntervalResponseModel {
  IntervalResponseModel({
    this.interval,
  });

  List<Map<String, String>>? interval;

  factory IntervalResponseModel.fromJson(Map<String, dynamic> json) => IntervalResponseModel(
    interval: List<Map<String, String>>.from(json["interval"].map((x) => Map.from(x).map((k, v) => MapEntry<String, String>(k, v)))),
  );

  Map<String, dynamic> toJson() => {
    "interval": List<dynamic>.from(interval!.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
  };
}

class AbnormalityTypeResponseModel {
  AbnormalityTypeResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  AbnormalityTypeResponse? data;

  factory AbnormalityTypeResponseModel.fromJson(Map<String, dynamic> json) => AbnormalityTypeResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: AbnormalityTypeResponse.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class AbnormalityTypeResponse {
  AbnormalityTypeResponse({
    this.typeData,
  });

  List<AbnormalityType>? typeData;

  factory AbnormalityTypeResponse.fromJson(Map<String, dynamic> json) => AbnormalityTypeResponse(
    typeData : List<AbnormalityType>.from(json["typedata"].map((x) => AbnormalityType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "typedata": typeData == null ? [] : List<dynamic>.from(typeData!.map((x) => x.toJson())),
  };
}

class AbnormalityType {
  AbnormalityType({
    this.id,
    this.typeName,
    this.manageUserId,
    this.status,
    this.createdAt,
    this.modifiedAt,
  });

  int? id;
  String? typeName;
  int? manageUserId;
  int? status;
  String? createdAt;
  String? modifiedAt;

  factory AbnormalityType.fromJson(Map<String, dynamic> json) => AbnormalityType(
    id: json["id"],
    typeName: json["type_name"],
    manageUserId: json["manage_user_id"],
    status: json["status"],
    createdAt: json["created_at"],
    modifiedAt: json["modified_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type_name": typeName,
    "manage_user_id": manageUserId,
    "status": status,
    "created_at": createdAt,
    "modified_at": modifiedAt,
  };
}

class AbnormalityRequest{
  String? editAbnormalityId;
  String? soleId;
  String? departmentId;
  String? subDepartmentId;
  String? machineId;
  String? subMachineId;
  String? partsId = "";
  String? partName;
  String? abnormalityTitle;
  String? abnormalityTypeId;
  String? abnormalityText;
  String? possibleSolution;
  String? abnormalityDate;
  String? userId;

  AbnormalityRequest({
    this.editAbnormalityId,
    this.soleId,
    this.departmentId,
    this.subDepartmentId,
    this.machineId,
    this.subMachineId,
    this.partsId,
    this.partName,
    this.abnormalityTitle,
    this.abnormalityTypeId,
    this.abnormalityText,
    this.possibleSolution,
    this.abnormalityDate,
    this.userId
  });

  factory AbnormalityRequest.fromJson(Map<String, dynamic> json) => AbnormalityRequest(
    editAbnormalityId: json["edit_abnormality_id"],
    soleId: json["sole_id"],
    departmentId: json["department_id"],
    subDepartmentId: json["subdepartment_id"],
    machineId: json["machine_id"],
    subMachineId:  json['submachine_id'],
    partsId: json["parts_id"],
    partName: json["part_name"],
    abnormalityTitle: json["abnormality_title"],
    abnormalityTypeId: json["abnormality_type_id"],
    abnormalityText: json["abnormality_text"],
    possibleSolution: json["possible_solution"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "edit_abnormality_id": editAbnormalityId ?? "",
    "sole_id": soleId,
    "department_id": departmentId,
    "subdepartment_id": subDepartmentId,
    "machine_id": machineId,
    "submachine_id": subMachineId,
    "parts_id": partsId,
    "part_name": partName,
    "abnormality_title": abnormalityTitle,
    "abnormality_type_id": abnormalityTypeId,
    "abnormality_text": abnormalityText,
    "possible_solution": possibleSolution,
    "abnormlity_date": abnormalityDate,
    "user_id": userId,
  };
}

class FilterDepartmentResponseModel {
  FilterDepartmentResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  List<FilterDepartment>? data;

  factory FilterDepartmentResponseModel.fromJson(Map<String, dynamic> json) => FilterDepartmentResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: List<FilterDepartment>.from(json["data"].map((x) => FilterDepartment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class FilterDepartment {
  FilterDepartment({
    this.id,
    this.transactionId,
    this.parentId,
    this.companyId,
    this.bussinessId,
    this.plantId,
    this.name,
    this.shortName,
    this.status,
    this.manageUserId,
    this.createdAt,
    this.modifiedAt,
    this.departmentShortName,
    this.departmentId,
    this.subdepartmentId,
    this.subdepartmentShortName,
  });

  int? id;
  String? transactionId;
  int? parentId;
  String? companyId;
  String? bussinessId;
  String? plantId;
  String? name;
  String? shortName;
  int? status;
  int? manageUserId;
  String? createdAt;
  String? modifiedAt;
  String? departmentShortName;
  int? departmentId;
  int? subdepartmentId;
  String? subdepartmentShortName;

  factory FilterDepartment.fromJson(Map<String, dynamic> json) => FilterDepartment(
    id: json["id"],
    transactionId: json["transaction_id"],
    parentId: json["parent_id"],
    companyId: json["company_id"],
    bussinessId: json["bussiness_id"],
    plantId: json["plant_id"],
    name: json["name"],
    shortName: json["short_name"],
    status: json["status"],
    manageUserId: json["manage_user_id"],
    createdAt: json["created_at"],
    modifiedAt: json["modified_at"],
    departmentShortName: json["department_short_name"],
    departmentId: json["department_id"],
    subdepartmentId: json["subdepartment_id"],
    subdepartmentShortName: json["subdepartment_short_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "transaction_id": transactionId,
    "parent_id": parentId,
    "company_id": companyId,
    "bussiness_id": bussinessId,
    "plant_id": plantId,
    "name": name,
    "short_name": shortName,
    "status": status,
    "manage_user_id": manageUserId,
    "created_at": createdAt,
    "modified_at": modifiedAt,
    "department_short_name": departmentShortName,
    "department_id": departmentId,
    "subdepartment_id": subdepartmentId,
    "subdepartment_short_name": subdepartmentShortName,
  };
}

class UserFilterResponseModel {
  UserFilterResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  List<UserFilterResponse>? data;

  factory UserFilterResponseModel.fromJson(Map<String, dynamic> json) => UserFilterResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: List<UserFilterResponse>.from(json["data"].map((x) => UserFilterResponse.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class UserFilterResponse {
  UserFilterResponse({
    this.userId,
    this.firstName,
    this.lastName,
    this.userName
  });

  int? userId;
  String? firstName;
  String? lastName;
  String? userName;

  factory UserFilterResponse.fromJson(Map<String, dynamic> json) => UserFilterResponse(
    userId: json["user_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    userName: json["user_name"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "first_name": firstName,
    "last_name": lastName,
    "user_name": userName,
  };
}

class TagResponse {
  TagResponse({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.data,
  });

  int statusCode;
  bool status;
  String message;
  Map<String, String> data;

  factory TagResponse.fromJson(Map<String, dynamic> json) => TagResponse(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: Map.from(json["data"]).map((k, v) => MapEntry<String, String>(k, v)),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}
