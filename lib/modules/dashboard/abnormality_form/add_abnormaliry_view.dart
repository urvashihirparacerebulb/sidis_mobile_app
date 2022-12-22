import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:my_projects/configurations/config_file.dart';
import 'package:my_projects/controllers/abnormality_controller.dart';
import 'package:my_projects/controllers/department_controller.dart';
import 'package:my_projects/controllers/part_controller.dart';
import 'package:my_projects/models/department_response_model.dart';
import 'package:my_projects/utility/constants.dart';
import '../../../common_widgets/common_textfield.dart';
import '../../../common_widgets/common_widget.dart';
import '../../../controllers/business_controller.dart';
import '../../../controllers/dropdown_data_controller.dart';
import '../../../models/activities_response_model.dart';
import '../../../models/business_data_model.dart';
import '../../../models/machines_response_model.dart';
import '../../../models/part_response_model.dart';
import '../../../models/plants_response_model.dart';
import '../../../textfields/abnormality_type_field.dart';
import '../../../textfields/business_textfiled.dart';
import '../../../textfields/department_textfiled.dart';
import '../../../textfields/machine_textfield.dart';
import '../../../textfields/part_textfiled.dart';
import '../../../textfields/plants_textfield.dart';
import '../../../theme/convert_theme_colors.dart';
import '../../../utility/color_utility.dart';
import '../../../utility/common_methods.dart';
import '../../../utility/screen_utility.dart';

class AddAbnormalityFormView extends StatefulWidget {
  final bool isEdit;
  final String abnormalityId;
  const AddAbnormalityFormView({Key? key, required this.isEdit, required this.abnormalityId}) : super(key: key);

  @override
  State<AddAbnormalityFormView> createState() => _AddAbnormalityFormViewState();
}

class _AddAbnormalityFormViewState extends State<AddAbnormalityFormView> {
  TextEditingController abnormalityController = TextEditingController();
  TextEditingController abnormalityTitleController = TextEditingController();
  TextEditingController possibleSolutionController = TextEditingController();
  BusinessData? selectedBusiness;
  CompanyBusinessPlant? selectedPlant;
  Department? selectedDepartment;
  Department? selectedSubDepartment;
  AbnormalityType? selectedAbnormalityType;
  MachineData? machineData;
  PartArray? selectedPart;
  // MachineData? subMachineData;
  List<MachineData> subMachineLists = [];

  @override
  void initState() {
    if(widget.isEdit){
        AbnormalityController.to.getAbnormalityByDetail(abnormalityId: widget.abnormalityId,callback: (){
          var abnormality = AbnormalityController.to.abnormalityDetail.value;
          if (BusinessController.to.businessData!.isEmpty) {
            BusinessController.to.getBusinesses();
          }
          BusinessData business  = BusinessData();
          business.businessId = abnormality.bussinessId;
          business.businessName = abnormality.bussinessName;
          selectedBusiness = business;
          CompanyBusinessPlant plant = CompanyBusinessPlant();
          plant.soleId = "${abnormality.companyId} - ${abnormality.plantId} - ${abnormality.bussinessId}";
          plant.soleName = abnormality.companyShortName;
          selectedPlant = plant;
          Department department = Department();
          department.departmentId = abnormality.departmentId;
          department.departmentName = abnormality.departmentShortName;
          selectedDepartment = department;
          Department subDepartment = Department();
          subDepartment.departmentId = abnormality.subdepartmentId;
          subDepartment.departmentName = abnormality.subdepartmentShortName;
          selectedSubDepartment = subDepartment;
          MachineData machine = MachineData();
          machine.machineId = abnormality.machineId;
          machine.machineName = abnormality.machineName;
          machineData = machine;
          AbnormalityType type = AbnormalityType();
          type.id = abnormality.abnormalityTypeId;
          type.typeName = abnormality.typeName;
          selectedAbnormalityType = type;
          PartArray part = PartArray();
          part.partId = abnormality.partsId;
          part.partName = abnormality.partName;
          selectedPart = part;
          abnormality.submachine?.forEach((element) {
            MachineData subMachine = MachineData();
            subMachine.machineId = element.id;
            subMachine.machineName = element.name;
            subMachineLists.add(subMachine);
          });
          abnormalityController.text = abnormality.abnormalityText ?? "";
          abnormalityTitleController.text = abnormality.abnormalityTitle ?? "";
          possibleSolutionController.text = abnormality.solutionText ?? "";
          setState(() {});
        });
    }else {
      if (BusinessController.to.businessData!.isEmpty) {
        BusinessController.to.getBusinesses();
      }
      Future.delayed(const Duration(seconds: 5), () {
        AbnormalityController.to.getAbnormalityType(callback: (){});
      });
    }
    super.initState();
  }

