import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:my_projects/controllers/abnormality_controller.dart';
import 'package:my_projects/controllers/department_controller.dart';
import 'package:my_projects/models/department_response_model.dart';
import 'package:my_projects/utility/constants.dart';
import '../../../common_widgets/common_textfield.dart';
import '../../../common_widgets/common_widget.dart';
import '../../../controllers/business_controller.dart';
import '../../../controllers/dropdown_data_controller.dart';
import '../../../models/activities_response_model.dart';
import '../../../models/business_data_model.dart';
import '../../../models/machines_response_model.dart';
import '../../../models/plants_response_model.dart';
import '../../../textfields/abnormality_type_field.dart';
import '../../../textfields/business_textfiled.dart';
import '../../../textfields/department_textfiled.dart';
import '../../../textfields/machine_textfield.dart';
import '../../../textfields/plants_textfield.dart';
import '../../../theme/convert_theme_colors.dart';
import '../../../utility/color_utility.dart';
import '../../../utility/screen_utility.dart';

class AddAbnormalityFormView extends StatefulWidget {
  const AddAbnormalityFormView({Key? key}) : super(key: key);

  @override
  State<AddAbnormalityFormView> createState() => _AddAbnormalityFormViewState();
}

class _AddAbnormalityFormViewState extends State<AddAbnormalityFormView> {
  TextEditingController abnormalityController = TextEditingController();
  TextEditingController abnormalityTitleController = TextEditingController();
  TextEditingController partNameController = TextEditingController();
  TextEditingController possibleSolutionController = TextEditingController();
  BusinessData? selectedBusiness;
  CompanyBusinessPlant? selectedPlant;
  Department? selectedDepartment;
  Department? selectedSubDepartment;
  AbnormalityType? selectedAbnormalityType;
  MachineData? machineData;
  MachineData? subMachineData;

