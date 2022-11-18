import 'dart:convert';

import 'package:get/get.dart';

import '../configurations/api_service.dart';
import '../configurations/config_file.dart';
import '../models/kaizen_response_model.dart';
import '../utility/common_methods.dart';
import 'package:dio/dio.dart' as dio;

import 'authentication_controller.dart';

class KaizenController extends GetxController {
  static KaizenController get to => Get.find();

  RxList<KaizenList> kaizenList = RxList<KaizenList>();
  RxBool isKaizenLoading = false.obs;

  void getKaizenListData() {
    isKaizenLoading.value = true;
    apiServiceCall(
      params: {
        "user_id": getLoginData()!.userdata!.first.id,
        "group_id": getLoginData()!.userdata!.first.groupId
      },
      serviceUrl: ApiConfig.getKaizenListURL,
      success: (dio.Response<dynamic> response) {
        KaizenResponseModel kaizenResponseModel = KaizenResponseModel.fromJson(jsonDecode(response.data));
        isKaizenLoading.value = false;
        kaizenList.value = kaizenResponseModel.data!.data!;
      },
      error: (dio.Response<dynamic> response) {
        isKaizenLoading.value = false;
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

}