  partAPICall(){
    String machineId = "";
    if(subMachineLists.isNotEmpty){
      if(subMachineLists.last.machineId != null){
        machineId = subMachineLists.last.machineId.toString();
      }else{
        machineId = machineData!.machineId.toString();
      }
    }else{
      machineId = machineData!.machineId.toString();
    }
    PartController.to.getPartList(machineId: machineId,callback: (){});
  }

  getSubMachineAPI({String? plantId, int? machineId}){
    DropDownDataController.to.getSubMachines(plantId: plantId,
        machineId: machineId,successCallback: (){
          partAPICall();
          if(DropDownDataController.to.subMachinesList!.isNotEmpty){
            subMachineLists.add(MachineData());
            setState(() {});
          }
          setState(() {
          });
        });
  }

  prepareRequestObject(){
    AbnormalityRequest abnormalityRequest = AbnormalityRequest();
    if(widget.isEdit){
      abnormalityRequest.editAbnormalityId = widget.abnormalityId;
    }
    abnormalityRequest.soleId = selectedPlant!.soleId;
    abnormalityRequest.departmentId = selectedDepartment!.departmentId.toString();
    abnormalityRequest.subDepartmentId = selectedSubDepartment!.departmentId.toString();
    abnormalityRequest.machineId = machineData!.machineId.toString();
    abnormalityRequest.partName = selectedPart!.partName;
    abnormalityRequest.partsId = selectedPart!.partId == null ? "" : selectedPart!.partId.toString();
    abnormalityRequest.abnormalityTitle = abnormalityTitleController.text;
    abnormalityRequest.abnormalityTypeId = selectedAbnormalityType!.id.toString();
    abnormalityRequest.abnormalityText = abnormalityController.text;
    abnormalityRequest.possibleSolution = possibleSolutionController.text;
    abnormalityRequest.userId = getLoginData()!.userdata!.first.id.toString();
    List<String> subMachineIds = [];
    for (var element in subMachineLists) {
      subMachineIds.add(element.machineId!.toString());
    }
    abnormalityRequest.subMachineId = subMachineIds.join(',');
    AbnormalityController.to.addEditNewAbnormality(abnormalityRequest);
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
                            machineData != null &&
                            selectedAbnormalityType != null && selectedPart != null &&
                            abnormalityTitleController.text.isNotEmpty){
                          prepareRequestObject();
                        }else{
                          showSnackBar(title: ApiConfig.error, message: "Please fill whole form");
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
                          commonHeaderTitle(title: "Where is Abnormality?",fontSize: isTablet() ? 1.5 : 1.2,fontWeight: 2,color: darkFontColor),
                          commonVerticalSpacing(spacing: 20),
                          InkWell(
                            onTap: (){
                              commonBottomView(context: context,child: BusinessBottomView(myItems: BusinessController.to.businessData!,selectionCallBack: (BusinessData business){
                                selectedBusiness = business;
                                selectedPlant = null;selectedDepartment = null;
                                selectedSubDepartment = null;machineData = null; subMachineLists = [];
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
                                            selectedDepartment = null;
                                            selectedSubDepartment = null;machineData = null; subMachineLists = [];
                                            setState(() {});
                                            if (selectedPlant != null) {
                                              DropDownDataController.to.getMachines(
                                                  plantId: selectedPlant!.soleId,
                                                  successCallback: () {
                                                    DepartmentController.to.getDepartment(
                                                        soleId: selectedPlant!.soleId,
                                                      callback: (){}
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
                                            selectedSubDepartment = null;machineData = null; subMachineLists = [];
                                            setState(() {});
                                            if (selectedDepartment != null) {
                                              DepartmentController.to.getSubDepartment(departmentId: selectedDepartment!.departmentId.toString(),callback: (){});
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
                                title: selectedSubDepartment == null ? "Select Sub Department" : selectedSubDepartment!.departmentName ?? "",
                                isChangeColor: selectedSubDepartment == null ? true : false,
                              )
                          ),
                          commonHeaderTitle(title: "Machine Detail",fontSize: isTablet() ? 1.5 : 1.2,fontWeight: 2,color: darkFontColor),
                          commonVerticalSpacing(spacing: 20),
                          InkWell(
                              onTap: (){
                                if(selectedPlant != null) {
                                  commonBottomView(context: context,
                                      child: MachineBottomView(
                                          hintText: "Select Machine",
                                          soleId: selectedPlant!.soleId ?? "",
                                          machineId: machineData == null ? 0 : machineData!.machineId ?? 0,
                                          myItems: DropDownDataController.to.machinesList!,
                                          selectionCallBack: (
                                              MachineData machine) {
                                            subMachineLists.clear();
                                            machineData = machine;
                                            subMachineLists = [];
                                            setState(() {});
                                            if (machineData != null) {
                                              getSubMachineAPI(
                                                  plantId: selectedPlant!.soleId,
                                                  machineId: machineData!.machineId
                                              );
                                            }
                                          }));
                                }
                              },
                              child: commonDecoratedTextView(
                                bottom: subMachineLists.isEmpty ? 25 : 0,
                                title: machineData == null ? "Select Machine" : machineData!.machineName ?? "",
                                isChangeColor: machineData == null ? true : false,
                              )
                          ),
                          commonVerticalSpacing(spacing: subMachineLists.isEmpty ? 0 : 25),
                          Visibility(
                            visible: machineData == null ? false : true,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: subMachineLists.length,
                                itemBuilder: (context, index) => InkWell(
                                onTap: (){
                                  commonBottomView(context: context,
                                      child: MachineBottomView(
                                          hintText: "Select Sub Machine",
                                          soleId: selectedPlant!.soleId ?? "",
                                          machineId: subMachineLists.last.machineId ?? 0,
                                          myItems: DropDownDataController.to.subMachinesList!,
                                          selectionCallBack: (
                                              MachineData machine) {
                                            subMachineLists[index] = machine;
                                            setState(() {
                                            });
                                            getSubMachineAPI(
                                                plantId: selectedPlant!.soleId,
                                                machineId: subMachineLists[index].machineId
                                            );
                                          }));
                                },
                                child: commonDecoratedTextView(
                                  title: subMachineLists[index].machineName == null ? "Select Sub Machine" : subMachineLists[index].machineName ?? "",
                                  isChangeColor: subMachineLists[index].machineName == null ? true : false,
                                )
                            )),
                          ),
                          InkWell(
                              onTap: (){
                                  commonBottomView(context: context,
                                      child: PartBottomView(
                                          hintText: "Part Name",
                                          machineId: subMachineLists.isNotEmpty ? subMachineLists.last.machineId.toString() : machineData!.machineId.toString(),
                                          myItems: PartController.to.allPartList,
                                          selectionCallBack: (
                                              PartArray part) {
                                            setState(() {
                                              selectedPart = part;
                                            });
                                          }));
                              },
                              child: commonDecoratedTextView(
                                title: selectedPart == null ? "Part Name*" : selectedPart!.partName ?? "",
                                isChangeColor: selectedPart == null ? true : false,
                              )
                          ),
                          commonHeaderTitle(title: "Abnormality Detail",fontSize: isTablet() ? 1.5 : 1.2,fontWeight: 2,color: darkFontColor),
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

class SubMachineViewList{
  MachineData? subMachine;
}