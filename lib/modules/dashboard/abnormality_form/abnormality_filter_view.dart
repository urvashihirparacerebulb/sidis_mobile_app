import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_projects/controllers/abnormality_controller.dart';

import '../../../common_widgets/common_widget.dart';
import '../../../models/activities_response_model.dart';
import '../../../textfields/abnormality_type_field.dart';
import '../../../textfields/common_bottom_string_view.dart';
import '../../../textfields/filter_department_textfield.dart';
import '../../../textfields/find_by_user_view_textfield.dart';
import '../../../theme/convert_theme_colors.dart';
import '../../../utility/color_utility.dart';
import '../../../utility/common_methods.dart';
import '../../../utility/screen_utility.dart';

class AbnormalityFilterView extends StatefulWidget {
  const AbnormalityFilterView({Key? key}) : super(key: key);

  @override
  State<AbnormalityFilterView> createState() => _AbnormalityFilterViewState();
}

class _AbnormalityFilterViewState extends State<AbnormalityFilterView> {

  DateTime? selectedCreatedDate = DateTime(2022);
  DateTime? selectedEndDate = DateTime.now();
  String selectedStatus = "";
  String selectedTag = "";
  FilterDepartment? selectedFilteredDepartment;
  UserFilterResponse? selectedUser;
  AbnormalityType? abnormalityType;

  @override
  void initState() {
    AbnormalityController.to.getFilterDepartment(callback: (){
      AbnormalityController.to.getUserFilters(callback: (){
        AbnormalityController.to.fetchAbnormalitiesTags(callback: (){
          AbnormalityController.to.getAbnormalityType(callback: (){

          });
        });
      });
    });
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
                      AbnormalityController.to.getAbnormalityLists(
                          {
                            "user_id": getLoginData()!.userdata!.first.id,
                            "group_id": getLoginData()!.userdata!.first.groupId,
                            "datefilter_id": "${DateFormat("dd-MM-yyyy").format(selectedCreatedDate!)} to ${DateFormat("dd-MM-yyyy").format(selectedEndDate!)}",
                            "department_filter_id": selectedFilteredDepartment == null ? "" : '${selectedFilteredDepartment!.departmentId} - department',
                            "user_filter_id": selectedUser == null ? "" : selectedUser!.userId,
                            "status_filter": selectedStatus == "Created" ? "1" : selectedStatus == "Assigned" ? "2" : "3",
                            "tag_filter": selectedTag,
                            "abnormality_type_filter": abnormalityType == null ? "" : abnormalityType?.id.toString()
                          },
                        callback: (){
                            Get.back();
                        }
                      );
                    },
                    isLoading: false)),
              ],
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            shrinkWrap: true,
            children: [
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
                              title: (selectedCreatedDate == null || selectedEndDate == null) ? "Created Date" : "${DateFormat("dd-MM-yyyy").format(selectedCreatedDate!)} to ${DateFormat("dd-MM-yyyy").format(selectedEndDate!)}")
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () async {
                              final picked = await showDateRangePicker(
                                context: context,
                                lastDate: selectedEndDate!,
                                firstDate: DateTime(2022),
                              );
                              if (picked != null) {
                                setState(() {
                                  selectedCreatedDate = picked.start;
                                  selectedEndDate = picked.end;
                                });
                              }
                            },
                            child: Icon(Icons.calendar_month, color: blackColor.withOpacity(0.4)),
                          )),
                    ],
                  )),
              commonVerticalSpacing(spacing: 15),
              InkWell(
                  onTap: (){
                    commonBottomView(context: context,
                          child: FilterDepartmentBottomView(
                              hintText: "Select Department",
                              myItems: AbnormalityController.to.abnormalityFilterDepartments!,
                              selectionCallBack: (
                                  FilterDepartment department) {
                                setState(() {
                                  selectedFilteredDepartment = department;
                                });
                              }));
                  },
                  child: commonDecoratedTextView(
                    title: selectedFilteredDepartment == null ? "Select Department" : selectedFilteredDepartment!.name ?? "",
                    isChangeColor: selectedFilteredDepartment == null ? true : false,
                  )
              ),
              InkWell(
                  onTap: (){
                    commonBottomView(context: context,
                        child: FilterUserBottomView(
                            hintText: "Select Find By User",
                            myItems: AbnormalityController.to.userFilters!,
                            selectionCallBack: (
                                UserFilterResponse user) {
                              setState(() {
                                selectedUser = user;
                              });
                            }));
                  },
                  child: commonDecoratedTextView(
                    title: selectedUser == null ? "Select Find By User" : "${selectedUser?.firstName ?? ""} ${selectedUser?.lastName ?? ""}",
                    isChangeColor: selectedUser == null ? true : false,
                  )
              ),
              InkWell(
                onTap: (){
                  commonBottomView(context: context,
                      child: CommonBottomStringView(
                          hintText: "Status",
                          myItems: const ["Created","Assigned","Completed"],
                          selectionCallBack: (
                              String val) {
                            setState(() {
                              selectedStatus = val;
                            });
                          }));
                },
                child: commonDecoratedTextView(
                    title: selectedStatus == "" ? "Status" : selectedStatus,
                    isChangeColor: false
                ),
              ),

              InkWell(
                onTap: (){
                  commonBottomView(context: context,
                      child: CommonBottomStringView(
                          hintText: "Tag",
                          myItems: AbnormalityController.to.allTags!,
                          selectionCallBack: (
                              String val) {
                            setState(() {
                              selectedTag = val;
                            });
                          }));
                },
                child: commonDecoratedTextView(
                    title: selectedTag == "" ? "Tag" : selectedTag,
                    isChangeColor: false
                ),
              ),

              InkWell(
                  onTap: (){
                    commonBottomView(context: context,
                        child: AbnormalityTypeBottomView(
                            myItems: AbnormalityController.to.abnormalityTypeData!,
                            selectionCallBack: (
                                AbnormalityType type) {
                              abnormalityType = type;
                              setState(() {});
                            }));
                  },
                  child: commonDecoratedTextView(
                    title: abnormalityType == null ? "Abnormality Type" : abnormalityType!.typeName ?? "",
                    isChangeColor: abnormalityType == null ? true : false,
                  )
              )
            ],
          ),
        )
    );
  }
}
