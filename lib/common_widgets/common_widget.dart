import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_projects/utility/color_utility.dart';

import '../modules/dashboard/dashboard_view.dart';
import '../utility/assets_utility.dart';
import '../utility/screen_utility.dart';
import '../utility/theme_utility.dart';

double commonHorizontalPadding = 10.0;
BorderRadius commonButtonBorderRadius = BorderRadius.circular(10.0);
BorderRadius commonBorderRadius = BorderRadius.circular(8.0);

Widget commonStructure({
  required BuildContext context,
  required Widget child,
  AppBar? appBar,
  Color bgColor = whiteColor,
  Widget? bottomNavigation,
}) {
  ///Pass null in appbar when it's optional ex = appBar : null
  return Stack(
    children: [
      commonAppBackground(bgColor: bgColor),
      Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        appBar: appBar,
        bottomNavigationBar: bottomNavigation,

        ///adding listView cause scroll issue
        body: Container(
          height: getScreenHeight(context),
          color: Colors.transparent,
          child: child,
        ),
      ),
    ],
  );
}

Widget commonAppBackground({Color? bgColor}) {
  return Container(
    decoration: BoxDecoration(
      color: bgColor
    ),
  );
}

Widget commonFillButtonView(
    {required BuildContext context,
      required String title,
      required Function tapOnButton,
      required bool isLoading,
      bool isLightButton = false,
      Color? color,
      Color? fontColor,
      double? height = 50.0,
      double? width}) {
  return SizedBox(
    width: width ?? MediaQuery.of(context).size.width - (commonHorizontalPadding * 2),
    height: height,
    child: ElevatedButton(
      onPressed: () {
        if (!isLoading) {
          tapOnButton();
        }
      },
      style: ElevatedButton.styleFrom(
        primary: primaryColor,
        shape: RoundedRectangleBorder(borderRadius: commonButtonBorderRadius),
        padding: EdgeInsets.symmetric(vertical: height == 50.0 ? 15 : 2),
        elevation: 0.0,
      ),
      child: Text(
        title,
        style: black15PxW800.copyWith(
            color: blackColor,
            fontWeight: isLightButton ? FontWeight.w500 : FontWeight.bold,
            fontSize: height! >= 50.0 ? 16 : 12),
      )
    )
  );
}

Widget commonBorderButtonView(
    {required BuildContext context,
      required String title,
      required Function tapOnButton,
      required bool isLoading,
      Color? color,
      double height = 50,
      IconData? iconData}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width - (commonHorizontalPadding * 2),
    height: height,
    child: ElevatedButton(
      onPressed: () {
        if (!isLoading) {
          tapOnButton();
        }
      },
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        primary: Colors.transparent,
        side: const BorderSide(
          color: blackColor,
          width: 1.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: commonBorderRadius,
        ),
        padding: EdgeInsets.symmetric(vertical: height == 50.0 ? 15 : 2),
        elevation: 0.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: black15PxW800.copyWith(
                color: blackColor,
                fontWeight: FontWeight.bold,
                fontSize: height >= 50.0 ? 16 : 12),
          ),
          iconData != null ? commonHorizontalSpacing() : const SizedBox(),
          iconData != null
              ? Icon(
            iconData,
            size: 20,
            color: blackColor,
          )
              : const SizedBox(),
        ],
      ),
    ),
  );
}

commonHeaderTitle({String title = "",
  double height = 1.0,
  double fontSize = 1,int fontWeight = 0,Color color = whiteColor,
  TextAlign align = TextAlign.start,
  FontStyle fontStyle = FontStyle.normal}){
  return Text(
    title,
    style: white14PxNormal
        .apply(
        color: color,
        fontStyle: fontStyle,
        fontSizeFactor: fontSize,
        fontFamily: "Arial",
        fontWeightDelta: fontWeight)
        .merge(TextStyle(height: height)),
    textAlign: align,
  );
}

commonVerticalSpacing({double spacing = 10}){
  return SizedBox(height: spacing);
}

commonHorizontalSpacing({double spacing = 10}){
  return SizedBox(width: spacing);
}

AppBar commonAppbar({BuildContext? context,String title = "",
  bool isLeadingCCustom = false,
  Widget? leadingWidget,
  bool centerTitle = false}){
  return AppBar(
    backgroundColor: blackColor,
    centerTitle: centerTitle,
    title: commonHeaderTitle(title: title,fontSize: 1.3,fontWeight: 2),
    leading: isLeadingCCustom ? leadingWidget! : InkWell(
      onTap: (){
        Get.back();
      },
        child: Image(image: backIconImage)),
    actions: [
      InkWell(
        onTap: (){
          showDialog(context: context!, builder: (BuildContext context) => const CustomDialog());
        },
        child: Image
          (image: plantIconImage,height: 30,width: 30),
      ),
      commonHorizontalSpacing(),
      const Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: Icon(Icons.notifications,color: whiteColor),
      ),
    ],
  );
}

Widget commonRoundedContainer({BuildContext? context,Widget? child, double commonMargin = 20}){
 return Container(
   width: getScreenWidth(context!),
   height: getScreenHeight(context),
   margin: EdgeInsets.only(top: commonMargin),
   decoration: const BoxDecoration(
       color: whiteColor,
       borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
   ),
   child: child,
 );
}