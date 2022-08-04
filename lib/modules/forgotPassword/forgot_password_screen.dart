import 'package:flutter/material.dart';
import 'package:my_projects/common_widgets/common_widget.dart';
import 'package:my_projects/utility/color_utility.dart';
import 'package:my_projects/utility/screen_utility.dart';

import '../../common_widgets/common_textfield.dart';
import '../../utility/assets_utility.dart';
import '../../utility/constants.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return commonStructure(
        context: context,
        bgColor: blackColor,
        appBar: commonAppbar(
            context: context,title: forgotPassword,
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
                  commonHeaderTitle(title: registerEmailMsg,color: blackColor,fontSize: 1.3,fontWeight: 2),
                  commonVerticalSpacing(spacing: 15),
                  commonHeaderTitle(title: verificationRegisteredMsg,color: greyColor,fontSize: 1,fontWeight: 2),
                  commonVerticalSpacing(spacing: 50),
                  CommonTextFiled(
                    fieldTitleText: "Email",
                    hintText: "Email",
                    // isBorderEnable: false,
                    isChangeFillColor: true,
                    textEditingController: emailController,
                    preFixIcon: const Icon(Icons.email,color: blackColor),
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
                      title: sendText,
                      width: getScreenWidth(context) - 40,
                      height: 50,
                      tapOnButton: () {

                      },
                      isLoading: false)
                ],
              ),
            )
          ],
        )
    );
  }

}
