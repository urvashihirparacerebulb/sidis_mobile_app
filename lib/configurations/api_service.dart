import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:my_projects/common_widgets/common_widget.dart';
import '../main.dart';
import '../models/boolean_response_model.dart';
import '../utility/color_utility.dart';
import '../utility/common_methods.dart';
import '../utility/constants.dart';
import 'api_utility.dart';
import 'config_file.dart';

const String somethingWrong = "Something Went Wrong";
const String responseMessage = "NO RESPONSE DATA FOUND";
const String interNetMessage =
    "NO INTERNET CONNECTION, PLEASE CHECK YOUR INTERNET CONNECTION AND TRY AGAIN LATTER.";
const String connectionTimeOutMessage =
    "Opps.. Server not working or might be in maintenance .Please Try Again Later";
const String authenticationMessage =
    "The session has been Expired. Please log in again.";
const String tryAgain = "Try Again";

Map<String, dynamic>? tempParams;
FormData? tempFormData;
String? tempServiceUrl;
Function? tempSuccess;
Function? tempError;
bool? tempIsProgressShow;
bool? isTempFormData;
bool? tempIsLoading;
bool? tempIsFromLogout;
bool? tempIsHideLoader;
bool? tempIsHandleResponse;
String? tempMethodType;

///Status Code with message type array or string
// 501 : sql related error
// 401: validation array
// 201 : string error
// 400 : string error
// 200: response, string/null
// 422: array

apiServiceCall({
  required Map<String, dynamic> params,
  required String serviceUrl,
  required Function success,
  required Function error,
  required bool isProgressShow,
  required String methodType,
  bool isFromLogout = false,
  bool? isLoading,
  String? headerToken = "",
  bool? isHideLoader = true,
  bool? isHandleResponse = true,
  FormData? formValues,
}) async {
  tempParams = params;
  tempServiceUrl = serviceUrl;
  tempSuccess = success;
  tempMethodType = methodType;
  tempError = error;
  tempIsProgressShow = isProgressShow;
  tempIsLoading = isLoading;
  tempIsFromLogout = isFromLogout;
  tempIsHandleResponse = isHandleResponse;
  tempFormData = formValues;
  tempIsHideLoader = isHideLoader;

  if (await checkInternet()) {
    if (tempIsProgressShow != null && tempIsProgressShow!) {
      showProgressDialog();
    }
    Map<String, dynamic> headerParameters;
    if (headerToken == "") {
      headerParameters = {
        'Access-Control-Allow-Origin': '*',
        // "Authorization": getLoginData() != null
        //     ? getLoginData()!.token != null
        //         ? "Bearer ${getLoginData()!.token}"
        //         : ""
        //     : "",
      };
    } else {
      headerParameters = {"Authorization": "Bearer $headerToken"};
    }

    try {
      Response response;
      if (tempMethodType == ApiConfig.methodGET) {
        response = await APIProvider.getDio().get(tempServiceUrl!,
            queryParameters: tempParams,
            options: Options(headers: headerParameters));
      } else if (tempMethodType == ApiConfig.methodPUT) {
        response = await APIProvider.getDio().put(tempServiceUrl!,
            data: tempFormData ?? tempParams,
            options: Options(headers: headerParameters));
      } else if (tempMethodType == ApiConfig.methodDELETE) {
        response = await APIProvider.getDio().delete(tempServiceUrl!,
            data: tempParams, options: Options(headers: headerParameters));
      } else {
        response = await APIProvider.getDio().post(tempServiceUrl!,
            data: tempFormData ?? tempParams,
            options: Options(headers: headerParameters));
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        /// 200 : success response
        if (handleResponse(response)) {
          if (tempIsHandleResponse!) {
            BooleanResponseModel? responseData;
            responseData = BooleanResponseModel.fromJson(jsonDecode(response.data.toString()));
            if (tempIsHideLoader!) {
              hideProgressDialog();
            }
            if (responseData.status!) {
              tempSuccess!(response);
            } else {
              tempError!(response);
            }
          } else {
            if (tempIsHideLoader!) {
              hideProgressDialog();
            }
            tempSuccess!(response);
          }
        } else {
          showErrorMessage(message: somethingWrong, isRecall: true);
          tempError!(response.toString());
        }
      } else {
        if (tempIsHideLoader!) {
          hideProgressDialog();
        }

        ///statusCode 401 = Session Expired Manage Authentication/Session Expire
        if (response.statusCode == 401) {
          handleAuthentication();
        } else {
          /// statusCode 400 Bad Request - Error Message.
          tempError!(response);
        }
      }
    } on DioError catch (dioError) {
      dioErrorCall(
          dioError: dioError,
          onCallBack: (String message, bool isRecallError) {
            showErrorMessage(message: message, isRecall: isRecallError);
          });
    }
  } else {
    showErrorMessage(message: interNetMessage, isRecall: true);
  }
}

