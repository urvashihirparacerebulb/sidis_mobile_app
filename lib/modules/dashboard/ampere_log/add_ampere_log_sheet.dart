import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../common_widgets/common_textfield.dart';
import '../../../common_widgets/common_widget.dart';
import '../../../controllers/business_controller.dart';
import '../../../controllers/department_controller.dart';
import '../../../controllers/dropdown_data_controller.dart';
import '../../../models/business_data_model.dart';
import '../../../models/department_response_model.dart';
import '../../../models/plants_response_model.dart';
import '../../../textfields/business_textfiled.dart';
import '../../../textfields/department_textfiled.dart';
import '../../../textfields/plants_textfield.dart';
import '../../../theme/convert_theme_colors.dart';
import '../../../utility/color_utility.dart';
import '../../../utility/common_methods.dart';
import '../../../utility/constants.dart';
import '../../../utility/screen_utility.dart';

class AddAmpereLogSheetView extends StatefulWidget {
  const AddAmpereLogSheetView({Key? key}) : super(key: key);

  @override
  State<AddAmpereLogSheetView> createState() => _AddAmpereLogSheetViewState();
}

class _AddAmpereLogSheetViewState extends State<AddAmpereLogSheetView> {
  BusinessData? selectedBusiness;
  CompanyBusinessPlant? selectedPlant;
  Department? selectedDepartment;
  Department? selectedSubDepartment;
  String _selectedGender = "1";
  String selectedStartDate = "";
  TextEditingController rPhaseController = TextEditingController();
  TextEditingController yPhaseController = TextEditingController();
  TextEditingController bPhaseController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  @override
  void initState() {
    if (BusinessController.to.businessData!.isEmpty) {
      BusinessController.to.getBusinesses();
    }
    super.initState();
  }

  addAmpereLogForm(){
    return Column(
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
              selectedSubDepartment = null;
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
                          selectedSubDepartment = null;
                          setState(() {});
                          if (selectedPlant != null) {
                            DepartmentController.to.getDepartment(
                                soleId: selectedPlant!.soleId,
                                callback: (){}
                            );
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
                          selectedSubDepartment = null;
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
        commonVerticalSpacing(),
        commonHeaderTitle(title: "Shift Detail",fontSize: isTablet() ? 1.5 : 1.2,fontWeight: 2,color: darkFontColor),
        commonVerticalSpacing(spacing: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: commonHeaderTitle(title: "Select Shift *",color: blackColor.withOpacity(0.5),fontSize: 1,fontWeight: 0,align: TextAlign.start),
        ),
        // commonVerticalSpacing(spacing: 10),
        SizedBox(
          height: 50,
          width: getScreenWidth(context) - 40,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ListTile(
                  leading: Radio<String>(
                    value: '1',
                    groupValue: _selectedGender,
                    activeColor: primaryColor,
                    onChanged: (value) {
                      _selectedGender = value!;
                    },
                  ),
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text('A'),
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: Radio<String>(
                    value: '2',
                    groupValue: _selectedGender,
                    activeColor: primaryColor,
                    onChanged: (value) {
                      _selectedGender = value!;
                    },
                  ),
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text('B'),
                ),
              ),
            ],
          ),
        ),
        commonVerticalSpacing(spacing: 15),
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
                        isChangeColor: true,
                        color: selectedStartDate.isEmpty ? blackColor.withOpacity(0.5) : blackColor,
                        title: selectedStartDate.isEmpty ? "Select Date and Time *" : selectedStartDate)
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
                    )
                ),
              ],
            )),
        commonVerticalSpacing(spacing: 20),
        InkWell(
          onTap: (){

          },
          child: commonDecoratedTextView(
              title: "Select Equipment",
              isChangeColor: true
          ),
        ),
        commonVerticalSpacing(),
        commonHeaderTitle(title: "Phase Detail",fontSize: isTablet() ? 1.5 : 1.2,fontWeight: 2,color: darkFontColor),
        commonVerticalSpacing(spacing: 20),
        CommonTextFiled(
            fieldTitleText: "R - Phase *",
            hintText: "R - Phase *",
            // isBorderEnable: false,
            isChangeFillColor: true,
            textEditingController: rPhaseController,
            onChangedFunction: (String value){
            },
            validationFunction: (String value) {
              return value.toString().isEmpty
                  ? notEmptyFieldMessage
                  : null;
            }),
        commonVerticalSpacing(spacing: 20),

        CommonTextFiled(
            fieldTitleText: "Y - Phase *",
            hintText: "Y - Phase *",
            // isBorderEnable: false,
            isChangeFillColor: true,
            textEditingController: yPhaseController,
            onChangedFunction: (String value){
            },
            validationFunction: (String value) {
              return value.toString().isEmpty
                  ? notEmptyFieldMessage
                  : null;
            }),
        commonVerticalSpacing(spacing: 20),

        CommonTextFiled(
            fieldTitleText: "B - Phase *",
            hintText: "B - Phase *",
            // isBorderEnable: false,
            isChangeFillColor: true,
            textEditingController: bPhaseController,
            onChangedFunction: (String value){
            },
            validationFunction: (String value) {
              return value.toString().isEmpty
                  ? notEmptyFieldMessage
                  : null;
            }),
        commonVerticalSpacing(spacing: 30),
        commonHeaderTitle(title: "Remarks",fontSize: isTablet() ? 1.5 : 1.2,fontWeight: 2,color: darkFontColor),
        commonVerticalSpacing(spacing: 20),
        CommonTextFiled(
            fieldTitleText: "Remarks",
            hintText: "Remarks",
            // isBorderEnable: false,
            isChangeFillColor: true,
            maxLine: 5,
            textEditingController: remarksController,
            onChangedFunction: (String value){
            },
            validationFunction: (String value) {
              return value.toString().isEmpty
                  ? notEmptyFieldMessage
                  : null;
            }),
        commonVerticalSpacing(spacing: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return commonStructure(
        context: context,
        bgColor: blackColor,
        appBar: commonAppbar(context: context,title: "Add Ampere Log Sheet"),
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
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24.0,right: 24.0,top: 24.0),
              child: addAmpereLogForm(),
            )
          ],
        )
    );
  }
}
