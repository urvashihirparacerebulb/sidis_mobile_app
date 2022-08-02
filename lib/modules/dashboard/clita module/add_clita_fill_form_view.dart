import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_projects/controllers/dropdown_data_controller.dart';
import 'package:my_projects/models/business_data_model.dart';
import 'package:my_projects/models/machines_response_model.dart';
import 'package:my_projects/utility/constants.dart';
import '../../../common_widgets/common_typeaheadfield.dart';
import '../../../common_widgets/common_widget.dart';
import '../../../models/plants_response_model.dart';
import '../../../textfields/business_textfiled.dart';
import '../../../textfields/machine_textfield.dart';
import '../../../textfields/plants_textfield.dart';
import '../../../utility/color_utility.dart';
import '../../../utility/common_methods.dart';

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
  String selectedDate = "";

  @override
  void initState() {
    if(DropDownDataController.to.businessData!.isEmpty) {
      DropDownDataController.to.getBusinesses();
    }
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
            return DropDownDataController.to.businessData!.isEmpty ? const SpinKitThreeBounce(
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
                      myItems: DropDownDataController.to.businessData!,
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
                            DropDownDataController.to.getMachines(plantId: selectedPlant!.soleId);
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
                          if(machineData != null){
                            DropDownDataController.to.getSubMachines(plantId: selectedPlant!.soleId,machineId: machineData!.machineId);
                          }
                        });
                      },
                      validationFunction: (String val){

                      },
                    ),
                    commonVerticalSpacing(spacing: 20),
                    Visibility(
                      visible: machineData == null ? false : true,
                      child: MachineTextFiled(
                        controller: subMachineController,
                        myItems: DropDownDataController.to.subMachinesList!,
                        hintText: "Select Sub Machine",
                        clearCallback: (){

                        },
                        selectionCallBack: (MachineData val){
                          setState(() {
                            machineData = val;
                            subMachineController.text = machineData?.machineName ?? "";
                          });
                        },
                        validationFunction: (String val){

                        },
                      ),
                    ),
                    commonVerticalSpacing(spacing: machineData == null ? 0 : 20),
                    CommonTypeAheadTextField(
                      controller: intervalController,
                      myItems: DropDownDataController.to.intervalList,
                      hintText: "Select Interval",
                      clearCallback: (){

                      },
                      selectionCallBack: (String val){
                        setState(() {
                          intervalController.text = val;
                        });
                      },
                      validationFunction: (String val){

                      },
                    ),
                    commonVerticalSpacing(spacing: 20),
                    Container(
                        height: 48,
                        padding: EdgeInsets.symmetric(horizontal: commonHorizontalPadding),
                        decoration: neurmorphicBoxDecoration,
                        child: Stack(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: commonHeaderTitle(title: selectedDate.isEmpty ? "Select Date" : selectedDate)
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
                                        selectedDate = DateFormat("dd/MM/yyyy").format(value);
                                      });
                                    });
                                  },
                                  child: Icon(Icons.calendar_month, color: blackColor.withOpacity(0.4)),
                                )),
                          ],
                        )),
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
