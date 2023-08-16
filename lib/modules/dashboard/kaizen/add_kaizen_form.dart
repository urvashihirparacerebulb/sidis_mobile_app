import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_projects/common_widgets/common_widget.dart';
import 'package:my_projects/controllers/kaizen_controller.dart';
import 'package:my_projects/models/kaizen_response_model.dart';
import 'package:my_projects/utility/constants.dart';
import 'package:image_picker/image_picker.dart';
import '../../../common_widgets/common_textfield.dart';
import '../../../controllers/business_controller.dart';
import '../../../controllers/dashboard_controller.dart';
import '../../../controllers/department_controller.dart';
import '../../../controllers/dropdown_data_controller.dart';
import '../../../models/business_data_model.dart';
import '../../../models/department_response_model.dart';
import '../../../models/machines_response_model.dart';
import '../../../models/pillar_data_model.dart';
import '../../../models/plants_response_model.dart';
import '../../../models/team_member_model.dart';
import '../../../textfields/business_textfiled.dart';
import '../../../textfields/common_bottom_string_view.dart';
import '../../../textfields/department_textfiled.dart';
import '../../../textfields/machine_textfield.dart';
import '../../../textfields/pillar_textfield.dart';
import '../../../textfields/plants_textfield.dart';
import '../../../textfields/team_member_textfield.dart';
import '../../../theme/convert_theme_colors.dart';
import '../../../utility/color_utility.dart';
import '../../../utility/common_methods.dart';
import '../../../utility/screen_utility.dart';

class AddKaizenFormView extends StatefulWidget {
  final bool isEdit;
  final String id;
  const AddKaizenFormView({Key? key, this.isEdit = false, this.id = ""}) : super(key: key);

  @override
  State<AddKaizenFormView> createState() => _AddKaizenFormViewState();
}

class _AddKaizenFormViewState extends State<AddKaizenFormView> {

  PillarResponse? selectedPillar;
  BusinessData? selectedBusiness;
  CompanyBusinessPlant? selectedPlant;
  Department? selectedDepartment;
  Department? selectedSubDepartment;
  MachineData? machineData;
  List<MachineData> subMachineLists = [];
  String selectedStartDate = "";
  String selectedResultArea = "";
  String selectedRootCause = "";
  File? problemImage;
  File? countermeasureImage;
  List<KaizenTeamData> selectedTeamMembers = [];
  bool isEdit = false;

  TextEditingController kaizenLossNoController = TextEditingController();
  TextEditingController kaizenThemeController = TextEditingController();
  TextEditingController benchMarkController = TextEditingController();
  TextEditingController targetController = TextEditingController();
  TextEditingController problemController = TextEditingController();
  TextEditingController productImageController = TextEditingController();
  TextEditingController rootCauseRemarksController = TextEditingController();
  TextEditingController kaizenIdeaController = TextEditingController();
  TextEditingController countermeasureController = TextEditingController();
  TextEditingController analysisTitleController = TextEditingController();
  TextEditingController analysisAnswerController = TextEditingController();
  KaizenAnalysis? editableKaizen;
  int? selectedKaizenIndex;

