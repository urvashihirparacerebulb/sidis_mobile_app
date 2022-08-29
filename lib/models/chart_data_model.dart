class ChartResponseModel {
  ChartResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  ChartResponse? data;

  factory ChartResponseModel.fromJson(Map<String, dynamic> json) => ChartResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: ChartResponse.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "DatastatusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class ChartResponse {
  ChartResponse({
    this.data,
    this.value,
    this.commpleteddata,
    this.commpletedvalue,
    this.totalProjects,
    this.totalCompleted,
  });

  List<String>? data;
  List<int>? value;
  List<String>? commpleteddata;
  List<int>? commpletedvalue;
  int? totalProjects;
  int? totalCompleted;

  factory ChartResponse.fromJson(Map<String, dynamic> json) => ChartResponse(
    data: List<String>.from(json["data"].map((x) => x)),
    value: List<int>.from(json["value"].map((x) => x)),
    commpleteddata: List<String>.from(json["commpleteddata"].map((x) => x)),
    commpletedvalue: List<int>.from(json["commpletedvalue"].map((x) => x)),
    totalProjects: json["total_projects"],
    totalCompleted: json["total_completed"],
  );

  Map<String, dynamic> toJson() => {
    "data": data!.isEmpty ? [] : List<dynamic>.from(data!.map((x) => x)),
    "value": value!.isEmpty ? [] : List<dynamic>.from(value!.map((x) => x)),
    "commpleteddata": commpleteddata!.isEmpty ? [] : List<dynamic>.from(commpleteddata!.map((x) => x)),
    "commpletedvalue": commpletedvalue!.isEmpty ? [] : List<dynamic>.from(commpletedvalue!.map((x) => x)),
    "total_projects": totalProjects,
    "total_completed": totalCompleted,
  };
}
