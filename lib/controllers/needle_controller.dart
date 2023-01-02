import 'dart:convert';

import 'package:get/get.dart';

import '../configurations/api_service.dart';
import '../configurations/config_file.dart';
import '../models/needle_response_model.dart';
import '../modules/dashboard/needle/add_needle_board_view.dart';
import '../modules/dashboard/needle/add_needle_record_view.dart';
import '../utility/common_methods.dart';
import 'authentication_controller.dart';
import 'package:dio/dio.dart' as dio;

class NeedleController extends GetxController {
  static NeedleController get to => Get.find();

  RxList<NeedleRecord> needleRecordList = RxList<NeedleRecord>();
  RxList<NeedleBoardNumber> needleBoardList = RxList<NeedleBoardNumber>();
  RxList<ChangeStatus> changeStatusList = RxList<ChangeStatus>();
  RxList<LineData> lineDataList = RxList<LineData>();
  RxList<LoomsData> loomsDataList = RxList<LoomsData>();
  RxList<LocationData> machineLocationList = RxList<LocationData>();
  RxList<NeedleBoard> needleBoards = RxList<NeedleBoard>();
  RxList<String> locationIds = RxList<String>();
  Rx<NeedleRecordDetail> selectedNeedleRecord = NeedleRecordDetail().obs;

