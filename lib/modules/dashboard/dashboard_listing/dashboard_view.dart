import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_projects/controllers/dashboard_controller.dart';
import 'package:my_projects/utility/common_methods.dart';

import '../../../common_widgets/common_widget.dart';
import '../../../models/pillar_data_model.dart';
import '../../../utility/color_utility.dart';
import '../../../utility/constants.dart';
import '../../../utility/screen_utility.dart';
import '../../plant_dashboard/plant_dashboard_view.dart';
import 'list_dashboard_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {

  @override
  void initState() {
    if (DashboardController.to.pillarList.isEmpty) {
      DashboardController.to.getPillarList();
    }
    super.initState();
  }


  commonCardView({PillarResponse? pillarResponse}){
    return commonNeumorphicView(
      child: InkWell(
        onTap: (){
          Get.to(() => ListDashboardView(pillarCat: pillarResponse!));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: commonHeaderTitle(title: pillarResponse?.pillarName ?? "",
                    fontSize: isTablet() ? 2.1 : 1.8,fontWeight: 1),
              ),
              Container(
                padding: EdgeInsets.all(isTablet() ? 11 : 8.0),
                decoration: const BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: commonHeaderTitle(title: (pillarResponse?.status ?? 0).toString(),fontSize: isTablet() ? 1.10 : 0.85,
                      fontWeight: 2,color: blackColor,
                      isChangeColor: true,align: TextAlign.center),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 24),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonHeaderTitle(title: "Hello,",
                      isChangeColor: true,
                      color: lightFontColor,fontSize: isTablet() ? 1.6 : 1.4,fontWeight: 1),
                  commonVerticalSpacing(spacing: 5),
                  commonHeaderTitle(title: getLoginData()!.userdata?.first.sessionName ?? "",
                      fontSize: isTablet() ? 2.5 : 2,fontWeight: 3),
                ],
              ),
              Row(
                children: actionIcons(context,isAllowSpacing: true),
              )
            ],
          ),
          commonVerticalSpacing(spacing: 25),

          Obx(() {
            if(DashboardController.to.isLoadingForList.value){
              return const Center(child: CircularProgressIndicator());
            }
            return GridView.builder(
              shrinkWrap: true,
              itemCount: DashboardController.to.pillarList.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 16/9,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return commonCardView(pillarResponse: DashboardController.to.pillarList[index]);
              },
            );
          }),
        ],
      ),
    );
  }
}

class CustomDialog extends StatefulWidget {
  const CustomDialog({Key? key}) : super(key: key);

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  String _selectedGender = '1';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 0.0,right: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 18.0,),
            margin: const EdgeInsets.only(top: 13.0,right: 8.0),
            decoration: BoxDecoration(
                color: whiteColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 0.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  commonHeaderTitle(title: selectPlant,color: blackColor,fontSize: 1.3,fontWeight: 2),
                  commonVerticalSpacing(spacing: 8),
                  const Divider(color: greyColor,thickness: 0.7,height: 5),
                  ListTile(
                    minVerticalPadding: 0,
                    visualDensity: VisualDensity.comfortable,
                    contentPadding: EdgeInsets.zero,
                    trailing: Radio<String>(
                      value: '1',
                      groupValue: _selectedGender,
                      activeColor: primaryColor,
                      onChanged: (value) {
                        _selectedGender = value!;
                        Get.back();
                        Get.to(() => const PlantDashboardView());
                      },
                    ),
                    title: const Text('SKAPS_Woven_Unit2(102)'),
                  ),
                  ListTile(
                    minVerticalPadding: 0,
                    visualDensity: VisualDensity.comfortable,
                    contentPadding: EdgeInsets.zero,
                    trailing: Radio<String>(
                      value: '2',
                      groupValue: _selectedGender,
                      activeColor: primaryColor,
                      onChanged: (value) {
                          _selectedGender = value!;
                          Get.back();
                          Get.to(() => const PlantDashboardView());
                      },
                    ),
                    title: const Text('SKAPS_Woven_EOU(100)'),
                  ),
                  ListTile(
                    minVerticalPadding: 0,
                    visualDensity: VisualDensity.comfortable,
                    contentPadding: EdgeInsets.zero,
                    trailing: Radio<String>(
                      value: '3',
                      groupValue: _selectedGender,
                      activeColor: primaryColor,
                      onChanged: (value) {
                          _selectedGender = value!;
                          Get.back();
                          Get.to(() => const PlantDashboardView());
                      },
                    ),
                    title: const Text('SKAPS_Woven_Unit2(103)'),
                  ),
                  ListTile(
                    minVerticalPadding: 0,
                    visualDensity: VisualDensity.comfortable,
                    contentPadding: EdgeInsets.zero,
                    trailing: Radio<String>(
                      value: '4',
                      groupValue: _selectedGender,
                      activeColor: primaryColor,
                      onChanged: (value) {
                          _selectedGender = value!;
                          Get.back();
                          Get.to(() => const PlantDashboardView());
                      },
                    ),
                    title: const Text('SKAPS_Woven_Unit2(104)'),
                  ),
                  commonVerticalSpacing(spacing: 10)
                ],
              ),
            ),
          ),
          Positioned(
            right: 0.0,
            child: GestureDetector(
              onTap: (){
                Get.back();
              },
              child: const Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 14.0,
                  backgroundColor: blackColor,
                  child: Icon(Icons.close, color: whiteColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
