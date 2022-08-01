import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../common_widgets/common_widget.dart';
import '../models/machines_response_model.dart';
import '../utility/color_utility.dart';
import '../utility/theme_utility.dart';

class MachineTextFiled extends StatefulWidget {
  final String hintText;
  final List<MachineData> myItems;
  final Function? validationFunction;
  final Function? clearCallback;
  final TextEditingController controller;
  final bool? isEnabled;
  final Function? selectionCallBack;
  const MachineTextFiled({Key? key,required this.hintText,
    this.validationFunction, this.selectionCallBack, this.clearCallback,
    required this.controller,
    required this.myItems, this.isEnabled}) : super(key: key);

  @override
  State<MachineTextFiled> createState() => _MachineTextFiledState();
}

class _MachineTextFiledState extends State<MachineTextFiled> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: neurmorphicBoxDecoration,
      child: TypeAheadFormField(
        textFieldConfiguration: TextFieldConfiguration(
          controller: widget.controller,
          style: white14PxNormal.apply(color: blackColor,fontSizeFactor: 1.2),
          autofocus: false,
          enabled: widget.isEnabled ?? true,
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
        itemBuilder: (context, MachineData? text) {
          return text == null
              ? Container()
              : ListTile(
            title: Text(
              text.machineName ?? "",
              style: white14PxNormal.copyWith(color: fontColor),
            ),
          );
        },
        onSuggestionSelected: (MachineData? suggestion) {
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
