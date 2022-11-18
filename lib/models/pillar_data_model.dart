class PillarDataModel {
  PillarDataModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  List<PillarResponse>? data;

  factory PillarDataModel.fromJson(Map<String, dynamic> json) => PillarDataModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: List<PillarResponse>.from(json["data"].map((x) => PillarResponse.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class PillarResponse {
  PillarResponse({
    this.pillarCategoryId,
    this.pillarName,
    this.status,
    this.createdAt,
  });

  num? pillarCategoryId;
  String? pillarName;
  int? status;
  DateTime? createdAt;

  factory PillarResponse.fromJson(Map<String, dynamic> json) => PillarResponse(
    pillarCategoryId: json["pillar_category_id"],
    pillarName: json["pillar_name"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "pillar_category_id": pillarCategoryId,
    "pillar_name": pillarName,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
  };
}


class PillarFormResponseModel {
  PillarFormResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  List<PillarForm>? data;

  factory PillarFormResponseModel.fromJson(Map<String, dynamic> json) => PillarFormResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: List<PillarForm>.from(json["data"].map((x) => PillarForm.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class PillarForm {
  PillarForm({
    this.id,
    this.groupId,
    this.menuId,
    this.controlType,
    this.status,
    this.manageUserId,
    this.createdAt,
    this.modifiedAt,
    this.pillarId,
    this.parentId,
    this.name,
    this.icon,
    this.link,
    this.orderBy,
    this.userNotificationSetting,
    this.mobileApp,
    this.pillarCategoryId,
    this.pillarName,
  });

  int? id;
  int? groupId;
  int? menuId;
  int? controlType;
  int? status;
  int? manageUserId;
  DateTime? createdAt;
  DateTime? modifiedAt;
  int? pillarId;
  int? parentId;
  String? name;
  String? icon;
  String? link;
  int? orderBy;
  int? userNotificationSetting;
  int? mobileApp;
  int? pillarCategoryId;
  String? pillarName;

  factory PillarForm.fromJson(Map<String, dynamic> json) => PillarForm(
    id: json["id"],
    groupId: json["group_id"],
    menuId: json["menu_id"],
    controlType: json["control_type"],
    status: json["status"],
    manageUserId: json["manage_user_id"],
    createdAt: DateTime.parse(json["created_at"]),
    modifiedAt: DateTime.parse(json["modified_at"]),
    pillarId: json["pillar_id"],
    parentId: json["parent_id"],
    name: json["name"],
    icon: json["icon"],
    link: json["link"],
    orderBy: json["order_by"],
    userNotificationSetting: json["user_notification_setting"],
    mobileApp: json["mobile_app"],
    pillarCategoryId: json["pillar_category_id"],
    pillarName: json["pillar_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "group_id": groupId,
    "menu_id": menuId,
    "control_type": controlType,
    "status": status,
    "manage_user_id": manageUserId,
    "created_at": createdAt?.toIso8601String(),
    "modified_at": modifiedAt?.toIso8601String(),
    "pillar_id": pillarId,
    "parent_id": parentId,
    "name": name,
    "icon": icon,
    "link": link,
    "order_by": orderBy,
    "user_notification_setting": userNotificationSetting,
    "mobile_app": mobileApp,
    "pillar_category_id": pillarCategoryId,
    "pillar_name": pillarName,
  };
}
