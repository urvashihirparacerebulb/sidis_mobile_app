import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_projects/controllers/product_requisition_controller.dart';
import 'package:my_projects/models/product_requisition_response_model.dart';
import 'package:my_projects/utility/constants.dart';
import '../../../common_widgets/common_textfield.dart';
import '../../../common_widgets/common_widget.dart';
import '../../../configurations/config_file.dart';
import '../../../controllers/business_controller.dart';
import '../../../controllers/department_controller.dart';
import '../../../controllers/dropdown_data_controller.dart';
import '../../../models/business_data_model.dart';
import '../../../models/department_response_model.dart';
import '../../../models/machines_response_model.dart';
import '../../../models/plants_response_model.dart';
import '../../../textfields/business_textfiled.dart';
import '../../../textfields/common_bottom_string_view.dart';
import '../../../textfields/department_textfiled.dart';
import '../../../textfields/machine_textfield.dart';
import '../../../textfields/plants_textfield.dart';
import '../../../textfields/required_in_textfield.dart';
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
  DateTime? selectedStartDate;
  File? productImage;
  TextEditingController itemDescriptionController = TextEditingController();
  TextEditingController requiredQuantityController = TextEditingController();
  RequiredIn? requiredIn;
  String selectedItemType = "";

  @override
  void initState() {
    if (BusinessController.to.businessData!.isEmpty) {
      BusinessController.to.getBusinesses();
    }

    Future.delayed(const Duration(seconds: 5),(){
      ProductRequisitionController.to.getRequisitionType();
    });
    super.initState();
  }

  imageView({String title = "", File? selectedFile}){
    return SizedBox(
      height: productImage == null ? 72 : 144,
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
            height: productImage == null ? 50 : 100,
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
                          productImage = File(pickedFile!.path);
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
                productImage == null ? commonHeaderTitle(
                    title: "No File Chosen",
                    color: blackColor.withOpacity(0.4),
                    isChangeColor: true
                ) : Expanded(child: Image.file(productImage!,height: 100))
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
              selectedSubDepartment = null;machineData = null;
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
                          selectedSubDepartment = null;machineData = null;
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
                          selectedSubDepartment = null;machineData = null;
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
                        myItems: DropDownDataController.to.machinesList!,
                        selectionCallBack: (
                            MachineData machine) {
                          machineData = machine;
                          setState(() {});
                        }));
              }
            },
            child: commonDecoratedTextView(
              bottom: 25,
              title: machineData == null ? "Select Machine" : machineData!.machineName ?? "",
              isChangeColor: machineData == null ? true : false,
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
                        title: selectedStartDate == null ? "Select Date" : DateFormat("dd-MM-yyyy").format(selectedStartDate!))
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
                            selectedStartDate = value;
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
              commonBottomView(context: context,
                  child: RequiredInBottomView(
                      hintText: "Select Required In",
                      myItems: ProductRequisitionController.to.requiredInData.value,
                      selectionCallBack: (
                          MachineData machine) {
                        machineData = machine;
                        setState(() {});
                      }));
            },
            child: commonDecoratedTextView(
              title: requiredIn == null ? "Select Required In" : (requiredIn!.value ?? ""),
              isChangeColor: requiredIn == null ? true : false,
            )
        ),
        InkWell(
            onTap: (){
              commonBottomView(context: context,
                  child: CommonBottomStringView(
                      hintText: "Select Item Type",
                      myItems: ProductRequisitionController.to.requisitionTypes,
                      selectionCallBack: (
                          String val) {
                        setState(() {
                          selectedItemType = val;
                        });
                      }));
            },
            child: commonDecoratedTextView(
              title: selectedItemType.isEmpty ? "Select Item Type" : selectedItemType,
              isChangeColor: selectedItemType.isEmpty ? true : false,
            )
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
                      if(selectedBusiness != null){
                        if(selectedPlant != null){
                          if(selectedDepartment != null){
                            if(selectedSubDepartment != null){
                              if(machineData != null){
                                if(selectedStartDate != null){
                                  if(requiredIn != null){
                                    if(selectedItemType.isNotEmpty){
                                      if(itemDescriptionController.text.isNotEmpty){
                                        if(requiredQuantityController.text.isNotEmpty){
                                          if(productImage != null){
                                            ProductRequisitionRequest productRequisitionRequest = ProductRequisitionRequest();
                                            productRequisitionRequest.userId = getLoginData()!.userdata!.first.id.toString();
                                            productRequisitionRequest.requisitionDate = DateFormat("dd-MM-yyyy").format(selectedStartDate!);
                                            productRequisitionRequest.soleId = selectedPlant!.soleId;
                                            productRequisitionRequest.departmentId = selectedDepartment!.departmentId.toString();
                                            productRequisitionRequest.subDepartmentId = selectedSubDepartment!.departmentId.toString();
                                            productRequisitionRequest.machineId = machineData?.machineId.toString();
                                            productRequisitionRequest.itemId = selectedItemType == "Others" ? "" : selectedItemType;
                                            productRequisitionRequest.otherItem = selectedItemType == "Others" ? "Others" : "";
                                            productRequisitionRequest.requiredIn = "1";
                                            productRequisitionRequest.itemDescription = itemDescriptionController.text;
                                            productRequisitionRequest.quantity = requiredQuantityController.text;
                                            productRequisitionRequest.productImage = productImage;
                                            ProductRequisitionController.to.addProductRequisition(productRequisitionRequest: productRequisitionRequest);
                                          }else{
                                            showSnackBar(title: ApiConfig.error, message: "Please choose product image");
                                          }
                                        }else{
                                          showSnackBar(title: ApiConfig.error, message: "Please enter quantity");
                                        }
                                      }else{
                                        showSnackBar(title: ApiConfig.error, message: "Please enter description");
                                      }
                                    }else{
                                      showSnackBar(title: ApiConfig.error, message: "Please select item type");
                                    }
                                  }else{
                                    showSnackBar(title: ApiConfig.error, message: "Please select requiredIn");
                                  }
                                }else{
                                  showSnackBar(title: ApiConfig.error, message: "Please select date");
                                }
                              }else{
                                showSnackBar(title: ApiConfig.error, message: "Please select machine");
                              }
                            }else{
                              showSnackBar(title: ApiConfig.error, message: "Please select sub department");
                            }
                          }else{
                            showSnackBar(title: ApiConfig.error, message: "Please select department");
                          }
                        }else{
                          showSnackBar(title: ApiConfig.error, message: "Please select plant");
                        }
                      }else{
                        showSnackBar(title: ApiConfig.error, message: "Please select business");
                      }
                    },
                    isLoading: false)
                )
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

class ProductRequisitionRequest{
  String? userId;
  String? requisitionDate;
  String? soleId;
  String? departmentId;
  String? subDepartmentId;
  String? machineId;
  String? itemId;
  String? otherItem;
  String? requiredIn;
  String? itemDescription;
  String? quantity;
  File? productImage;
}