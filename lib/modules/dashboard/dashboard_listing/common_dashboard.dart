import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:my_projects/controllers/general_controller.dart';
import 'package:my_projects/modules/profile/profile_view.dart';
import 'package:my_projects/utility/assets_utility.dart';

import '../../../theme/convert_theme_colors.dart';
import '../../../utility/color_utility.dart';
import '../../../utility/common_methods.dart';
import '../../../utility/constants.dart';
import 'dashboard_view.dart';
import '../home/home_screen.dart';

class CommonDashboard extends StatefulWidget {
  const CommonDashboard({Key? key}) : super(key: key);

  @override
  State<CommonDashboard> createState() => _CommonDashboardState();
}

class _CommonDashboardState extends State<CommonDashboard> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        confirmationAlertDialog(
            message: exitMessage,
            buttonCallBack: () {
              Get.back();
              SystemNavigator.pop();
              return Future.value(true);
            });
        return Future.value(true);
      },
      child: Obx((){
        return Scaffold(
          backgroundColor: ConvertTheme.convertTheme.getBackGroundColor(),
          floatingActionButton: SizedBox(
            height: 64,width: 64,
            child: NeumorphicFloatingActionButton(
              style: const NeumorphicStyle(
                boxShape: NeumorphicBoxShape.circle(),
                shape: NeumorphicShape.concave,
                color: bgColor
              ),
              child: Image(image: dashboardIconImage),
              onPressed: () {
                GeneralController.to.dashboardIndex.value = 1;
              },
            ),
          ),
          bottomNavigationBar: Container(
            height: 70,
            decoration: const BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: whiteColor,
                    blurRadius: 15.0,
                    offset: Offset(0.0, 0.95)
                )
              ],
            ),
            child: BottomNavigationBar(
              showSelectedLabels: false,
              backgroundColor: bgColor,
              selectedLabelStyle: const TextStyle(fontSize: 0),
              currentIndex: GeneralController.to.dashboardIndex.value,
              unselectedLabelStyle: const TextStyle(fontSize: 0),
              items: [
                BottomNavigationBarItem(
                    icon: Image(image: listingIconImage,color: iconColor),
                    label: ''
                ),
                BottomNavigationBarItem(
                    icon: Container(),
                    label: ''
                ),
                BottomNavigationBarItem(
                    icon: Image(image: profileIconImage,color: iconColor),
                    label: ''
                )
              ],
              onTap: (index){
                GeneralController.to.dashboardIndex.value = index;
              },
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          body: GeneralController.to.dashboardIndex.value == 0 ?
          const DashboardView() : GeneralController.to.dashboardIndex.value == 2 ?
          const ProfileView() :
          const HomeScreen(),
        );
      }),
    );
  }
}
