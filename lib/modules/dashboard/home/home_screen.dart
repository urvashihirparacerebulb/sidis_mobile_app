import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:my_projects/controllers/dashboard_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../common_widgets/common_widget.dart';
import '../../../utility/color_utility.dart';
import '../../../utility/screen_utility.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SelectionBehavior _selectionBehavior;

  @override
  void initState(){
    DashboardController.to.getKaizenChartData();
    _selectionBehavior = SelectionBehavior(
        enable: true);
    super.initState();
  }

  List<ChartData> getKaizenXData(){
    List<ChartData> myChartData = [];
    var val = DashboardController.to.kaizenCharts.value;
    for(int i = 0; i < val.value!.length; i ++){
      myChartData.add(ChartData(val.data![i], val.value![i], 0));
    }
    return myChartData;
  }

  List<ChartData> getAbnormalityXData(){
    List<ChartData> myChartData = [];
    var val = DashboardController.to.abnormalitiesCharts.value;
    for(int i = 0; i < val.value!.length; i ++){
      myChartData.add(ChartData(val.data![i], val.value![i], 0));
    }
    return myChartData;
  }

  List<ChartData> getKaizenYData(){
    List<ChartData> myChartData = [];
    var val = DashboardController.to.kaizenCharts.value;
    for(int i = 0; i < val.commpletedvalue!.length; i ++){
      myChartData.add(ChartData(val.data![i], 0, val.commpletedvalue![i]));
    }
    return myChartData;
  }

  List<ChartData> getAbnormalityYData(){
    List<ChartData> myChartData = [];
    var val = DashboardController.to.abnormalitiesCharts.value;
    for(int i = 0; i < val.commpletedvalue!.length; i ++){
      myChartData.add(ChartData(val.data![i], 0, val.commpletedvalue![i]));
    }
    return myChartData;
  }

  totalCompletedView(){
    return Row(
      children: [
        Container(
          height: isTablet() ? 11 : 7,width: isTablet() ? 11 : 7,
          decoration: const BoxDecoration(
              color: ourBlueColor
          ),),
        commonHorizontalSpacing(spacing: 5),
        commonHeaderTitle(title: "Total",fontSize: isTablet() ? 1.0 : 0.7,fontWeight: 1),
        commonHorizontalSpacing(spacing: 5),
        Container(
          height: isTablet() ? 11 : 7,width: isTablet() ? 11 : 7,
          decoration: const BoxDecoration(
              color: ourGreenColor
          ),),
        commonHorizontalSpacing(spacing: 5),
        commonHeaderTitle(title: "Completed",fontSize: isTablet() ? 1.0 : 0.7,fontWeight: 1),
      ],
    );
  }

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
                      color: lightFontColor,fontSize: isTablet() ? 1.1 : 0.90,fontWeight: 1),
                  commonVerticalSpacing(spacing: 5),
                  commonHeaderTitle(title: "SKAPS_Woven_Unit2(102)",
                      fontSize: isTablet() ? 1.7 : 1,fontWeight: 1),
                ],
              ),
              commonHorizontalSpacing(),
              Row(
                children: actionIcons(context,isAllowSpacing: true),
              )
            ],
          ),
          commonVerticalSpacing(spacing: 20),
          commonNeumorphicView(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonHeaderTitle(title: "Projects".toUpperCase(),fontSize: isTablet() ? 2.0 : 1.7,fontWeight: 2),
                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(isTablet() ? 18 : 14.0),
                          decoration: const BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: commonHeaderTitle(title: (DashboardController.to.kaizenCharts.value.totalProjects ?? 0).toString(),
                                fontSize: isTablet() ? 1.5 : 1.2,fontWeight: 1,color: whiteColor,isChangeColor: true,align: TextAlign.center),
                          ),
                        ),
                        commonVerticalSpacing(spacing: 8),
                        commonHeaderTitle(title: "Progress",fontSize: isTablet() ? 1.2 : 1,fontWeight: 2,color: primaryColor,isChangeColor: true)
                      ],
                    ),
                    commonHorizontalSpacing(spacing: 15),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(isTablet() ? 18 : 14.0),
                          decoration: const BoxDecoration(
                              color: greenColor,
                              shape: BoxShape.circle
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: commonHeaderTitle(title: (DashboardController.to.kaizenCharts.value.totalCompleted ?? 0).toString(),
                                fontSize: isTablet() ? 1.5 : 1.2,fontWeight: 1,color: whiteColor,isChangeColor: true),
                          ),
                        ),
                        commonVerticalSpacing(spacing: 8),
                        commonHeaderTitle(title: "Completed",fontSize: isTablet() ? 1.2 : 1,fontWeight: 2,color: greenColor,isChangeColor: true)
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
                  commonHeaderTitle(title: "Senior Score".toUpperCase(),fontSize: isTablet() ? 2.0 : 1.7,fontWeight: 2),
                  Row(
                    children: [
                      commonHeaderTitle(title: "9.5".toUpperCase(),fontSize: isTablet() ? 2.0 : 1.7,fontWeight: 2,isChangeColor: true,color: const Color(0xffBE48DB)),
                      commonHeaderTitle(title: "/10".toUpperCase(),fontSize: isTablet() ? 1.6 : 1.3,fontWeight: 2,isChangeColor: true,color: lightFontColor),
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
                      commonHeaderTitle(title: "Kaizen",fontSize: isTablet() ? 1.4 : 1.15,fontWeight: 1),
                      totalCompletedView()
                    ],
                  ),
                  commonVerticalSpacing(),
                  Obx(() => Visibility(
                    visible: DashboardController.to.kaizenCharts.value.data != null,
                    child: SfCartesianChart(
                        palette: const [
                          Color(0xff147AD6),
                          Color(0xff00BE4C),
                        ],
                        primaryXAxis: CategoryAxis(),
                        series: <ChartSeries<ChartData, String>>[
                          ColumnSeries<ChartData, String>(
                            dataSource: getKaizenXData(),
                            xValueMapper: (ChartData sales, _) => sales.x,
                            yValueMapper: (ChartData sales, _) => sales.y, // same y variable used but assign y data value from series -1 data source.
                          ),
                          ColumnSeries<ChartData, String>(
                            dataSource: getKaizenYData(),
                            xValueMapper: (ChartData sales, _) => sales.x,
                            // same y variable used but assign y data value from series -2 data source.
                            yValueMapper: (ChartData sales, _) => sales.y1,
                          ),
                        ]
                    ),
                  ))
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
                      commonHeaderTitle(title: "Abnormality",fontSize: isTablet() ? 1.4 : 1.15,fontWeight: 1),
                      totalCompletedView()
                    ],
                  ),
                  commonVerticalSpacing(),
                  Obx(() => Visibility(
                    visible: DashboardController.to.abnormalitiesCharts.value.data != null,
                    child: SfCartesianChart(
                        palette: const [
                          Color(0xff147AD6),
                          Color(0xff00BE4C),
                        ],
                        primaryXAxis: CategoryAxis(),
                        series: <ChartSeries<ChartData, String>>[
                          ColumnSeries<ChartData, String>(
                            dataSource: getAbnormalityXData(),
                            xValueMapper: (ChartData sales, _) => sales.x,
                            yValueMapper: (ChartData sales, _) => sales.y, // same y variable used but assign y data value from series -1 data source.
                          ),
                          ColumnSeries<ChartData, String>(
                            dataSource: getAbnormalityYData(),
                            xValueMapper: (ChartData sales, _) => sales.x,
                            // same y variable used but assign y data value from series -2 data source.
                            yValueMapper: (ChartData sales, _) => sales.y1,
                          ),
                        ]
                    ),
                  ))
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

class ChartData {
  ChartData(this.x, this.y,this.y1);
  final String x;
  final num y;
  final num y1;
}