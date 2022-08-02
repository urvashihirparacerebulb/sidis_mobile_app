import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:my_projects/utility/color_utility.dart';
import '../utility/theme_utility.dart';
import 'common_widget.dart';

class CommonTypeAheadTextField extends StatefulWidget {
  final String hintText;
  final List<String> myItems;
  final Function? validationFunction;
  final Function? clearCallback;
  final TextEditingController controller;
  final Function? selectionCallBack;
  const CommonTypeAheadTextField({Key? key, required this.hintText,
    this.validationFunction, this.selectionCallBack, this.clearCallback,
    required this.controller,
    required this.myItems}) : super(key: key);

  @override
  State<CommonTypeAheadTextField> createState() => _CommonTypeAheadTextFieldState();
}

class _CommonTypeAheadTextFieldState extends State<CommonTypeAheadTextField> {

  @override
  Widget build(BuildContext context) {
    // return SizedBox(
    //   height: 50,
    //   child: DropdownSearch<String>(
    //     onChanged: (String? text){
    //       print(text);
    //     },
    //     asyncItems: (String text) async {
    //       print(text);
    //       return [];
    //     },
    //     key: myKey,
    //     items: myItems,
    //     dropdownButtonProps: DropdownButtonProps(
    //       icon: Icon(Icons.keyboard_arrow_down_outlined,color: blackColor.withOpacity(0.4))
    //     ),
    //     compareFn: (i1, i2) => i1 == i2,
    //     dropdownDecoratorProps: DropDownDecoratorProps(
    //         dropdownSearchDecoration: InputDecoration(
    //           hintText: widget.hintText,
    //             hintStyle: TextStyle(color: blackColor.withOpacity(0.4),fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "Poppins"),
    //             focusedBorder: textFieldBorderStyle,
    //             disabledBorder: textFieldBorderStyle,
    //             enabledBorder: textFieldBorderStyle,
    //             errorBorder: textFieldBorderStyle,
    //             focusedErrorBorder: textFieldBorderStyle,
    //           filled: true,
    //             contentPadding: const EdgeInsets.fromLTRB(10.0, 3.0, 10.0, 3.0),
    //           fillColor: bgColor.withOpacity(0.8)
    //         ),
    //     ),
    //     popupProps: PopupProps.menu(
    //       showSelectedItems: true,
    //       interceptCallBacks: true,
    //       itemBuilder: (ctx, item, isSelected) {
    //         return ListTile(
    //           selected: isSelected,
    //           title: Text(item),
    //           onTap: () => myKey.currentState?.popupValidate([item]),
    //         );
    //       },
    //     ),
    //   ),
    // );
    return Container(
      decoration: neurmorphicBoxDecoration,
      child: TypeAheadFormField(
        textFieldConfiguration: TextFieldConfiguration(
          controller: widget.controller,
          style: white14PxNormal.apply(color: blackColor,fontSizeFactor: 1.2),
          autofocus: false,
          decoration: InputDecoration(
              fillColor: bgColor.withOpacity(0.8),
              filled: true,
              focusedBorder: textFieldBorderStyle,
              disabledBorder: textFieldBorderStyle,
              enabledBorder: textFieldBorderStyle,
              errorBorder: textFieldBorderStyle,
              focusedErrorBorder: textFieldBorderStyle,
              hintText: widget.hintText,
              contentPadding: const EdgeInsets.fromLTRB(10.0,0,10,20),
              hintStyle: white14PxNormal.copyWith(
                  color: blackColor.withOpacity(0.4)),
              suffixIcon: const Icon(Icons.arrow_drop_down, color: fontColor)),
          onChanged: (text) {
            setState(() {
              widget.clearCallback!();
            });
          },
        ),
        validator: (value) {
          return widget.validationFunction != null ? widget.validationFunction!(value) : null;
        },
        suggestionsBoxDecoration: const SuggestionsBoxDecoration(color: whiteColor),
        suggestionsCallback: (pattern) async {
          return widget.myItems;
        },
        transitionBuilder: (context, suggestionsBox, controller) {
          return suggestionsBox;
        },
        itemBuilder: (context, String? text) {
          return text == null
              ? Container()
              : ListTile(
            title: Text(
              text,
              style: white14PxNormal.copyWith(color: fontColor),
            ),
          );
        },
        onSuggestionSelected: (String? suggestion) {
          setState(() {
            if (suggestion != null) {
              FocusScope.of(context).unfocus();
              if (widget.selectionCallBack != null) {
                widget.selectionCallBack!(suggestion);
              }
            }
          });
        },
      ),
    );
  }
}
