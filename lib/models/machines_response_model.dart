
class MachineResponse {
  MachineResponse({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  MachineResponseModel? data;

  factory MachineResponse.fromJson(Map<String, dynamic> json) => MachineResponse(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: MachineResponseModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class MachineResponseModel {
  MachineResponseModel({
    this.machineData,
  });

  List<MachineData>? machineData;

  factory MachineResponseModel.fromJson(Map<String, dynamic> json) => MachineResponseModel(
    machineData: List<MachineData>.from(json["machine_data"].map((x) => MachineData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "machine_data": machineData == null ? [] : List<dynamic>.from(machineData!.map((x) => x.toJson())),
  };
}

class SubMachineResponse {
  SubMachineResponse({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  SubMachineResponseModel? data;

  factory SubMachineResponse.fromJson(Map<String, dynamic> json) => SubMachineResponse(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: SubMachineResponseModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class SubMachineResponseModel {
  SubMachineResponseModel({
    this.submachineArray,
  });

  List<MachineData>? submachineArray;

  factory SubMachineResponseModel.fromJson(Map<String, dynamic> json) => SubMachineResponseModel(
    submachineArray: List<MachineData>.from(json["submachine_array"].map((x) => MachineData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "submachine_array": submachineArray == null ? [] : List<dynamic>.from(submachineArray!.map((x) => x.toJson())),
  };
}

class MachineData {
  MachineData({
    this.machineId,
    this.machineName,
  });

  int? machineId;
  String? machineName;

  factory MachineData.fromJson(Map<String, dynamic> json) => MachineData(
    machineId: json["machine_id"],
    machineName: json["machine_name"],
  );

  Map<String, dynamic> toJson() => {
    "machine_id": machineId,
    "machine_name": machineName,
  };
}
