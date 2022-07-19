import 'package:flutter/material.dart';
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
