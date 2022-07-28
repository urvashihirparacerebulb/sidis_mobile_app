import 'package:flutter/material.dart';

import '../controllers/general_controller.dart';
import '../utility/color_utility.dart';

class ConvertTheme{
  Color getBackGroundColor() {
    return GeneralController.to.isDarkMode.value ? darkThemePrimaryColor : bgColor;
  }

  Color getTextFiledBackGroundColor() {
    return GeneralController.to.isDarkMode.value ? darkThemePrimaryColor : textFieldColor;
  }

  Color getWhiteToFontColor() {
    return GeneralController.to.isDarkMode.value ? whiteColor : fontColor;
  }

  Color getFontToWhiteColor() {
    return GeneralController.to.isDarkMode.value ? fontColor : whiteColor;
  }
}