  @override
  void initState() {
    if (BusinessController.to.businessData!.isEmpty) {
      BusinessController.to.getBusinesses();
    }
    Future.delayed(const Duration(seconds: 3),(){
      KaizenController.to.getKaizenResultArea(callback: (){
        if(widget.isEdit){
          Future.delayed(const Duration(seconds: 2),(){
            KaizenController.to.getKaizenDetail(kaizenId: widget.id,callback: (){
              var kaizen = KaizenController.to.kaizenDetail.value;
              PillarResponse pillar = PillarResponse();
              pillar.pillarCategoryId = kaizen.pillarCategoryId;
              pillar.pillarName = kaizen.pillarName;
              selectedPillar = pillar;
              BusinessData business  = BusinessData();
              business.businessId = kaizen.bussinessId;
              business.businessName = kaizen.businessName;
              selectedBusiness = business;
              CompanyBusinessPlant plant = CompanyBusinessPlant();
              plant.soleId = "${kaizen.companyId} - ${kaizen.plantId} - ${kaizen.bussinessId}";
              plant.soleName = kaizen.plantShortName;
              selectedPlant = plant;
              Department department = Department();
              department.departmentId = kaizen.departmentId;
              department.departmentName = kaizen.departmentName;
              selectedDepartment = department;
              Department subDepartment = Department();
              subDepartment.departmentId = kaizen.subdepartmentId;
              subDepartment.departmentName = kaizen.subdepartmentName;
              selectedSubDepartment = subDepartment;
              MachineData machine = MachineData();
              machine.machineId = kaizen.machineId;
              machine.machineName = kaizen.machineName;
              machineData = machine;
              MachineData subMachine = MachineData();
              subMachine.machineId = kaizen.subdepartmentId;
              subMachine.machineName = kaizen.submachineName;
              subMachineLists.add(subMachine);

              selectedRootCause = kaizen.rootCause ?? "";
              selectedStartDate = kaizen.startDate ?? "";
              kaizenLossNoController.text = kaizen.lossNoStep ?? "";
              selectedResultArea = kaizen.resultArea ?? "";
              kaizenThemeController.text = kaizen.theme ?? "";
              benchMarkController.text = kaizen.benchMark ?? "";
              targetController.text = kaizen.target ?? "";
              countermeasureController.text = kaizen.countermeasure ?? "";

              List<String>? teamsIds = kaizen.teamMemberId?.split(",");
              List<String>? teamsNames = kaizen.teamMembers?.split(",");
              for(int i = 0; i < teamsIds!.length; i++){
                KaizenTeamData teamObj = KaizenTeamData();
                teamObj.userId = int.parse(teamsIds[i]);
                teamObj.userName = teamsNames![i];
                selectedTeamMembers.add(teamObj);
              }

              problemController.text = kaizen.presentProblem ?? "";
              rootCauseRemarksController.text = kaizen.remarks ?? "";
              kaizenIdeaController.text = kaizen.idea ?? "";
              setState(() {});
            });
          });
        }
      });
    });
    super.initState();
  }

