import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_projects/models/kaizen_response_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../common_widgets/common_textfield.dart';
import '../../../common_widgets/common_widget.dart';
import '../../../configurations/config_file.dart';
import '../../../controllers/kaizen_controller.dart';
import '../../../textfields/common_bottom_string_view.dart';
import '../../../theme/convert_theme_colors.dart';
import '../../../utility/color_utility.dart';
import '../../../utility/common_methods.dart';
import '../../../utility/constants.dart';
import '../../../utility/screen_utility.dart';
import '../home/home_screen.dart';

class FinishKaizenFormView extends StatefulWidget {
  final KaizenList kaizenList;
  const FinishKaizenFormView({Key? key, required this.kaizenList}) : super(key: key);

  @override
  State<FinishKaizenFormView> createState() => _FinishKaizenFormViewState();
}

class _FinishKaizenFormViewState extends State<FinishKaizenFormView> {
  KaizenDetail? kaizen;
  TableReqParameter? reqTableParams = TableReqParameter();
  @override
  void initState() {
    KaizenController.to.getKaizenOtherBenifits(kaizenId: widget.kaizenList.kaizenId.toString(),callback: (){
      KaizenController.to.getKaizenDetail(kaizenId: widget.kaizenList.kaizenId.toString(),callback: (){
        kaizen = KaizenController.to.kaizenDetail.value;
      });
    });
    super.initState();
  }

  String kaizenFinishDate = "";
  TextEditingController waitingTimeController = TextEditingController();
  TextEditingController columnsController = TextEditingController();
  TextEditingController rowsController = TextEditingController();
  TextEditingController textViewController = TextEditingController();
  TextEditingController chartXAxisController = TextEditingController();
  TextEditingController chartYAxisController = TextEditingController();
  TextEditingController otherBenifitsController = TextEditingController();
  bool isEdit = false;
  int? selectedKaizenIndex;
  BenifitsData? editableBenifit;
  RxList<ChartData> chartDataChanged = RxList<ChartData>();

  List<ChartData> listOfChartData(){
    List<ChartData> myChartData = [];
    if(chartXAxisController.text.isNotEmpty && chartYAxisController.text.isNotEmpty){
      List<String> splitedXAxis = chartXAxisController.text.split(",");
      List<String> splitedYAxis = chartYAxisController.text.split(",");
      for (int i = 0; i < splitedXAxis.length; i ++) {
        myChartData.add(ChartData(splitedXAxis[i], splitedYAxis.length == splitedXAxis.length ? num.parse(splitedYAxis[i]) : 0, 0));
      }
    }
    return myChartData;
  }

