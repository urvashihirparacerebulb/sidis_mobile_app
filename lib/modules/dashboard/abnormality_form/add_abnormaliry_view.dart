import 'package:flutter/material.dart';
import 'package:my_projects/utility/constants.dart';

import '../../../common_widgets/common_textfield.dart';
import '../../../common_widgets/common_typeaheadfield.dart';
import '../../../common_widgets/common_widget.dart';
import '../../../utility/color_utility.dart';

class AddAbnormalityFormView extends StatefulWidget {
  const AddAbnormalityFormView({Key? key}) : super(key: key);

  @override
  State<AddAbnormalityFormView> createState() => _AddAbnormalityFormViewState();
}

class _AddAbnormalityFormViewState extends State<AddAbnormalityFormView> {
  TextEditingController abnormalityController = TextEditingController();
  TextEditingController partNameController = TextEditingController();
  TextEditingController possibleSolutionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return commonStructure(
        context: context,
        bgColor: blackColor,
        appBar: commonAppbar(context: context,title: abnormalityFormText),
        child: commonRoundedContainer(
          context: context,
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        commonHeaderTitle(title: "Where is Abnormality?",fontSize: 1.3,fontWeight: 4,color: darkFontColor),
                        commonVerticalSpacing(spacing: 20),
                        CommonTypeAheadTextField(
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
                          hintText: "Select Sub Department*",
                          clearCallback: (){

                          },
                          selectionCallBack: (String val){

                          },
                          validationFunction: (String val){

                          },
                        ),
                        commonVerticalSpacing(spacing: 20),
                        commonHeaderTitle(title: "Machine Detail",fontSize: 1.3,fontWeight: 4,color: darkFontColor),
                        commonVerticalSpacing(spacing: 20),
                        CommonTypeAheadTextField(
                          hintText: "Select Machine*",
                          clearCallback: (){

                          },
                          selectionCallBack: (String val){

                          },
                          validationFunction: (String val){

                          },
                        ),
                        commonVerticalSpacing(spacing: 20),
                        CommonTypeAheadTextField(
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
                          isBorderEnable: false,
                          isChangeFillColor: true,
                          textEditingController: partNameController,
                          onChangedFunction: (String value){
                          },
                          validationFunction: (String value) {
                            return value.toString().isEmpty
                                ? notEmptyFieldMessage
                                : null;
                          },),

                        commonHeaderTitle(title: "Abnormality Detail",fontSize: 1.3,fontWeight: 4,color: darkFontColor),
                        commonVerticalSpacing(spacing: 20),
                        CommonTypeAheadTextField(
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
                          isBorderEnable: false,
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
                        CommonTextFiled(
                          fieldTitleText: "Possible Solution",
                          hintText: "Possible Solution",
                          isBorderEnable: false,
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
          ),
        )
    );
  }
}
