import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_projects/controllers/abnormality_controller.dart';

import '../../../common_widgets/common_textfield.dart';
import '../../../common_widgets/common_widget.dart';
import '../../../configurations/config_file.dart';
import '../../../models/abnormality_response_model.dart';
import '../../../models/activities_response_model.dart';
import '../../../models/department_response_model.dart';
import '../../../textfields/department_textfiled.dart';
import '../../../theme/convert_theme_colors.dart';
import '../../../utility/color_utility.dart';
import '../../../utility/common_methods.dart';
import '../../../utility/screen_utility.dart';

class AssignAbnormalityView extends StatefulWidget {
  final Abnormality abnormality;
  const AssignAbnormalityView({Key? key, required this.abnormality}) : super(key: key);

  @override
  State<AssignAbnormalityView> createState() => _AssignAbnormalityViewState();
}

class _AssignAbnormalityViewState extends State<AssignAbnormalityView> {

  Department? selectedDepartment;
  SubDepartment? selectedSubDepartment;
  List<UserFilterResponse> selectedUsers = [];
  String assignDate = "";
  String selectedTag = "1";
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void initState() {
    AbnormalityController.to.getAssignAbnormalityData(
      abnormality: widget.abnormality,
      callback: (){
        Department dep = Department();
        dep.departmentId = widget.abnormality.departmentId;
        dep.departmentName = widget.abnormality.departmentName;
        selectedDepartment = dep;

        SubDepartment subDep = SubDepartment();
        subDep.departmentId = widget.abnormality.subDepartmentId;
        subDep.departmentName = widget.abnormality.subDepartmentName ?? "";
        selectedSubDepartment = subDep;

        List<String>? splitedData =  widget.abnormality.assignUserData?.split(",");
        List<String>? splitedDataIds =  widget.abnormality.assignUserId?.split(",");

        if(splitedData!.isNotEmpty){
          for (int i = 0; i<splitedData.length; i++) {
            UserFilterResponse user = UserFilterResponse();
            user.userName = splitedData[i];
            user.userId = int.parse(splitedDataIds![i]);
            selectedUsers.add(user);
          }
        }
        selectedTag = widget.abnormality.abnormalityTag == "Red" ? "1" : widget.abnormality.abnormalityTag == "White" ? "2" : "3";
      }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return commonStructure(
        context: context,
        bgColor: blackColor,
        appBar: commonAppbar(context: context,title: "Abnormality List"),
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
                      if(selectedDepartment != null){
                        if(selectedSubDepartment != null){
                          if(selectedUsers.isNotEmpty){
                            if(assignDate != ""){
                              AbnormalityController.to.assignAbnormality(
                                callback: (){
                                  Get.back();
                                },
                                abnormalityId: widget.abnormality.abnormalityId.toString(),
                                assignDate: assignDate,
                                assignIds: selectedUsers.map((e) => e.userId!).toList(),
                                assignTime: "${selectedTime.hour}:${selectedTime.minute} ${selectedTime.period.name}",
                                dId: selectedDepartment?.departmentId,
                                subDId: selectedSubDepartment?.departmentId,
                                tag: selectedTag
                              );
                            }else{
                              showSnackBar(title: ApiConfig.error, message: "Please select assign date");
                            }
                          }else{
                            showSnackBar(title: ApiConfig.error, message: "Please add assign users");
                          }
                        }else{
                          showSnackBar(title: ApiConfig.error, message: "Please select sub department");
                        }
                      }else{
                        showSnackBar(title: ApiConfig.error, message: "Please select department");
                      }
                    },
                    isLoading: false)),
              ],
            ),
          ),
        ),
        child: Obx(() => AbnormalityController.to.assignedAbnormalityDetail.value.departmentData == null ? Container() : ListView(
          children: [
            InkWell(
                onTap: (){
                  commonBottomView(context: context,
                      child: DepartmentBottomView(
                          hintText: "Select Department",
                          myItems: AbnormalityController.to.assignedAbnormalityDetail.value.departmentData ?? [],
                          selectionCallBack: (
                              Department department) {
                            selectedDepartment = department;
                            setState(() {});
                          }
                      ));
                },
                child: commonDecoratedTextView(
                  title: selectedDepartment == null ? "Select Department" : selectedDepartment!.departmentName ?? "",
                  isChangeColor: selectedDepartment == null ? true : false,
                )
            ),
            InkWell(
                onTap: (){
                  commonBottomView(context: context,
                      child: SubDepartmentBottomView(
                          hintText: "Select Sub Department",
                          myItems: AbnormalityController.to.assignedAbnormalityDetail.value.subdepartmentData ?? [],
                          selectionCallBack: (
                              SubDepartment department) {
                            selectedSubDepartment = department;
                            setState(() {});
                          }));
                },
                child: commonDecoratedTextView(
                  title: selectedSubDepartment == null ? "Select Sub Department" : selectedSubDepartment!.departmentName ?? "",
                  isChangeColor: selectedSubDepartment == null ? true : false,
                )
            ),

            InkWell(
              onTap: (){
                commonBottomView(context: context,
                    child: AssignedUserBottomView(
                        hintText: "Assign to",
                        myItems: AbnormalityController.to.assignedAbnormalityDetail.value.userData ?? [],
                        selectionCallBack: (
                            UserFilterResponse user) {
                          setState(() {
                            selectedUsers.add(user);
                          });
                        }));
              },
              child: Container(
                width: getScreenWidth(context),
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 25),
                decoration: neurmorphicBoxDecoration,
                child: selectedUsers.isEmpty ? commonHeaderTitle(
                    title: "Assign To",
                    isChangeColor: true,
                    color: blackColor
                ) : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonHeaderTitle(
                        title: "Assign To",
                        fontSize: 1.1,
                        fontWeight: 1,
                        isChangeColor: true,
                        color: blackColor
                    ),
                    commonVerticalSpacing(spacing: 20),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      runAlignment: WrapAlignment.start,
                      children: selectedUsers.map((i) => Container(
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(16)
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(i.userName ?? "",style: const TextStyle(
                                  color: whiteColor,
                                  fontSize: 14
                              )),
                              commonHorizontalSpacing(),
                              InkWell(
                                  onTap: (){
                                    selectedUsers.remove(i);
                                  },
                                  child: const Icon(Icons.close,color: whiteColor,size: 20))
                            ],
                          )
                      )).toList(),
                    ),
                  ],
                ),
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: commonHorizontalPadding),
                      decoration: neurmorphicBoxDecoration,
                      child: Stack(
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: commonHeaderTitle(
                                  fontSize: isTablet() ? 1.3 : 1,
                                  title: assignDate.isEmpty ? "Assign Date" : assignDate)
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
                                      assignDate = DateFormat("dd MMM,yyyy").format(value);
                                    });
                                  });
                                },
                                child: Icon(Icons.calendar_month, color: blackColor.withOpacity(0.4)),
                              )),
                        ],
                      )),
                ),
                commonHorizontalSpacing(spacing: 15),
                Expanded(
                  child: Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: commonHorizontalPadding),
                      decoration: neurmorphicBoxDecoration,
                      child: Stack(
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: commonHeaderTitle(
                                  fontSize: isTablet() ? 1.3 : 1,
                                  title: "${selectedTime.hour}:${selectedTime.minute} ${selectedTime.period.name}"
                              )
                          ),
                          Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () async {
                                  final TimeOfDay? picked_s = await showTimePicker(
                                  context: context,
                                  initialTime: selectedTime, builder: (BuildContext context, Widget? child) {
                                  return MediaQuery(
                                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                                  child: child!,
                                  );});

                                  if (picked_s != null && picked_s != selectedTime ) {
                                    setState(() {
                                      selectedTime = picked_s;
                                    });
                                  }
                                },
                                child: Icon(Icons.calendar_month, color: blackColor.withOpacity(0.4)),
                              )),
                        ],
                      )),
                ),
              ],
            ),
            commonVerticalSpacing(spacing: 30),
            commonHeaderTitle(
                fontSize: isTablet() ? 1.3 : 1,
                fontWeight: 2,
                title: "Abnormality Tag *"),
            commonVerticalSpacing(),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Radio<String>(
                    value: '1',
                    groupValue: selectedTag,
                    activeColor: primaryColor,
                    onChanged: (value) {
                      setState((){
                        selectedTag = value!;
                      });
                    },
                  ),
                  commonHeaderTitle(
                      fontSize: isTablet() ? 1.3 : 1,
                      title: "Red")
                ],
              ),
            ),
            SizedBox(
                height: 40,
              child: Row(
                children: [
                  Radio<String>(
                    value: '2',
                    groupValue: selectedTag,
                    activeColor: primaryColor,
                    onChanged: (value) {
                      setState((){
                        selectedTag = value!;
                      });
                    },
                  ),
                  commonHeaderTitle(
                      fontSize: isTablet() ? 1.3 : 1,
                      title: "White")
                ],
              ),
            ),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Radio<String>(
                    value: '3',
                    groupValue: selectedTag,
                    activeColor: primaryColor,
                    onChanged: (value) {
                      setState((){
                        selectedTag = value!;
                      });
                    },
                  ),
                  commonHeaderTitle(
                      fontSize: isTablet() ? 1.3 : 1,
                      title: "Yellow")
                ],
              ),
            ),
          ],
        ))
    );
  }
}

