import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_projects/utility/constants.dart';

import '../../../common_widgets/common_textfield.dart';
import '../../../common_widgets/common_widget.dart';
import '../../../controllers/business_controller.dart';
import '../../../controllers/department_controller.dart';
import '../../../controllers/dropdown_data_controller.dart';
import '../../../models/business_data_model.dart';
import '../../../models/department_response_model.dart';
import '../../../models/machines_response_model.dart';
import '../../../models/plants_response_model.dart';
import '../../../textfields/business_textfiled.dart';
import '../../../textfields/department_textfiled.dart';
import '../../../textfields/machine_textfield.dart';
import '../../../textfields/plants_textfield.dart';
import '../../../theme/convert_theme_colors.dart';
import '../../../utility/color_utility.dart';
import '../../../utility/common_methods.dart';
import '../../../utility/screen_utility.dart';

class AddProductRequisitionView extends StatefulWidget {
  const AddProductRequisitionView({Key? key}) : super(key: key);

  @override
  State<AddProductRequisitionView> createState() => _AddProductRequisitionViewState();
}

class _AddProductRequisitionViewState extends State<AddProductRequisitionView> {

  BusinessData? selectedBusiness;
  CompanyBusinessPlant? selectedPlant;
  Department? selectedDepartment;
  Department? selectedSubDepartment;
  MachineData? machineData;
  List<MachineData> subMachineLists = [];
  String selectedStartDate = "";
  File? productImage;
  TextEditingController itemDescriptionController = TextEditingController();
  TextEditingController requiredQuantityController = TextEditingController();

  @override
  void initState() {
    if (BusinessController.to.businessData!.isEmpty) {
      BusinessController.to.getBusinesses();
    }
    super.initState();
  }

  getSubMachineAPI({String? plantId, int? machineId}){
    DropDownDataController.to.getSubMachines(plantId: plantId,
        machineId: machineId,successCallback: (){
          if(DropDownDataController.to.subMachinesList!.isNotEmpty){
            subMachineLists.add(MachineData());
            setState(() {});
          }else {
            setState(() {});
          }
    });
  }

  imageView({String title = "", File? selectedFile}){
    return SizedBox(
      height: 72,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonHeaderTitle(
              title: title,
              color: fontColor,
              isChangeColor: true
          ),
          commonVerticalSpacing(spacing: 8),
          Container(
            height: 50,
            padding: const EdgeInsets.all(10),
            decoration: neurmorphicBoxDecoration,
            child: Row(
              children: [
                InkWell(
                    onTap: () async{
                      final ImagePicker picker = ImagePicker();
                      try {
                        final XFile? pickedFile = await picker.pickImage(
                          source: ImageSource.gallery,
                        );
                        setState(() {
                          selectedFile = File(pickedFile!.path);
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: commonHeaderTitle(
                        title: "Choose File",
                        color: blackColor.withOpacity(0.4),
                        isChangeColor: true
                    )
                ),
                commonHorizontalSpacing(spacing: 10),
                Container(height: 40,width: 1,color: fontColor),
                commonHorizontalSpacing(spacing: 10),
                commonHeaderTitle(
                    title: selectedFile == null ? "No File Chosen" : selectedFile!.path,
                    color: blackColor.withOpacity(0.4),
                    isChangeColor: true
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  addProductRequisitionView(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        InkWell(
            onTap: (){
              if(selectedPlant != null) {
                commonBottomView(context: context,
                    child: MachineBottomView(
                        hintText: "Select Machine",
                        soleId: selectedPlant!.soleId ?? "",
                        machineId: machineData!.machineId ?? 0,
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
                )
            )
        ),
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
                        title: selectedStartDate.isEmpty ? "Select Date" : selectedStartDate)
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
            )),
        commonVerticalSpacing(spacing: 20),
        InkWell(
          onTap: (){

          },
          child: commonDecoratedTextView(
              title: "Select Required In",
              isChangeColor: true
          ),
        ),
        InkWell(
          onTap: (){

          },
          child: commonDecoratedTextView(
              title: "Select Item Type",
              isChangeColor: true
          ),
        ),

        CommonTextFiled(
            fieldTitleText: "Item Description*",
            hintText: "Item Description*",
            // isBorderEnable: false,
            isChangeFillColor: true,
            maxLine: 5,
            textEditingController: itemDescriptionController,
            onChangedFunction: (String value){
            },
            validationFunction: (String value) {
              return value.toString().isEmpty
                  ? notEmptyFieldMessage
                  : null;
            }),
        commonVerticalSpacing(spacing: 20),
        CommonTextFiled(
            fieldTitleText: "Required Quantity",
            hintText: "Required Quantity",
            // isBorderEnable: false,
            isChangeFillColor: true,
            textEditingController: requiredQuantityController,
            onChangedFunction: (String value){
            },
            validationFunction: (String value) {
              return value.toString().isEmpty
                  ? notEmptyFieldMessage
                  : null;
            }
        ),
        commonVerticalSpacing(spacing: 30),
        imageView(title: "Product Image (if available)", selectedFile: productImage),
        commonVerticalSpacing(spacing: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return commonStructure(
        context: context,
        bgColor: blackColor,
        appBar: commonAppbar(context: context,title: productRequisitionText),
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
                child: addProductRequisitionView()
              )
            ],
          );
        })
    );
  }
}
