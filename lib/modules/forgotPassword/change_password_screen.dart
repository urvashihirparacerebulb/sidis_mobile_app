import 'package:flutter/material.dart';
import 'package:my_projects/controllers/authentication_controller.dart';

import '../../common_widgets/common_textfield.dart';
import '../../common_widgets/common_widget.dart';
import '../../configurations/config_file.dart';
import '../../utility/assets_utility.dart';
import '../../utility/color_utility.dart';
import '../../utility/common_methods.dart';
import '../../utility/constants.dart';
import '../../utility/screen_utility.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return commonStructure(
        context: context,
        bgColor: blackColor,
        appBar: commonAppbar(
          context: context,title: "Change Password",
          centerTitle: true,
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  commonVerticalSpacing(),
                  Center(child: Image(image: forgotPasswordImage,height: getScreenWidth(context) /2.3,width: getScreenWidth(context)/2.3)),
                  commonVerticalSpacing(spacing: 30),
                  CommonTextFiled(
                    fieldTitleText: "Current Password",
                    hintText: "Current Password",
                    isPassword: true,
                    textEditingController: currentPasswordController,
                    onChangedFunction: (String value){
                    },
                    validationFunction: (String value) {
                      return value.toString().isEmpty
                          ? notEmptyFieldMessage
                          : null;
                    },),
                  commonVerticalSpacing(spacing: 25),
                  CommonTextFiled(
                    fieldTitleText: "New Password",
                    hintText: "New Password",
                    isPassword: true,
                    textEditingController: newPasswordController,
                    onChangedFunction: (String value){
                    },
                    validationFunction: (String value) {
                      return value.toString().isEmpty
                          ? notEmptyFieldMessage
                          : null;
                    },),
                  commonVerticalSpacing(spacing: 25),
                  CommonTextFiled(
                    fieldTitleText: "Confirm Password",
                    hintText: "Confirm Password",
                    isPassword: true,
                    textEditingController: confirmPasswordController,
                    onChangedFunction: (String value){
                    },
                    validationFunction: (String value) {
                      return value.toString().isEmpty
                          ? notEmptyFieldMessage
                          : null;
                    },),
                  commonVerticalSpacing(spacing: 60),
                  commonFillButtonView(
                      context: context,
                      title: "Update",
                      width: getScreenWidth(context) - 40,
                      height: 50,
                      tapOnButton: () {
                        if(currentPasswordController.text.isNotEmpty){
                          if(newPasswordController.text.isNotEmpty){
                            if(confirmPasswordController.text.isNotEmpty){
                              if(newPasswordController.text == confirmPasswordController.text){
                                AuthenticationController.to.changePasswordAPI({
                                  "old_password": currentPasswordController.text,
                                  "password": newPasswordController.text,
                                  "cpassword": confirmPasswordController.text,
                                  "manage_user_id": getLoginData()!.userdata?.first.id.toString()
                                });
                              }else{
                                showSnackBar(title: ApiConfig.error, message: "Password and confirm password doesn't match");
                              }
                            }else{
                              showSnackBar(title: ApiConfig.error, message: "Please enter confirm password");
                            }
                          }else{
                            showSnackBar(title: ApiConfig.error, message: "Please enter new password");
                          }
                        }else{
                          showSnackBar(title: ApiConfig.error, message: "Please enter current password");
                        }
                      },
                      isLoading: false)
                ],
              ),
            ),
          ],
        )
    );
  }
}