class SubDepartmentBottomView extends StatefulWidget {
  final String hintText;
  final List<SubDepartment> myItems;
  final Function? selectionCallBack;
  const SubDepartmentBottomView({Key? key, required this.myItems, this.selectionCallBack, required this.hintText}) : super(key: key);

  @override
  State<SubDepartmentBottomView> createState() => _SubDepartmentBottomViewState();
}

class _SubDepartmentBottomViewState extends State<SubDepartmentBottomView> {
  TextEditingController searchController = TextEditingController();
  List<SubDepartment> searchedMyItems = [];

  @override
  void initState() {
    searchedMyItems = List.from(widget.myItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          commonVerticalSpacing(spacing: 15),
          commonHeaderTitle(title: widget.hintText ,fontWeight: 2,fontSize: 1.5),
          commonVerticalSpacing(spacing: 15),
          CommonTextFiled(
            fieldTitleText: "Search",
            hintText: "Search",
            // isBorderEnable: false,
            isChangeFillColor: true,
            textEditingController: searchController,
            onChangedFunction: (String value){
              setState(() {
                if(value.isEmpty){
                  searchedMyItems = widget.myItems;
                }else{
                  searchedMyItems = widget.myItems.where((p0) => p0.departmentName!.toLowerCase().startsWith(value.toLowerCase())).toList();
                }
              });
            },
          ),
          commonVerticalSpacing(spacing: 30),
          ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              shrinkWrap: true,
              itemCount: searchedMyItems.length,
              itemBuilder: (context, index) => InkWell(
                onTap: (){
                  Get.back();
                  widget.selectionCallBack!(searchedMyItems[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: commonHeaderTitle(
                      title: searchedMyItems[index].departmentName ?? "",
                      fontSize: 1.2
                  ),
                ),
              )
          ),
          commonVerticalSpacing(spacing: 30),
        ],
      ),
    );
  }
}

