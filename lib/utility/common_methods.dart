import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../configurations/config_file.dart';
import '../main.dart';
import '../models/login_response_model.dart';
import 'constants.dart';

isNotEmptyString(String? string) {
  return string != null && string.isNotEmpty;
}

showSnackBar({required String title, required String message}) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: title.isEmpty || title == ApiConfig.warning
          ? const Color(0xffFFCC00)
          : title == ApiConfig.success
          ? Colors.green
          : Colors.red,
      textColor: Colors.white,
      fontSize: 12.0);
}

writeThemePref({required value}) {
  getPreferences.write("theme", value);
}

readThemePref() {
  return getPreferences.read("theme") ?? ThemeSettingEnum.SystemDefault;
}

writeDataInPref({required String key, required bool value}) {
  getPreferences.write(key, value);
}

bool readDataFromPref(String key) {
  return getPreferences.read(key) ?? false;
}

setIsLogin({required bool isLogin}) {
  getPreferences.write('isLogin', isLogin);
}

bool getIsLogin() {
  return (getPreferences.read('isLogin') ?? false);
}

getObject(String key) {
  return getPreferences.read(key) != null
      ? json.decode(getPreferences.read(key))
      : null;
}

setObject(String key, value) {
  getPreferences.write(key, json.encode(value));
}

LoginResponseModel? getLoginData() {
  if (getObject(ApiConfig.loginPref) != null) {
    LoginResponseModel loginResponse =
    LoginResponseModel.fromJson(getObject(ApiConfig.loginPref));
    return loginResponse;
  } else {
    return null;
  }
}

confirmationAlertDialog({String? title, required String message, Function? buttonCallBack, Function? noButtonCallBack}) {
  Get.dialog(
    CupertinoAlertDialog(
      title: Text(
        isNotEmptyString(title) ? title! : appName.capitalize!,
        // style: primary18PxW700,
      ),
      content: Text(
        message,
        // style: black14PxNormal,
      ),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text("No"),
          onPressed: () {
            Get.back();
            if (noButtonCallBack != null) {
              noButtonCallBack();
            }
          },
        ),
        CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text("Yes"),
            onPressed: () {
              buttonCallBack!();
            }
        ),
      ],
    ),
    barrierDismissible: false,
    transitionCurve: Curves.easeInCubic,
    transitionDuration: const Duration(milliseconds: 400),
  );
}