import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:my_projects/utility/color_utility.dart';

import '../controllers/general_controller.dart';
import '../models/activities_response_model.dart';
import '../modules/dashboard/dashboard_listing/dashboard_view.dart';
import '../theme/convert_theme_colors.dart';
import '../utility/assets_utility.dart';
import '../utility/screen_utility.dart';
import '../utility/theme_utility.dart';

double commonHorizontalPadding = 10.0;
BorderRadius commonButtonBorderRadius = BorderRadius.circular(10.0);
BorderRadius commonBorderRadius = BorderRadius.circular(12.0);
OutlineInputBorder textFieldBorderStyle = OutlineInputBorder(
  borderSide: const BorderSide(color: bgColor),
  borderRadius: commonButtonBorderRadius,
);

BoxDecoration neurmorphicBoxDecoration = BoxDecoration(
  boxShadow: GeneralController.to.isDarkMode.value ? [
    BoxShadow(
      color: Colors.white.withOpacity(0.1),
      offset: const Offset(-5.0, -6.0),
      blurRadius: 16.0,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.4),
      offset: const Offset(6.0, 6.0),
      blurRadius: 16.0,
    ),
  ] : [
    BoxShadow(
      color: Colors.white.withOpacity(0.8),
      offset: const Offset(-5.0, -6.0),
      blurRadius: 16.0,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      offset: const Offset(6.0, 6.0),
      blurRadius: 16.0,
    ),
  ],
  color: ConvertTheme.convertTheme.getBackGroundColor(),
  borderRadius: BorderRadius.circular(12.0),
);


Widget commonStructure({
  required BuildContext context,
  required Widget child,
  PreferredSize? appBar,
  Color bgColor = whiteColor,
  Widget? bottomNavigation,
  Widget? floatingAction,
}) {
  ///Pass null in appbar when it's optional ex = appBar : null
  return Stack(
    children: [
      commonAppBackground(),
      Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        appBar: appBar,
        bottomNavigationBar: bottomNavigation,
        floatingActionButton: floatingAction,
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

Widget commonAppBackground() {
  return Obx(() {
    return Container(
      decoration: BoxDecoration(
        color: ConvertTheme.convertTheme.getBackGroundColor(),
      ),
    );
  });
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
        shadowColor: blackColor.withOpacity(0.8),
        primary: primaryColor,
        shape: RoundedRectangleBorder(borderRadius: commonButtonBorderRadius),
        padding: EdgeInsets.symmetric(vertical: height == 50.0 ? 15 : 2),
        elevation: 5.0,
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
  return Container(
    decoration: neurmorphicBoxDecoration,
    width: MediaQuery.of(context).size.width - (commonHorizontalPadding * 2),
    height: height,
    child: ElevatedButton(
      onPressed: () {
        if (!isLoading) {
          tapOnButton();
        }
      },
      style: ElevatedButton.styleFrom(
        // shadowColor: blackColor.withOpacity(0.8),
        alignment: Alignment.center,
        primary: ConvertTheme.convertTheme.getBackGroundColor(),
        // side: const BorderSide(
        //   color: blackColor,
        //   width: 1.0,
        // ),
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
  double fontSize = 1,int fontWeight = 0,
  Color color = whiteColor,
  bool isChangeColor = false,
  TextAlign align = TextAlign.start,
  FontStyle fontStyle = FontStyle.normal}){
  return Text(
    title,
    style: white14PxNormal
        .apply(
        color: isChangeColor ? color : ConvertTheme.convertTheme.getWhiteToFontColor(),
        fontStyle: fontStyle,
        fontSizeFactor: fontSize,
        fontFamily: "Poppins",
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

PreferredSize commonAppbar({BuildContext? context,
  String title = "",
  bool isLeadingCCustom = false,
  Widget? leadingWidget,
  bool centerTitle = false}){
   return PreferredSize(
       preferredSize: const Size.fromHeight(56.0),
       child: Obx(() {
       return AppBar(
         backgroundColor: ConvertTheme.convertTheme.getBackGroundColor(),
         centerTitle: centerTitle,
         elevation: 0.0,
         title: Padding(
           padding: const EdgeInsets.only(top: 5),
           child: commonHeaderTitle(title: title,fontSize: 1.3,fontWeight: 2,align: TextAlign.center),
         ),
         leading: isLeadingCCustom ? leadingWidget! : InkWell(
             onTap: (){
               Get.back();
             },
             child: Image(image: backIconImage,color: ConvertTheme.convertTheme.getWhiteToFontColor())),
         actions: actionIcons(context!),
       );
     }),
   );
}

List<Widget> actionIcons(BuildContext context,{isAllowSpacing = false}){
  return [
    InkWell(
      onTap: (){
        showDialog(context: context, builder: (BuildContext context) => const CustomDialog());
      },
      child: Image
        (image: plantIconImage,color: ConvertTheme.convertTheme.getWhiteToFontColor()),
    ),
    if(isAllowSpacing)
      commonHorizontalSpacing(spacing: 15),
    Icon(Icons.notifications,color: ConvertTheme.convertTheme.getWhiteToFontColor(),size: 32),
    if(!isAllowSpacing)
      commonHorizontalSpacing(),
  ];
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

Widget commonNeumorphicView({Widget? child}){
  return Container(
      decoration: neurmorphicBoxDecoration,
      child: child);
}

void commonBottomView(
    {BuildContext? context,
      Widget? child}) {
  showModalBottomSheet(
      context: context!,
      isScrollControlled: true,
      backgroundColor: ConvertTheme.convertTheme.getBackGroundColor(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      builder: (builder) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: child
        );
        // return FractionallySizedBox(
        //   heightFactor: 0.92,
        //   child:,
        // );
      });
}

Widget getActivityCard({ActivityData? activityResponse, Function? callback}){
  return Container(
    margin: const EdgeInsets.only(bottom: 20,left: 16,right: 16),
    decoration: neurmorphicBoxDecoration,
    child: CheckboxListTile(
      title: Text(activityResponse!.activityFor ?? ""),
      subtitle: Text(activityResponse.activityQuestion ?? "",style: white14PxNormal.apply(color: greyColor)),
      value: activityResponse.isSelected,
      activeColor: greenColor,
      onChanged: (bool? value) {
        callback!(value);
      },
    ),
  );
}

commonDecoratedTextView({String title = "", bool isChangeColor = false,double bottom = 25}){
  return Container(
    padding: const EdgeInsets.all(12),
    margin: EdgeInsets.only(bottom: bottom),
    decoration: neurmorphicBoxDecoration,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        commonHeaderTitle(
            title: title,
            isChangeColor: isChangeColor,
            fontSize: 1.1,
            color: blackColor.withOpacity(0.4)
        ),
        commonHorizontalSpacing(),
        Icon(Icons.keyboard_arrow_down,color: ConvertTheme.convertTheme.getWhiteToFontColor(),)
      ],
    ),
  );
}