  otherBenifitsView(){
    return [
      Obx(() => Visibility(
        visible: KaizenController.to.benifitsData.isNotEmpty,
        child: ListView.builder(
            itemCount: KaizenController.to.benifitsData.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 16),
                decoration: neurmorphicBoxDecoration,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: commonHeaderTitle(title: KaizenController.to.benifitsData[index].otherBenifits ?? "",
                          fontWeight: 0,fontSize: isTablet() ? 1.5 : 1.2),),
                      commonHorizontalSpacing(),
                      Row(
                          children: [
                            InkWell(
                                onTap: (){
                                  setState(() {
                                    isEdit = true;
                                    editableBenifit = KaizenController.to.benifitsData[index];
                                    otherBenifitsController.text = editableBenifit!.otherBenifits ?? "";
                                  });
                                },
                                child: const Icon(Icons.edit,color: Colors.orange)),
                            commonHorizontalSpacing(),
                            InkWell(
                              onTap: (){
                                KaizenController.to.deleteKaizenBenifits(kaizenId: widget.kaizenList.kaizenId.toString(),
                                    benifitId: KaizenController.to.benifitsData[index].otherBenifitsId.toString()
                                );
                              },
                                child: const Icon(Icons.delete_outline,color: Colors.redAccent)),
                          ]
                      )
                    ]
                ),
              );
            }),
      )),

      Row(
        children: [
          Expanded(
            child: CommonTextFiled(
                fieldTitleText: "Other Benifits",
                hintText: "Other Benifits",
                // isBorderEnable: false,
                isChangeFillColor: true,
                textEditingController: otherBenifitsController,
                onChangedFunction: (String value){

                },
                validationFunction: (String value) {
                  return value.toString().isEmpty
                      ? notEmptyFieldMessage
                      : null;
                }),
          ),
          commonHorizontalSpacing(spacing: 10),
          InkWell(
            onTap: (){
              if(isEdit){
                KaizenController.to.getManageKaizenBenifits(
                    otherBenifitsText: otherBenifitsController.text,
                    isEdit: true,
                    editOtherKaizenId: editableBenifit!.otherBenifitsId.toString(),
                    kaizenId: widget.kaizenList.kaizenId.toString()
                );
                otherBenifitsController.clear();
                isEdit = false;
              }else {
                KaizenController.to.getManageKaizenBenifits(
                    otherBenifitsText: otherBenifitsController.text,
                    kaizenId: widget.kaizenList.kaizenId.toString(),
                );
                otherBenifitsController.clear();
              }
            },
            child: Container(
                margin: const EdgeInsets.only(top: 8),
                padding: EdgeInsets.all(isEdit ? 12 : 8),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8.0)
                ),
                child: isEdit ? commonHeaderTitle(title: "Edit",isChangeColor: true,color: whiteColor) : const Icon(Icons.add,color: whiteColor,size: 26)),
          )
        ],
      )
    ];
  }

  chartViewFields(){
    return StatefulBuilder(builder: (context, newSetState) {
      return Column(
        children: [
          CommonTextFiled(
              fieldTitleText: "Waiting Time (In Hours)",
              hintText: "Waiting Time (In Hours)",
              // isBorderEnable: false,
              isChangeFillColor: true,
              textEditingController: waitingTimeController,
              onChangedFunction: (String value){
              },
              validationFunction: (String value) {
                return value.toString().isEmpty
                    ? notEmptyFieldMessage
                    : null;
              }),
          commonVerticalSpacing(spacing: 20),
          CommonTextFiled(
              fieldTitleText: "Chart X Axis",
              hintText: "Chart X Axis",
              // isBorderEnable: false,
              isChangeFillColor: true,
              textEditingController: chartXAxisController,
              onChangedFunction: (String value){
                newSetState((){});
              },
              validationFunction: (String value) {
                return value.toString().isEmpty
                    ? notEmptyFieldMessage
                    : null;
              }),

          commonVerticalSpacing(spacing: 20),
          CommonTextFiled(
              fieldTitleText: "Chart Y Axis with number value",
              hintText: "Chart Y Axis(Num value seperated By ,) ",
              // isBorderEnable: false,
              isChangeFillColor: true,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              textEditingController: chartYAxisController,
              onFieldSubmit: (){
                newSetState((){});
              },
              onChangedFunction: (String value){
              },
              validationFunction: (String value) {
                return value.toString().isEmpty
                    ? notEmptyFieldMessage
                    : null;
              }),
          commonVerticalSpacing(spacing: chartXAxisController.text.isNotEmpty && chartYAxisController.text.isNotEmpty ? 20 : 0),
          Visibility(
            visible: chartXAxisController.text.isNotEmpty && chartYAxisController.text.isNotEmpty,
            child: SfCartesianChart(
                palette: const [
                  Color(0xff147AD6),
                ],
                primaryXAxis: CategoryAxis(),
                series: <ChartSeries<ChartData, String>>[
                  ColumnSeries<ChartData, String>(
                    dataSource: listOfChartData(),
                    xValueMapper: (ChartData sales, _) => sales.x,
                    yValueMapper: (ChartData sales, _) => sales.y, // same y variable used but assign y data value from series -1 data source.
                  ),
                ]
            ),
          ),
        ],
      );
    });
  }

  tableViewFields(){
    return Column(
      children: [
        CommonTextFiled(
            fieldTitleText: "Columns",
            hintText: "Columns",
            // isBorderEnable: false,
            keyboardType: TextInputType.number,
            isChangeFillColor: true,
            textEditingController: columnsController,
            onChangedFunction: (String value){
              reqTableParams?.columns = [];
              for(int i =0; i < int.parse(columnsController.text); i++){
                reqTableParams?.columns?.add("");
              }
            },
            validationFunction: (String value) {
              return value.toString().isEmpty
                  ? notEmptyFieldMessage
                  : null;
            }),
        commonVerticalSpacing(spacing: 20),
        CommonTextFiled(
            fieldTitleText: "Rows",
            hintText: "Rows",
            // isBorderEnable: false,
            isChangeFillColor: true,
            keyboardType: TextInputType.number,
            textEditingController: rowsController,
            onChangedFunction: (String value){
              reqTableParams?.rows = [];
              for(int i =0; i < int.parse(rowsController.text); i++){
                reqTableParams?.rows?.add([]);
              }
              reqTableParams?.rows?.forEach((element) {
                for(int i = 0; i < int.parse(columnsController.text); i++){
                  element.add("");
                }
              });
            },
            validationFunction: (String value) {
              return value.toString().isEmpty
                  ? notEmptyFieldMessage
                  : null;
            }),
        commonVerticalSpacing(spacing: 20),
        columnsController.text.isNotEmpty && rowsController.text.isNotEmpty ?
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
              rows: <DataRow>[
            for (int i = 0; i < reqTableParams!.rows!.length; i++) _getDataRow(i),
          ], columns: <DataColumn>[
            for (int i = 0; i < reqTableParams!.columns!.length; i++) _getDataColumn(i),
          ]),
        )
            : Container()
      ],
    );
  }

  textViewFields(){
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: CommonTextFiled(
          fieldTitleText: "Enter text result",
          hintText: "Enter text result",
          // isBorderEnable: false,
          isChangeFillColor: true,
          maxLine: 4,
          textEditingController: textViewController,
          onChangedFunction: (String value){
          },
          validationFunction: (String value) {
            return value.toString().isEmpty
                ? notEmptyFieldMessage
                : null;
          }),
    );
  }

  DataRow _getDataRow(int rowIndex) {
    return DataRow(
      cells: <DataCell>[
        for (int i = 0; i < reqTableParams!.columns!.length; i++) getCells(i,rowIndex)
      ],
    );
  }

  DataCell getCells(int i, rowIndex){
    return DataCell(DataTableTextFieldView(initialText: reqTableParams?.columns == null || reqTableParams!.columns!.isEmpty ? "" : reqTableParams!.columns![i],onChange: (String val){
        reqTableParams!.rows![rowIndex][i] = val;
      },
    ));
  }

  DataColumn _getDataColumn(int i) {
    return DataColumn(
      label: DataTableTextFieldView(initialText: reqTableParams?.columns == null || reqTableParams!.columns!.isEmpty ? "" : reqTableParams!.columns![i],onChange: (String val){
        reqTableParams!.columns![i] = val;
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return commonStructure(
      context: context,
      bgColor: blackColor,
      appBar: commonAppbar(context: context,title: "Finish Kaizen"),
      bottomNavigation: Container(
          color: ConvertTheme.convertTheme.getBackGroundColor(),
          child: Padding(
            padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16,top: 10),
            child: Row(
              children: [
                Expanded(child: commonBorderButtonView(
                    context: context,
                    title: "Cancel",
                    height: 50,
                    tapOnButton: () {
                      Get.back();
                    },
                    isLoading: false)),
                commonHorizontalSpacing(),
                Expanded(child: commonFillButtonView(
                    context: context,
                    title: "Save",
                    width: getScreenWidth(context) - 40,
                    height: 50,
                    tapOnButton: () {
                      if(KaizenController.to.kaizenResultInList.contains("Text")){
                        if(textViewController.text.isEmpty){
                          return showSnackBar(title: ApiConfig.error, message: "Please enter text result");
                        }
                      }
                      if(KaizenController.to.kaizenResultInList.contains("Table")){
                        if(columnsController.text.isEmpty || rowsController.text.isEmpty){
                          return showSnackBar(title: ApiConfig.error, message: "Please enter table values");
                        }
                      }
                      if(KaizenController.to.kaizenResultInList.contains("Chart")){
                        if(waitingTimeController.text.isEmpty || chartXAxisController.text.isEmpty || chartYAxisController.text.isEmpty){
                          return showSnackBar(title: ApiConfig.error, message: "Please enter chart field values");
                        }
                      }
                      KaizenFinishRequestModel finishKaizen = KaizenFinishRequestModel();
                      finishKaizen.kaizenId = widget.kaizenList.kaizenId.toString();
                      finishKaizen.plantId = kaizen?.plantId.toString();
                      finishKaizen.pillarCategoryId = kaizen?.pillarCategoryId.toString();
                      finishKaizen.departmentId = kaizen?.departmentId.toString();
                      finishKaizen.plantShortName = kaizen?.plantShortName;
                      finishKaizen.pillarName = kaizen?.pillarName;
                      finishKaizen.departmentName = kaizen?.departmentName;
                      finishKaizen.finishDate = kaizenFinishDate;
                      finishKaizen.kaizenTheme = kaizen?.theme;
                      finishKaizen.textResult = textViewController.text;
                      finishKaizen.tableResultColoum = columnsController.text;
                      finishKaizen.tableResultRows = rowsController.text;
                      finishKaizen.showTableResult = reqTableParams;
                      finishKaizen.chartTitle = waitingTimeController.text;
                      finishKaizen.chartResultX = chartXAxisController.text;
                      finishKaizen.chartResultY = chartYAxisController.text;
                      finishKaizen.manageUserId = getLoginData()!.userdata!.first.id.toString();
                      KaizenController.to.finishKaizenForm(kaizenFinishRequestModel: finishKaizen);
                    },
                    isLoading: false)
                ),
              ],
            ),
          ),
        ),
        child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            commonVerticalSpacing(spacing: 20),
            Row(
              children: [
                commonHeaderTitle(title: "Request No : ",fontWeight: 3,fontSize: isTablet() ? 1.5 : 1.2),
                Expanded(child: commonHeaderTitle(title: widget.kaizenList.requestNo ?? "",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),)
              ],
            ),
            commonVerticalSpacing(spacing: 20),
            Row(
              children: [
                commonHeaderTitle(title: "Kaizen Theme : ",fontWeight: 3,fontSize: isTablet() ? 1.5 : 1.2),
                Expanded(child: commonHeaderTitle(title: widget.kaizenList.theme ?? "",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),)
              ],
            ),
            commonVerticalSpacing(spacing: 20),
            Row(
              children: [
                commonHeaderTitle(title: "Kaizen Pillar : ",fontWeight: 3,fontSize: isTablet() ? 1.5 : 1.2),
                Expanded(child: commonHeaderTitle(title: widget.kaizenList.pillarName ?? "",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),)
              ],
            ),
            commonVerticalSpacing(spacing: 30),
            commonHeaderTitle(title: "Kaizen Finish Date",fontWeight: 3,fontSize: isTablet() ? 1.5 : 1.2),
            commonVerticalSpacing(),
            Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: commonHorizontalPadding),
                decoration: neurmorphicBoxDecoration,
                child: Stack(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: commonHeaderTitle(
                            fontSize: isTablet() ? 1.3 : 1,
                            title: kaizenFinishDate.isEmpty ? "Select Kaizen Finish Date" : kaizenFinishDate)
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            openCalendarView(
                              context,
                              initialDate: DateTime.now().toString(),
                            ).then((value) {
                              setState(() {
                                kaizenFinishDate = DateFormat("dd MMM,yyyy").format(value);
                              });
                            });
                          },
                          child: Icon(Icons.calendar_month, color: blackColor.withOpacity(0.4)),
                        )),
                  ],
                )),
            commonVerticalSpacing(spacing: 20),
            commonHeaderTitle(title: "Show Result In",fontWeight: 3,fontSize: isTablet() ? 1.5 : 1.2),
            commonVerticalSpacing(),
            InkWell(
              onTap: (){
                commonBottomView(context: context,
                    child: CommonBottomStringView(
                        hintText: "Select Result In",
                        myItems: const ["Text","Table","Chart"],
                        selectionCallBack: (
                            String val) {
                          KaizenController.to.kaizenResultInList.add(val);
                        }));
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Obx(() => KaizenController.to.kaizenResultInList.isEmpty ? commonHeaderTitle(
                  title: "Select Result In",
                  isChangeColor: true,
                  color: blackColor
                ) : Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  runAlignment: WrapAlignment.start,
                  children: KaizenController.to.kaizenResultInList.map((i) => Container(
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(16)
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(i,style: const TextStyle(
                              color: whiteColor,
                              fontSize: 14
                          )),
                          commonHorizontalSpacing(),
                          InkWell(
                            onTap: (){
                              KaizenController.to.kaizenResultInList.remove(i);
                            },
                              child: const Icon(Icons.close,color: whiteColor,size: 20))
                        ],
                      )
                  )).toList(),
                )),
              ),
            ),
            commonVerticalSpacing(spacing: 20),
            Obx(() => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                KaizenController.to.kaizenResultInList.contains("Text") ? textViewFields() : Container(),
                KaizenController.to.kaizenResultInList.contains("Table") ? tableViewFields() : Container(),
                KaizenController.to.kaizenResultInList.contains("Chart") ? chartViewFields() : Container()
              ],
            ),),
            commonVerticalSpacing(spacing: 30),
            commonHeaderTitle(title: "Other Benifits",fontWeight: 3,fontSize: isTablet() ? 1.5 : 1.2),
            commonVerticalSpacing(spacing: 20),
            ...otherBenifitsView(),
            commonVerticalSpacing(spacing: 20)
          ],
        ),
      )
    );
  }
}

class KaizenFinishRequestModel{
  String? kaizenId;
  String? plantId;
  String? pillarCategoryId;
  String? departmentId;
  String? plantShortName;
  String? pillarName;
  String? departmentName;
  String? finishDate;
  String? kaizenTheme;
  String? textResult;
  String? tableResultColoum;
  String? tableResultRows;
  TableReqParameter? showTableResult;
  String? chartTitle;
  String? chartResultX;
  String? chartResultY;
  String? manageUserId;
}

class DataTableTextFieldView extends StatefulWidget {
  final String initialText;
  final Function onChange;
  const DataTableTextFieldView({Key? key, required this.initialText, required this.onChange}) : super(key: key);

  @override
  State<DataTableTextFieldView> createState() => _DataTableTextFieldViewState();
}

class _DataTableTextFieldViewState extends State<DataTableTextFieldView> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    searchController.text = widget.initialText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: TextField(
        controller: searchController,
        onChanged: (String value){
          // setState(() {
          //   searchController.text = value;
          // });
        },
        onSubmitted: (String value){
          widget.onChange(value);
        },
      ),
    );
  }
}

class TableReqParameter{
  List<String>? columns = [];
  List<List<String>>? rows = [];
}