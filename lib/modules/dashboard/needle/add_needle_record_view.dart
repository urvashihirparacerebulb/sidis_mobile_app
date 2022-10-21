import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_projects/common_widgets/common_widget.dart';
import 'package:my_projects/utility/constants.dart';

import '../../../common_widgets/common_textfield.dart';
import '../../../controllers/business_controller.dart';
import '../../../controllers/dropdown_data_controller.dart';
import '../../../models/business_data_model.dart';
import '../../../models/plants_response_model.dart';
import '../../../textfields/business_textfiled.dart';
import '../../../textfields/plants_textfield.dart';
import '../../../theme/convert_theme_colors.dart';
import '../../../utility/color_utility.dart';
import '../../../utility/common_methods.dart';
import '../../../utility/screen_utility.dart';

class AddNeedleRecordView extends StatefulWidget {
  const AddNeedleRecordView({Key? key}) : super(key: key);

  @override
  State<AddNeedleRecordView> createState() => _AddNeedleRecordViewState();
}

class _AddNeedleRecordViewState extends State<AddNeedleRecordView> {

  BusinessData? selectedBusiness;
  CompanyBusinessPlant? selectedPlant;
  TextEditingController needleConsumedController = TextEditingController();
  String selectedDate = "";

  recordFormView(){
    return Column(
      children: [
        InkWell(
          onTap: (){
            commonBottomView(context: context,child: BusinessBottomView(myItems: BusinessController.to.businessData!,selectionCallBack: (BusinessData business){
              selectedBusiness = business;
              selectedPlant = null;
              setState(() {});
              if(selectedBusiness?.businessId != null) {
                DropDownDataController.to.getCompanyPlants(businessId: selectedBusiness?.businessId.toString(),successCallback: (){
                  // getActivityList();
                });
              }
            }));
          },
          child: commonDecoratedTextView(
              title: selectedBusiness?.businessId == null ? "Select Business" : selectedBusiness?.businessName ?? "",
              isChangeColor: selectedBusiness?.businessId == null ? true : false
          ),
        ),
        InkWell(
            onTap: (){
              if(selectedBusiness?.businessId != null) {
                commonBottomView(context: context,
                    child: PlantBottomView(
                        myItems: DropDownDataController.to
                            .companyBusinessPlants!,
                        businessId: selectedBusiness!.businessId.toString(),
                        selectionCallBack: (
                            CompanyBusinessPlant plant) {
                          selectedPlant = plant;
                          setState(() {});
                        }));
              }
            },
            child: commonDecoratedTextView(
              title: selectedPlant == null ? "Select Plant" : selectedPlant!.soleName ?? "",
              isChangeColor: selectedPlant == null ? true : false,
            )
        ),

        InkWell(
          onTap: (){

          },
          child: commonDecoratedTextView(
              title: "Select Board Number *",
              isChangeColor: true
          ),
        ),
        InkWell(
          onTap: (){

          },
          child: commonDecoratedTextView(
              title: "Needles Changed Status * ",
              isChangeColor: true
          ),
        ),
        Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: commonHorizontalPadding),
            decoration: neurmorphicBoxDecoration,
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: commonHeaderTitle(
                        fontSize: isTablet() ? 1.3 : 1,
                        title: selectedDate.isEmpty ? "Date" : selectedDate)
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        openCalendarView(
                          context,
                          initialDate: DateTime.now().toString(),
                        ).then((value) {
                          setState(() {
                            selectedDate = DateFormat("dd MMM,yyyy").format(value);
                          });
                        });
                      },
                      child: Icon(Icons.calendar_month, color: blackColor.withOpacity(0.4)),
                    )),
              ],
            )),
        commonVerticalSpacing(spacing: 20),
        CommonTextFiled(
            fieldTitleText: "No of Needles Consumed *",
            hintText: "No of Needles Consumed *",
            // isBorderEnable: false,
            isChangeFillColor: true,
            textEditingController: needleConsumedController,
            onChangedFunction: (String value){
            },
            validationFunction: (String value) {
              return value.toString().isEmpty
                  ? notEmptyFieldMessage
                  : null;
            }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return commonStructure(
      context: context,
      bgColor: blackColor,
      appBar: commonAppbar(context: context,title: needleRecordFormText),
      bottomNavigation: Container(
        color: ConvertTheme.convertTheme.getBackGroundColor(),
        child: Padding(
          padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16,top: 10),
          child: Row(
            children: [
              Expanded(child: commonBorderButtonView(
                  context: context,
                  title: "Cancel",
                  height: 50,
                  tapOnButton: () {
                    Get.back();
                  },
                  isLoading: false)),
              commonHorizontalSpacing(),
              Expanded(child: commonFillButtonView(
                  context: context,
                  title: "Save",
                  width: getScreenWidth(context) - 40,
                  height: 50,
                  tapOnButton: () {

                  },
                  isLoading: false)),
            ],
          ),
        ),
      ), child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24.0,right: 24.0,top: 24.0),
              child: recordFormView(),
            )
          ],
      ),
    );
  }
}
