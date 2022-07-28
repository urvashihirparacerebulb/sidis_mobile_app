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
  });

  int? activityId;
  int? activityMstId;
  String? activityFor;
  String? activityQuestion;

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
