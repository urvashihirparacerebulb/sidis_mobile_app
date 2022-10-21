import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../common_widgets/common_textfield.dart';
import '../../../common_widgets/common_widget.dart';
import '../../../controllers/business_controller.dart';
import '../../../controllers/dropdown_data_controller.dart';
import '../../../models/business_data_model.dart';
import '../../../models/plants_response_model.dart';
import '../../../textfields/business_textfiled.dart';
import '../../../textfields/plants_textfield.dart';
import '../../../theme/convert_theme_colors.dart';
import '../../../utility/color_utility.dart';
import '../../../utility/common_methods.dart';
import '../../../utility/constants.dart';
import '../../../utility/screen_utility.dart';

class AddProjectView extends StatefulWidget {
  const AddProjectView({Key? key}) : super(key: key);

  @override
  State<AddProjectView> createState() => _AddProjectViewState();
}

class _AddProjectViewState extends State<AddProjectView> {
  BusinessData? selectedBusiness;
  CompanyBusinessPlant? selectedPlant;
  TextEditingController projectNameController = TextEditingController();
  TextEditingController projectDesController = TextEditingController();
  String selectedStartDate = "";
  String selectedEndDate = "";

  @override
  Widget build(BuildContext context) {
    return commonStructure(
        context: context,
        bgColor: blackColor,
        appBar: commonAppbar(context: context,title: "Add Project"),
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

                    },
                    isLoading: false)),
              ],
            ),
          ),
        ),
        child: Obx(() {
          return BusinessController.to.businessData!.isEmpty ? const SpinKitThreeBounce(
            color: primaryColor,
            size: 30.0,
          ) : ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0,right: 24.0,top: 24.0),
                child: ListView(
                  shrinkWrap: true,
                      children: [
                        InkWell(
                          onTap: (){
                            commonBottomView(context: context,child: BusinessBottomView(myItems: BusinessController.to.businessData!,selectionCallBack: (BusinessData business){
                              selectedBusiness = business;
                              selectedPlant = null;
                              setState(() {});
                              if(selectedBusiness?.businessId != null) {
                                DropDownDataController.to.getCompanyPlants(businessId: selectedBusiness?.businessId.toString(),successCallback: (){
                                  // getActivityList();
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
                                        businessId: selectedBusiness!.businessId.toString(),
                                        selectionCallBack: (
                                            CompanyBusinessPlant plant) {
                                          selectedPlant = plant;
                                          setState(() {});
                                          if (selectedPlant != null) {
                                            DropDownDataController.to.getMachines(
                                                plantId: selectedPlant!.soleId,
                                                successCallback: () {

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

                          },
                          child: commonDecoratedTextView(
                              title: "Select Team",
                              isChangeColor: true
                          ),
                        ),

                        CommonTextFiled(
                            fieldTitleText: "Project Name*",
                            hintText: "Project Name*",
                            // isBorderEnable: false,
                            isChangeFillColor: true,
                            textEditingController: projectNameController,
                            onChangedFunction: (String value){
                            },
                            validationFunction: (String value) {
                              return value.toString().isEmpty
                                  ? notEmptyFieldMessage
                                  : null;
                            }),
                        commonVerticalSpacing(spacing: 20),
                        CommonTextFiled(
                            fieldTitleText: "Project Description*",
                            hintText: "Project Description*",
                            // isBorderEnable: false,
                            isChangeFillColor: true,
                            maxLine: 5,
                            textEditingController: projectDesController,
                            onChangedFunction: (String value){
                            },
                            validationFunction: (String value) {
                              return value.toString().isEmpty
                                  ? notEmptyFieldMessage
                                  : null;
                            }
                         ),
                        commonVerticalSpacing(spacing: 20),
                        Row(
                          children: [
                            Expanded(child: Container(
                                height: 50,
                                padding: EdgeInsets.symmetric(horizontal: commonHorizontalPadding),
                                decoration: neurmorphicBoxDecoration,
                                child: Stack(
                                  children: [
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: commonHeaderTitle(
                                            fontSize: isTablet() ? 1.3 : 1,
                                            title: selectedStartDate.isEmpty ? "Select Start Date" : selectedStartDate)
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
                                                selectedStartDate = DateFormat("dd MMM,yyyy").format(value);
                                              });
                                            });
                                          },
                                          child: Icon(Icons.calendar_month, color: blackColor.withOpacity(0.4)),
                                        )),
                                  ],
                                ))),
                            commonHorizontalSpacing(),
                            Expanded(child: Container(
                                height: 50,
                                padding: EdgeInsets.symmetric(horizontal: commonHorizontalPadding),
                                decoration: neurmorphicBoxDecoration,
                                child: Stack(
                                  children: [
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: commonHeaderTitle(
                                            fontSize: isTablet() ? 1.3 : 1,
                                            title: selectedEndDate.isEmpty ? "Select End Date" : selectedEndDate)
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
                                                selectedEndDate = DateFormat("dd MMM,yyyy").format(value);
                                              });
                                            });
                                          },
                                          child: Icon(Icons.calendar_month, color: blackColor.withOpacity(0.4)),
                                        )),
                                  ],
                                )),)
                          ],
                        )
                      ],
                ),
              )
            ],
          );
        })
    );
  }
}
