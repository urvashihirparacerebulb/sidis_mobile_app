import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_projects/utility/common_methods.dart';
import '../../common_widgets/common_widget.dart';
import '../../controllers/authentication_controller.dart';
import '../../utility/assets_utility.dart';
import '../../utility/color_utility.dart';
import '../../utility/screen_utility.dart';
import '../forgotPassword/change_password_screen.dart';
import '../login/login_screen.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  commonView({String title = "", String subTitle = ""}){
    return Container(
      margin: const EdgeInsets.only(left: 15,right: 15,bottom: 20),
      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
      decoration: neurmorphicBoxDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          commonHeaderTitle(
              title: title, height: 1.2, fontSize: 1, fontWeight: 1, isChangeColor: true,
              color: const Color(0xFFB0B0B0)),
          commonHorizontalSpacing(),
          commonHeaderTitle(title: subTitle,
              fontSize: 1.1,fontWeight: 1,isChangeColor: true,color: fontColor)
        ],
      ),
    );
  }

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
                  children: actionIcons(context,isAllowSpacing: true)
                )
              ],
            ),
          ),
          commonVerticalSpacing(spacing: 30),
          Image(image: userDefaultImage, height: isTablet() ? 150 : 115,
              width: isTablet() ? 150 : 115,fit: BoxFit.contain),
          commonVerticalSpacing(spacing: 20),
          commonHeaderTitle(title: getLoginData()!.userdata?.first.sessionName ?? "",
              fontSize: 1.5,fontWeight: 2, align: TextAlign.center),
          commonVerticalSpacing(spacing: 20),
          commonView(title: "EMP ID(ARS ID)", subTitle: "4568792018"),
          commonView(title: "User Name/\nEmail Id", subTitle: "Rocky_anna"),
          commonView(title: "Soul\nDepartment", subTitle: "SKAPS_Woven_Unit2(102)"),
          commonView(title: "Contact No", subTitle: "+91 987956950"),
          commonView(title: "Group", subTitle: "Worker"),
          commonView(title: "Designation", subTitle: "Labor"),
          commonVerticalSpacing(),
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
          GestureDetector(
            onTap: (){
              AuthenticationController.to.clearPref();
              Get.offAll(() => const LoginScreen());
            },
            child: Container(
              margin: const EdgeInsets.only(left: 15,right: 15,bottom: 40),
              padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
              decoration: neurmorphicBoxDecoration,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonHeaderTitle(title: "Logout",
                      fontSize: 1.5,fontWeight: 2,color: Colors.red,isChangeColor: true),
                  const Icon(Icons.logout,color: dangerColor)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
