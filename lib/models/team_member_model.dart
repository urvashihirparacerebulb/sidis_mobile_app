class TeamMembersResponseModel {
  TeamMembersResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  KaizenTeamDataResponse? data;

  factory TeamMembersResponseModel.fromJson(Map<String, dynamic> json) => TeamMembersResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: KaizenTeamDataResponse.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class KaizenTeamDataResponse {
  KaizenTeamDataResponse({
    this.kaizenTeamData,
  });

  List<KaizenTeamData>? kaizenTeamData;

  factory KaizenTeamDataResponse.fromJson(Map<String, dynamic> json) => KaizenTeamDataResponse(
    kaizenTeamData: List<KaizenTeamData>.from(json["kaizen_team_data"].map((x) => KaizenTeamData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "kaizen_team_data": kaizenTeamData == null ? [] : List<dynamic>.from(kaizenTeamData!.map((x) => x.toJson())),
  };
}

class KaizenTeamData {
  KaizenTeamData({
    this.userId,
    this.userName,
  });

  int? userId;
  String? userName;

  factory KaizenTeamData.fromJson(Map<String, dynamic> json) => KaizenTeamData(
    userId: json["user_id"],
    userName: json["user_name"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_name": userName,
  };
}
