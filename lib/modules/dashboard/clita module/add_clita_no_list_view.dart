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
  TextEditingController businessController = TextEditingController();
  TextEditingController plantsController = TextEditingController();
  TextEditingController machineController = TextEditingController();
  TextEditingController subMachineController = TextEditingController();
  TextEditingController intervalController = TextEditingController();
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
                      myItems: [],
                      hintText: "Select Business",
                      controller: businessController,
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
                      hintText: "Select COMPANY_BUSINESS_PLANTS",
                      controller: plantsController,
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
                      controller: machineController,
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
                      myItems: [],
                      controller: intervalController,
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
                      fieldTitleText: "Select Date",
                      hintText: "Select Date",
                      // isBorderEnable: false,
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
