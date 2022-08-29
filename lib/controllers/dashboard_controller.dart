import 'dart:convert';
import 'package:get/get.dart';
import '../configurations/api_service.dart';
import '../configurations/config_file.dart';
import '../models/chart_data_model.dart';
import '../utility/common_methods.dart';
import 'package:dio/dio.dart' as dio;

import 'authentication_controller.dart';

class DashboardController extends GetxController {
  static DashboardController get to => Get.find();

  Rx<ChartResponse> abnormalitiesCharts = ChartResponse().obs;
  Rx<ChartResponse> kaizenCharts = ChartResponse().obs;
  var currentDate = DateTime.now();
  DateTime pastMonth = DateTime.now().subtract(const Duration(days: 120));

  void getAbnormalitiesChartData() {
    apiServiceCall(
      params: {
        "user_id": getLoginData()!.userdata!.first.id,
        "group_id": getLoginData()!.userdata!.first.groupId,
        "startdate": "${pastMonth.year}-${pastMonth.month}-${pastMonth.day}",
        "enddate": "${currentDate.year}-${currentDate.month}-${currentDate.day}",
        "company_id": getLoginData()!.currentPlants!.first.companyId,
        "bussiness_id": getLoginData()!.currentPlants!.first.bussinessId,
        "plant_id": getLoginData()!.currentPlants!.first.plantId
      },
      serviceUrl: ApiConfig.getAbnormalityGraphURL,
      success: (dio.Response<dynamic> response) {
        ChartResponseModel abnormalitiesGraphData = ChartResponseModel.fromJson(jsonDecode(response.data));
        abnormalitiesCharts.value = abnormalitiesGraphData.data!;
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

  void getKaizenChartData() {
    apiServiceCall(
      params: {
        "user_id": getLoginData()!.userdata!.first.id,
        "group_id": getLoginData()!.userdata!.first.groupId,
        "startdate": "${pastMonth.year}-${pastMonth.month}-${pastMonth.day}",
        "enddate": "${currentDate.year}-${currentDate.month}-${currentDate.day}",
        "company_id": getLoginData()!.currentPlants!.first.companyId,
        "bussiness_id": getLoginData()!.currentPlants!.first.bussinessId,
        "plant_id": getLoginData()!.currentPlants!.first.plantId
      },
      serviceUrl: ApiConfig.getKaizenGraphURL,
      success: (dio.Response<dynamic> response) {
        ChartResponseModel abnormalitiesGraphData = ChartResponseModel.fromJson(jsonDecode(response.data));
        kaizenCharts.value = abnormalitiesGraphData.data!;
        getAbnormalitiesChartData();
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }
}