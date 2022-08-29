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
import '../../speech_view.dart';
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
        bottomNavigation: Stack(
          children: [
            Image.asset("assets/images/login_tansparent_curve.png",height: 125,
              width: getScreenWidth(context),fit: BoxFit.cover,),
            Positioned(
              bottom: 8,left: 5,right: 5,
              child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                commonHeaderTitle(title: "Having Trouble?",fontWeight: 1,fontSize: 1),
                commonHorizontalSpacing(spacing: 6),
                commonHeaderTitle(title: "We Can Help >",color: primaryColor,fontWeight: 2,fontSize: 1),
              ],
            )),
            Positioned(
                top: 0,right: 20,
                child: NeumorphicFloatingActionButton(
                  style: const NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.circle(),
                      color: primaryColor
                  ),
                  child: const Icon(Icons.navigate_next_outlined, size: 30),
                  onPressed: () {
                    // Get.to(() => const CommonDashboard());
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Map<String, dynamic> params = {
                        "loginemail": userNameController.text,
                        "loginpassword": passwordController.text,
                      };
                      AuthenticationController.to.loginAPI(params);
                    }
                  },
                )
            )
          ],
        ),
        child: Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Align(
              alignment: Alignment.center,
              child: ListView(
                children: [
                  commonVerticalSpacing(spacing: 20),
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
                                  color: ConvertTheme.convertTheme.getWhiteToFontColor())
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
                  commonVerticalSpacing(spacing: 30),
                  commonHeaderTitle(title: orText,fontWeight: 2,fontSize: 1.2,align: TextAlign.center),
                  commonVerticalSpacing(),
                  InkWell(
                    onTap: (){
                      Get.to(() => const SpeechSampleApp());
                    },
                    child: Center(
                      child: Neumorphic(
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
                                color: ConvertTheme.convertTheme.getWhiteToFontColor(),
                                borderRadius: commonBorderRadius
                            ),
                            child: Icon(Icons.fingerprint,color: ConvertTheme.convertTheme.getFontToWhiteColor()),
                          ),
                      ),
                    ),
                  ),
                  commonVerticalSpacing(spacing: 15),
                  commonHeaderTitle(title: loginWithFinger,fontWeight: 2,fontSize: 1,align: TextAlign.center),
                  commonVerticalSpacing(spacing: 60),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}