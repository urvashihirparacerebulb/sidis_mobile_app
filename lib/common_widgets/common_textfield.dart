import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utility/color_utility.dart';
import '../utility/theme_utility.dart';
import 'common_widget.dart';

OutlineInputBorder textFormFieldBorderStyle = OutlineInputBorder(
  borderSide: const BorderSide(color: whiteColor),
  borderRadius: commonBorderRadius,
);

class CommonTextFiled extends StatefulWidget {
  final String fieldTitleText;
  final String hintText;
  final String? helperText;
  final bool isPassword;
  final bool isRequired;
  final TextEditingController textEditingController;
  final Function? validationFunction;
  final int? maxLength;
  final Function? onSavedFunction;
  final Function? onFieldSubmit;
  final TextInputType? keyboardType;
  final Function? onTapFunction;
  final Function? onChangedFunction;
  final List<TextInputFormatter>? inputFormatter;
  final bool isEnabled;
  final bool isBorderEnable;
  final bool isReadOnly;
  final int? errorMaxLines;
  final int? maxLine;
  final FocusNode? textFocusNode;
  final GlobalKey<FormFieldState>? formFieldKey;
  final TextAlign align;
  final Widget? suffixIcon;
  final Widget? preFixIcon;
  final bool isShowTitle;
  final bool isFloatingLabel;
  final bool isChangeFillColor;

  const CommonTextFiled({
    required this.fieldTitleText,
    required this.hintText,
    this.isPassword = false,
    this.isRequired = true,
    required this.textEditingController,
    this.validationFunction,
    this.helperText,
    this.maxLength,
    this.onSavedFunction,
    this.onFieldSubmit,
    this.keyboardType,
    this.onTapFunction,
    this.onChangedFunction,
    this.inputFormatter,
    this.isEnabled = true,
    this.isReadOnly = false,
    this.isBorderEnable = false,
    this.isChangeFillColor = false,
    this.errorMaxLines,
    this.maxLine,
    this.textFocusNode,
    this.formFieldKey,
    this.align = TextAlign.start,
    this.suffixIcon,
    this.preFixIcon,
    this.isFloatingLabel = false,
    this.isShowTitle = false,
  });

  @override
  _CommonTextFiledState createState() => _CommonTextFiledState();
}

class _CommonTextFiledState extends State<CommonTextFiled> {
  bool? passwordVisible = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        passwordVisible = widget.isPassword;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: !widget.isEnabled ? false : true,
      textAlign: widget.align,
      showCursor: !widget.isReadOnly,
      onTap: () {
        if (widget.onTapFunction != null) {
          widget.onTapFunction!();
        }
      },
      key: widget.key,
      focusNode: widget.textFocusNode,
      onChanged: (value) {
        if (widget.onChangedFunction != null) {
          widget.onChangedFunction!(value);
        }
      },
      validator: (value) {
        return widget.validationFunction != null ? widget
            .validationFunction!(value) : null;
      },
      // onSaved: onSavedFunction != null ? onSavedFunction : (value) {},
      onSaved: (value) {
        widget.onSavedFunction != null ? widget
            .onSavedFunction!(value) : null;
      },
      onFieldSubmitted: (value) {
        widget.onFieldSubmit != null ? widget.onFieldSubmit!(
            value) : null;
      },
      maxLines: widget.maxLine ?? 1,
      keyboardType: widget.keyboardType,
      controller: widget.textEditingController,
      cursorColor: primaryColor,
      obscureText: passwordVisible!,
      style: black15PxW800.copyWith(
          color: blackColor,fontWeight: FontWeight.normal),
      inputFormatters: widget.inputFormatter,
      decoration: InputDecoration(
        labelStyle: black15PxW800.copyWith(
            fontWeight: FontWeight.w500,
            color: blackColor.withOpacity(0.4)),
        labelText: widget.hintText,
        alignLabelWithHint: true,
        floatingLabelBehavior: widget.isFloatingLabel ? FloatingLabelBehavior.auto : FloatingLabelBehavior.never,
        errorMaxLines: widget
            .errorMaxLines ?? 1,
        filled: true,
        contentPadding: const EdgeInsets.all(10.0),
        focusedBorder: widget.isBorderEnable ? OutlineInputBorder(
          borderSide:  BorderSide(color: Theme.of(context).focusColor),
          borderRadius: commonBorderRadius,
        ) : textFormFieldBorderStyle,
        disabledBorder: widget.isBorderEnable ? OutlineInputBorder(
          borderSide:  BorderSide(color: Theme.of(context).focusColor),
          borderRadius: commonBorderRadius,
        ) : textFormFieldBorderStyle,
        enabledBorder: widget.isBorderEnable ? OutlineInputBorder(
          borderSide:  BorderSide(color: Theme.of(context).focusColor),
          borderRadius: commonBorderRadius,
        ) : textFormFieldBorderStyle,
        errorBorder: widget.isBorderEnable ? OutlineInputBorder(
          borderSide:  BorderSide(color: Theme.of(context).focusColor),
          borderRadius: commonBorderRadius,
        ) : textFormFieldBorderStyle,
        focusedErrorBorder: widget.isBorderEnable ? OutlineInputBorder(
          borderSide:  BorderSide(color: Theme.of(context).focusColor),
          borderRadius: commonBorderRadius,
        ) : textFormFieldBorderStyle,
        hintText: widget.hintText,
        fillColor: widget.isChangeFillColor ? bgColor.withOpacity(0.8) : whiteColor,
        helperText: widget.helperText ?? "",
        helperStyle: white14PxNormal.copyWith(
            color: Theme.of(context).focusColor.withOpacity(0.7),
            fontSize:12),
        helperMaxLines: 3,
        hintStyle: white14PxNormal.copyWith(
            color: blackColor.withOpacity(0.4)),
        prefixIcon: widget.preFixIcon != null
            ? Padding(
          padding: const EdgeInsets.all(6.0),
          child: widget.preFixIcon,
        )
            : null,
        suffixIcon: widget.isPassword
            ? InkWell(
            onTap: () {
              setState(() {
                passwordVisible = !passwordVisible!;
              });
            },
            child: passwordVisible!
                ? Icon(Icons.visibility_off_outlined,
                color: Theme.of(context).colorScheme.secondary)
                : Icon(Icons.visibility_outlined,
                color:  Theme.of(context).colorScheme.secondary))
            : widget.suffixIcon,
      ),);
  }
}
