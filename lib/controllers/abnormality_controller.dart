import 'dart:convert';

import 'package:get/get.dart';
import 'package:my_projects/models/activities_response_model.dart';
import 'package:my_projects/models/boolean_response_model.dart';

import '../configurations/api_service.dart';
import '../configurations/config_file.dart';
import '../utility/common_methods.dart';
import 'authentication_controller.dart';
import 'package:dio/dio.dart' as dio;

class AbnormalityController extends GetxController {
  static AbnormalityController get to => Get.find();

  RxList<AbnormalityType>? abnormalityTypeData = RxList<AbnormalityType>();

  void getAbnormalityType() {
    abnormalityTypeData!.clear();
    apiServiceCall(
      params: {},
      serviceUrl: ApiConfig.getAbnormalityTypeURL,
      success: (dio.Response<dynamic> response) {
        AbnormalityTypeResponseModel abnormalityTypeResponse =
        AbnormalityTypeResponseModel.fromJson(jsonDecode(response.data));
        abnormalityTypeData!.addAll(abnormalityTypeResponse.data?.typeData ?? []);
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: false,
      methodType: ApiConfig.methodPOST,
    );
  }

  void addEditNewAbnormality(AbnormalityRequest? abnormalityRequest) {
    apiServiceCall(
      params: abnormalityRequest!.toJson(),
      serviceUrl: ApiConfig.addNewAbnormalityURL,
      success: (dio.Response<dynamic> response) {
        BooleanResponseModel booleanResponseModel = BooleanResponseModel.fromJson(jsonDecode(response.data));
        showSnackBar(title: ApiConfig.success, message: booleanResponseModel.message ?? "");
        Get.back();
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }
}
