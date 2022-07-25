import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_projects/common_widgets/common_widget.dart';
import 'package:my_projects/modules/forgotPassword/forgot_password_screen.dart';
import 'package:my_projects/utility/color_utility.dart';
import 'package:my_projects/utility/screen_utility.dart';

import '../../biometrc_view.dart';
import '../../common_widgets/common_textfield.dart';
import '../../controllers/authentication_controller.dart';
import '../../utility/assets_utility.dart';
import '../../utility/constants.dart';
import '../dashboard/dashboard_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isRemember = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: splashBgImage, // <-- BACKGROUND IMAGE
              fit: BoxFit.cover,
            ),
          ),
        ),
        Material(
          type: MaterialType.transparency,
          child: Container(
            width: getScreenWidth(context) - 40,
            decoration: BoxDecoration(
              color: whiteColor.withOpacity(0.3),
              borderRadius: commonButtonBorderRadius
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image(image: welcomeBgImage,height: 80),
                    commonVerticalSpacing(),
                    commonHeaderTitle(title: welcomeTo,fontWeight: 3,fontSize: 1.11),
                    commonVerticalSpacing(spacing: 2),
                    commonHeaderTitle(title: infoMsg,fontSize: 0.95),
                    commonVerticalSpacing(spacing: 5),
                    Container(
                      height: 1,
                      width: getScreenWidth(context) - 80,
                      decoration: const BoxDecoration(
                        color: primaryColor
                      ),
                    ),
                    commonVerticalSpacing(spacing: 30),
                    CommonTextFiled(
                      fieldTitleText: userName,
                      hintText: userName,
                      textEditingController: userNameController,
                      preFixIcon: Image(image: userNameImage),
                      onChangedFunction: (String value){
                      },
                      validationFunction: (String value) {
                        return value.toString().isEmpty
                            ? notEmptyFieldMessage
                            : null;
                      },),
                    commonVerticalSpacing(spacing: 20),
                    CommonTextFiled(
                      fieldTitleText: passwordText,
                      hintText: passwordText,
                      isPassword: true,
                      textEditingController: passwordController,
                      preFixIcon: Image(image: passwordImage,height: 40),
                      onChangedFunction: (String value){
                      },
                      validationFunction: (String value) {
                        return value.toString().isEmpty
                            ? notEmptyFieldMessage
                            : null;
                      },),
                    commonVerticalSpacing(spacing: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StatefulBuilder(builder: (context, newSetState) => Row(
                          children: [
                            InkWell(
                              onTap: (){
                                newSetState((){
                                  isRemember = !isRemember;
                                });
                              },
                                child: Image(image: isRemember ? checkedImage : unCheckedImage,width: 20,height: 20)
                            ),
                            commonHorizontalSpacing(spacing: 6),
                            commonHeaderTitle(title: reMemberMe,fontSize: 0.95),
                          ],
                        )),
                        InkWell(
                          onTap: (){
                            Get.to(() => const ForgotPasswordView());
                          },
                          child: commonHeaderTitle(title: "$forgotPassword?",fontSize: 0.95),
                        )
                      ],
                    ),
                    commonVerticalSpacing(spacing: 30),
                    commonFillButtonView(
                        context: context,
                        title: signIn,
                        width: getScreenWidth(context) - 40,
                        height: 50,
                        tapOnButton: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            Map<String, dynamic> params = {
                              "loginemail": userNameController.text,
                              "loginpassword": passwordController.text,
                            };
                            AuthenticationController.to.loginAPI(params);
                          }
                        },
                        isLoading: false
                    ),
                    commonVerticalSpacing(),
                    commonHeaderTitle(title: orText,fontWeight: 1,fontSize: 0.98),
                    commonVerticalSpacing(),
                    InkWell(
                      onTap: (){
                        Get.to(() => const MyLockView());
                        // showModalBottomSheet(
                        //   context: context,
                        //   builder: (context) {
                        //     return Container(
                        //       margin: const EdgeInsets.all(30),
                        //       child: Wrap(
                        //         crossAxisAlignment: WrapCrossAlignment.center,
                        //         alignment: WrapAlignment.center,
                        //         children: [
                        //           Row(
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             crossAxisAlignment: CrossAxisAlignment.center,
                        //             children: [
                        //               commonHeaderTitle(title: "Use ",color: blackColor,fontSize: 1.3),
                        //               commonHeaderTitle(title: "Finger Print ",color: blackColor,fontWeight: 2,fontSize: 1.3),
                        //               commonHeaderTitle(title: "to log in",color: blackColor,fontSize: 1.3),
                        //             ],
                        //           ),
                        //
                        //           commonVerticalSpacing(spacing: 80),
                        //           InkWell(
                        //             onTap: (){},
                        //               child: const Icon(Icons.fingerprint,size: 80,color: primaryColor,))
                        //         ],
                        //       ),
                        //     );
                        //   },
                        // );
                      },
                      child: Container(
                        width: 30,
                        height: 40,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: commonBorderRadius
                        ),
                        child: const Icon(Icons.fingerprint),
                      ),
                    ),
                    commonVerticalSpacing(),
                    commonHeaderTitle(title: loginWithFinger,fontWeight: 1,fontSize: 0.98),
                    commonVerticalSpacing(spacing: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        commonHeaderTitle(title: "Having Trouble?",fontWeight: 1,fontSize: 1),
                        commonHorizontalSpacing(spacing: 6),
                        commonHeaderTitle(title: "We Can Help >",color: primaryColor,fontWeight: 1,fontSize: 1),
                      ],
                    ),
                    commonVerticalSpacing(spacing: 20),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}