  @override
  void initState() {
    if(BusinessController.to.businessData!.isEmpty) {
      BusinessController.to.getBusinesses();
    }
    Future.delayed(const Duration(seconds: 5), () {
      AbnormalityController.to.getAbnormalityType();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return commonStructure(
        context: context,
        bgColor: blackColor,
        appBar: commonAppbar(context: context,title: abnormalityFormText),
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
                        if(selectedBusiness != null && selectedPlant != null &&
                            selectedDepartment != null && selectedSubDepartment != null &&
                            machineData != null && subMachineData != null &&
                            selectedAbnormalityType != null && partNameController.text.isNotEmpty &&
                            abnormalityTitleController.text.isNotEmpty){

                        }
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
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0,right: 24.0,top: 24.0),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          commonHeaderTitle(title: "Where is Abnormality?",fontSize: 1.2,fontWeight: 2,color: darkFontColor),
                          commonVerticalSpacing(spacing: 20),
                          InkWell(
                            onTap: (){
                              commonBottomView(context: context,child: BusinessBottomView(myItems: BusinessController.to.businessData!,selectionCallBack: (BusinessData business){
                                selectedBusiness = business;
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
                                          selectionCallBack: (
                                              CompanyBusinessPlant plant) {
                                            selectedPlant = plant;
                                            setState(() {});
                                            if (selectedPlant != null) {
                                              DropDownDataController.to.getMachines(
                                                  plantId: selectedPlant!.soleId,
                                                  successCallback: () {
                                                    DepartmentController.to.getDepartment(
                                                        soleId: selectedPlant!.soleId
                                                    );
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
                                      child: DepartmentBottomView(
                                          hintText: "Select Department",
                                          myItems: DepartmentController.to.departmentData!,
                                          selectionCallBack: (
                                              Department department) {
                                            selectedDepartment = department;
                                            setState(() {});
                                            if (selectedDepartment != null) {
                                              DepartmentController.to.getSubDepartment(departmentId: selectedDepartment!.departmentId.toString());
                                            }
                                          }));
                                }
                              },
                              child: commonDecoratedTextView(
                                bottom: selectedSubDepartment == null ? 25 : 0,
                                title: selectedDepartment == null ? "Select Department" : selectedDepartment!.departmentName ?? "",
                                isChangeColor: selectedDepartment == null ? true : false,
                              )
                          ),
                          commonVerticalSpacing(spacing: selectedSubDepartment == null ? 0 : 25),
                          InkWell(
                              onTap: (){
                                if(selectedDepartment != null) {
                                  commonBottomView(context: context,
                                      child: DepartmentBottomView(
                                          hintText: "Select Sub Department",
                                          myItems: DepartmentController.to.subDepartmentData!,
                                          selectionCallBack: (Department subDepartment) {
                                            selectedSubDepartment = subDepartment;
                                            setState(() {});
                                          }));
                                }
                              },
                              child: commonDecoratedTextView(
                                title: selectedSubDepartment == null ? "Select Sub Machine" : selectedSubDepartment!.departmentName ?? "",
                                isChangeColor: selectedSubDepartment == null ? true : false,
                              )
                          ),
                          commonHeaderTitle(title: "Machine Detail",fontSize: 1.2,fontWeight: 2,color: darkFontColor),
                          commonVerticalSpacing(spacing: 20),
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
                                            }
                                          }));
                                },
                                child: commonDecoratedTextView(
                                  title: subMachineData == null ? "Select Sub Machine" : subMachineData!.machineName ?? "",
                                  isChangeColor: subMachineData == null ? true : false,
                                )
                            ),
                          ),
                          CommonTextFiled(
                            fieldTitleText: "Part Name*",
                            hintText: "Part Name*",
                            // isBorderEnable: false,
                            isChangeFillColor: true,
                            textEditingController: partNameController,
                            onChangedFunction: (String value){
                            },
                            validationFunction: (String value) {
                              return value.toString().isEmpty
                                  ? notEmptyFieldMessage
                                  : null;
                            },),
                          commonVerticalSpacing(spacing: 30),
                          commonHeaderTitle(title: "Abnormality Detail",fontSize: 1.2,fontWeight: 2,color: darkFontColor),
                          commonVerticalSpacing(spacing: 20),
                          CommonTextFiled(
                            fieldTitleText: "Abnormality Title*",
                            hintText: "Abnormality Title*",
                            // isBorderEnable: false,
                            isChangeFillColor: true,
                            textEditingController: abnormalityTitleController,
                            onChangedFunction: (String value){
                            },
                            validationFunction: (String value) {
                              return value.toString().isEmpty
                                  ? notEmptyFieldMessage
                                  : null;
                            },),
                          commonVerticalSpacing(spacing: 20),
                          InkWell(
                              onTap: (){
                                  commonBottomView(context: context,
                                      child: AbnormalityTypeBottomView(
                                          myItems: AbnormalityController.to.abnormalityTypeData!,
                                          selectionCallBack: (
                                              AbnormalityType type) {
                                            selectedAbnormalityType = type;
                                            setState(() {});
                                          }));
                              },
                              child: commonDecoratedTextView(
                                title: selectedAbnormalityType == null ? "Abnormality Type" : selectedAbnormalityType!.typeName ?? "",
                                isChangeColor: selectedAbnormalityType == null ? true : false,
                              )
                          ),
                          CommonTextFiled(
                              fieldTitleText: "Abnormality(In Detail)",
                              hintText: "Abnormality(In Detail)",
                              // isBorderEnable: false,
                              isChangeFillColor: true,
                              maxLine: 5,
                              textEditingController: abnormalityController,
                              onChangedFunction: (String value){
                              },
                              validationFunction: (String value) {
                                return value.toString().isEmpty
                                    ? notEmptyFieldMessage
                                    : null;
                              }),
                          commonVerticalSpacing(spacing: 20),
                          CommonTextFiled(
                            fieldTitleText: "Possible Solution",
                            hintText: "Possible Solution",
                            // isBorderEnable: false,
                            maxLine: 5,
                            isChangeFillColor: true,
                            textEditingController: possibleSolutionController,
                            onChangedFunction: (String value){
                            },
                            validationFunction: (String value) {
                              return value.toString().isEmpty
                                  ? notEmptyFieldMessage
                                  : null;
                            },),
                          commonVerticalSpacing(spacing: 20),
                        ]
                    )
                  ],
                ),
              ),
            ],
          );
        })
    );
  }
}
