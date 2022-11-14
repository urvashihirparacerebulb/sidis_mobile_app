import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_projects/utility/common_methods.dart';

import '../../../common_widgets/common_widget.dart';
import '../../../utility/color_utility.dart';
import '../../../utility/constants.dart';
import '../../../utility/screen_utility.dart';
import '../../plant_dashboard/plant_dashboard_view.dart';
import 'list_dashboard_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {

  commonCardView({String title = "", String subTitle = ""}){
    return commonNeumorphicView(
      child: InkWell(
        onTap: (){
          Get.to(() => const ListDashboardView());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: commonHeaderTitle(title: title,
                    fontSize: isTablet() ? 2.1 : 1.8,fontWeight: 1),
              ),
              Container(
                padding: EdgeInsets.all(isTablet() ? 11 : 8.0),
                decoration: const BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: commonHeaderTitle(title: subTitle,fontSize: isTablet() ? 1.10 : 0.85,
                      fontWeight: 2,color: blackColor,
                      isChangeColor: true,align: TextAlign.center),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 24),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonHeaderTitle(title: "Hello,",
                      isChangeColor: true,
                      color: lightFontColor,fontSize: isTablet() ? 1.6 : 1.4,fontWeight: 1),
                  commonVerticalSpacing(spacing: 5),
                  commonHeaderTitle(title: getLoginData()!.userdata?.first.sessionName ?? "",
                      fontSize: isTablet() ? 2.5 : 2,fontWeight: 3),
                ],
              ),
              Row(
                children: actionIcons(context,isAllowSpacing: true),
              )
            ],
          ),
          commonVerticalSpacing(spacing: 25),
          Row(
            children: [
              Expanded(child: commonCardView(title: "JH",subTitle: "99+")),
              commonHorizontalSpacing(spacing: 20),
              Expanded(child: commonCardView(title: "KK",subTitle: "50"))
            ],
          ),
          commonVerticalSpacing(spacing: 27),
          Row(
            children: [
              Expanded(child: commonCardView(title: "PM",subTitle: "99+")),
              commonHorizontalSpacing(spacing: 20),
              Expanded(child: commonCardView(title: "QM",subTitle: "50"))
            ],
          ),
          commonVerticalSpacing(spacing: 27),
          Row(
            children: [
              Expanded(child: commonCardView(title: "E&T",subTitle: "99+")),
              commonHorizontalSpacing(spacing: 20),
              Expanded(child: commonCardView(title: "SHE",subTitle: "50"))
            ],
          ),
          commonVerticalSpacing(spacing: 27),
          Row(
            children: [
              Expanded(child: commonCardView(title: "OTPM",subTitle: "99+")),
              commonHorizontalSpacing(spacing: 20),
              Expanded(child: commonCardView(title: "DM",subTitle: "50"))
            ],
          ),
          commonVerticalSpacing(spacing: 27),
          commonCardView(title: "GENERAL",subTitle: "5"),
        ],
      ),
    );
    // return commonStructure(
    //     context: context,
    //     bgColor: blackColor,
    //     appBar: commonAppbar(
    //         context: context,title: "Hello, John",
    //         isLeadingCCustom: true,
    //         centerTitle: true,
    //         leadingWidget: InkWell(
    //       onTap: (){
    //         Get.to(() => const MenuScreen());
    //       },
    //       child: Image(image: menuIconImage),
    //     )),
    //     child: ListView.builder(
    //       itemCount: 15,
    //       shrinkWrap: true,
    //       itemBuilder: (context, index) {
    //         return InkWell(
    //           onTap: (){
    //             Get.to(() => const PlantDashboardView());
    //           },
    //           child: Card(
    //             margin: const EdgeInsets.all(10),
    //             color: whiteColor,
    //             elevation: 7.0,
    //             shadowColor: greyColor.withOpacity(0.3),
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(10),
    //             ),
    //             child: Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Stack(
    //                     children: <Widget>[
    //                       Padding(padding: const EdgeInsets.only(right: 10,top: 8),child:
    //                       commonHeaderTitle(title: "RM",color: blackColor,fontWeight: 2,fontSize: 1.2),
    //                       ),
    //                       Positioned(
    //                         right: 0,
    //                         top: 0,
    //                         child: Container(
    //                           decoration: const BoxDecoration(
    //                               color: Color(0xffFF7777),
    //                               shape: BoxShape.circle
    //                           ),
    //                           constraints: const BoxConstraints(
    //                             minWidth: 12,
    //                             minHeight: 12,
    //                           ),
    //                           child: const Center(
    //                             child: Text(
    //                               '10',
    //                               style: TextStyle(
    //                                 color: Colors.white,
    //                                 fontSize: 8,
    //                               ),
    //                               textAlign: TextAlign.center,
    //                             ),
    //                           ),
    //                         ),
    //                       )
    //                     ],
    //                   ),
    //                   Image(image: nextPageArrowImage)
    //                 ],
    //               ),
    //             ),
    //           ),
    //         );
    //       },)
    // );
  }
}