  void getNeedleRecordListData() {
    apiServiceCall(
      params: {
        "group_id": getLoginData()!.userdata!.first.groupId,
        "company_id": (getLoginData()!.currentPlants != null && getLoginData()!.currentPlants!.isNotEmpty) ? getLoginData()!.currentPlants?.first.companyId : "",
        "business_id": (getLoginData()!.currentPlants != null && getLoginData()!.currentPlants!.isNotEmpty) ? getLoginData()!.currentPlants?.first.bussinessId : "",
        "plant_id": (getLoginData()!.currentPlants != null && getLoginData()!.currentPlants!.isNotEmpty) ? getLoginData()!.currentPlants?.first.plantId : ""
      },
      serviceUrl: ApiConfig.needleRecordListURL,
      success: (dio.Response<dynamic> response) {
        NeedleRecordListResponseModel needleRecordListResponseModel = NeedleRecordListResponseModel.fromJson(jsonDecode(response.data));
        needleRecordList.value = needleRecordListResponseModel.data!.data!;
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

  void getNeedleBoardListData() {
    apiServiceCall(
      params: {
        "group_id": getLoginData()!.userdata!.first.groupId,
        "company_id": (getLoginData()!.currentPlants != null && getLoginData()!.currentPlants!.isNotEmpty) ? getLoginData()!.currentPlants?.first.companyId : "",
        "business_id": (getLoginData()!.currentPlants != null && getLoginData()!.currentPlants!.isNotEmpty) ? getLoginData()!.currentPlants?.first.bussinessId : "",
        "plant_id": (getLoginData()!.currentPlants != null && getLoginData()!.currentPlants!.isNotEmpty) ? getLoginData()!.currentPlants?.first.plantId : ""
      },
      serviceUrl: ApiConfig.needleBoardListURL,
      success: (dio.Response<dynamic> response) {
        NeedleBoardListResponseModel needleBoardListResponseModel = NeedleBoardListResponseModel.fromJson(jsonDecode(response.data));
        needleBoards.value = needleBoardListResponseModel.data!.data!;
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

  void getNeedleBoardNumber({String companyId = "",String plantId = "", String businessId = ""}) {
    needleBoardList.clear();
    apiServiceCall(
      params: {
        "company_id": companyId,
        "business_id": businessId,
        "plant_id": plantId
      },
      serviceUrl: ApiConfig.needleBoardNumberURL,
      success: (dio.Response<dynamic> response) {
        NeedleBoardNumberResponseModel needleBoardNumberResponseModel = NeedleBoardNumberResponseModel.fromJson(jsonDecode(response.data));
        needleBoardList.value = needleBoardNumberResponseModel.data!.boardData ?? [];
        if(changeStatusList.isEmpty) {
          getNeedleChangeStatus();
        }
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST
    );
  }

  void getNeedleChangeStatus() {
    apiServiceCall(
      params: {
      },
      serviceUrl: ApiConfig.needleChangeStatusURL,
      success: (dio.Response<dynamic> response) {
        ChangeStatusResponseModel changeStatusResponseModel = ChangeStatusResponseModel.fromJson(jsonDecode(response.data));
        changeStatusList.value = changeStatusResponseModel.data!.needlesChangedStatusData ?? [];
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: false,
      methodType: ApiConfig.methodPOST
    );
  }

  void getBoardRecordDetail({String? boardId,Function? callback}) {
    apiServiceCall(
        params: {
          "board_record_id": boardId,
          "manage_user_id": getLoginData()!.userdata!.first.id.toString()
        },
        serviceUrl: ApiConfig.getRecordBoardDetailURL,
        success: (dio.Response<dynamic> response) {
          NeedleRecordDetailResponseModel needleRecordDetailResponseModel = NeedleRecordDetailResponseModel.fromJson(jsonDecode(response.data));
          selectedNeedleRecord.value = needleRecordDetailResponseModel.data!;
          callback!();
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  void deleteNeedleBoard({String? boardId}) {
    apiServiceCall(
      params: {
        "id": boardId,
        "manage_user_id": getLoginData()!.userdata?.first.id
      },
      serviceUrl: ApiConfig.deleteNeedleBoardURL,
      success: (dio.Response<dynamic> response) {
        showSnackBar(title: ApiConfig.success, message: "Deleted Successfully");
        getNeedleBoardListData();
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST
    );
  }

  void deleteNeedleBoardRecord({String? boardRecordId}) {
    apiServiceCall(
      params: {
        "id": boardRecordId
      },
      serviceUrl: ApiConfig.deleteNeedleBoardRecordURL,
      success: (dio.Response<dynamic> response) {
        showSnackBar(title: ApiConfig.success, message: "Deleted Successfully");
        getNeedleRecordListData();
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST
    );
  }

  void getLines({String? companyId, businessId, plantId}) {
    apiServiceCall(
      params: {
        "company_id": companyId,
        "business_id": businessId,
        "plant_id": plantId
      },
      serviceUrl: ApiConfig.getLinesURL,
      success: (dio.Response<dynamic> response) {
        LineResponseModel lineResponseModel = LineResponseModel.fromJson(jsonDecode(response.data));
        lineDataList.value = lineResponseModel.data!.lineData ?? [];
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: false,
      methodType: ApiConfig.methodPOST
    );
  }

  void getLoomsByLine({String? companyId, businessId, plantId,lineId}) {
    apiServiceCall(
      params: {
        "company_id": companyId,
        "business_id": businessId,
        "plant_id": plantId,
        "line_id": lineId
      },
      serviceUrl: ApiConfig.getLoomsURL,
      success: (dio.Response<dynamic> response) {
        LoomsResponseModel loomsResponseModel = LoomsResponseModel.fromJson(jsonDecode(response.data));
        loomsDataList.value = loomsResponseModel.data!.loopsData ?? [];
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: false,
      methodType: ApiConfig.methodPOST
    );
  }

  void getMachineLocations({String? companyId, businessId, plantId,date,lineId,loomID}) {
    apiServiceCall(
      params: {
        "company_id": companyId,
        "business_id": businessId,
        "plant_id": plantId,
        "needleboarddate": date,
        "line_id": lineId,
        "looms_id": loomID
      },
      serviceUrl: ApiConfig.getMachineLocationURL,
      success: (dio.Response<dynamic> response) {
        MachineLocationResponseModel machineLocationResponseModel = MachineLocationResponseModel.fromJson(jsonDecode(response.data));
        machineLocationList.value = machineLocationResponseModel.data!.location ?? [];
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: false,
      methodType: ApiConfig.methodPOST
    );
  }

  Future<void> addNeedleRecordData({AddNeedleRecordRequest? addNeedleRecordRequest,bool isEdit = false}) async {
    dio.FormData formData = dio.FormData.fromMap({
      "company_id": addNeedleRecordRequest?.companyId,
      "plant_id": addNeedleRecordRequest?.plantId,
      "business_id": addNeedleRecordRequest?.businessId,
      "needle_record_add_date": addNeedleRecordRequest?.needleRecordAddDate,
      "needle_status": addNeedleRecordRequest?.needleStatus,
      "needle_board_number": addNeedleRecordRequest?.needleBoardNumber,
      "needle_consumed": addNeedleRecordRequest?.needleConsumed,
      "user_id": addNeedleRecordRequest?.userId
    });
    if(isEdit){
      formData.fields.add(MapEntry("needlerecordid", addNeedleRecordRequest!.needleRecordId!.toString()));
    }
    apiServiceCall(
      params: {},
      formValues: formData,
      serviceUrl: ApiConfig.manageNeedleRecordURL,
      success: (dio.Response<dynamic> response) {
        getNeedleRecordListData();
        Get.back();
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST
    );
  }

  Future<void> addNeedleBoardData({AddNeedleBoardRequest? addNeedleRecordRequest}) async {
    dio.FormData formData = dio.FormData.fromMap({
      "company_id": addNeedleRecordRequest?.companyId,
      "plant_id": addNeedleRecordRequest?.plantId,
      "business_id": addNeedleRecordRequest?.businessId,
      "line_id": addNeedleRecordRequest?.lineId,
      "looms_id": addNeedleRecordRequest?.loomId,
      "board_confirm": addNeedleRecordRequest?.boardConfirm,
      "location_id": addNeedleRecordRequest?.locationId,
      "needleboarddate": addNeedleRecordRequest?.needleBoardDate,
      "manage_user_id": addNeedleRecordRequest?.userId,
    });
    for (var element in NeedleController.to.machineLocationList) {
      if(element.selectedOldBoard != null) {
        if (element.selectedOldBoard!.selectedOldBoard!.isNotEmpty) {
          formData.fields.add(MapEntry(
              'old_needle_board${(element.selectedOldBoard?.index)! + 1}',
              element.selectedOldBoard!
                  .selectedOldBoard!
                  .map((e) => e.boardId)
                  .toList()
                  .join(",")));
        }
      }

      if(element.selectedNewBoard != null) {
        if (element.selectedNewBoard!.selectedNewBoard!.isNotEmpty) {
          formData.fields.add(MapEntry(
              'new_needle_board${(element.selectedNewBoard?.index)! + 1}',
              element.selectedNewBoard!
                  .selectedNewBoard!
                  .map((e) => e.boardId)
                  .toList()
                  .join(",")));
        }
      }
    }
    apiServiceCall(
      params: {},
      formValues: formData,
      serviceUrl: ApiConfig.manageNeedleBoardURL,
      success: (dio.Response<dynamic> response) {
        getNeedleBoardListData();
        Get.back();
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST
    );
  }

}