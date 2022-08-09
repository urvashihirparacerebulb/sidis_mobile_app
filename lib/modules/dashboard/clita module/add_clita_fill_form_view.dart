import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_projects/controllers/business_controller.dart';
import 'package:my_projects/controllers/dropdown_data_controller.dart';
import 'package:my_projects/models/business_data_model.dart';
import 'package:my_projects/models/machines_response_model.dart';
import 'package:my_projects/utility/constants.dart';
import '../../../common_widgets/common_widget.dart';
import '../../../models/plants_response_model.dart';
import '../../../textfields/business_textfiled.dart';
import '../../../textfields/common_bottom_string_view.dart';
import '../../../textfields/machine_textfield.dart';
import '../../../textfields/plants_textfield.dart';
import '../../../theme/convert_theme_colors.dart';
import '../../../utility/color_utility.dart';
import '../../../utility/common_methods.dart';

class CLITAFillFormView extends StatefulWidget {
  const CLITAFillFormView({Key? key}) : super(key: key);

  @override
  State<CLITAFillFormView> createState() => _CLITAFillFormViewState();
}

class _CLITAFillFormViewState extends State<CLITAFillFormView> {

  TextEditingController dateController = TextEditingController();
  TextEditingController businessController = TextEditingController();
  TextEditingController plantsController = TextEditingController();
  TextEditingController machineController = TextEditingController();
  TextEditingController subMachineController = TextEditingController();
  TextEditingController intervalController = TextEditingController();
  BusinessData? selectedBusiness;
  CompanyBusinessPlant? selectedPlant;
  MachineData? machineData;
  MachineData? subMachineData;
  String selectedDate = "";
  bool isExpanded = true;

  @override
  void initState() {
    if(BusinessController.to.businessData!.isEmpty) {
      BusinessController.to.getBusinesses();
    }
    super.initState();
  }

