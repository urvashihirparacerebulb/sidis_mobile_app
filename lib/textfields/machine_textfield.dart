// class MachineTextFiled extends StatefulWidget {
//   final String hintText;
//   final List<MachineData> myItems;
//   final Function? validationFunction;
//   final Function? clearCallback;
//   final TextEditingController controller;
//   final bool? isEnabled;
//   final Function? selectionCallBack;
//   const MachineTextFiled({Key? key,required this.hintText,
//     this.validationFunction, this.selectionCallBack, this.clearCallback,
//     required this.controller,
//     required this.myItems, this.isEnabled}) : super(key: key);
//
//   @override
//   State<MachineTextFiled> createState() => _MachineTextFiledState();
// }
//
// class _MachineTextFiledState extends State<MachineTextFiled> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: neurmorphicBoxDecoration,
//       child: TypeAheadFormField(
//         textFieldConfiguration: TextFieldConfiguration(
//           controller: widget.controller,
//           style: white14PxNormal.apply(color: blackColor,fontSizeFactor: 1.2),
//           autofocus: false,
//           enabled: widget.isEnabled ?? true,
//           decoration: InputDecoration(
//               fillColor: bgColor.withOpacity(0.8),
//               filled: true,
//               focusedBorder: textFieldBorderStyle,
//               disabledBorder: textFieldBorderStyle,
//               enabledBorder: textFieldBorderStyle,
//               errorBorder: textFieldBorderStyle,
//               focusedErrorBorder: textFieldBorderStyle,
//               hintText: widget.hintText,
//               contentPadding: const EdgeInsets.fromLTRB(10.0,0,10,20),
//               hintStyle: white14PxNormal.copyWith(
//                   color: blackColor.withOpacity(0.4)),
//               suffixIcon: const Icon(Icons.arrow_drop_down, color: fontColor)),
//           onChanged: (text) {
//             setState(() {
//               widget.clearCallback!();
//             });
//           },
//         ),
//         validator: (value) {
//           return widget.validationFunction != null ? widget.validationFunction!(value) : null;
//         },
//         suggestionsBoxDecoration: const SuggestionsBoxDecoration(color: whiteColor),
//         suggestionsCallback: (pattern) async {
//           return widget.myItems;
//         },
//         transitionBuilder: (context, suggestionsBox, controller) {
//           return suggestionsBox;
//         },
//         itemBuilder: (context, MachineData? text) {
//           return text == null
//               ? Container()
//               : ListTile(
//             title: Text(
//               text.machineName ?? "",
//               style: white14PxNormal.copyWith(color: fontColor),
//             ),
//           );
//         },
//         onSuggestionSelected: (MachineData? suggestion) {
//           setState(() {
//             if (suggestion != null) {
//               FocusScope.of(context).unfocus();
//               if (widget.selectionCallBack != null) {
//                 widget.selectionCallBack!(suggestion);
//               }
//             }
//           });
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common_widgets/common_textfield.dart';
import '../common_widgets/common_widget.dart';
import '../controllers/dropdown_data_controller.dart';
import '../models/machines_response_model.dart';

class MachineBottomView extends StatefulWidget {
  final String hintText;
  final String soleId;
  final int machineId;
  final List<MachineData> myItems;
  final Function? selectionCallBack;

  const MachineBottomView({Key? key, required this.myItems, this.selectionCallBack,
    required this.hintText, this.soleId = "", this.machineId = 0}) : super(key: key);

  @override
  State<MachineBottomView> createState() => _MachineBottomViewState();
}

class _MachineBottomViewState extends State<MachineBottomView> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    if(widget.myItems.isEmpty){
      if(widget.hintText == "Select Machine") {
        DropDownDataController.to.getMachines(
            plantId: widget.soleId,
            successCallback: () {
              setState(() {
              });
            });
      }else{
        DropDownDataController.to.getSubMachines(plantId: widget.soleId,
            machineId: widget.machineId,successCallback: (){
              setState(() {
              });
            });
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          commonVerticalSpacing(spacing: 15),
          commonHeaderTitle(title: widget.hintText,fontWeight: 2,fontSize: 1.5),
          commonVerticalSpacing(spacing: 15),
          CommonTextFiled(
            fieldTitleText: "Search",
            hintText: "Search",
            // isBorderEnable: false,
            isChangeFillColor: true,
            textEditingController: searchController,
            onChangedFunction: (String value){
              setState(() {
              });
            },
          ),
          commonVerticalSpacing(spacing: 30),
          ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              shrinkWrap: true,
              itemCount: searchController.text.isEmpty ? widget.myItems.length : widget.myItems.where((element) => element.machineName!.startsWith(searchController.text)).toList().length,
              itemBuilder: (context, index) => InkWell(
                onTap: (){
                  Get.back();
                  widget.selectionCallBack!(widget.myItems[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: commonHeaderTitle(
                      title: widget.myItems[index].machineName ?? "",
                      fontSize: 1.2
                  ),
                ),
              )
          ),
          commonVerticalSpacing(spacing: 30),
        ],
      ),
    );
  }
}
