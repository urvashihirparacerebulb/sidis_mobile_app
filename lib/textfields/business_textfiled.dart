import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_projects/theme/convert_theme_colors.dart';

import '../common_widgets/common_textfield.dart';
import '../common_widgets/common_widget.dart';
import '../models/business_data_model.dart';

// class BusinessTextField extends StatefulWidget {
//   final String hintText;
//   final List<BusinessData> myItems;
//   final Function? validationFunction;
//   final Function? clearCallback;
//   final TextEditingController controller;
//   final Function? selectionCallBack;
//   const BusinessTextField({Key? key,required this.hintText,
//     this.validationFunction, this.selectionCallBack, this.clearCallback,
//     required this.controller,
//     required this.myItems}) : super(key: key);
//
//   @override
//   State<BusinessTextField> createState() => _BusinessTextFieldState();
// }
//
// class _BusinessTextFieldState extends State<BusinessTextField> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: neurmorphicBoxDecoration,
//       child: TypeAheadFormField(
//         textFieldConfiguration: TextFieldConfiguration(
//           controller: widget.controller,
//           style: white14PxNormal.apply(color: blackColor,fontSizeFactor: 1.2),
//           autofocus: false,
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
//         itemBuilder: (context, BusinessData? text) {
//           return text == null
//               ? Container()
//               : ListTile(
//             title: Text(
//               text.businessName ?? "",
//               style: white14PxNormal.copyWith(color: fontColor),
//             ),
//           );
//         },
//         onSuggestionSelected: (BusinessData? suggestion) {
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

class BusinessBottomView extends StatefulWidget {
  final List<BusinessData> myItems;
  final Function? selectionCallBack;

  const BusinessBottomView({Key? key, required this.myItems, this.selectionCallBack}) : super(key: key);

  @override
  State<BusinessBottomView> createState() => _BusinessBottomViewState();
}

class _BusinessBottomViewState extends State<BusinessBottomView> {

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          commonVerticalSpacing(spacing: 15),
          commonHeaderTitle(title: "Select Business",fontWeight: 2,fontSize: 1.5),
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
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            itemCount: searchController.text.isEmpty ? widget.myItems.length : widget.myItems.where((element) => element.businessName!.startsWith(searchController.text)).toList().length,
              itemBuilder: (context, index) => InkWell(
                onTap: (){
                  Get.back();
                  widget.selectionCallBack!(widget.myItems[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: commonHeaderTitle(
                      title: widget.myItems[index].businessName ?? "",
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
