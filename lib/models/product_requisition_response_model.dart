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
    this.requestNo,
    this.requisitionDate,
    this.companyBussinessPlant,
    this.machineDetail,
    this.requiredIn,
    this.img,
    this.itemStatus,
    this.username,
  });

  int? productRequisitionId;
  String? requestNo;
  String? requisitionDate;
  String? companyBussinessPlant;
  String? machineDetail;
  String? requiredIn;
  String? img;
  String? itemStatus;
  String? username;

  factory ProductRequisition.fromJson(Map<String, dynamic> json) => ProductRequisition(
    productRequisitionId: json["product_requisition_id"],
    requestNo: json["request_no"],
    requisitionDate: json["requisition_date"],
    companyBussinessPlant: json["company_bussiness_plant"],
    machineDetail: json["machine_detail"],
    requiredIn: json["required_in"],
    img: json["img"],
    itemStatus: json["item_status"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "product_requisition_id": productRequisitionId,
    "request_no": requestNo,
    "requisition_date": requisitionDate,
    "company_bussiness_plant": companyBussinessPlant,
    "machine_detail": machineDetail,
    "required_in": requiredIn,
    "img": img,
    "item_status": itemStatus,
    "username": username,
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