void handleAuthentication() {
  // if (!tempIsFromLogout!) {
  //   apiAlertDialog(
  //       buttonTitle: Constant.logInAgain,
  //       message: boolResponse.message ?? authenticationMessage,
  //       isShowGoBack: false,
  //       buttonCallBack: () {
  //         GeneralController.to.clearPref();
  //         setIsLogin(isLogin: false);
  //         getX.Get.offAll(() => LoginView(), transition: getX.Transition.rightToLeftWithFade);
  //       });
  // } else {
  // GeneralController.to.clearPref();
  // setIsLogin(isLogin: false);
  // getX.Get.offAll(() => LoginView(),
  //     transition: getX.Transition.rightToLeftWithFade);
  // }
}

int serviceCallCount = 0;

showErrorMessage(
    {required String message, required bool isRecall, Function? callBack}) {
  serviceCallCount = 0;
  // serviceCallCount++;
  hideProgressDialog();
  apiAlertDialog(
      buttonTitle: serviceCallCount < 3 ? tryAgain : "Restart App",
      message: message,
      buttonCallBack: () {
        if (serviceCallCount < 3) {
          if (isRecall) {
            getx.Get.back();
            apiServiceCall(
                params: tempParams!,
                serviceUrl: tempServiceUrl!,
                success: tempSuccess!,
                error: tempError!,
                isProgressShow: tempIsProgressShow!,
                methodType: tempMethodType!,
                formValues: tempFormData,
                isFromLogout: tempIsFromLogout!,
                isHideLoader: tempIsHideLoader,
                isLoading: tempIsLoading);
          } else {
            if (callBack != null) {
              callBack();
            } else {
              getx.Get.back(); // For redirecting to back screen
            }
          }
        } else {
          getx.Get.back(); // For redirecting to back screen
          getx.Get.offAll(() => const MyHomePage());
        }
      });
}

void showProgressDialog() {
  if (tempIsLoading != null) {
    tempIsLoading = true;
    // FeedListController.to.isFetching.value = true;
  }
  getx.Get.dialog(
    Center(
      child: SizedBox(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              borderRadius: commonButtonBorderRadius, color: Colors.black),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(whiteColor),
              ),
              commonVerticalSpacing(spacing: 20),
              Material(
                  color: Colors.black,
                  child: commonHeaderTitle(
                      title: "Please Wait...",
                      align: TextAlign.center,
                      isChangeColor: true,
                      color: whiteColor)),
            ],
          ),
        ),
        // height: 50.0,
        // width: 50.0,
      ),
    ),
    barrierDismissible: false,
  );
}

void hideProgressDialog() {
  if (tempIsLoading != null) {
    tempIsLoading = false;
    // FeedListController.to.isFetching.value = false;
  }
  if ((tempIsProgressShow! || tempIsHideLoader!) && getx.Get.isDialogOpen!) {
    getx.Get.back();
  }
}

dioErrorCall({required DioError dioError, required Function onCallBack}) {
  switch (dioError.type) {
    case DioErrorType.other:
    case DioErrorType.connectTimeout:
      // onCallBack(connectionTimeOutMessage, false);
      onCallBack(dioError.message, true);
      break;
    case DioErrorType.response:
    case DioErrorType.cancel:
    case DioErrorType.receiveTimeout:
    case DioErrorType.sendTimeout:
    default:
      onCallBack(dioError.message, true);
      break;
  }
}

Future<bool> checkInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

bool handleResponse(Response response) {
  try {
    if (isNotEmptyString(response.toString())) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

apiAlertDialog(
    {required String message,
    String? buttonTitle,
    Function? buttonCallBack,
    bool isShowGoBack = true}) {
  if (!getx.Get.isDialogOpen!) {
    getx.Get.dialog(
      WillPopScope(
        onWillPop: () {
          return isShowGoBack ? Future.value(true) : Future.value(false);
        },
        child: CupertinoAlertDialog(
          title: const Text(appName),
          content: Text(message),
          actions: isShowGoBack
              ? [
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    child: Text(isNotEmptyString(buttonTitle)
                        ? buttonTitle!
                        : "Try again"),
                    onPressed: () {
                      if (buttonCallBack != null) {
                        buttonCallBack();
                      } else {
                        getx.Get.back();
                      }
                    },
                  ),
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    child: const Text("Go Back"),
                    onPressed: () {
                      getx.Get.back();
                      getx.Get.back();
                    },
                  )
                ]
              : [
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    child: Text(isNotEmptyString(buttonTitle)
                        ? buttonTitle!
                        : "Try again"),
                    onPressed: () {
                      if (buttonCallBack != null) {
                        buttonCallBack();
                      } else {
                        getx.Get.back();
                      }
                    },
                  ),
                ],
        ),
      ),
      barrierDismissible: false,
      transitionCurve: Curves.easeInCubic,
      transitionDuration: const Duration(milliseconds: 400),
    );
  }
}
