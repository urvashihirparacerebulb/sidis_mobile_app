import 'dart:convert';

import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:my_projects/modules/dashboard/common_dashboard.dart';
import '../configurations/api_service.dart';
import '../configurations/config_file.dart';
import '../models/boolean_response_model.dart';
import '../models/login_response_model.dart';
import '../modules/dashboard/dashboard_view.dart';
import '../utility/common_methods.dart';

class AuthenticationController extends GetxController {
  static AuthenticationController get to => Get.find();

  void loginAPI(Map<String, dynamic> params) {
    apiServiceCall(
      params: params,
      serviceUrl: ApiConfig.loginURL,
      success: (dio.Response<dynamic> response) {
        LoginResponseModel loginResponseModel =
            LoginResponseModel.fromJson(jsonDecode(response.data));
        setObject(ApiConfig.loginPref, loginResponseModel);
        setIsLogin(isLogin: true);
        Get.offAll(() => const CommonDashboard());
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

  // void logoutAPI() {
  //   apiServiceCall(
  //     params: {},
  //     headerToken: getLoginData()!.token,
  //     serviceUrl: getDecodedURL(ApiConfig.BASE_URI) + ApiConfig.logoutURL,
  //     success: (dio.Response<dynamic> response) {
  //       BooleanResponseModel booleanResponseModel =
  //           BooleanResponseModel.fromJson(response.data);
  //       showSnackBar(
  //           title: ApiConfig.success, message: booleanResponseModel.msg ?? "");
  //       clearPref();
  //       Get.offAll(() => const LoginScreen());
  //     },
  //     error: (dio.Response<dynamic> response) {
  //       errorHandling(response);
  //     },
  //     isProgressShow: true,
  //     methodType: ApiConfig.methodGET,
  //   );
  // }

  void clearPref() {
    setIsLogin(isLogin: false);
    setObject(ApiConfig.loginPref, "");
  }
}

void errorHandling(dio.Response<dynamic> response) {
  BooleanResponseModel? responseData =
  BooleanResponseModel.fromJson(jsonDecode(response.data));
  showSnackBar(title: ApiConfig.error, message: responseData.message ?? "");
}