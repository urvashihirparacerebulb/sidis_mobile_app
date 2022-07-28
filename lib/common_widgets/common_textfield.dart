import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_projects/controllers/general_controller.dart';
import 'package:my_projects/utility/color_utility.dart';
import '../theme/convert_theme_colors.dart';
import '../utility/theme_utility.dart';
import 'common_widget.dart';

OutlineInputBorder textFieldBorderStyle = OutlineInputBorder(
  borderSide: const BorderSide(color: Colors.transparent),
  borderRadius: commonBorderRadius,
);

class CommonTextFiled extends StatefulWidget {
  final String fieldTitleText;
  final String hintText;
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
  final bool isReadOnly;
  final int? errorMaxLines;
  final int? maxLine;
  final FocusNode? textFocusNode;
  final GlobalKey<FormFieldState>? formFieldKey;
  final TextAlign align;
  final Widget? suffixIcon;
  final Color fontColor;
  final Widget? preFixIcon;
  final bool isShowTitle;
  final Color? fillColor;
  final bool isChangeFillColor;

  const CommonTextFiled(
      {required this.fieldTitleText,
        required this.hintText,
        this.isPassword = false,
        this.isRequired = true,
        required this.textEditingController,
        this.validationFunction,
        this.maxLength,
        this.onSavedFunction,
        this.onFieldSubmit,
        this.keyboardType,
        this.onTapFunction,
        this.onChangedFunction,
        this.isChangeFillColor = false,
        this.inputFormatter,
        this.isEnabled = true,
        this.isReadOnly = false,
        this.errorMaxLines,
        this.maxLine,
        this.textFocusNode,
        this.formFieldKey,
        this.align = TextAlign.start,
        this.suffixIcon,
        this.preFixIcon,
        this.isShowTitle = false,
        this.fontColor = primaryColor,
        this.fillColor});

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
    return Obx(() => Container(
        decoration: BoxDecoration(
          boxShadow: GeneralController.to.isDarkMode.value ? [
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              offset: const Offset(-6.0, -6.0),
              blurRadius: 16.0,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              offset: const Offset(6.0, 6.0),
              blurRadius: 16.0,
            ),
          ] : [
            BoxShadow(
              color: Colors.white.withOpacity(0.8),
              offset: const Offset(-6.0, -6.0),
              blurRadius: 16.0,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(6.0, 6.0),
              blurRadius: 16.0,
            ),
          ],
          color: ConvertTheme().getTextFiledBackGroundColor(),
          borderRadius: BorderRadius.circular(12.0),
        ),
      child: TextFormField(
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
          return widget.validationFunction != null
              ? widget.validationFunction!(value)
              : null;
        },
        // onSaved: onSavedFunction != null ? onSavedFunction : (value) {},
        onSaved: (value) {
          // ignore: void_checks
          return widget.onSavedFunction != null
              ? widget.onSavedFunction!(value)
              : null;
        },
        onFieldSubmitted: (value) {
          // ignore: void_checks
          return widget.onFieldSubmit != null
              ? widget.onFieldSubmit!(value)
              : null;
        },
        maxLines: widget.maxLine ?? 1,
        keyboardType: widget.keyboardType,
        controller: widget.textEditingController,
        cursorColor: widget.fontColor,
        // initialValue: initialText,
        obscureText: passwordVisible!,
        style: black15PxW800.copyWith(
            color: blackColor,fontWeight: FontWeight.normal),
        inputFormatters: widget.inputFormatter,
        decoration: InputDecoration(
          labelStyle: black15PxW800.copyWith(
              fontWeight: FontWeight.w500,
              color: blackColor.withOpacity(0.4)),
          labelText: widget.fieldTitleText,
          alignLabelWithHint: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          errorMaxLines: widget.errorMaxLines ?? 1,
          filled: true,
          contentPadding: const EdgeInsets.only(top: 22, left: 15),
          focusedBorder: textFieldBorderStyle,
          disabledBorder: textFieldBorderStyle,
          enabledBorder: textFieldBorderStyle,
          errorBorder: textFieldBorderStyle,
          focusedErrorBorder: textFieldBorderStyle,
          hintText: widget.hintText,
          fillColor: widget.isChangeFillColor ? bgColor.withOpacity(0.8) : ConvertTheme().getTextFiledBackGroundColor(),
          hintStyle: white14PxNormal.copyWith(
              color: blackColor.withOpacity(0.4),fontSize: 16),
          suffixIcon: widget.isPassword
              ? InkWell(
              onTap: () {
                setState(() {
                  passwordVisible = !passwordVisible!;
                });
              },
              child: passwordVisible!
                  ? const Icon(
                Icons.visibility_off,
                color: blackColor,
              )
                  : const Icon(
                Icons.remove_red_eye_sharp,
                color: blackColor,
              ))
              : widget.suffixIcon,
          prefixIcon: widget.preFixIcon != null
              ? Padding(
            padding: const EdgeInsets.all(6.0),
            child: widget.preFixIcon,
          )
              : null,
        ),
      ),
    ));
  }
}