class AssignedUserBottomView extends StatefulWidget {
  final String hintText;
  final List<UserFilterResponse> myItems;
  final Function? selectionCallBack;
  const AssignedUserBottomView({Key? key, required this.myItems, this.selectionCallBack, required this.hintText}) : super(key: key);

  @override
  State<AssignedUserBottomView> createState() => _AssignedUserBottomViewState();
}

class _AssignedUserBottomViewState extends State<AssignedUserBottomView> {
  TextEditingController searchController = TextEditingController();
  List<UserFilterResponse> searchedMyItems = [];

  @override
  void initState() {
    searchedMyItems = List.from(widget.myItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          commonVerticalSpacing(spacing: 15),
          commonHeaderTitle(title: widget.hintText ,fontWeight: 2,fontSize: 1.5),
          commonVerticalSpacing(spacing: 15),
          CommonTextFiled(
            fieldTitleText: "Search",
            hintText: "Search",
            // isBorderEnable: false,
            isChangeFillColor: true,
            textEditingController: searchController,
            onChangedFunction: (String value){
              setState(() {
                if(value.isEmpty){
                  searchedMyItems = widget.myItems;
                }else{
                  searchedMyItems = widget.myItems.where((p0) => p0.userName!.toLowerCase().startsWith(value.toLowerCase())).toList();
                }
              });
            },
          ),
          commonVerticalSpacing(spacing: 30),
          ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              shrinkWrap: true,
              itemCount: searchedMyItems.length,
              itemBuilder: (context, index) => InkWell(
                onTap: (){
                  Get.back();
                  widget.selectionCallBack!(searchedMyItems[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: commonHeaderTitle(
                      title: searchedMyItems[index].userName ?? "",
                      fontSize: 1.2
                  ),
                ),
              )
          ),
          commonVerticalSpacing(spacing: 30),
        ],
      ),
    );
  }
}