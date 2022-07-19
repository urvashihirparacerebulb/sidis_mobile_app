import 'package:flutter/material.dart';
import 'package:my_projects/utility/constants.dart';

import '../../../common_widgets/common_textfield.dart';
import '../../../common_widgets/common_typeaheadfield.dart';
import '../../../common_widgets/common_widget.dart';
import '../../../utility/assets_utility.dart';
import '../../../utility/color_utility.dart';

class CLITANoListView extends StatefulWidget {
  const CLITANoListView({Key? key}) : super(key: key);

  @override
  State<CLITANoListView> createState() => _CLITANoListViewState();
}

class _CLITANoListViewState extends State<CLITANoListView> {
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return commonStructure(
        context: context,
        bgColor: blackColor,
        appBar: commonAppbar(context: context,title: clitaNoListText),
        child: commonRoundedContainer(
          context: context,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  children: [
                    CommonTypeAheadTextField(
                      hintText: "Select Business",
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
                      hintText: "Select Machine",
                      clearCallback: (){

                      },
                      selectionCallBack: (String val){

                      },
                      validationFunction: (String val){

                      },
                    ),
                    commonVerticalSpacing(spacing: 20),
                    CommonTypeAheadTextField(
                      hintText: "Select Interval",
                      clearCallback: (){

                      },
                      selectionCallBack: (String val){

                      },
                      validationFunction: (String val){

                      },
                    ),
                    commonVerticalSpacing(spacing: 20),
                    CommonTextFiled(
                      fieldTitleText: userName,
                      hintText: userName,
                      isBorderEnable: false,
                      isChangeFillColor: true,
                      textEditingController: dateController,
                      suffixIcon: InkWell(
                        onTap: (){},
                        child: const Icon(Icons.calendar_month),
                      ),
                      onChangedFunction: (String value){
                      },
                      validationFunction: (String value) {
                        return value.toString().isEmpty
                            ? notEmptyFieldMessage
                            : null;
                      },),
                  ],
                ),
                Positioned(
                  bottom: 20,
                  right: 10,left: 10,
                  child: Container(
                    height: 65,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: watermarkImage,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
