import 'dart:convert';

import 'package:get/get.dart';
import 'package:my_projects/models/activities_response_model.dart';

import '../configurations/api_service.dart';
import '../configurations/config_file.dart';
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
}