  getActivityList(){
    DropDownDataController.to.activityData!.clear();
    if(selectedBusiness != null && selectedPlant != null && machineData != null && intervalController.text.isNotEmpty && selectedDate.isNotEmpty){
      DropDownDataController.to.getActivityCheckList(
        businessId: selectedBusiness!.businessId.toString(),
        machineId: machineData!.machineId.toString(),
        subMachineId: subMachineData == null ? "" : subMachineData!.machineId.toString(),
        intervalId: getIntervalIdToString(intervalString: intervalController.text),
        date: selectedDate
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return commonStructure(
        context: context,
        bgColor: blackColor,
        appBar: commonAppbar(context: context,title: clitaFillFormText),
        child: Obx((){
          return BusinessController.to.businessData!.isEmpty ? const SpinKitThreeBounce(
            color: primaryColor,
            size: 30.0,
          ) : ListView(
            shrinkWrap: true,
            children: [
              commonVerticalSpacing(),
              InkWell(
                onTap: (){
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: neurmorphicBoxDecoration,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      commonHeaderTitle(
                          title: "Change Filter",
                          color: blackColor.withOpacity(0.4),
                        fontWeight: 2,
                        fontSize: 1.2
                      ),
                      commonHorizontalSpacing(),
                      Icon(isExpanded ? Icons.keyboard_arrow_up_outlined : Icons.keyboard_arrow_down,color: ConvertTheme.convertTheme.getWhiteToFontColor(),)
                    ],
                  ),
                )
              ),
              Visibility(
                visible: isExpanded,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      InkWell(
                        onTap: (){
                          commonBottomView(context: context,child: BusinessBottomView(myItems: BusinessController.to.businessData!,selectionCallBack: (BusinessData business){
                            selectedBusiness = business;
                            setState(() {});
                            if(selectedBusiness?.businessId != null) {
                              DropDownDataController.to.getCompanyPlants(businessId: selectedBusiness?.businessId.toString(),successCallback: (){
                                getActivityList();
                              });
                            }
                          }));
                        },
                        child: commonDecoratedTextView(
                            title: selectedBusiness?.businessId == null ? "Select Business" : selectedBusiness?.businessName ?? "",
                            isChangeColor: selectedBusiness?.businessId == null ? true : false
                        ),
                      ),
                      InkWell(
                          onTap: (){
                            if(selectedBusiness?.businessId != null) {
                              commonBottomView(context: context,
                                  child: PlantBottomView(
                                      myItems: DropDownDataController.to
                                          .companyBusinessPlants!,
                                      selectionCallBack: (
                                          CompanyBusinessPlant plant) {
                                        selectedPlant = plant;
                                        setState(() {});
                                        if (selectedPlant != null) {
                                          DropDownDataController.to.getMachines(
                                              plantId: selectedPlant!.soleId,
                                              successCallback: () {
                                                getActivityList();
                                              });
                                        }
                                      }));
                            }
                          },
                          child: commonDecoratedTextView(
                            title: selectedPlant == null ? "Select Plant" : selectedPlant!.soleName ?? "",
                            isChangeColor: selectedPlant == null ? true : false,
                          )
                      ),
                      InkWell(
                          onTap: (){
                            if(selectedPlant != null) {
                              commonBottomView(context: context,
                                  child: MachineBottomView(
                                      hintText: "Select Machine",
                                      myItems: DropDownDataController.to.machinesList!,
                                      selectionCallBack: (
                                          MachineData machine) {
                                        machineData = machine;
                                        if (machineData != null) {
                                          setState(() {});
                                          DropDownDataController.to.getSubMachines(plantId: selectedPlant!.soleId,machineId: machineData!.machineId,successCallback: (){
                                            getActivityList();
                                          });
                                        }
                                      }));
                            }
                          },
                          child: commonDecoratedTextView(
                            bottom: subMachineData == null ? 25 : 0,
                            title: machineData == null ? "Select Machine" : machineData!.machineName ?? "",
                            isChangeColor: machineData == null ? true : false,
                          )
                      ),
                      commonVerticalSpacing(spacing: subMachineData == null ? 0 : 25),
                      Visibility(
                        visible: machineData == null ? false : true,
                        child: InkWell(
                            onTap: (){
                              commonBottomView(context: context,
                                  child: MachineBottomView(
                                      hintText: "Select Sub Machine",
                                      myItems: DropDownDataController.to.subMachinesList!,
                                      selectionCallBack: (
                                          MachineData machine) {
                                        subMachineData = machine;
                                        setState(() {});
                                        if (subMachineData != null) {
                                          getActivityList();
                                        }
                                      }));
                            },
                            child: commonDecoratedTextView(
                              title: subMachineData == null ? "Select Sub Machine" : subMachineData!.machineName ?? "",
                              isChangeColor: subMachineData == null ? true : false,
                            )
                        ),
                      ),
                      InkWell(
                          onTap: (){
                            commonBottomView(context: context,
                                child: CommonBottomStringView(
                                    hintText: "Select Interval",
                                    myItems: BusinessController.to.intervalList,
                                    selectionCallBack: (
                                        String val) {
                                      setState(() {
                                        intervalController.text = val;
                                      });
                                      getActivityList();
                                    }));
                          },
                          child: commonDecoratedTextView(
                            title: intervalController.text.isEmpty ? "Select Interval" : intervalController.text,
                            isChangeColor: intervalController.text.isEmpty ? true : false,
                          )
                      ),
                      Container(
                          height: 48,
                          padding: EdgeInsets.symmetric(horizontal: commonHorizontalPadding),
                          decoration: neurmorphicBoxDecoration,
                          child: Stack(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: commonHeaderTitle(title: selectedDate.isEmpty ? "Select Date" : selectedDate)
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
                                          selectedDate = DateFormat("dd MMM,yyyy").format(value);
                                        });
                                        getActivityList();
                                      });
                                    },
                                    child: Icon(Icons.calendar_month, color: blackColor.withOpacity(0.4)),
                                  )),
                            ],
                          )),
                      commonVerticalSpacing(spacing: 15),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Visibility(
                  visible: selectedBusiness?.businessId != null && selectedPlant != null && machineData != null && subMachineData != null && intervalController.text.isNotEmpty && selectedDate.isNotEmpty,
                  child: Obx(() => ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: DropDownDataController.to.activityData!.length,
                    itemBuilder: (context, index) => getActivityCard(
                        activityResponse: DropDownDataController.to.activityData![index],
                        callback: (val) {
                          DropDownDataController.to.activityData![index].isSelected = val;
                          DropDownDataController.to.activityData!.refresh();
                        }
                    ),
                  )),
                ),
              )
            ],
          );
        })
    );
  }
}