  getSubMachineAPI({String? plantId, int? machineId}) {
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

  imageView({String title = "", Function? onChanged, File? selectedFile}){
    return SizedBox(
      height: selectedFile == null ? 72 : 144,
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
          widget.isEdit ?
          Container(
            height: selectedFile == null ? 50 : 100,
            padding: const EdgeInsets.all(10),
            decoration: neurmorphicBoxDecoration,
            child: Row(
              children: [
                InkWell(
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
                      try {
                        final XFile? pickedFile = await picker.pickImage(
                          source: ImageSource.gallery,
                        );
                        setState(() {
                          onChanged!(File(pickedFile!.path));
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: commonHeaderTitle(
                        title: "Change File",
                        color: blackColor.withOpacity(0.4),
                        isChangeColor: true
                    )
                ),
                commonHorizontalSpacing(spacing: 10),
                Container(height: 40,width: 1,color: fontColor),
                commonHorizontalSpacing(spacing: 10),
                Expanded(child: selectedFile == null ? Image.network(
                    title == "Problem Image *" ?
                    KaizenController.to.kaizenDetail.value.presentProblemImage ?? "" :
                    KaizenController.to.kaizenDetail.value.countermeasureImage ?? "",
                    height: 100) : Image.file(selectedFile, height: 100))
              ],
            ),
          )
              : Container(
            height: selectedFile == null ? 50 : 100,
            padding: const EdgeInsets.all(10),
            decoration: neurmorphicBoxDecoration,
            child: Row(
              children: [
                InkWell(
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
                      try {
                        final XFile? pickedFile = await picker.pickImage(
                          source: ImageSource.gallery,
                        );
                        setState(() {
                          onChanged!(File(pickedFile!.path));
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
                selectedFile == null ? commonHeaderTitle(
                    title: "No File Chosen",
                    color: blackColor.withOpacity(0.4),
                    isChangeColor: true
                ) : Expanded(child: Image.file(selectedFile,height: 100))
              ],
            ),
          ),
        ],
      ),
    );
  }

  analysisView(){
    return [
      Visibility(
        visible: KaizenController.to.kaizenAnalysisList.isNotEmpty,
        child: ListView.builder(
          itemCount: KaizenController.to.kaizenAnalysisList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 16),
              decoration: neurmorphicBoxDecoration,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      commonHeaderTitle(title: KaizenController.to.kaizenAnalysisList[index].why ?? "",fontWeight: 3,fontSize: isTablet() ? 1.5 : 1.2),
                      commonHorizontalSpacing(),
                      Row(
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                isEdit = true;
                                selectedKaizenIndex = index;
                                editableKaizen = KaizenController.to.kaizenAnalysisList[index];
                                analysisTitleController.text = editableKaizen!.why ?? "";
                                analysisAnswerController.text = editableKaizen!.answer ?? "";
                              });
                            },
                              child: const Icon(Icons.edit,color: Colors.orange)
                          ),
                          commonHorizontalSpacing(),
                          InkWell(
                            onTap: (){
                              KaizenController.to.deleteKaizenAnalysis(analysisId: KaizenController.to.kaizenAnalysisList[index].analysisId.toString(),callback: (){
                                KaizenController.to.kaizenAnalysisList.removeAt(index);
                              });
                            },
                              child: const Icon(Icons.delete_outline,color: Colors.redAccent)
                          )
                        ]
                      )
                    ]
                  ),
                  commonVerticalSpacing(),
                  commonHeaderTitle(title: KaizenController.to.kaizenAnalysisList[index].answer ?? "",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),
                ],
              ),
            );
        }),
      ),

      Row(
        children: [
          Expanded(
            child: CommonTextFiled(
                fieldTitleText: "Why",
                hintText: "Why",
                // isBorderEnable: false,
                isChangeFillColor: true,
                textEditingController: analysisTitleController,
                onChangedFunction: (String value){

                },
                validationFunction: (String value) {
                  return value.toString().isEmpty
                      ? notEmptyFieldMessage
                      : null;
                }),
          ),
          commonHorizontalSpacing(spacing: 10),
          Expanded(
            child: CommonTextFiled(
                fieldTitleText: "Answer",
                hintText: "Answer",
                // isBorderEnable: false,
                isChangeFillColor: true,
                textEditingController: analysisAnswerController,
                onChangedFunction: (String value){
                },
                validationFunction: (String value) {
                  return value.toString().isEmpty
                      ? notEmptyFieldMessage
                      : null;
                }),
          ),
          commonHorizontalSpacing(spacing: 10),
          InkWell(
            onTap: (){
              if(isEdit){
                KaizenController.to.addManageKaizenAnalysis(
                    answer: analysisAnswerController.text,
                    isEdit: true,
                    index: selectedKaizenIndex,
                    kaizenAnalysisId: editableKaizen!.kaizenId.toString(),
                    why: analysisTitleController.text);
                analysisTitleController.clear();
                analysisAnswerController.clear();
                isEdit = false;
              }else {
                KaizenController.to.addManageKaizenAnalysis(
                    answer: analysisAnswerController.text,
                    kaizenId: "0",
                    why: analysisTitleController.text);
                analysisTitleController.clear();
                analysisAnswerController.clear();
              }
            },
            child: Container(
              margin: const EdgeInsets.only(top: 8),
              padding: EdgeInsets.all(isEdit ? 12 : 8),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8.0)
              ),
                child: isEdit ? commonHeaderTitle(title: "Edit",isChangeColor: true,color: whiteColor) : const Icon(Icons.add,color: whiteColor,size: 26)),
          )
        ],
      )
    ];
  }

  kaizenWhomForm(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        commonHeaderTitle(title: "Kaizen for whom?",fontSize: isTablet() ? 1.5 : 1.2,fontWeight: 2,color: darkFontColor),
        commonVerticalSpacing(spacing: 20),
        InkWell(
          onTap: (){
            if(DashboardController.to.pillarList.isEmpty){
              DashboardController.to.getPillarList();
            }
            commonBottomView(context: context,child: PillarBottomView(myItems: DashboardController.to.pillarList,
                selectionCallBack: (PillarResponse pillar){
                  selectedPillar = pillar;
              setState(() {});
            }));
          },
          child: commonDecoratedTextView(
              title: selectedPillar?.pillarCategoryId == null ? "Select Pillar" : selectedPillar?.pillarName ?? "",
              isChangeColor: selectedPillar?.pillarCategoryId == null ? true : false
          ),
        ),
        InkWell(
          onTap: (){
            commonBottomView(context: context,child: BusinessBottomView(myItems: BusinessController.to.businessData!,selectionCallBack: (BusinessData business){
              selectedBusiness = business;
              selectedPlant = null;selectedDepartment = null;
              selectedSubDepartment = null;machineData = null; subMachineLists = [];
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
                if(DropDownDataController.to.companyBusinessPlants!.isEmpty){
                  DropDownDataController.to.getCompanyPlants(businessId: selectedBusiness?.businessId.toString(),successCallback: (){
                    // getActivityList();
                  });
                }
                commonBottomView(
                    context: context,
                    child: PlantBottomView(
                        myItems: DropDownDataController.to.companyBusinessPlants!,
                        businessId: selectedBusiness!.businessId.toString(),
                        selectionCallBack: (
                            CompanyBusinessPlant plant) {
                          selectedPlant = plant;
                          selectedDepartment = null;
                          selectedSubDepartment = null;machineData = null; subMachineLists = [];
                          setState(() {});
                          if (selectedPlant != null) {
                            DropDownDataController.to.getMachines(
                                plantId: selectedPlant!.soleId,
                                successCallback: () {
                                  DepartmentController.to.getDepartment(
                                      soleId: selectedPlant!.soleId,
                                      callback: (){}
                                  );
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
        InkWell(
            onTap: (){
              if(selectedPlant != null) {
                if(DepartmentController.to.departmentData!.isEmpty){
                  DepartmentController.to.getDepartment(
                      soleId: selectedPlant!.soleId,
                      callback: (){}
                  );
                }
                commonBottomView(context: context,
                    child: DepartmentBottomView(
                        hintText: "Select Department",
                        myItems: DepartmentController.to.departmentData!,
                        selectionCallBack: (
                            Department department) {
                          selectedDepartment = department;
                          selectedSubDepartment = null;machineData = null; subMachineLists = [];
                          setState(() {});
                          if (selectedDepartment != null) {
                            DepartmentController.to.getSubDepartment(departmentId: selectedDepartment!.departmentId.toString(),callback: (){});
                          }
                        })
                );
              }
            },
            child: commonDecoratedTextView(
              bottom: selectedSubDepartment == null ? 25 : 0,
              title: selectedDepartment == null ? "Select Department" : selectedDepartment!.departmentName ?? "",
              isChangeColor: selectedDepartment == null ? true : false,
            )
        ),
        commonVerticalSpacing(spacing: selectedSubDepartment == null ? 0 : 25),
        InkWell(
            onTap: (){
              if(selectedDepartment != null) {
                if(DepartmentController.to.subDepartmentData!.isEmpty){
                  DepartmentController.to.getSubDepartment(departmentId: selectedDepartment!.departmentId.toString(),callback: (){});
                }
                commonBottomView(context: context,
                    child: DepartmentBottomView(
                        hintText: "Select Sub Department",
                        myItems: DepartmentController.to.subDepartmentData!,
                        selectionCallBack: (Department subDepartment) {
                          selectedSubDepartment = subDepartment;
                          KaizenController.to.getTeamMembers(plantId: selectedPlant?.soleId,departmentId: selectedDepartment?.departmentId.toString(),subDepartmentId: selectedSubDepartment?.departmentId.toString());
                          setState(() {});
                        }));
              }
            },
            child: commonDecoratedTextView(
              title: selectedSubDepartment == null ? "Select Sub Department" : selectedSubDepartment!.departmentName ?? "",
              isChangeColor: selectedSubDepartment == null ? true : false,
            )
        ),
        InkWell(
            onTap: (){
              if(selectedPlant != null) {
                if(DropDownDataController.to.machinesList!.isEmpty){
                  DropDownDataController.to.getMachines(
                      plantId: selectedPlant!.soleId,
                      successCallback: () {
                      });
                }
                commonBottomView(context: context,
                    child: MachineBottomView(
                        hintText: "Select Machine",
                        soleId: selectedPlant!.soleId ?? "",
                        machineId: machineData == null ? 0 : machineData!.machineId ?? 0,
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
                              machineId: subMachineLists.length == 1 ? (machineData!.machineId ?? 0) : subMachineLists.last.machineId ?? 0,
                              myItems: DropDownDataController.to.subMachinesList!,
                              selectionCallBack: (
                                  MachineData machine) {
                                subMachineLists[index] = machine;
                                setState(() {});
                                // getSubMachineAPI(
                                //     plantId: selectedPlant!.soleId,
                                //     machineId: subMachineLists[index].machineId
                                // );
                              }));
                    },
                    child: commonDecoratedTextView(
                      title: subMachineLists[index].machineName == null ? "Select Sub Machine" : subMachineLists[index].machineName ?? "",
                      isChangeColor: subMachineLists[index].machineName == null ? true : false,
                    )
                )
            )
        ),
        commonHeaderTitle(title: "Kaizen Detail",fontSize: isTablet() ? 1.5 : 1.2,fontWeight: 2,color: darkFontColor),
        commonVerticalSpacing(spacing: 20),
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
                        title: selectedStartDate.isEmpty ? "Select Date" : selectedStartDate)
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
                            selectedStartDate = DateFormat("dd MMM,yyyy").format(value);
                          });
                        });
                      },
                      child: Icon(Icons.calendar_month, color: blackColor.withOpacity(0.4)),
                    )),
              ],
            )),
        commonVerticalSpacing(spacing: 20),
        CommonTextFiled(
            fieldTitleText: "Kaizen Loss No./ Step *",
            hintText: "Kaizen Loss No./ Step *",
            // isBorderEnable: false,
            isChangeFillColor: true,
            textEditingController: kaizenLossNoController,
            onChangedFunction: (String value){
            },
            validationFunction: (String value) {
              return value.toString().isEmpty
                  ? notEmptyFieldMessage
                  : null;
            }),
        commonVerticalSpacing(spacing: 20),
        InkWell(
            onTap: (){
              if(KaizenController.to.kaizenResultArea.isEmpty){
                KaizenController.to.getKaizenResultArea();
              }
              commonBottomView(context: context,
                  child: CommonBottomStringView(
                      hintText: "Select Result Area",
                      myItems: KaizenController.to.kaizenResultArea,
                      selectionCallBack: (
                          String val) {
                        setState(() {
                          selectedResultArea = val;
                        });
                      })
              );
            },
            child: commonDecoratedTextView(
              title: selectedResultArea.isEmpty ? "Select Result Area *" : selectedResultArea,
              isChangeColor: selectedResultArea.isEmpty ? true : false,
            )
        ),
        CommonTextFiled(
            fieldTitleText: "Kaizen Theme *",
            hintText: "Kaizen Theme *",
            // isBorderEnable: false,
            isChangeFillColor: true,
            textEditingController: kaizenThemeController,
            onChangedFunction: (String value){
            },
            validationFunction: (String value) {
              return value.toString().isEmpty
                  ? notEmptyFieldMessage
                  : null;
            }),
        commonVerticalSpacing(spacing: 20),
        CommonTextFiled(
            fieldTitleText: "Bench mark *",
            hintText: "Bench mark *",
            // isBorderEnable: false,
            isChangeFillColor: true,
            textEditingController: benchMarkController,
            onChangedFunction: (String value){
            },
            validationFunction: (String value) {
              return value.toString().isEmpty
                  ? notEmptyFieldMessage
                  : null;
            }),
        commonVerticalSpacing(spacing: 20),
        CommonTextFiled(
            fieldTitleText: "Target *",
            hintText: "Target *",
            // isBorderEnable: false,
            isChangeFillColor: true,
            textEditingController: targetController,
            onChangedFunction: (String value){
            },
            validationFunction: (String value) {
              return value.toString().isEmpty
                  ? notEmptyFieldMessage
                  : null;
            }),
        commonVerticalSpacing(spacing: 20),
        InkWell(
            onTap: (){
              if(KaizenController.to.plantMembersList.isEmpty){
                KaizenController.to.getTeamMembers(
                    plantId: selectedPlant?.soleId,departmentId: selectedDepartment?.departmentId.toString(),subDepartmentId: selectedSubDepartment?.departmentId.toString()
                );
              }
              commonBottomView(context: context,
                  child: TeamMemberBottomView(
                      myItems: KaizenController.to.plantMembersList,
                      selectionCallBack: (
                          KaizenTeamData val) {
                        setState(() {
                          selectedTeamMembers.add(val);
                        });
                      })
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                commonDecoratedTextView(
                  title: "Select Team Member *",
                  isChangeColor: true,
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  direction: Axis.vertical,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  runAlignment: WrapAlignment.start,
                  children: selectedTeamMembers.map((i) => Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                    child: Row(
                      children: [
                        Text('${i.userName}',style: const TextStyle(
                          color: blackColor,
                          fontSize: 14
                        )),
                        InkWell(
                          onTap: (){
                            setState(() {
                              selectedTeamMembers.remove(i);
                            });
                          },
                          child: const Icon(Icons.clear,color: blackColor),
                        )
                      ],
                    ),
                  )).toList(),
                ),
                commonVerticalSpacing(spacing: selectedTeamMembers.isEmpty ? 0 : 20),
              ],
            )
        ),
        CommonTextFiled(
            fieldTitleText: "Problem/Present status",
            hintText: "Problem/Present status",
            // isBorderEnable: false,
            isChangeFillColor: true,
            maxLine: 5,
            textEditingController: problemController,
            onChangedFunction: (String value){
            },
            validationFunction: (String value) {
              return value.toString().isEmpty
                  ? notEmptyFieldMessage
                  : null;
            }),
        commonVerticalSpacing(spacing: 25),
        imageView(title: "Problem Image *", onChanged: (File file){
          setState(() {
            problemImage = file;
          });
        },selectedFile: problemImage),
        commonVerticalSpacing(spacing: 30),
        commonHeaderTitle(title: "Analysis",fontSize: isTablet() ? 1.5 : 1.2,fontWeight: 2,color: darkFontColor),
        commonVerticalSpacing(spacing: 20),
        ...analysisView(),
        commonVerticalSpacing(spacing: 20),
        InkWell(
            onTap: (){
              if(KaizenController.to.rootCauseList.isEmpty){
                KaizenController.to.getRootCauses();
              }
              commonBottomView(context: context,
                  child: CommonBottomStringView(
                      hintText: "Select Root Cause",
                      myItems: KaizenController.to.rootCauseList,
                      selectionCallBack: (
                          String val) {
                        setState(() {
                          selectedRootCause = val;
                        });
                      })
              );
            },
            child: commonDecoratedTextView(
              title: selectedRootCause.isEmpty ? "Select Root Cause *" : selectedRootCause,
              isChangeColor: selectedRootCause.isEmpty ? true : false,
            )
        ),
        CommonTextFiled(
            fieldTitleText: "Remarks (Root Cause)",
            hintText: "Remarks (Root Cause)",
            // isBorderEnable: false,
            isChangeFillColor: true,
            maxLine: 5,
            textEditingController: rootCauseRemarksController,
            onChangedFunction: (String value){
            },
            validationFunction: (String value) {
              return value.toString().isEmpty
                  ? notEmptyFieldMessage
                  : null;
            }),
        commonVerticalSpacing(spacing: 20),
        CommonTextFiled(
            fieldTitleText: "Kaizen Idea *",
            hintText: "Kaizen Idea *",
            // isBorderEnable: false,
            isChangeFillColor: true,
            textEditingController: kaizenIdeaController,
            onChangedFunction: (String value){
            },
            validationFunction: (String value) {
              return value.toString().isEmpty
                  ? notEmptyFieldMessage
                  : null;
            }),
        commonVerticalSpacing(spacing: 20),
        CommonTextFiled(
            fieldTitleText: "Countermeasure",
            hintText: "Countermeasure",
            // isBorderEnable: false,
            isChangeFillColor: true,
            maxLine: 5,
            textEditingController: countermeasureController,
            onChangedFunction: (String value){
            },
            validationFunction: (String value) {
              return value.toString().isEmpty
                  ? notEmptyFieldMessage
                  : null;
            }),
        commonVerticalSpacing(spacing: 25),
        imageView(title: "Countermeasure Image *", onChanged: (File file){
          setState(() {
            countermeasureImage = file;
          });
        },selectedFile: countermeasureImage),
        commonVerticalSpacing(spacing: 20)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return commonStructure(
      context: context,
      bgColor: blackColor,
      appBar: commonAppbar(context: context,title: kaizenFormText),
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
                  title: "Complete Kaizen",
                  width: getScreenWidth(context) - 40,
                  height: 50,
                  tapOnButton: () {
                    AddKaizenModelRequest addKaizenReq = AddKaizenModelRequest();
                    addKaizenReq.soleId = selectedPlant!.soleId;
                    addKaizenReq.pillarCategoryId = selectedPillar!.pillarCategoryId.toString();
                    addKaizenReq.lossNoStep = kaizenLossNoController.text;
                    addKaizenReq.departmentId =  selectedDepartment == null ? "" : selectedDepartment!.departmentId.toString();
                    addKaizenReq.subDepartmentId = selectedSubDepartment == null ? "" : selectedSubDepartment!.departmentId.toString();
                    addKaizenReq.machineId = machineData == null ? "" : machineData!.machineId.toString();
                    addKaizenReq.countermeasureImage = countermeasureImage;
                    addKaizenReq.presentProblemImage = problemImage;
                    addKaizenReq.remarks = rootCauseRemarksController.text;
                    addKaizenReq.rootCause = selectedRootCause;
                    addKaizenReq.teamMemberId = selectedTeamMembers.isEmpty ? "" : selectedTeamMembers.map((e) => e.userId!).toList().join(",");
                    addKaizenReq.startDate = selectedStartDate;
                    addKaizenReq.target = targetController.text;
                    addKaizenReq.resultArea = selectedResultArea;
                    addKaizenReq.kaizenTheme = kaizenThemeController.text;
                    addKaizenReq.kaizenIdea = kaizenIdeaController.text;
                    addKaizenReq.benchMark = benchMarkController.text;
                    addKaizenReq.presentProblem = problemController.text;
                    addKaizenReq.finishStatus = "0";
                    addKaizenReq.manageUserId = getLoginData()!.userdata!.first.id.toString();
                    if(widget.isEdit){
                      addKaizenReq.editKaizenId = widget.id;
                    }
                    KaizenController.to.addKaizenData(addKaizenModelRequest: addKaizenReq,isEdit: widget.isEdit);
                    // if(selectedPillar != null){
                    //   if(selectedBusiness != null){
                    //     if(selectedPlant != null){
                    //       if(selectedDepartment != null){
                    //         if(selectedSubDepartment != null){
                    //           if(machineData != null){
                    //             if(selectedStartDate.isNotEmpty){
                    //               if(kaizenLossNoController.text.isNotEmpty){
                    //                 if(selectedResultArea.isNotEmpty){
                    //                   if(kaizenThemeController.text.isNotEmpty){
                    //                     if(benchMarkController.text.isNotEmpty){
                    //                       if(targetController.text.isNotEmpty){
                    //                         if(problemImage != null){
                    //                           if(kaizenIdeaController.text.isNotEmpty){
                    //                             if(countermeasureImage != null){
                    //
                    //                             }else{
                    //                               showSnackBar(title: ApiConfig.error, message: "Please choose countermeasure image");
                    //                             }
                    //                           }else{
                    //                             showSnackBar(title: ApiConfig.error, message: "Please enter kaizen idea");
                    //                           }
                    //                         }else{
                    //                           showSnackBar(title: ApiConfig.error, message: "Please choose problem image");
                    //                         }
                    //                       }else{
                    //                         showSnackBar(title: ApiConfig.error, message: "Please enter target");
                    //                       }
                    //                     }else{
                    //                       showSnackBar(title: ApiConfig.error, message: "Please enter benchmark");
                    //                     }
                    //                   }else{
                    //                     showSnackBar(title: ApiConfig.error, message: "Please enter kaizen theme");
                    //                   }
                    //                 }else{
                    //                   showSnackBar(title: ApiConfig.error, message: "Please choose result area");
                    //                 }
                    //               }else{
                    //                 showSnackBar(title: ApiConfig.error, message: "Please enter kaizen loss no");
                    //               }
                    //             }else{
                    //               showSnackBar(title: ApiConfig.error, message: "Please select start date");
                    //             }
                    //           }else{
                    //             showSnackBar(title: ApiConfig.error, message: "Please select machine");
                    //           }
                    //         }else{
                    //           showSnackBar(title: ApiConfig.error, message: "Please select sub department");
                    //         }
                    //       }else{
                    //         showSnackBar(title: ApiConfig.error, message: "Please select department");
                    //       }
                    //     }else{
                    //       showSnackBar(title: ApiConfig.error, message: "Please select plant");
                    //     }
                    //   }else{
                    //     showSnackBar(title: ApiConfig.error, message: "Please select business");
                    //   }
                    // }else{
                    //   showSnackBar(title: ApiConfig.error, message: "Please select pillar");
                    // }
                  },
                  isLoading: false)
              ),
            ],
          ),
        ),
      ),
      child: Obx(() {
        return BusinessController.to.businessData!.isEmpty ? const SpinKitThreeBounce(
          color: primaryColor,
          size: 30.0,
        ) : ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24.0,right: 24.0,top: 24.0),
              child: kaizenWhomForm(),
            )
          ],
        );
      })
    );
  }
}

class AnalysisView{
  String? title;
  String? answer;
}