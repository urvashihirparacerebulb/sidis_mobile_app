import 'dart:convert';

import 'package:get/get.dart';
import 'package:my_projects/models/activities_response_model.dart';
import 'package:my_projects/models/boolean_response_model.dart';

import '../configurations/api_service.dart';
import '../configurations/config_file.dart';
import '../models/abnormality_response_model.dart';
import '../utility/common_methods.dart';
import 'authentication_controller.dart';
import 'package:dio/dio.dart' as dio;

class AbnormalityController extends GetxController {
  static AbnormalityController get to => Get.find();

  RxList<AbnormalityType>? abnormalityTypeData = RxList<AbnormalityType>();
  RxList<Abnormality>? allAbnormalities = RxList<Abnormality>();
  RxList<Abnormality>? searchAllAbnormalities = RxList<Abnormality>();
  RxBool loadingForAbnormality = false.obs;
  Rx<AbnormalityDetail> abnormalityDetail = AbnormalityDetail().obs;

  void getAbnormalityType({Function? callback}) {
    abnormalityTypeData!.clear();
    apiServiceCall(
      params: {},
      serviceUrl: ApiConfig.getAbnormalityTypeURL,
      success: (dio.Response<dynamic> response) {
        AbnormalityTypeResponseModel abnormalityTypeResponse =
        AbnormalityTypeResponseModel.fromJson(jsonDecode(response.data));
        abnormalityTypeData!.addAll(abnormalityTypeResponse.data?.typeData ?? []);
        callback!();
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: false,
      methodType: ApiConfig.methodPOST,
    );
  }

  void getAbnormalityLists() {
    loadingForAbnormality.value = true;
    allAbnormalities!.clear();
    searchAllAbnormalities!.clear();
    apiServiceCall(
      params: {
        "user_id": getLoginData()!.userdata!.first.id,
        "group_id": getLoginData()!.userdata!.first.groupId,
      },
      serviceUrl: ApiConfig.abnormalityListURL,
      success: (dio.Response<dynamic> response) {
        AbnormalityResponseModel abnormalityResponseModel =
        AbnormalityResponseModel.fromJson(jsonDecode(response.data));
        allAbnormalities!.addAll(abnormalityResponseModel.data?.data ?? []);
        searchAllAbnormalities?.value = List.from(allAbnormalities!);
        loadingForAbnormality.value = false;
      },
      error: (dio.Response<dynamic> response) {
        loadingForAbnormality.value = false;
        errorHandling(response);
      },
      isProgressShow: true,
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
        getAbnormalityLists();
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

  void getAbnormalityByDetail({String? abnormalityId,Function? callback}) {
    apiServiceCall(
      params: {
        "user_id": getLoginData()!.userdata!.first.id,
        "abnormality_id": abnormalityId,
      },
      serviceUrl: ApiConfig.getAbnormalityDetailURL,
      success: (dio.Response<dynamic> response) {
        AbnormalityDetailResponse abnormalityDetailResponse =
        AbnormalityDetailResponse.fromJson(jsonDecode(response.data));
        abnormalityDetail.value = abnormalityDetailResponse.data!;
        callback!();
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

}
