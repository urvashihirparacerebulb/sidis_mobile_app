class NeedleRecordListResponseModel {
  NeedleRecordListResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  NeedleRecordLists? data;

  factory NeedleRecordListResponseModel.fromJson(Map<String, dynamic> json) => NeedleRecordListResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: NeedleRecordLists.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class NeedleRecordLists {
  NeedleRecordLists({
    this.data,
  });

  List<NeedleRecord>? data;

  factory NeedleRecordLists.fromJson(Map<String, dynamic> json) => NeedleRecordLists(
    data: List<NeedleRecord>.from(json["data"].map((x) => NeedleRecord.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] :  List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class NeedleRecord {
  NeedleRecord({
    this.needleRecordId,
    this.recordDate,
    this.companyShortName,
    this.bussinessName,
    this.plantShortName,
    this.boardNo,
    this.machineDetail,
    this.consumedNeedle,
  });

  int? needleRecordId;
  String? recordDate;
  String? companyShortName;
  String? bussinessName;
  String? plantShortName;
  String? boardNo;
  String? machineDetail;
  String? consumedNeedle;

  factory NeedleRecord.fromJson(Map<String, dynamic> json) => NeedleRecord(
    needleRecordId: json["needle_record_id"],
    recordDate: json["record_date"],
    companyShortName: json["company_short_name"],
    bussinessName: json["bussiness_name"],
    plantShortName: json["plant_short_name"],
    boardNo: json["board_no"],
    machineDetail: json["machine_detail"],
    consumedNeedle: json["consumed_needle"],
  );

  Map<String, dynamic> toJson() => {
    "needle_record_id": needleRecordId,
    "record_date": recordDate,
    "company_short_name": companyShortName,
    "bussiness_name": bussinessName,
    "plant_short_name": plantShortName,
    "board_no": boardNo,
    "machine_detail": machineDetail,
    "consumed_needle": consumedNeedle,
  };
}

class NeedleBoardNumberResponseModel {
  NeedleBoardNumberResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  NeedleBoardNumberResponse? data;

  factory NeedleBoardNumberResponseModel.fromJson(Map<String, dynamic> json) => NeedleBoardNumberResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: NeedleBoardNumberResponse.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class NeedleBoardNumberResponse {
  NeedleBoardNumberResponse({
    this.boardData,
  });

  List<NeedleBoardNumber>? boardData;

  factory NeedleBoardNumberResponse.fromJson(Map<String, dynamic> json) => NeedleBoardNumberResponse(
    boardData: List<NeedleBoardNumber>.from(json["board_data"].map((x) => NeedleBoardNumber.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "board_data": boardData == null ? [] : List<dynamic>.from(boardData!.map((x) => x.toJson())),
  };
}

class NeedleBoardNumber {
  NeedleBoardNumber({
    this.boardId,
    this.boardNo,
  });

  int? boardId;
  String? boardNo;

  factory NeedleBoardNumber.fromJson(Map<String, dynamic> json) => NeedleBoardNumber(
    boardId: json["board_id"],
    boardNo: json["board_no"],
  );

  Map<String, dynamic> toJson() => {
    "board_id": boardId,
    "board_no": boardNo,
  };
}

class ChangeStatusResponseModel {
  ChangeStatusResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  ChangeStatusResponse? data;

  factory ChangeStatusResponseModel.fromJson(Map<String, dynamic> json) => ChangeStatusResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: ChangeStatusResponse.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class ChangeStatusResponse {
  ChangeStatusResponse({
    this.needlesChangedStatusData,
  });

  List<ChangeStatus>? needlesChangedStatusData;

  factory ChangeStatusResponse.fromJson(Map<String, dynamic> json) => ChangeStatusResponse(
    needlesChangedStatusData: List<ChangeStatus>.from(json["needles_changed_status_data"].map((x) => ChangeStatus.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "needles_changed_status_data": needlesChangedStatusData == null ? [] : List<dynamic>.from(needlesChangedStatusData!.map((x) => x.toJson())),
  };
}

class ChangeStatus {
  ChangeStatus({
    this.id,
    this.value,
  });

  int? id;
  String? value;

  factory ChangeStatus.fromJson(Map<String, dynamic> json) => ChangeStatus(
    id: json["id"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "value": value,
  };
}

class LineResponseModel {
  LineResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  LineLists? data;

  factory LineResponseModel.fromJson(Map<String, dynamic> json) => LineResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: LineLists.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class LineLists {
  LineLists({
    this.lineData,
  });

  List<LineData>? lineData;

  factory LineLists.fromJson(Map<String, dynamic> json) => LineLists(
    lineData: List<LineData>.from(json["line_data"].map((x) => LineData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "line_data": lineData == null ? [] : List<dynamic>.from(lineData!.map((x) => x.toJson())),
  };
}

class LineData {
  LineData({
    this.lineId,
    this.lineNo,
  });

  int? lineId;
  String? lineNo;

  factory LineData.fromJson(Map<String, dynamic> json) => LineData(
    lineId: json["line_id"],
    lineNo: json["line_no"],
  );

  Map<String, dynamic> toJson() => {
    "line_id": lineId,
    "line_no": lineNo,
  };
}

class LoomsResponseModel {
  LoomsResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  LoomsList? data;

  factory LoomsResponseModel.fromJson(Map<String, dynamic> json) => LoomsResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: LoomsList.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class LoomsList {
  LoomsList({
    this.loopsData,
  });

  List<LoomsData>? loopsData;

  factory LoomsList.fromJson(Map<String, dynamic> json) => LoomsList(
    loopsData: List<LoomsData>.from(json["loops_data"].map((x) => LoomsData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "loops_data": loopsData == null ? [] : List<dynamic>.from(loopsData!.map((x) => x.toJson())),
  };
}

class LoomsData {
  LoomsData({
    this.loopsId,
    this.loopsNo,
  });

  int? loopsId;
  String? loopsNo;

  factory LoomsData.fromJson(Map<String, dynamic> json) => LoomsData(
    loopsId: json["loops_id"],
    loopsNo: json["loops_no"],
  );

  Map<String, dynamic> toJson() => {
    "loops_id": loopsId,
    "loops_no": loopsNo,
  };
}

class MachineLocationResponseModel {
  MachineLocationResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  LocationLists? data;

  factory MachineLocationResponseModel.fromJson(Map<String, dynamic> json) => MachineLocationResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: LocationLists.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class LocationLists {
  LocationLists({
    this.location,
  });

  List<LocationData>? location;

  factory LocationLists.fromJson(Map<String, dynamic> json) => LocationLists(
    location: List<LocationData>.from(json["location"].map((x) => LocationData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "location": location == null ? [] : List<dynamic>.from(location!.map((x) => x.toJson())),
  };
}

class LocationData {
  LocationData({
    this.locationId,
    this.locationLabel,
    this.oldBoard,
    this.newBoard,
    this.selectedOldBoard,
    this.selectedNewBoard
  });

  String? locationId;
  String? locationLabel;
  List<NeedleBoardNumber>? oldBoard;
  List<NeedleBoardNumber>? newBoard;

  SelectedLocationBoardReq? selectedOldBoard;
  SelectedLocationBoardReq? selectedNewBoard;

  factory LocationData.fromJson(Map<String, dynamic> json) => LocationData(
    locationId: json["location_id"],
    locationLabel: json["location_label"],
    oldBoard: List<NeedleBoardNumber>.from(json["old_board"].map((x) => NeedleBoardNumber.fromJson(x))),
    newBoard: List<NeedleBoardNumber>.from(json["new_board"].map((x) => NeedleBoardNumber.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "location_id": locationId,
    "location_label": locationLabel,
    "old_board": oldBoard == null ? [] : List<dynamic>.from(oldBoard!.map((x) => x.toJson())),
    "new_board": newBoard == null ? [] : List<dynamic>.from(newBoard!.map((x) => x.toJson())),
  };
}

class SelectedLocationBoardReq {
  SelectedLocationBoardReq({
    this.index,
    this.selectedOldBoard,
    this.selectedNewBoard
  });

  int? index;
  List<NeedleBoardNumber>? selectedOldBoard = [];
  List<NeedleBoardNumber>? selectedNewBoard = [];
}