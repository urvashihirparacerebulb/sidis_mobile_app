import 'dart:ui';

import 'package:flutter/material.dart';

import '../../common_widgets/common_widget.dart';
import '../../utility/assets_utility.dart';
import '../../utility/color_utility.dart';
import '../../utility/screen_utility.dart';

class PlantDashboardView extends StatefulWidget {
  const PlantDashboardView({Key? key}) : super(key: key);

  @override
  State<PlantDashboardView> createState() => _PlantDashboardViewState();
}

class _PlantDashboardViewState extends State<PlantDashboardView> {
  @override
  Widget build(BuildContext context) {
    return commonStructure(
        context: context,
        bgColor: blackColor,
        appBar: commonAppbar(context: context,title: "JH"),
        child: Container(
          width: getScreenWidth(context),
          height: getScreenHeight(context),
          margin: const EdgeInsets.only(top: 10),
          decoration: const BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                GridView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) => Card(
                    color: whiteColor,
                    elevation: 9.0,
                    shadowColor: greyColor.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        commonVerticalSpacing(spacing: 20),
                        Image(image: assignedAbnormalityImage),
                        commonVerticalSpacing(spacing: 15),
                        commonHeaderTitle(title: index == 0 ? "Assigned\nAbnormality" : "Clita Activity", fontSize: 1.1,color: blackColor,align: TextAlign.center)
                      ],
                    ),
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,left: 10,
                  child: Container(
                    height: 65,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: watermarkImage,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
