import 'dart:convert';

import 'package:get/get.dart';

import '../configurations/api_service.dart';
import '../configurations/config_file.dart';
import '../models/part_response_model.dart';
import '../utility/common_methods.dart';
import 'package:dio/dio.dart' as dio;

import 'authentication_controller.dart';

class PartController extends GetxController {
  static PartController get to => Get.find();

  RxList<PartArray> allPartList = RxList<PartArray>();

  void getPartList({String machineId = ""}) {
    allPartList.clear();
    apiServiceCall(
      params: {
        "machine_id": machineId,
        "user_id": getLoginData()!.userdata!.first.id,
        "group_id": getLoginData()!.userdata!.first.groupId
      },
      serviceUrl: ApiConfig.getPartDataURL,
      success: (dio.Response<dynamic> response) {
        PartResponseModel partResponseModel = PartResponseModel.fromJson(jsonDecode(response.data));
        allPartList.addAll(partResponseModel.data?.partArray ?? []);
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }
}
