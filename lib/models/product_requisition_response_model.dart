class ProductRequisitionResponseModel {
  ProductRequisitionResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  ProductRequisitionResponse? data;

  factory ProductRequisitionResponseModel.fromJson(Map<String, dynamic> json) => ProductRequisitionResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: ProductRequisitionResponse.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class ProductRequisitionResponse {
  ProductRequisitionResponse({
    this.data,
  });

  List<ProductRequisition>? data;

  factory ProductRequisitionResponse.fromJson(Map<String, dynamic> json) => ProductRequisitionResponse(
    data: List<ProductRequisition>.from(json["data"].map((x) => ProductRequisition.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ProductRequisition {
  ProductRequisition({
    this.productRequisitionId,
    this.poNo,
    this.requisitionDate,
    this.companyBussinessPlant,
    this.machineDetail,
    this.requiredIn,
    this.img,
    this.itemStatus,
    this.username,
    this.quantity,
    this.itemType,
    this.requestedUserId
  });

  int? productRequisitionId;
  String? poNo;
  String? requisitionDate;
  String? companyBussinessPlant;
  String? machineDetail;
  String? requiredIn;
  String? img;
  String? itemStatus;
  String? username;
  String? itemType;
  num? quantity;
  int? requestedUserId;

  factory ProductRequisition.fromJson(Map<String, dynamic> json) => ProductRequisition(
    productRequisitionId: json["product_requisition_id"],
    poNo: json["po_no"],
    requisitionDate: json["requisition_date"],
    companyBussinessPlant: json["company_bussiness_plant"],
    machineDetail: json["machine_detail"],
    requiredIn: json["required_in"],
    img: json["img"],
    itemStatus: json["item_status"],
    username: json["username"],
    quantity: json["quantity"],
    itemType: json["item_type"],
    requestedUserId: json["requested_user_id"],
  );

  Map<String, dynamic> toJson() => {
    "product_requisition_id": productRequisitionId,
    "po_no": poNo,
    "requisition_date": requisitionDate,
    "company_bussiness_plant": companyBussinessPlant,
    "machine_detail": machineDetail,
    "required_in": requiredIn,
    "img": img,
    "item_status": itemStatus,
    "username": username,
    "quantity": quantity,
    "item_type": itemType,
    "requested_user_id": requestedUserId,
  };
}

class RequisitionItemResponseModel {
  RequisitionItemResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  RequisitionItemType? data;

  factory RequisitionItemResponseModel.fromJson(Map<String, dynamic> json) => RequisitionItemResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: RequisitionItemType.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class RequisitionItemType {
  RequisitionItemType({
    this.typedata,
  });

  List<List<String>>? typedata;

  factory RequisitionItemType.fromJson(Map<String, dynamic> json) => RequisitionItemType(
    typedata: List<List<String>>.from(json["typedata"].map((x) => List<String>.from(x.map((x) => x)))),
  );

  Map<String, dynamic> toJson() => {
    "typedata": List<dynamic>.from(typedata!.map((x) => List<dynamic>.from(x.map((x) => x)))),
  };
}


class RequisitionRequiredInModel {
  RequisitionRequiredInModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  RequiredInModel? data;

  factory RequisitionRequiredInModel.fromJson(Map<String, dynamic> json) => RequisitionRequiredInModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: RequiredInModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class RequiredInModel {
  RequiredInModel({
    this.requiredInData,
  });

  List<RequiredIn>? requiredInData;

  factory RequiredInModel.fromJson(Map<String, dynamic> json) => RequiredInModel(
    requiredInData: List<RequiredIn>.from(json["required_in_data"].map((x) => RequiredIn.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "required_in_data": requiredInData== null ? [] : List<dynamic>.from(requiredInData!.map((x) => x.toJson())),
  };
}

class RequiredIn {
  RequiredIn({
    this.id,
    this.value,
  });

  int? id;
  String? value;

  factory RequiredIn.fromJson(Map<String, dynamic> json) => RequiredIn(
    id: json["id"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "value": value,
  };
}

class RequisitionStatusResponseModel {
  RequisitionStatusResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  RequisitionStatus? data;

  factory RequisitionStatusResponseModel.fromJson(Map<String, dynamic> json) => RequisitionStatusResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: RequisitionStatus.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class RequisitionStatus {
  RequisitionStatus({
    this.statusdata,
  });

  List<List<String>>? statusdata;

  factory RequisitionStatus.fromJson(Map<String, dynamic> json) => RequisitionStatus(
    statusdata: List<List<String>>.from(json["statusdata"].map((x) => List<String>.from(x.map((x) => x)))),
  );

  Map<String, dynamic> toJson() => {
    "statusdata": statusdata == null ? [] : List<dynamic>.from(statusdata!.map((x) => List<dynamic>.from(x.map((x) => x)))),
  };
}

class ProductRequisitionDetailResponse {
  ProductRequisitionDetailResponse({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  ProductRequisitionDetail? data;

  factory ProductRequisitionDetailResponse.fromJson(Map<String, dynamic> json) => ProductRequisitionDetailResponse(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: ProductRequisitionDetail.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class ProductRequisitionDetail {
  ProductRequisitionDetail({
    this.id,
    this.companyId,
    this.plantId,
    this.businessId,
    this.departmentId,
    this.subdepartmentId,
    this.machineId,
    this.requestNo,
    this.requisitionDate,
    this.requiredIn,
    this.itemType,
    this.otherItem,
    this.itemDescription,
    this.poNo,
    this.remarks,
    this.quantity,
    this.productImage,
    this.itemStatus,
    this.manageUserId,
    this.status,
    this.createdAt,
    this.modifiedAt,
    this.companyShortName,
    this.bussinessName,
    this.departmentShortName,
    this.subdepartmentShortName,
    this.machineName,
    this.requiredInId
  });

  int? id;
  int? companyId;
  int? plantId;
  int? businessId;
  int? departmentId;
  int? subdepartmentId;
  int? machineId;
  String? requestNo;
  String? requisitionDate;
  String? requiredIn;
  String? itemType;
  String? otherItem;
  String? itemDescription;
  String? poNo;
  String? remarks;
  int? quantity;
  String? productImage;
  String? itemStatus;
  int? manageUserId;
  int? status;
  String? createdAt;
  String? modifiedAt;
  String? companyShortName;
  String? bussinessName;
  String? departmentShortName;
  String? subdepartmentShortName;
  String? machineName;
  int? requiredInId;

  factory ProductRequisitionDetail.fromJson(Map<String, dynamic> json) => ProductRequisitionDetail(
    id: json["id"],
    companyId: json["company_id"],
    plantId: json["plant_id"],
    businessId: json["business_id"],
    departmentId: json["department_id"],
    subdepartmentId: json["subdepartment_id"],
    machineId: json["machine_id"],
    requestNo: json["request_no"],
    requisitionDate: json["requisition_date"],
    requiredIn: json["required_in"],
    itemType: json["item_type"],
    otherItem: json["other_item"],
    itemDescription: json["item_description"],
    poNo: json["po_no"],
    remarks: json["remarks"],
    quantity: json["quantity"],
    productImage: json["product_image"],
    itemStatus: json["item_status"],
    manageUserId: json["manage_user_id"],
    status: json["status"],
    createdAt: json["created_at"],
    modifiedAt: json["modified_at"],
    companyShortName: json["company_short_name"],
    bussinessName: json["bussiness_name"],
    departmentShortName: json["department_short_name"],
    subdepartmentShortName: json["subdepartment_short_name"],
    machineName: json["machine_name"],
    requiredInId: json["required_in_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company_id": companyId,
    "plant_id": plantId,
    "business_id": businessId,
    "department_id": departmentId,
    "subdepartment_id": subdepartmentId,
    "machine_id": machineId,
    "request_no": requestNo,
    "requisition_date": requisitionDate,
    "required_in": requiredIn,
    "item_type": itemType,
    "other_item": otherItem,
    "item_description": itemDescription,
    "po_no": poNo,
    "remarks": remarks,
    "quantity": quantity,
    "product_image": productImage,
    "item_status": itemStatus,
    "manage_user_id": manageUserId,
    "status": status,
    "created_at": createdAt,
    "modified_at": modifiedAt,
    "company_short_name": companyShortName,
    "bussiness_name": bussinessName,
    "department_short_name": departmentShortName,
    "subdepartment_short_name": subdepartmentShortName,
    "machine_name": machineName,
    "required_in_id": requiredInId,
  };
}
