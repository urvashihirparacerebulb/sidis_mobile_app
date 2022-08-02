import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import '../controllers/general_controller.dart';
import '../utility/color_utility.dart';
import '../utility/common_methods.dart';
import '../utility/constants.dart';

class Themes {
  static final light = ThemeData(
    primaryColor: bgColor,
    fontFamily: 'Poppins',
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    hoverColor: Colors.transparent,
    canvasColor: Colors.transparent,
    textSelectionTheme: const TextSelectionThemeData(cursorColor: dangerColor),
    textTheme: const TextTheme(
        caption: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
  static final dark = ThemeData(
    backgroundColor: blackColor,
    unselectedWidgetColor: whiteColor,
    primaryColor: darkThemePrimaryColor,
    fontFamily: 'Poppins',
    // primarySwatch: colorCustom,
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    hoverColor: Colors.transparent,
    canvasColor: Colors.transparent,
    textTheme: const TextTheme(
        caption: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

class ThemeService {
  // bool a = readDataFromPref('isDarkMode');

  /// Load isDArkMode from local storage and if it's empty, returns false (that means default theme is light)
  bool loadThemeFromBox() => readDataFromPref(themePreference);

  /// Get isDarkMode info from local storage and return ThemeMode
  ThemeMode get theme => loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  /// Save isDarkMode to local storage
  saveThemeToBox(bool isDarkMode) =>
      writeDataInPref(key: themePreference, value: isDarkMode);
}

void systemDefaultTheme() {
  if (SchedulerBinding.instance.window.platformBrightness == Brightness.dark) {
    darkTheme();
  } else {
    lightTheme();
  }
}

void lightTheme() {
  Get.changeThemeMode(ThemeMode.light);
  ThemeService().saveThemeToBox(false);
  GeneralController.to.isDarkMode.value = false;
}

void darkTheme() {
  Get.changeThemeMode(ThemeMode.dark);
  ThemeService().saveThemeToBox(true);
  GeneralController.to.isDarkMode.value = true;
}
