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
  Rx<AssignAbnormalityResponse> assignedAbnormalityDetail = AssignAbnormalityResponse().obs;
  RxList<FilterDepartment>? abnormalityFilterDepartments = RxList<FilterDepartment>();
  RxList<UserFilterResponse>? userFilters = RxList<UserFilterResponse>();
  RxList<String>? allTags = RxList<String>();

  void getAbnormalityType({Function? callback}) {
    apiServiceCall(
      params: {},
      serviceUrl: ApiConfig.getAbnormalityTypeURL,
      success: (dio.Response<dynamic> response) {
        AbnormalityTypeResponseModel abnormalityTypeResponse =
        AbnormalityTypeResponseModel.fromJson(jsonDecode(response.data));
        abnormalityTypeData!.value = abnormalityTypeResponse.data?.typeData ?? [];
        callback!();
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: false,
      methodType: ApiConfig.methodPOST,
    );
  }

  void getFilterDepartment({Function? callback}) {
    apiServiceCall(
      params: {
        "user_id": getLoginData()!.userdata!.first.id,
        "group_id": getLoginData()!.userdata!.first.groupId,
      },
      serviceUrl: ApiConfig.getFilterDepartmentURL,
      success: (dio.Response<dynamic> response) {
        FilterDepartmentResponseModel filterDepartmentResponseModel =
        FilterDepartmentResponseModel.fromJson(jsonDecode(response.data));
        abnormalityFilterDepartments!.value = filterDepartmentResponseModel.data ?? [];
        callback!();
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: false,
      methodType: ApiConfig.methodPOST,
    );
  }

  void getAbnormalityLists(Map<String, dynamic> params, {Function? callback}) {
    loadingForAbnormality.value = true;
    allAbnormalities!.clear();
    searchAllAbnormalities!.clear();
    apiServiceCall(
      params: params,
      serviceUrl: ApiConfig.abnormalityListURL,
      success: (dio.Response<dynamic> response) {
        AbnormalityResponseModel abnormalityResponseModel =
        AbnormalityResponseModel.fromJson(jsonDecode(response.data));
        allAbnormalities!.addAll(abnormalityResponseModel.data?.data ?? []);
        searchAllAbnormalities?.value = List.from(allAbnormalities!);
        loadingForAbnormality.value = false;
        callback!();
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
        getAbnormalityLists({
          "user_id": getLoginData()!.userdata!.first.id,
          "group_id": getLoginData()!.userdata!.first.groupId,
        },callback: (){});
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

  void deleteAbnormality({String? abnormalityId}) {
    apiServiceCall(
      params: {
        "abnormality_id": abnormalityId,
        "manage_user_id": getLoginData()!.userdata?.first.id
      },
      serviceUrl: ApiConfig.deleteAbnormalityURL,
      success: (dio.Response<dynamic> response) {
        showSnackBar(title: ApiConfig.success, message: "Deleted Successfully");
        getAbnormalityLists({
          "user_id": getLoginData()!.userdata!.first.id,
          "group_id": getLoginData()!.userdata!.first.groupId,
        },callback: (){});
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

  void getUserFilters({Function? callback}) {
    apiServiceCall(
      params: {
        "user_id": getLoginData()!.userdata!.first.id
      },
      serviceUrl: ApiConfig.getUserFiltersURL,
      success: (dio.Response<dynamic> response) {
        UserFilterResponseModel userFilterResponseModel =
        UserFilterResponseModel.fromJson(jsonDecode(response.data));
        userFilters!.value = userFilterResponseModel.data ?? [];
        callback!();
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: false,
      methodType: ApiConfig.methodPOST,
    );
  }

  void fetchAbnormalitiesTags({Function? callback}) {
    apiServiceCall(
      params: {
        "user_id": getLoginData()!.userdata!.first.id
      },
      serviceUrl: ApiConfig.fetchAbnormalitiesTagsURL,
      success: (dio.Response<dynamic> response) {
        TagResponse userFilterResponseModel =
        TagResponse.fromJson(jsonDecode(response.data));
        allTags!.addAll(userFilterResponseModel.data.values) ;
        callback!();
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: false,
      methodType: ApiConfig.methodPOST,
    );
  }

  void getAssignAbnormalityData({Abnormality? abnormality, Function? callback}) {
    apiServiceCall(
      params: {
        "abnormality_id": abnormality?.abnormalityId,
        "group_id": getLoginData()?.userdata?.first.groupId,
        "department_id": abnormality?.departmentId,
        "subdepartment_id": abnormality?.subDepartmentId,
        "plant_id": abnormality?.plantId,
        "company_id": abnormality?.companyId,
      },
      serviceUrl: ApiConfig.getAbnormalityAssignDataURL,
      success: (dio.Response<dynamic> response) {
        AssignAbnormalityResponseModel assignAbnormalityResponse =
        AssignAbnormalityResponseModel.fromJson(jsonDecode(response.data));
        assignedAbnormalityDetail.value = assignAbnormalityResponse.data!;
        callback!();
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

  void assignAbnormality({
    List<int>? assignIds, Function? callback,
    String? abnormalityId, assignDate,assignTime,tag,subDId, dId}) {
    apiServiceCall(
      params: {
        "assign_to": "1",
        "manage_user_id": getLoginData()?.userdata?.first.id,
        "assign_to_user_id": assignIds?.join(","),
        "form_id": abnormalityId,
        "assign_date": assignDate,
        "assign_time": assignTime,
        "abnormality_tag": tag,
        "subdepartment_id": subDId,
        "department_id": '$dId - department'
      },
      serviceUrl: ApiConfig.assignAbnormalityURL,
      success: (dio.Response<dynamic> response) {
        showSnackBar(title: ApiConfig.success, message: "Assigned Successfully");
        callback!();
        getAbnormalityLists({
          "user_id": getLoginData()!.userdata!.first.id,
          "group_id": getLoginData()!.userdata!.first.groupId,
        },callback: (){});
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

  void abnormalityNotResolveAPI({
    Function? callback,
    int? assignId}) {
    apiServiceCall(
      params: {
        "manage_user_id": getLoginData()?.userdata?.first.id,
        "assign_id": assignId
      },
      serviceUrl: ApiConfig.abnormalityNotSolveURL,
      success: (dio.Response<dynamic> response) {
        showSnackBar(title: ApiConfig.success, message: "Unable to complete this abnormality");
        callback!();
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

  void completeAbnormality({
    Function? callback,
    String? completeDate,
    completeTime,actualSolution,
    int? abnormalityId}) {
    apiServiceCall(
      params: {
        "abnormality_id": abnormalityId,
        "complete_date": completeDate,
        "complete_time": completeTime,
        "actual_solution": actualSolution,
        "user_id":getLoginData()!.userdata?.first.id
      },
      serviceUrl: ApiConfig.completeAbnormalityURL,
      success: (dio.Response<dynamic> response) {
        showSnackBar(title: ApiConfig.success, message: "Completed Successfully");
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
