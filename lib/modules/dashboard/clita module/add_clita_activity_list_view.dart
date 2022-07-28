import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_projects/controllers/dropdown_data_controller.dart';
import 'package:my_projects/utility/constants.dart';

import '../../../common_widgets/common_typeaheadfield.dart';
import '../../../common_widgets/common_widget.dart';
import '../../../utility/assets_utility.dart';
import '../../../utility/color_utility.dart';


class CLITActivityListFormScreen extends StatefulWidget {
  const CLITActivityListFormScreen({Key? key}) : super(key: key);

  @override
  State<CLITActivityListFormScreen> createState() => _CLITActivityListFormScreenState();
}

class _CLITActivityListFormScreenState extends State<CLITActivityListFormScreen> {

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
        appBar: commonAppbar(context: context,title: clitaActivityListText),
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
                      controller: businessController,
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
                      myItems: [],
                      controller: plantsController,
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
                      hintText: "Select Machine",
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
                      myItems: [],
                      controller: intervalController,
                      hintText: "Select Interval",
                      clearCallback: (){

                      },
                      selectionCallBack: (String val){

                      },
                      validationFunction: (String val){

                      },
                    )
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
