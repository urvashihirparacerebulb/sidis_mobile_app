import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_projects/utility/screen_utility.dart';

import '../../common_widgets/common_widget.dart';
import '../../controllers/authentication_controller.dart';
import '../../utility/color_utility.dart';
import '../../utility/common_methods.dart';
import '../forgotPassword/change_password_screen.dart';
import '../login/login_screen.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: [
          commonVerticalSpacing(spacing: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonHeaderTitle(title: "Profile",
                    fontSize: 1.8,fontWeight: 3),
                Row(
                  children: actionIcons(context,isAllowSpacing: true),
                )
              ],
            ),
          ),
          commonVerticalSpacing(spacing: 20),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: neurmorphicBoxDecoration,
                  // height: getScreenHeight(context) / 1,
                  width: getScreenWidth(context),
                  margin: const EdgeInsets.only(top: 60,left: 15,right: 15,bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 90.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        commonHeaderTitle(title: getLoginData() == null ? "" : getLoginData()!.userdata?.first.sessionName ?? "",fontWeight: 3,fontSize: 1.5),
                        commonVerticalSpacing(spacing: 20),
                        commonHeaderTitle(title: "EMP ID(ARS ID)",color: const Color(0xffB0B0B0),fontSize: 1,fontWeight: 1),
                        commonVerticalSpacing(spacing: 8),
                        commonHeaderTitle(title: "4568792018",fontWeight: 2,fontSize: 1.4),

                        commonVerticalSpacing(spacing: isTablet() ? 20 : 15),
                        commonHeaderTitle(title: "User Name/ Email Id",color: const Color(0xffB0B0B0),fontSize: 1,fontWeight: 1),
                        commonVerticalSpacing(spacing: 8),
                        commonHeaderTitle(title: "Rocky_anna",fontWeight: 2,fontSize: 1.4),

                        commonVerticalSpacing(spacing: isTablet() ? 20 : 15),
                        commonHeaderTitle(title: "Soul Department",color: const Color(0xffB0B0B0),fontSize: 1,fontWeight: 1),
                        commonVerticalSpacing(spacing: 8),
                        commonHeaderTitle(title: "SKAPS_Woven_Unit2(102)",fontWeight: 2,fontSize: 1.4),

                        commonVerticalSpacing(spacing: isTablet() ? 20 : 15),
                        commonHeaderTitle(title: "Contact No",color: const Color(0xffB0B0B0),fontSize: 1,fontWeight: 1),
                        commonVerticalSpacing(spacing: 8),
                        commonHeaderTitle(title: "+91 987956950",fontWeight: 2,fontSize: 1.4),

                        commonVerticalSpacing(spacing: isTablet() ? 20 : 15),
                        commonHeaderTitle(title: "Group",color: const Color(0xffB0B0B0),fontSize: 1,fontWeight: 1),
                        commonVerticalSpacing(spacing: 8),
                        commonHeaderTitle(title: getLoginData() == null ? "" : getLoginData()!.userdata?.first.groupName ?? "",fontWeight: 2,fontSize: 1.4),

                        commonVerticalSpacing(spacing: isTablet() ? 20 : 15),
                        commonHeaderTitle(title: "Designation",color: const Color(0xffB0B0B0),fontSize: 1,fontWeight: 1),
                        commonVerticalSpacing(spacing: 8),
                        commonHeaderTitle(title: "Labor",fontWeight: 2,fontSize: 1.4),

                        commonVerticalSpacing(spacing: 20),

                      ],
                    ),
                  )
              ),

              Positioned(
                  top: 0,
                  child: Center(
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
                    ),
                  )
              ),
            ],
          ),
          commonVerticalSpacing(spacing: 20),
          InkWell(
            onTap: (){
              Get.to(() => const ChangePasswordView());
            },
            child: Container(
              margin: const EdgeInsets.only(left: 15,right: 15),
              padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
              decoration: neurmorphicBoxDecoration,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonHeaderTitle(title: "Change Password",
                      fontSize: 1.5,fontWeight: 2),
                  const Icon(Icons.navigate_next_outlined)
                ],
              ),
            ),
          ),
          commonVerticalSpacing(spacing: 20),
          Container(
            margin: const EdgeInsets.only(left: 15,right: 15,bottom: 40),
            padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
            decoration: neurmorphicBoxDecoration,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonHeaderTitle(title: "Logout",
                    fontSize: 1.5,fontWeight: 2),
                InkWell(
                  onTap: (){
                    AuthenticationController.to.clearPref();
                    Get.offAll(() => const LoginScreen());
                  },
                  child: const Icon(Icons.logout,color: dangerColor),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
