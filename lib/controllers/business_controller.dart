import 'dart:convert';

import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import '../configurations/api_service.dart';
import '../configurations/config_file.dart';
import '../models/activities_response_model.dart';
import '../models/business_data_model.dart';
import '../utility/common_methods.dart';

import 'authentication_controller.dart';

class BusinessController extends GetxController {
  static BusinessController get to => Get.find();
  RxList<BusinessData>? businessData =  RxList<BusinessData>();
  RxList<String> intervalList = RxList<String>();

  void getBusinesses() {
    businessData!.clear();
    apiServiceCall(
      params: {
        "user_id": getLoginData()!.userdata!.first.id,
        "group_id": getLoginData()!.userdata!.first.groupId
      },
      serviceUrl: ApiConfig.businessListURL,
      success: (dio.Response<dynamic> response) {
        BusinessDataResponseModel businessDataResponse =
        BusinessDataResponseModel.fromJson(jsonDecode(response.data));
        businessData!.addAll(businessDataResponse.data?.data ?? []);
        if(intervalList.isEmpty){
          getIntervalList();
        }
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

  void getIntervalList({bool isLoading = false}) {
    apiServiceCall(
      params: {
        "user_id": getLoginData()!.userdata!.first.id,
      },
      serviceUrl: ApiConfig.intervalListURL,
      success: (dio.Response<dynamic> response) {
        IntervalResponse intervalResponseModel =
        IntervalResponse.fromJson(jsonDecode(response.data));
        intervalList.addAll(intervalResponseModel.data!.interval!.first.values);
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: isLoading,
      methodType: ApiConfig.methodPOST,
    );
  }

}