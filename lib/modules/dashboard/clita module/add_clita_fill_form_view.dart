import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:my_projects/controllers/dropdown_data_controller.dart';
import 'package:my_projects/models/business_data_model.dart';
import 'package:my_projects/models/machines_response_model.dart';
import 'package:my_projects/utility/constants.dart';

import '../../../common_widgets/common_textfield.dart';
import '../../../common_widgets/common_typeaheadfield.dart';
import '../../../common_widgets/common_widget.dart';
import '../../../models/plants_response_model.dart';
import '../../../textfields/business_textfiled.dart';
import '../../../textfields/machine_textfield.dart';
import '../../../textfields/plants_textfield.dart';
import '../../../utility/color_utility.dart';

class CLITAFillFormView extends StatefulWidget {
  const CLITAFillFormView({Key? key}) : super(key: key);

  @override
  State<CLITAFillFormView> createState() => _CLITAFillFormViewState();
}

class _CLITAFillFormViewState extends State<CLITAFillFormView> {

  TextEditingController dateController = TextEditingController();
  TextEditingController businessController = TextEditingController();
  TextEditingController plantsController = TextEditingController();
  TextEditingController machineController = TextEditingController();
  TextEditingController subMachineController = TextEditingController();
  TextEditingController intervalController = TextEditingController();
  BusinessData? selectedBusiness;
  CompanyBusinessPlant? selectedPlant;
  MachineData? machineData;

  @override
  void initState() {
    DropDownDataController.to.getBusinesses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return commonStructure(
        context: context,
        bgColor: blackColor,
        appBar: commonAppbar(context: context,title: clitaFillFormText),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Obx((){
            return DropDownDataController.to.bussinessData!.isEmpty ? const SpinKitThreeBounce(
              color: primaryColor,
              size: 30.0,
            ) : Stack(
              alignment: Alignment.topCenter,
              children: [
                ListView(
                  shrinkWrap: true,
                  children: [
                    BusinessTextField(
                      controller: businessController,
                      hintText: "Select Business",
                      myItems: DropDownDataController.to.bussinessData!,
                      clearCallback: (){

                      },
                      selectionCallBack: (BusinessData val){
                        setState((){
                          selectedBusiness = val;
                          businessController.text = selectedBusiness!.businessName ?? "";
                          if(selectedBusiness != null) {
                            DropDownDataController.to.getCompanyPlants(businessId: selectedBusiness!.businessId.toString());
                          }
                        });
                      },
                      validationFunction: (String val){

                      },
                    ),
                    commonVerticalSpacing(spacing: 20),
                    PlantsTextField(
                      controller: plantsController,
                      isEnabled: selectedBusiness == null ? false : true,
                      myItems: DropDownDataController.to.companyBusinessPlants!,
                      hintText: "Select COMPANY_BUSINESS_PLANTS",
                      clearCallback: (){

                      },
                      selectionCallBack: (CompanyBusinessPlant val){
                        setState(() {
                          selectedPlant = val;
                          plantsController.text = selectedPlant!.soleName ?? "";
                          if(selectedPlant != null) {
                            DropDownDataController.to.getMachines(plantId: selectedPlant!.soleId.toString());
                          }
                        });
                      },
                      validationFunction: (String val){

                      },
                    ),
                    commonVerticalSpacing(spacing: 20),
                    MachineTextFiled(
                      controller: machineController,
                      isEnabled: selectedPlant == null ? false : true,
                      myItems: DropDownDataController.to.machinesList!,
                      hintText: "Select Machine",
                      clearCallback: (){

                      },
                      selectionCallBack: (MachineData val){
                        setState(() {
                          machineData = val;
                          machineController.text = machineData?.machineName ?? "";
                        });
                      },
                      validationFunction: (String val){

                      },
                    ),
                    commonVerticalSpacing(spacing: 20),
                    CommonTypeAheadTextField(
                      controller: intervalController,
                      myItems: [],
                      hintText: "Select Interval",
                      clearCallback: (){

                      },
                      selectionCallBack: (String val){

                      },
                      validationFunction: (String val){

                      },
                    ),
                    commonVerticalSpacing(spacing: 20),
                    CommonTextFiled(
                      fieldTitleText: "Select Date",
                      hintText: "Select Date",
                      // isBorderEnable: false,
                      isChangeFillColor: true,
                      textEditingController: dateController,
                      suffixIcon: InkWell(
                        onTap: (){},
                        child: const Icon(Icons.calendar_month),
                      ),
                      onChangedFunction: (String value){
                      },
                      validationFunction: (String value) {
                        return value.toString().isEmpty
                            ? notEmptyFieldMessage
                            : null;
                      },),
                  ],
                ),
                // Positioned(
                //   bottom: 20,
                //   right: 10,left: 10,
                //   child: Container(
                //     height: 65,
                //     decoration: BoxDecoration(
                //       image: DecorationImage(
                //         image: watermarkImage,
                //         fit: BoxFit.contain,
                //       ),
                //     ),
                //   ),
                // )
              ],
            );
          }),
        )
    );
  }
}
