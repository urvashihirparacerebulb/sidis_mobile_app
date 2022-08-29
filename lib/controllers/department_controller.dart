import 'dart:convert';

import 'package:get/get.dart';
import 'package:my_projects/models/department_response_model.dart';

import '../configurations/api_service.dart';
import '../configurations/config_file.dart';
import '../utility/common_methods.dart';
import 'package:dio/dio.dart' as dio;

import 'authentication_controller.dart';

class DepartmentController extends GetxController {
  static DepartmentController get to => Get.find();

  RxList<Department>? departmentData = RxList<Department>();
  RxList<Department>? subDepartmentData = RxList<Department>();

  void getDepartment({String? soleId, Function? callback}) {
    departmentData!.clear();
    apiServiceCall(
      params: {
        "user_id": getLoginData()!.userdata!.first.id,
        "group_id": getLoginData()!.userdata!.first.groupId,
        "sole_id": soleId
      },
      serviceUrl: ApiConfig.departmentListURL,
      success: (dio.Response<dynamic> response) {
        DepartmentResponseModel departmentResponse =
        DepartmentResponseModel.fromJson(jsonDecode(response.data));
        departmentData!.addAll(departmentResponse.data?.departmentData ?? []);
        callback!();
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

  void getSubDepartment({String? departmentId, Function? callback}) {
    subDepartmentData!.clear();
    apiServiceCall(
      params: {
        "user_id": getLoginData()!.userdata!.first.id,
        "group_id": getLoginData()!.userdata!.first.groupId,
        "department_id": departmentId
      },
      serviceUrl: ApiConfig.subDepartmentListURL,
      success: (dio.Response<dynamic> response) {
        DepartmentResponseModel departmentResponse =
        DepartmentResponseModel.fromJson(jsonDecode(response.data));
        subDepartmentData!.addAll(departmentResponse.data?.departmentData ?? []);
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