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
                commonVerticalSpacing(spacing: 20),
                Container(
                  width: getScreenWidth(context)/4.5,
                  height: getScreenWidth(context)/4.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: appLogo,
                      fit: BoxFit.contain
                    )
                  ),
                ),
                Container(
                  width: getScreenWidth(context)/4.7,
                  color: blackColor.withOpacity(0.3),
                  child: commonHeaderTitle(title: "SKAPS",
                      fontStyle: FontStyle.italic,
                      fontSize: 1.2,color: primaryColor,
                      fontWeight: 2,
                      align: TextAlign.center),
                ),
                commonVerticalSpacing(spacing: 40),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: commonHeaderTitle(title: "Speak Less, Listen More. Don't Form Hasty Conclusion. If you Decide, Decide. Calculate your Responses. Don't betray your own.",
                      fontStyle: FontStyle.italic,
                      align: TextAlign.center,
                      fontSize: 1.4,
                      height: 1.6,
                      fontWeight: 2
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
