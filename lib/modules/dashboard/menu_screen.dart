import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_projects/utility/assets_utility.dart';
import 'package:my_projects/utility/color_utility.dart';
import 'package:my_projects/utility/common_methods.dart';

import '../../common_widgets/common_widget.dart';
import '../../controllers/authentication_controller.dart';
import '../../utility/constants.dart';
import '../login/login_screen.dart';
import 'abnormality_form/add_abnormaliry_view.dart';
import 'assigned_form/add_assigned_form_view.dart';
import 'clita module/add_clita_fill_form_view.dart';
import 'clita module/add_clita_no_list_view.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  iconTitleView({ExactAssetImage? image, String title = ""}){
    return InkWell(
      onTap: (){
        // if(title == ){
        //   Get.to(() => const CLITActivityListFormScreen());
        // }
        if(title == clitaFillFormText){
          Get.to(() => const CLITAFillFormView());
        }
        if(title == clitaNoListText){
          Get.to(() => const CLITANoListView());
        }
        if(title == abnormalityFormText){
          Get.to(() => const AddAbnormalityFormView());
        }
        if(title == assignedFormText){
          Get.to(() => const AddAssignedFormView());
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            Image(image: image!),
            commonHorizontalSpacing(),
            commonHeaderTitle(title: title,color: fontColor,fontSize: 1.2)
          ],
        ),
      ),
    );
  }

  ExactAssetImage getMenuIcon(int index) {
    switch (index) {
      case 0:
        return dashboardImage;
      // case 1:
      //   return companiesImage;
      // case 2:
      //   return businessesImage;
      // case 3:
      //   return plantsImage;
      // case 4:
      //   return departmentsImage;
      // case 5:
      //   return machinesImage;
      // case 6:
      //   return clitaActivityListImage;
      case 1:
        return clitaFillFormImage;
      case 2:
        return clitaNoListImage;
      case 3:
        return abnormalityFormImage;
      case 4:
        return assignedFormImage;
      case 5:
        return kaizenFormImage;
      // case 12:
      //   return userManagementImage;
      default:
        return dashboardImage;
    }
  }

  String getMenuTitle(int index) {
    return getLoginData()!.allMenus?[index].menuName ?? "";

    // switch (index) {
    //   case 0:
    //     return getLoginData()!.allMenus[index].menuName ?? "";
    //   case 1:
    //     return companiesText;
    //   case 2:
    //     return businessesText;
    //   case 3:
    //     return plantsText;
    //   case 4:
    //     return departmentsText;
    //   case 5:
    //     return machinesText;
    //   case 6:
    //     return clitaActivityListText;
    //   case 7:
    //     return clitaFillFormText;
    //   case 8:
    //     return clitaNoListText;
    //   case 9:
    //     return abnormalityFormText;
    //   case 10:
    //     return assignedFormText;
    //   case 11:
    //     return kaizenFormText;
    //   case 12:
    //     return userManagementText;
    //   default:
    //     return "";
    // }
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
              commonMargin: 30,
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
                        commonHeaderTitle(title: getLoginData() == null ? "" : getLoginData()!.userdata?.first.sessionName ?? "",color: fontColor,fontWeight: 2,fontSize: 1.4),
                        commonVerticalSpacing(spacing: 3),
                        commonHeaderTitle(title: getLoginData() == null ? "" : getLoginData()!.userdata?.first.groupName ?? "",color: const Color(0xff1C1B1B).withOpacity(0.5))
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8,left: 16,right: 16),
                      child: ListView.builder(
                        itemCount: getLoginData() == null ? 0 : getLoginData()!.allMenus?.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => iconTitleView(
                            image: getMenuIcon(index),
                            title: getMenuTitle(index)),
                      ),
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
              margin: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                color: whiteColor,
                shape: BoxShape.circle,
              ),
            ),
          )),

          Positioned(
              right: 20,
              top: 90,
              child: InkWell(
                onTap: (){
                  AuthenticationController.to.clearPref();
                  Get.offAll(() => const LoginScreen());
                },
                child: Image(
                  image: logoutImage,
                ),
              )
          )
        ],
      )
    );
  }
}
