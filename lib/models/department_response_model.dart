class DepartmentResponseModel {
  DepartmentResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  DepartmentResponse? data;

  factory DepartmentResponseModel.fromJson(Map<String, dynamic> json) => DepartmentResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: DepartmentResponse.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class DepartmentResponse {
  DepartmentResponse({
    this.departmentData,
  });

  List<Department>? departmentData;

  factory DepartmentResponse.fromJson(Map<String, dynamic> json) => DepartmentResponse(
    departmentData: List<Department>.from(json["department_data"].map((x) => Department.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "department_data": departmentData == null ? [] : List<dynamic>.from(departmentData!.map((x) => x.toJson())),
  };
}

class Department {
  Department({
    this.departmentId,
    this.departmentName,
  });

  int? departmentId;
  String? departmentName;

  factory Department.fromJson(Map<String, dynamic> json) => Department(
    departmentId: json["department_id"],
    departmentName: json["department_name"],
  );

  Map<String, dynamic> toJson() => {
    "department_id": departmentId,
    "department_name": departmentName,
  };
}



class SubDepartment {
  SubDepartment({
    this.departmentId,
    this.departmentName,
  });

  int? departmentId;
  String? departmentName;

  factory SubDepartment.fromJson(Map<String, dynamic> json) => SubDepartment(
    departmentId: json["subdepartment_id"],
    departmentName: json["subdepartment_name"],
  );

  Map<String, dynamic> toJson() => {
    "subdepartment_id": departmentId,
    "subdepartment_name": departmentName,
  };
}
