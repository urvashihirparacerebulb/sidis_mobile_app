class PartResponseModel {
  PartResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  PartArrayModel? data;

  factory PartResponseModel.fromJson(Map<String, dynamic> json) => PartResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: PartArrayModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class PartArrayModel {
  PartArrayModel({
    this.partArray,
  });

  List<PartArray>? partArray;

  factory PartArrayModel.fromJson(Map<String, dynamic> json) => PartArrayModel(
    partArray: List<PartArray>.from(json["part_array"].map((x) => PartArray.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "part_array": partArray == null ? [] : List<dynamic>.from(partArray!.map((x) => x.toJson())),
  };
}

class PartArray {
  PartArray({
    this.partId,
    this.partName,
  });

  int? partId;
  String? partName;

  factory PartArray.fromJson(Map<String, dynamic> json) => PartArray(
    partId: json["part_id"],
    partName: json["part_name"],
  );

  Map<String, dynamic> toJson() => {
    "part_id": partId,
    "part_name": partName,
  };
}
