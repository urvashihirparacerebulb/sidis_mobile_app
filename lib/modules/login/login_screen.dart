import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:my_projects/common_widgets/common_widget.dart';
import 'package:my_projects/controllers/general_controller.dart';
import 'package:my_projects/modules/forgotPassword/forgot_password_screen.dart';
import 'package:my_projects/theme/convert_theme_colors.dart';
import 'package:my_projects/utility/color_utility.dart';
import 'package:my_projects/utility/screen_utility.dart';
import '../../common_widgets/common_textfield.dart';
import '../../controllers/authentication_controller.dart';
import '../../utility/assets_utility.dart';
import '../../utility/constants.dart';

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
    return commonStructure(context: context,
        floatingAction: Padding(
          padding: const EdgeInsets.only(bottom: 40.0,right: 10),
          child: NeumorphicFloatingActionButton(
            style: const NeumorphicStyle(
              boxShape: NeumorphicBoxShape.circle(),
              color: primaryColor
            ),
          child: const Icon(Icons.navigate_next_outlined, size: 30),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                Map<String, dynamic> params = {
                  "loginemail": userNameController.text,
                  "loginpassword": passwordController.text,
                };
                AuthenticationController.to.loginAPI(params);
              }
            },
          ),
        ),
        child: Stack(
      alignment: Alignment.center,
      children: [
        Positioned(bottom: 0, left: 0, right: 0,
            child: Image.asset("assets/images/login_tansparent_curve.png",height: 130,width: getScreenWidth(context),fit: BoxFit.contain,)),
        Positioned(bottom:10,child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            commonHeaderTitle(title: "Having Trouble?",fontWeight: 1,fontSize: 1),
            commonHorizontalSpacing(spacing: 6),
            commonHeaderTitle(title: "We Can Help >",color: primaryColor,fontWeight: 2,fontSize: 1),
          ],
        )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                commonVerticalSpacing(),
                Obx(() => Image(image: GeneralController.to.isDarkMode.value ? horizontalAppLogoDark : horizontalAppLogoLight,height: 80),),
                commonVerticalSpacing(spacing: 20),
                commonHeaderTitle(title: infoMsg,fontSize: 1.4,align: TextAlign.center,height: 1.3,fontWeight: 3),
                commonVerticalSpacing(spacing: 40),
                CommonTextFiled(
                  fieldTitleText: userName,
                  hintText: userName,
                  textEditingController: userNameController,
                  onChangedFunction: (String value){
                  },
                  validationFunction: (String value) {
                    return value.toString().isEmpty
                        ? notEmptyFieldMessage
                        : null;
                  },),
                commonVerticalSpacing(spacing: 25),
                CommonTextFiled(
                  fieldTitleText: passwordText,
                  hintText: passwordText,
                  isPassword: true,
                  textEditingController: passwordController,
                  onChangedFunction: (String value){
                  },
                  validationFunction: (String value) {
                    return value.toString().isEmpty
                        ? notEmptyFieldMessage
                        : null;
                  },),
                commonVerticalSpacing(spacing: 25),
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
                            child: Image(image: isRemember ? checkedImage : unCheckedImage,
                                width: 20,height: 20,
                                color: ConvertTheme().getWhiteToFontColor())
                        ),
                        commonHorizontalSpacing(spacing: 6),
                        commonHeaderTitle(title: reMemberMe,fontSize: 1,fontWeight: 1),
                      ],
                    )),
                    InkWell(
                      onTap: (){
                        Get.to(() => const ForgotPasswordView());
                      },
                      child: commonHeaderTitle(title: "$forgotPassword?",fontSize: 1,fontWeight: 1),
                    )
                  ],
                ),
                // commonVerticalSpacing(spacing: 30),
                // commonFillButtonView(
                //     context: context,
                //     title: signIn,
                //     width: getScreenWidth(context) - 40,
                //     height: 50,
                //     tapOnButton: () {
                //       if (_formKey.currentState!.validate()) {
                //         _formKey.currentState!.save();
                //         Map<String, dynamic> params = {
                //           "loginemail": userNameController.text,
                //           "loginpassword": passwordController.text,
                //         };
                //         AuthenticationController.to.loginAPI(params);
                //       }
                //     },
                //     isLoading: false
                // ),
                commonVerticalSpacing(spacing: 30),
                commonHeaderTitle(title: orText,fontWeight: 2,fontSize: 1.2),
                commonVerticalSpacing(),
                // InkWell(
                //   onTap: (){
                //     Get.to(() => const MyLockView());
                //     // showModalBottomSheet(
                //     //   context: context,
                //     //   builder: (context) {
                //     //     return Container(
                //     //       margin: const EdgeInsets.all(30),
                //     //       child: Wrap(
                //     //         crossAxisAlignment: WrapCrossAlignment.center,
                //     //         alignment: WrapAlignment.center,
                //     //         children: [
                //     //           Row(
                //     //             mainAxisAlignment: MainAxisAlignment.center,
                //     //             crossAxisAlignment: CrossAxisAlignment.center,
                //     //             children: [
                //     //               commonHeaderTitle(title: "Use ",color: blackColor,fontSize: 1.3),
                //     //               commonHeaderTitle(title: "Finger Print ",color: blackColor,fontWeight: 2,fontSize: 1.3),
                //     //               commonHeaderTitle(title: "to log in",color: blackColor,fontSize: 1.3),
                //     //             ],
                //     //           ),
                //     //
                //     //           commonVerticalSpacing(spacing: 80),
                //     //           InkWell(
                //     //             onTap: (){},
                //     //               child: const Icon(Icons.fingerprint,size: 80,color: primaryColor,))
                //     //         ],
                //     //       ),
                //     //     );
                //     //   },
                //     // );
                //   },
                //   child: Container(
                //     width: 30,
                //     height: 40,
                //     decoration: BoxDecoration(
                //         color: primaryColor,
                //         borderRadius: commonBorderRadius
                //     ),
                //     child: const Icon(Icons.fingerprint),
                //   ),
                // ),

                Neumorphic(
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                        depth: 8,
                        color: Colors.grey
                    ),
                    child: Container(
                      width: 30,
                      height: 40,
                      decoration: BoxDecoration(
                          color: ConvertTheme().getWhiteToFontColor(),
                          borderRadius: commonBorderRadius
                      ),
                      child: Icon(Icons.fingerprint,color: ConvertTheme().getFontToWhiteColor()),
                    ),
                ),
                commonVerticalSpacing(spacing: 15),
                commonHeaderTitle(title: loginWithFinger,fontWeight: 2,fontSize: 1),
                commonVerticalSpacing(spacing: 60),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}