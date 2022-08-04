import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_projects/utility/constants.dart';

import '../../../common_widgets/common_textfield.dart';
import '../../../common_widgets/common_typeaheadfield.dart';
import '../../../common_widgets/common_widget.dart';
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
  TextEditingController abnormalityTypeController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController subDepartmentController = TextEditingController();
  TextEditingController partNameController = TextEditingController();
  TextEditingController possibleSolutionController = TextEditingController();
  TextEditingController businessController = TextEditingController();
  TextEditingController plantsController = TextEditingController();
  TextEditingController machineController = TextEditingController();
  TextEditingController subMachineController = TextEditingController();
  TextEditingController intervalController = TextEditingController();
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
                      },
                      isLoading: false)),
                ],
              ),
          ),
        ),
        child: ListView(
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
                      CommonTypeAheadTextField(
                        myItems: [],
                        controller: businessController,
                        hintText: "Select Business*",
                        clearCallback: (){

                        },
                        selectionCallBack: (String val){

                        },
                        validationFunction: (String val){

                        },
                      ),
                      commonVerticalSpacing(spacing: 20),
                      CommonTypeAheadTextField(
                        controller: plantsController,
                        myItems: [],
                        hintText: "Select COMPANY_BUSINESS_PLANTS",
                        clearCallback: (){

                        },
                        selectionCallBack: (String val){

                        },
                        validationFunction: (String val){

                        },
                      ),

                      commonVerticalSpacing(spacing: 20),
                      CommonTypeAheadTextField(
                        myItems: [],
                        controller: departmentController,
                        hintText: "Select Department*",
                        clearCallback: (){

                        },
                        selectionCallBack: (String val){

                        },
                        validationFunction: (String val){

                        },
                      ),
                      commonVerticalSpacing(spacing: 20),
                      CommonTypeAheadTextField(
                        myItems: [],
                        controller: subDepartmentController,
                        hintText: "Select Sub Department*",
                        clearCallback: (){

                        },
                        selectionCallBack: (String val){

                        },
                        validationFunction: (String val){

                        },
                      ),
                      commonVerticalSpacing(spacing: 30),
                      commonHeaderTitle(title: "Machine Detail",fontSize: 1.2,fontWeight: 2,color: darkFontColor),
                      commonVerticalSpacing(spacing: 20),
                      CommonTypeAheadTextField(
                        myItems: [],
                        hintText: "Select Machine*",
                        controller: machineController,
                        clearCallback: (){

                        },
                        selectionCallBack: (String val){

                        },
                        validationFunction: (String val){

                        },
                      ),
                      commonVerticalSpacing(spacing: 20),
                      CommonTypeAheadTextField(
                        controller: subMachineController,
                        myItems: [],
                        hintText: "Select Sub Machine*",
                        clearCallback: (){

                        },
                        selectionCallBack: (String val){

                        },
                        validationFunction: (String val){

                        },
                      ),
                      commonVerticalSpacing(spacing: 20),
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
                      CommonTypeAheadTextField(
                        myItems: [],
                        controller: abnormalityTitleController,
                        hintText: "Abnormality Title*",
                        clearCallback: (){

                        },
                        selectionCallBack: (String val){

                        },
                        validationFunction: (String val){

                        },
                      ),
                      commonVerticalSpacing(spacing: 20),
                      CommonTypeAheadTextField(
                        controller: abnormalityTypeController,
                        myItems: [],
                        hintText: "Abnormality Type*",
                        clearCallback: (){

                        },
                        selectionCallBack: (String val){

                        },
                        validationFunction: (String val){

                        },
                      ),
                      commonVerticalSpacing(spacing: 20),
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
                        },),
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
                    ],
                  ),
                  // Positioned(
                  //   bottom: 20,
                  //   right: 10,left: 10,
                  //   child: Container(
                  //     height: 65,
                  //     decoration: BoxDecoration(
                  //       image: DecorationImage(
                  //         image: watermarkImage,
                  //         fit: BoxFit.contain,
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ],
        )
    );
  }
}
