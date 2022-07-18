import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_projects/common_widgets/common_widget.dart';
import 'package:my_projects/utility/color_utility.dart';
import '../../utility/assets_utility.dart';
import '../../utility/constants.dart';
import '../../utility/screen_utility.dart';
import 'login_screen.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: splashBgImage, // <-- BACKGROUND IMAGE
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent, // <-- SCAFFOLD WITH TRANSPARENT BG
          appBar: AppBar(
            centerTitle: true,
            title: Image(image: welcomeBgImage),
            backgroundColor: blackColor.withOpacity(0.4), // <-- APPBAR WITH TRANSPARENT BG
            elevation: 0, // <-- ELEVATION ZEROED
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 20),
            child: commonFillButtonView(
                context: context,
                title: goToLogin,
                width: getScreenWidth(context) / 2 - 40,
                height: 50,
                isLightButton: true,
                tapOnButton: () {
                  Get.to(() => const LoginScreen());
                },
                isLoading: false),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                commonVerticalSpacing(spacing: 20),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: blackColor,
                      borderRadius: BorderRadius.circular(16.0)
                    ),
                    child: commonHeaderTitle(title: welcomeTo,fontSize: 1.2),
                  ),
                ),

                Image(image: appLogo,
                    width: getScreenWidth(context)/4,
                    height: getScreenHeight(context)/4,fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
