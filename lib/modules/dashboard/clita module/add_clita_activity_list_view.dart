import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_projects/utility/constants.dart';
import '../../../common_widgets/common_widget.dart';
import '../../../controllers/business_controller.dart';
import '../../../controllers/dropdown_data_controller.dart';
import '../../../models/business_data_model.dart';
import '../../../models/machines_response_model.dart';
import '../../../models/plants_response_model.dart';
import '../../../textfields/business_textfiled.dart';
import '../../../textfields/common_bottom_string_view.dart';
import '../../../textfields/machine_textfield.dart';
import '../../../textfields/plants_textfield.dart';
import '../../../utility/color_utility.dart';
import '../../../utility/screen_utility.dart';

class CLITActivityListFormScreen extends StatefulWidget {
  const CLITActivityListFormScreen({Key? key}) : super(key: key);

  @override
  State<CLITActivityListFormScreen> createState() => _CLITActivityListFormScreenState();
}

class _CLITActivityListFormScreenState extends State<CLITActivityListFormScreen> {
  BusinessData? selectedBusiness;
  CompanyBusinessPlant? selectedPlant;
  MachineData? machineData;
  List<MachineData> subMachineLists = [];
  File? uploadImage;
  String selectedClita = '';

  @override
  void initState() {
    if (BusinessController.to.businessData!.isEmpty) {
      BusinessController.to.getBusinesses();
    }
    super.initState();
  }

  getSubMachineAPI({String? plantId, int? machineId}){
    DropDownDataController.to.getSubMachines(plantId: plantId,
        machineId: machineId,successCallback: (){
          if(DropDownDataController.to.subMachinesList!.isNotEmpty){
            subMachineLists.add(MachineData());
            setState(() {});
          }else {
            setState(() {});
          }
        });
  }

  imageView({String title = "", File? selectedFile}){
    return SizedBox(
      height: 72,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonHeaderTitle(
              title: title,
              color: fontColor,
              isChangeColor: true
          ),
          commonVerticalSpacing(spacing: 8),
          Container(
            height: 50,
            padding: const EdgeInsets.all(10),
            decoration: neurmorphicBoxDecoration,
            child: Row(
              children: [
                InkWell(
                    onTap: () async{
                      final ImagePicker picker = ImagePicker();
                      try {
                        final XFile? pickedFile = await picker.pickImage(
                          source: ImageSource.gallery,
                        );
                        setState(() {
                          uploadImage = File(pickedFile!.path);
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: commonHeaderTitle(
                        title: "Choose File",
                        color: blackColor.withOpacity(0.4),
                        isChangeColor: true
                    )
                ),
                commonHorizontalSpacing(spacing: 10),
                Container(height: 40,width: 1,color: fontColor),
                commonHorizontalSpacing(spacing: 10),
                commonHeaderTitle(
                    title: uploadImage == null ? "No File Chosen" : uploadImage!.path,
                    color: blackColor.withOpacity(0.4),
                    isChangeColor: true
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  clitaActivityListForm(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: (){
            commonBottomView(context: context,child: BusinessBottomView(myItems: BusinessController.to.businessData!,selectionCallBack: (BusinessData business){
              selectedBusiness = business;
              selectedPlant = null;machineData = null; subMachineLists = [];
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
                          machineData = null; subMachineLists = [];
                          setState(() {});
                          if (selectedPlant != null) {
                            DropDownDataController.to.getMachines(
                                plantId: selectedPlant!.soleId,
                                successCallback: () {

                                });
                          }
                        }));
              }
            },
            child: commonDecoratedTextView(
              title: selectedPlant == null ? "Select Plant" : selectedPlant!.soleName ?? "",
              isChangeColor: selectedPlant == null ? true : false,
            )
        ),
        GestureDetector(
            onTap: (){
              if(selectedPlant != null) {
                commonBottomView(context: context,
                    child: MachineBottomView(
                        hintText: "Select Machine",
                        soleId: selectedPlant!.soleId ?? "",
                        myItems: DropDownDataController.to.machinesList!,
                        selectionCallBack: (
                            MachineData machine) {
                          subMachineLists.clear();
                          machineData = machine;
                          subMachineLists = [];
                          setState(() {});
                          if (machineData != null) {
                            getSubMachineAPI(
                                plantId: selectedPlant!.soleId,
                                machineId: machineData!.machineId
                            );
                          }
                        }));
              }
            },
            child: commonDecoratedTextView(
              bottom: subMachineLists.isEmpty ? 25 : 0,
              title: machineData == null ? "Select Machine" : machineData!.machineName ?? "",
              isChangeColor: machineData == null ? true : false,
            )
        ),
        commonVerticalSpacing(spacing: subMachineLists.isEmpty ? 0 : 25),
        Visibility(
            visible: machineData == null ? false : true,
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: subMachineLists.length,
                itemBuilder: (context, index) => InkWell(
                    onTap: (){
                      commonBottomView(context: context,
                          child: MachineBottomView(
                              hintText: "Select Sub Machine",
                              soleId: selectedPlant!.soleId ?? "",
                              machineId: subMachineLists.last.machineId ?? 0,
                              myItems: DropDownDataController.to.subMachinesList!,
                              selectionCallBack: (
                                  MachineData machine) {
                                subMachineLists[index] = machine;
                                setState(() {
                                });
                                getSubMachineAPI(
                                    plantId: selectedPlant!.soleId,
                                    machineId: subMachineLists[index].machineId
                                );
                              }));
                    },
                    child: commonDecoratedTextView(
                      title: subMachineLists[index].machineName == null ? "Select Sub Machine" : subMachineLists[index].machineName ?? "",
                      isChangeColor: subMachineLists[index].machineName == null ? true : false,
                    )
                )
            )
        ),
        Visibility(
            visible: selectedBusiness != null && selectedPlant != null && machineData != null ,
            child: commonHeaderTitle(title: "Activity In Image",fontSize: isTablet() ? 1.5 : 1.2,fontWeight: 2,color: darkFontColor)),
        commonVerticalSpacing(spacing: selectedBusiness != null && selectedPlant != null && machineData != null ? 25 : 0),
        Visibility(
          visible: selectedBusiness != null && selectedPlant != null && machineData != null ,
          child: InkWell(
            onTap: (){
              commonBottomView(context: context,
                  child: CommonBottomStringView(
                      hintText: "Select CLITA",
                      myItems: const ["C","L","I","T","A"],
                      selectionCallBack: (
                          String val) {
                        setState(() {
                          selectedClita = val;
                        });
                      }));
            },
            child: commonDecoratedTextView(
                title: selectedClita == "" ? "Select CLITA" : selectedClita,
                isChangeColor: true
            ),
          ),
        ),
        Visibility(
          visible: selectedClita != "",
            child: imageView(title: "Upload Image", selectedFile: uploadImage)
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
        appBar: commonAppbar(context: context,title: clitaActivityListText),
        child: Obx(() {
          return BusinessController.to.businessData!.isEmpty ? const SpinKitThreeBounce(
            color: primaryColor,
            size: 30.0,
          ) : ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0,right: 24.0,top: 24.0),
                child: clitaActivityListForm()
              )
            ],
          );
        })
    );
  }
}