class CustomDialog extends StatefulWidget {
  const CustomDialog({Key? key}) : super(key: key);

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  String _selectedGender = '1';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 0.0,right: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 18.0,),
            margin: const EdgeInsets.only(top: 13.0,right: 8.0),
            decoration: BoxDecoration(
                color: whiteColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 0.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  commonHeaderTitle(title: selectPlant,color: blackColor,fontSize: 1.3,fontWeight: 2),
                  commonVerticalSpacing(spacing: 8),
                  const Divider(color: greyColor,thickness: 0.7,height: 5),
                  ListTile(
                    minVerticalPadding: 0,
                    visualDensity: VisualDensity.comfortable,
                    contentPadding: EdgeInsets.zero,
                    trailing: Radio<String>(
                      value: '1',
                      groupValue: _selectedGender,
                      activeColor: primaryColor,
                      onChanged: (value) {
                        _selectedGender = value!;
                        Get.back();
                        Get.to(() => const PlantDashboardView());
                      },
                    ),
                    title: const Text('SKAPS_Woven_Unit2(102)'),
                  ),
                  ListTile(
                    minVerticalPadding: 0,
                    visualDensity: VisualDensity.comfortable,
                    contentPadding: EdgeInsets.zero,
                    trailing: Radio<String>(
                      value: '2',
                      groupValue: _selectedGender,
                      activeColor: primaryColor,
                      onChanged: (value) {
                          _selectedGender = value!;
                          Get.back();
                          Get.to(() => const PlantDashboardView());
                      },
                    ),
                    title: const Text('SKAPS_Woven_EOU(100)'),
                  ),
                  ListTile(
                    minVerticalPadding: 0,
                    visualDensity: VisualDensity.comfortable,
                    contentPadding: EdgeInsets.zero,
                    trailing: Radio<String>(
                      value: '3',
                      groupValue: _selectedGender,
                      activeColor: primaryColor,
                      onChanged: (value) {
                          _selectedGender = value!;
                          Get.back();
                          Get.to(() => const PlantDashboardView());
                      },
                    ),
                    title: const Text('SKAPS_Woven_Unit2(103)'),
                  ),
                  ListTile(
                    minVerticalPadding: 0,
                    visualDensity: VisualDensity.comfortable,
                    contentPadding: EdgeInsets.zero,
                    trailing: Radio<String>(
                      value: '4',
                      groupValue: _selectedGender,
                      activeColor: primaryColor,
                      onChanged: (value) {
                          _selectedGender = value!;
                          Get.back();
                          Get.to(() => const PlantDashboardView());
                      },
                    ),
                    title: const Text('SKAPS_Woven_Unit2(104)'),
                  ),
                  commonVerticalSpacing(spacing: 10)
                ],
              ),
            ),
          ),
          Positioned(
            right: 0.0,
            child: GestureDetector(
              onTap: (){
                Get.back();
              },
              child: const Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 14.0,
                  backgroundColor: blackColor,
                  child: Icon(Icons.close, color: whiteColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
