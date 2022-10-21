import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_projects/utility/constants.dart';
import '../../../common_widgets/common_widget.dart';
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

class AddNeedleBoardView extends StatefulWidget {
  const AddNeedleBoardView({Key? key}) : super(key: key);

  @override
  State<AddNeedleBoardView> createState() => _AddNeedleBoardViewState();
}

class _AddNeedleBoardViewState extends State<AddNeedleBoardView> {

  BusinessData? selectedBusiness;
  CompanyBusinessPlant? selectedPlant;
  TextEditingController needleConsumedController = TextEditingController();
  String selectedDate = "";
  String _selectedGender = "1";

  boardFormView(){
    return Column(
      mainAxisSize: MainAxisSize.min,
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
              title: "Select Line *",
              isChangeColor: true
          ),
        ),
        InkWell(
          onTap: (){

          },
          child: commonDecoratedTextView(
              title: "Select Looms * ",
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
                        title: selectedDate.isEmpty ? "Date Time" : selectedDate)
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
        commonVerticalSpacing(spacing: 30),
        Align(
          alignment: Alignment.centerLeft,
          child: commonHeaderTitle(title: "Did You Changed Needle Board?",color: blackColor,fontSize: 1.2,fontWeight: 1,align: TextAlign.start),
        ),
        commonVerticalSpacing(spacing: 10),
        SizedBox(
          height: 50,
          width: getScreenWidth(context) - 40,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ListTile(
                  leading: Radio<String>(
                    value: '1',
                    groupValue: _selectedGender,
                    activeColor: primaryColor,
                    onChanged: (value) {
                      _selectedGender = value!;
                    },
                  ),
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text('Yes'),
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: Radio<String>(
                    value: '2',
                    groupValue: _selectedGender,
                    activeColor: primaryColor,
                    onChanged: (value) {
                      _selectedGender = value!;
                    },
                  ),
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text('No'),
                ),
              ),
            ],
          ),
        ),
        commonVerticalSpacing(spacing: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return commonStructure(
      context: context,
      bgColor: blackColor,
      appBar: commonAppbar(context: context,title: needleBoardText),
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
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24.0,right: 24.0,top: 24.0),
          child: boardFormView(),
        )
      ],
    ),
    );
  }
}
