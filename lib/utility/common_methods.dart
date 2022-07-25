import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../configurations/config_file.dart';
import '../main.dart';
import '../models/login_response_model.dart';

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
