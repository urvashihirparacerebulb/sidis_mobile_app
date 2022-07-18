import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_projects/utility/assets_utility.dart';
import 'package:my_projects/utility/color_utility.dart';
import 'package:my_projects/utility/constants.dart';

import '../../common_widgets/common_widget.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  iconTitleView({ExactAssetImage? image, String title = ""}){
    return Row(
      children: [
        Image(image: image!),
        commonHorizontalSpacing(),
        commonHeaderTitle(title: title,color: fontColor,fontSize: 1.2)
      ],
    );
  }

  ExactAssetImage getMenuIcon(int index) {
    switch (index) {
      case 0:
        return dashboardImage;
      case 1:
        return companiesImage;
      case 2:
        return businessesImage;
      case 3:
        return plantsImage;
      case 4:
        return departmentsImage;
      case 5:
        return machinesImage;
      case 6:
        return clitaActivityListImage;
      case 7:
        return clitaFillFormImage;
      case 8:
        return clitaNoListImage;
      case 9:
        return abnormalityFormImage;
      case 10:
        return assignedFormImage;
      case 11:
        return kaizenFormImage;
      case 12:
        return userManagementImage;
      default:
        return dashboardImage;
    }
  }

  String getMenuTitle(int index) {
    switch (index) {
      case 0:
        return dashboardText;
      case 1:
        return companiesText;
      case 2:
        return businessesText;
      case 3:
        return plantsText;
      case 4:
        return departmentsText;
      case 5:
        return machinesText;
      case 6:
        return clitaActivityListText;
      case 7:
        return clitaFillFormText;
      case 8:
        return clitaNoListText;
      case 9:
        return abnormalityFormText;
      case 10:
        return assignedFormText;
      case 11:
        return kaizenFormText;
      case 12:
        return userManagementText;
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return commonStructure(
      context: context,
      bgColor: blackColor,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 30),
            child: InkWell(
              onTap: (){
                Get.back();
              },
              child: const Icon(Icons.close,color: whiteColor,size: 32),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: commonRoundedContainer(
              context: context,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(padding: const EdgeInsets.only(left: 160,top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        commonHeaderTitle(title: "John Deo",color: fontColor,fontWeight: 2,fontSize: 1.3),
                        commonVerticalSpacing(spacing: 3),
                        commonHeaderTitle(title: "Worker",color: const Color(0xff1C1B1B).withOpacity(0.5))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8,left: 16,right: 16),
                    child: ListView.builder(
                      itemCount: 12,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => iconTitleView(image: getMenuIcon(index),title: getMenuTitle(index)),
                    ),
                  ),
                ],
              )
            ),
          ),

          Positioned(
            left: 20,
              top: 50,
              child: Container(
            height: 130,width: 130,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: blackColor
            ),
            child: Container(
              margin: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                color: whiteColor,
                shape: BoxShape.circle,
              ),
            ),
          )),

          Positioned(
              right: 20,
              top: 90,
              child: Image(
                image: logoutImage,
              )
          )
        ],
      )
    );
  }
}
