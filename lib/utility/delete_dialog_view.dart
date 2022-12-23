import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_projects/common_widgets/common_widget.dart';

import 'color_utility.dart';

class DeleteDialogView extends StatefulWidget {
  final Function doneCallback;
  const DeleteDialogView({Key? key, required this.doneCallback}) : super(key: key);

  @override
  State<DeleteDialogView> createState() => _DeleteDialogViewState();
}

class _DeleteDialogViewState extends State<DeleteDialogView> {

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: deleteDialogContent(context),
    );
  }

  Widget deleteDialogContent(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 0.0,right: 0.0),
      child: Container(
        padding: const EdgeInsets.only(top: 18.0,),
        margin: const EdgeInsets.only(top: 13.0,right: 8.0),
        decoration: BoxDecoration(
            color: whiteColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.black26,
                blurRadius: 0.0,
                offset: Offset(0.0, 0.0),
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.warning_amber,size: 66,color: primaryColor),
              commonVerticalSpacing(spacing: 20),
              commonHeaderTitle(
                title: "Are you sure?",
                color: blackColor,
                isChangeColor: true,
                fontSize: 1.7,
                fontWeight: 2
              ),
              commonVerticalSpacing(spacing: 20),
              Row(
                children: [
                  Expanded(
                    child: commonBorderButtonView(
                        context: context,
                        title: "Cancel",
                        height: 50,
                        tapOnButton: () {
                          Get.back();
                        },
                        isLoading: false),
                  ),
                  commonHorizontalSpacing(spacing: 10),
                  Expanded(
                    child: commonFillButtonView(
                        context: context,
                        title: "Yes, delete it!",
                        height: 50,
                        color: Colors.blue,
                        fontColor: whiteColor,
                        tapOnButton: () {
                          Get.back();
                          widget.doneCallback();
                        },
                        isLoading: false),
                  )
                ],
              ),
              commonVerticalSpacing(spacing: 20),
            ],
          ),
        ),
      ),
    );
  }
}
