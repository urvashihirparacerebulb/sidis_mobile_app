
class RootCauseModel {
  RootCauseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  RootCause? data;

  factory RootCauseModel.fromJson(Map<String, dynamic> json) => RootCauseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: RootCause.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class RootCause {
  RootCause({
    this.rootdata,
  });

  List<List<String>>? rootdata;

  factory RootCause.fromJson(Map<String, dynamic> json) => RootCause(
    rootdata: List<List<String>>.from(json["rootdata"].map((x) => List<String>.from(x.map((x) => x)))),
  );

  Map<String, dynamic> toJson() => {
    "rootdata": List<dynamic>.from(rootdata!.map((x) => List<dynamic>.from(x.map((x) => x)))),
  };
}
