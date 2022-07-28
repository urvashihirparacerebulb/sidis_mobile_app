import 'dart:convert';

import 'package:get/get.dart';
import 'package:my_projects/models/activities_response_model.dart';
import 'package:my_projects/models/plants_response_model.dart';
import 'package:my_projects/utility/common_methods.dart';

import '../configurations/api_service.dart';
import '../configurations/config_file.dart';
import 'package:dio/dio.dart' as dio;

import '../models/business_data_model.dart';
import '../models/machines_response_model.dart';
import 'authentication_controller.dart';

class DropDownDataController extends GetxController {
  static DropDownDataController get to => Get.find();
  RxList<BusinessData>? bussinessData =  RxList<BusinessData>();
  RxList<CompanyBusinessPlant>? companyBusinessPlants = RxList<CompanyBusinessPlant>();
  RxList<MachineData>? machinesList = RxList<MachineData>();
  RxList<MachineData>? subMachinesList = RxList<MachineData>();
  RxList intervalList = [].obs;

  void getBusinesses() {
    bussinessData!.clear();
    apiServiceCall(
      params: {
        "user_id": getLoginData()!.userdata!.first.id,
        "group_id": getLoginData()!.userdata!.first.groupId
      },
      serviceUrl: ApiConfig.businessListURL,
      success: (dio.Response<dynamic> response) {
        BusinessDataResponse businessDataResponse =
        BusinessDataResponse.fromJson(jsonDecode(response.data));
        bussinessData!.addAll(businessDataResponse.bussinessData ?? []);
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

  void getCompanyPlants({String? businessId}) {
    companyBusinessPlants!.clear();
    apiServiceCall(
      params: {
        "user_id": getLoginData()!.userdata!.first.id,
        "group_id": getLoginData()!.userdata!.first.groupId,
        "bussiness_id": businessId
      },
      serviceUrl: ApiConfig.plantsListURL,
      success: (dio.Response<dynamic> response) {
        PlantsResponseModel plantsResponseModel =
        PlantsResponseModel.fromJson(jsonDecode(response.data));
        companyBusinessPlants!.addAll(plantsResponseModel.companyBusinessPlants ?? []);
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

  void getMachines({String? plantId}) {
    machinesList!.clear();
    apiServiceCall(
      params: {
        "user_id": getLoginData()!.userdata!.first.id,
        "group_id": getLoginData()!.userdata!.first.groupId,
        "plant_id": plantId
      },
      serviceUrl: ApiConfig.machineListURL,
      success: (dio.Response<dynamic> response) {
        MachineResponseModel machineResponseModel =
        MachineResponseModel.fromJson(jsonDecode(response.data));
        machinesList!.addAll(machineResponseModel.machineData ?? []);
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

  void getSubMachines({String? plantId,int? machineId}) {
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
        SubMachineResponseModel subMachineResponseModel =
        SubMachineResponseModel.fromJson(jsonDecode(response.data));
        subMachinesList!.addAll(subMachineResponseModel.submachineArray ?? []);
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

  void getIntervalList() {
    apiServiceCall(
      params: {
        "user_id": getLoginData()!.userdata!.first.id,
      },
      serviceUrl: ApiConfig.intervalListURL,
      success: (dio.Response<dynamic> response) {
        IntervalResponseModel intervalResponseModel =
        IntervalResponseModel.fromJson(jsonDecode(response.data));
        intervalList.addAll(intervalResponseModel.interval ?? []);
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }
}