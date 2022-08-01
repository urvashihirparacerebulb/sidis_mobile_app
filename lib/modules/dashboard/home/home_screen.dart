import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:my_projects/utility/screen_utility.dart';
import '../../../common_widgets/common_widget.dart';
import '../../../utility/assets_utility.dart';
import '../../../utility/color_utility.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 24),
      child: ListView(
        children: [
          commonVerticalSpacing(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonHeaderTitle(title: "Current Working Plant",
                      isChangeColor: true,
                      color: lightFontColor,fontSize: 0.90,fontWeight: 1),
                  commonVerticalSpacing(spacing: 5),
                  commonHeaderTitle(title: "SKAPS_Woven_Unit2(102)",
                      fontSize: 1,fontWeight: 1),
                ],
              ),
              commonHorizontalSpacing(),
              Row(
                children: actionIcons(context),
              )
            ],
          ),
          commonVerticalSpacing(spacing: 20),
          commonNeumorphicView(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonHeaderTitle(title: "Projects".toUpperCase(),fontSize: 1.7,fontWeight: 2),
                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(14.0),
                          decoration: const BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: commonHeaderTitle(title: '15',fontSize: 1.2,fontWeight: 1,color: whiteColor,isChangeColor: true,align: TextAlign.center),
                          ),
                        ),
                        commonVerticalSpacing(spacing: 8),
                        commonHeaderTitle(title: "Progress",fontSize: 1,fontWeight: 2,color: primaryColor,isChangeColor: true)
                      ],
                    ),
                    commonHorizontalSpacing(spacing: 15),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(14.0),
                          decoration: const BoxDecoration(
                              color: greenColor,
                              shape: BoxShape.circle
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: commonHeaderTitle(title: '15',fontSize: 1.2,fontWeight: 1,color: whiteColor,isChangeColor: true),
                          ),
                        ),
                        commonVerticalSpacing(spacing: 8),
                        commonHeaderTitle(title: "Completed",fontSize: 1,fontWeight: 2,color: greenColor,isChangeColor: true)
                      ],
                    )
                  ],
                )
              ],
            ),
          )),
          commonVerticalSpacing(spacing: 27),
          commonNeumorphicView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  commonHeaderTitle(title: "Senior Score".toUpperCase(),fontSize: 1.7,fontWeight: 2),
                  Row(
                    children: [
                      commonHeaderTitle(title: "9.5".toUpperCase(),fontSize: 1.7,fontWeight: 2,isChangeColor: true,color: const Color(0xffBE48DB)),
                      commonHeaderTitle(title: "/10".toUpperCase(),fontSize: 1.3,fontWeight: 2,isChangeColor: true,color: lightFontColor),
                    ],
                  )
                ],
              ),
            )
          ),
          commonVerticalSpacing(spacing: 27),
          commonNeumorphicView(
            child: Padding(
                padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      commonHeaderTitle(title: "Kaizen",fontSize: 1.15,fontWeight: 1),
                      Row(
                        children: [
                          Container(
                            height: 7,width: 7,
                            decoration: const BoxDecoration(
                            color: ourBlueColor
                          ),),
                          commonHorizontalSpacing(spacing: 5),
                          commonHeaderTitle(title: "Total",fontSize: 0.7,fontWeight: 1),
                          commonHorizontalSpacing(spacing: 5),
                          Container(
                            height: 7,width: 7,
                            decoration: const BoxDecoration(
                                color: ourGreenColor
                            ),),
                          commonHorizontalSpacing(spacing: 5),
                          commonHeaderTitle(title: "Completed",fontSize: 0.7,fontWeight: 1),
                        ],
                      )
                    ],
                  ),
                  commonVerticalSpacing(),
                  Container(
                    height: 130,
                    width: getScreenWidth(context),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: defaultGraphImage,
                            fit: BoxFit.fill
                        )
                    ),
                  )
                ],
              ),
            ),
          ),

          commonVerticalSpacing(spacing: 27),
          commonNeumorphicView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      commonHeaderTitle(title: "Abnormality",fontSize: 1.15,fontWeight: 1),
                      Row(
                        children: [
                          Container(
                            height: 7,width: 7,
                            decoration: const BoxDecoration(
                                color: ourBlueColor
                            ),),
                          commonHorizontalSpacing(spacing: 5),
                          commonHeaderTitle(title: "Total",fontSize: 0.7,fontWeight: 1),
                          commonHorizontalSpacing(spacing: 5),
                          Container(
                            height: 7,width: 7,
                            decoration: const BoxDecoration(
                                color: ourGreenColor
                            ),),
                          commonHorizontalSpacing(spacing: 5),
                          commonHeaderTitle(title: "Completed",fontSize: 0.7,fontWeight: 1),
                        ],
                      )
                    ],
                  ),
                  commonVerticalSpacing(),
                  Container(
                    height: 130,
                    width: getScreenWidth(context),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: defaultGraphImage,
                            fit: BoxFit.fill
                        )
                    ),
                  )
                ],
              ),
            ),
          ),
          commonVerticalSpacing(spacing: 27),
        ],
      ),
    );
  }
}
