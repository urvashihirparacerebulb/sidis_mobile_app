import 'dart:convert';

import 'package:get/get.dart';
import 'package:my_projects/models/activities_response_model.dart';
import 'package:my_projects/models/plants_response_model.dart';
import 'package:my_projects/utility/common_methods.dart';

import '../configurations/api_service.dart';
import '../configurations/config_file.dart';
import 'package:dio/dio.dart' as dio;
import '../models/machines_response_model.dart';
import 'authentication_controller.dart';

class DropDownDataController extends GetxController {
  static DropDownDataController get to => Get.find();
  RxList<CompanyBusinessPlant>? companyBusinessPlants = RxList<CompanyBusinessPlant>();
  RxList<MachineData>? machinesList = RxList<MachineData>();
  RxList<MachineData>? subMachinesList = RxList<MachineData>();
  RxList<ActivityData>? activityData = RxList<ActivityData>();

  void getCompanyPlants({String? businessId,Function? successCallback}) {
    companyBusinessPlants!.clear();
    apiServiceCall(
      params: {
        "user_id": getLoginData()!.userdata!.first.id,
        "group_id": getLoginData()!.userdata!.first.groupId,
        "bussiness_id": businessId
      },
      serviceUrl: ApiConfig.plantsListURL,
      success: (dio.Response<dynamic> response) {
        PlantsResponse plantsResponseModel =
        PlantsResponse.fromJson(jsonDecode(response.data));
        companyBusinessPlants!.addAll(plantsResponseModel.data?.companyBusinessPlants ?? []);
        successCallback!();
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

  void getMachines({String? plantId,Function? successCallback}) {
    machinesList!.clear();
    apiServiceCall(
      params: {
        "user_id": getLoginData()!.userdata!.first.id,
        "group_id": getLoginData()!.userdata!.first.groupId,
        "plant_id": plantId
      },
      serviceUrl: ApiConfig.machineListURL,
      success: (dio.Response<dynamic> response) {
        MachineResponse machineResponseModel =
        MachineResponse.fromJson(jsonDecode(response.data));
        machinesList!.addAll(machineResponseModel.data?.machineData ?? []);
        successCallback!();
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

  void getSubMachines({String? plantId,int? machineId,Function? successCallback}) {
    subMachinesList!.clear();
    apiServiceCall(
      params: {
        "user_id": getLoginData()!.userdata!.first.id,
        "group_id": getLoginData()!.userdata!.first.groupId,
        "plant_id": plantId,
        "machine_id": machineId
      },
      serviceUrl: ApiConfig.subMachineListURL,
      success: (dio.Response<dynamic> response) {
        SubMachineResponse subMachineResponseModel =
        SubMachineResponse.fromJson(jsonDecode(response.data));
        subMachinesList!.value = subMachineResponseModel.data?.submachineArray ?? [];
        successCallback!();
      },
      error: (dio.Response<dynamic> response) {
        // errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

  void getActivityCheckList({String? businessId,machineId,subMachineId,intervalId,date}) {
    activityData!.clear();
    apiServiceCall(
      params: {
        "user_id": getLoginData()!.userdata!.first.id,
        "group_id": getLoginData()!.userdata!.first.groupId,
        "bussiness_id": businessId,
        "machine_id": machineId,
        "submachine_id": subMachinesList,
        "interval_id": intervalId,
        "date": date
      },
      serviceUrl: ApiConfig.activityListURL,
      success: (dio.Response<dynamic> response) {
        ActivityResponse activityResponse =
        ActivityResponse.fromJson(jsonDecode(response.data));
        activityData!.addAll(activityResponse.data?.activitydata ?? []);
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }
}
