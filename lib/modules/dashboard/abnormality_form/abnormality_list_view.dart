import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_projects/controllers/abnormality_controller.dart';
import '../../../common_widgets/common_textfield.dart';
import '../../../common_widgets/common_widget.dart';
import '../../../configurations/config_file.dart';
import '../../../models/abnormality_response_model.dart';
import '../../../theme/convert_theme_colors.dart';
import '../../../utility/color_utility.dart';
import '../../../utility/common_methods.dart';
import '../../../utility/constants.dart';
import '../../../utility/delete_dialog_view.dart';
import '../../../utility/screen_utility.dart';
import 'abnormality_filter_view.dart';
import 'add_abnormaliry_view.dart';
import 'assign_abnormalities_view.dart';

class AbnormalityListView extends StatefulWidget {
  const AbnormalityListView({Key? key}) : super(key: key);

  @override
  State<AbnormalityListView> createState() => _AbnormalityListViewState();
}

class _AbnormalityListViewState extends State<AbnormalityListView> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    AbnormalityController.to.getAbnormalityLists(
        {
          "user_id": getLoginData()!.userdata!.first.id,
          "group_id": getLoginData()!.userdata!.first.groupId,
        },callback: (){}
    );
    super.initState();
  }

  Widget abnormalityCardView({Abnormality? abnormality}){
    return Container(
      margin: const EdgeInsets.only(bottom: 20,left: 16,right: 16),
      decoration: neurmorphicBoxDecoration,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonHeaderTitle(title: abnormality?.abnormalityTitle ?? "",fontWeight: 3,fontSize: isTablet() ? 1.5 : 1.2),
            commonVerticalSpacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonHeaderTitle(title: abnormality!.createdAt ?? "",fontWeight: 1,fontSize: isTablet() ? 1.11 : 1.2),
                commonHeaderTitle(title: abnormality.abnormalityTag ?? "",fontWeight: 3,fontSize: isTablet() ? 1.5 : 1.2)
              ],
            ),
            commonVerticalSpacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonHeaderTitle(title: abnormality.plantShortName ?? "",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),
                commonHeaderTitle(title: abnormality.departmentName ?? "",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),
              ],
            ),
            commonVerticalSpacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonHeaderTitle(title: abnormality.findUserName ?? "",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),
                commonHeaderTitle(title: abnormality.assignUserData ?? "",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90,color: Colors.purple,isChangeColor: true)
              ],
            ),
            commonVerticalSpacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonHeaderTitle(title: abnormality.completeData ?? "",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90,color: Colors.green,isChangeColor: true)
              ],
            ),
            commonVerticalSpacing(),
            Row(
              children: [
                Expanded(
                    flex: 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        commonHeaderTitle(title: "Assign to: ${abnormality.assignUserData}",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),
                        commonVerticalSpacing(),
                        commonHeaderTitle(title: "Tag: ${abnormality.abnormalityTag}",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),
                      ],
                    )),

                Expanded(flex: 1,child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                        onTapDown: (TapDownDetails details) {
                          List<String> userIds = (abnormality.assignUserId.toString()).split(",");
                          if(abnormality.abnormalityStatus == 2 && userIds.contains(getLoginData()!.userdata?.first.id.toString())){
                            _showPopupMenuForCompleted(details.globalPosition, abnormality
                                .abnormalityId!, abnormality);
                          }else {
                            _showPopupMenu(details.globalPosition, abnormality
                                .abnormalityId!, abnormality);
                          }
                        },
                        child: Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffD9D9D9)
                            ),
                            child: Icon(Icons.more_vert_rounded,size: isTablet() ? 28 : 20))
                    )
                ))
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showPopupMenuForCompleted(Offset offset,int id,Abnormality abnormality) async {
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
      context: context,
      color: ConvertTheme.convertTheme.getBackGroundColor(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),      position: RelativeRect.fromLTRB(left, top, 20, 0),
      items: [
        PopupMenuItem<String>(
            value: 'Abnormality Detail',
            child: InkWell(
              onTap: (){
                Get.back();
              },
              child: const Text('Abnormality Detail'),
            )
        ),

        PopupMenuItem<String>(
            value: 'Complete Data',
            child: InkWell(
              onTap: (){
                Get.back();
                showDialog(context: context, builder: (BuildContext context) => CompleteAbnormalityView(abnormality: abnormality));
              },
              child: const Text('Complete Data'),
            )
        ),

        PopupMenuItem<String>(
            value: 'Unable to Complete',
            child: InkWell(
              onTap: (){
                Get.back();
                AbnormalityController.to.abnormalityNotResolveAPI(assignId: abnormality.assignId);
              },
              child: const Text('Unable to Complete'),
            )
        ),
      ],
      elevation: 8.0,
    );
  }

  void _showPopupMenu(Offset offset,int id,Abnormality abnormality) async {
    double left = offset.dx;
    double top = offset.dy;
    List<String> userIds = (abnormality.findUserId.toString()).split(",");
    await showMenu(
      context: context,
      color: ConvertTheme.convertTheme.getBackGroundColor(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),      position: RelativeRect.fromLTRB(left, top, 20, 0),
      items: [
        if(abnormality.abnormalityStatus == 0 && userIds.contains(getLoginData()!.userdata?.first.id.toString()))
          PopupMenuItem<String>(
            value: 'Assign',
            child: InkWell(
              onTap: (){
                Get.back();
                Get.to(() =>  AssignAbnormalityView(abnormality: abnormality));
              },
              child: Row(
                children: [
                  const Icon(Icons.people),
                  commonHorizontalSpacing(),
                  const Text('Assign')
                ],
              ),
            )),
        if(abnormality.abnormalityStatus == 0 && !(userIds.contains(getLoginData()!.userdata?.first.id.toString())))
          const PopupMenuItem<String>(
              value: 'Created',
              child: Text('Created')
          ),
        if(abnormality.abnormalityStatus != 0)
          PopupMenuItem<String>(
              value: 'Assign',
              child: Row(
                children: [
                  const Icon(Icons.people),
                  commonHorizontalSpacing(),
                  Text(abnormality.abnormalityStatus == 1 ? 'Assigned' : "Completed"),
                ],
              )
          ),
        if(abnormality.abnormalityStatus != 1 && userIds.contains(getLoginData()!.userdata?.first.id.toString()))
          PopupMenuItem<String>(
              value: 'Edit',
              child: InkWell(
                onTap: (){
                  Get.back();
                  Get.to(() => AddAbnormalityFormView(isEdit: true,abnormalityId: id.toString()));
                },
                child: Row(
                  children: [
                    const Icon(Icons.edit),
                    commonHorizontalSpacing(),
                    const Text('Edit'),
                  ],
                ),
              )),
          PopupMenuItem<String>(
              value: 'Delete',
              child: InkWell(
                onTap: (){
                  Get.back();
                  showDialog(context: context, builder: (BuildContext context) => DeleteDialogView(doneCallback: (){
                    AbnormalityController.to.deleteAbnormality(abnormalityId: id.toString());
                  }));
                },
                child: Row(
                  children: [
                    const Icon(Icons.delete_forever_outlined),
                    commonHorizontalSpacing(),
                    const Text('Delete'),
                  ],
                ),
              )),
      ],
      elevation: 8.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return commonStructure(
        context: context,
        bgColor: blackColor,
        appBar: commonAppbar(context: context,title: "Abnormality List"),
        floatingAction: InkWell(
          onTap: (){
            Get.to(() => const AddAbnormalityFormView(isEdit: false,abnormalityId: ""));
          },
          child: Container(
              height: 60,width: 60,
              decoration: const BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle
              ),
              child: const Icon(Icons.add,color: blackColor,size: 30)
          ),
        ),
        child: Obx(() {
          if(AbnormalityController.to.loadingForAbnormality.value){
            return const Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            // alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    commonHeaderTitle(title: "Search",fontSize: isTablet() ? 1.5 : 1.2,fontWeight: 2,color: darkFontColor),
                    commonHorizontalSpacing(),
                    Expanded(
                      child: CommonTextFiled(
                        fieldTitleText: "Search here..",
                        hintText: "Search here..",
                        // isBorderEnable: false,
                        isChangeFillColor: true,
                        textEditingController: searchController,
                        onChangedFunction: (String value){
                          if(value.isEmpty){
                            AbnormalityController.to.searchAllAbnormalities?.value = AbnormalityController.to.allAbnormalities!;
                          }else{
                            AbnormalityController.to.searchAllAbnormalities?.value = AbnormalityController.to.allAbnormalities!.where((p0) => p0.businessName!.startsWith(value)
                                || p0.requestNo!.toLowerCase().startsWith(value) ||
                                p0.machineDetail!.toLowerCase().startsWith(value) ||
                                p0.companyShortName!.toLowerCase().startsWith(value) ||
                                p0.plantShortName!.toLowerCase().startsWith(value) ||
                                p0.abnormalityTitle!.toLowerCase().startsWith(value) ||
                                p0.partsName!.toLowerCase().startsWith(value) ||
                                p0.departmentName!.toLowerCase().startsWith(value)).toList();
                          }
                        },
                        suffixIcon: InkWell(
                          onTap: (){
                            Get.to(() => const AbnormalityFilterView());
                          },
                          child: const Icon(Icons.filter_list_alt,color: blackColor),
                        ),
                        validationFunction: (String value) {
                          return value.toString().isEmpty
                              ? notEmptyFieldMessage
                              : null;
                        },),
                    )
                  ],
                ),
              ),
              commonVerticalSpacing(spacing: 20),
              Expanded(
                child: SizedBox(
                  height: getScreenHeight(context) - 150,
                  child: ListView.builder(
                      itemCount: AbnormalityController.to.searchAllAbnormalities!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => abnormalityCardView(abnormality: AbnormalityController.to.allAbnormalities![index])
                  ),
                ),
              )
            ],
          );
        })
    );
  }
}

class CompleteAbnormalityView extends StatefulWidget {
  final Abnormality abnormality;
  const CompleteAbnormalityView({Key? key, required this.abnormality}) : super(key: key);

  @override
  State<CompleteAbnormalityView> createState() => _CompleteAbnormalityViewState();
}

class _CompleteAbnormalityViewState extends State<CompleteAbnormalityView> {

  String completeDate = DateTime.now().toString();
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController solutionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
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
                                      title: completeDate.isEmpty ? "Complete Date" : completeDate)
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
                                          completeDate = DateFormat("dd-MM-yyyy").format(value);
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
                commonVerticalSpacing(),
                CommonTextFiled(
                    fieldTitleText: "Actual Solution",
                    hintText: "Actual Solution",
                    // isBorderEnable: false,
                    isChangeFillColor: true,
                    maxLine: 4,
                    textEditingController: solutionController,
                    onChangedFunction: (String value){
                    },
                    validationFunction: (String value) {
                      return value.toString().isEmpty
                          ? notEmptyFieldMessage
                          : null;
                    }),
                Row(
                  children: [
                    Expanded(child: commonBorderButtonView(
                        context: context,
                        title: "Cancel",
                        height: 50,
                        tapOnButton: () {
                          Get.back();
                        },
                        isLoading: false)
                    ),
                    commonHorizontalSpacing(),
                    Expanded(child: commonFillButtonView(
                        context: context,
                        title: "Save",
                        width: getScreenWidth(context) - 40,
                        height: 50,
                        tapOnButton: () {
                          if(solutionController.text.isNotEmpty){
                            AbnormalityController.to.completeAbnormality(
                              callback: (){
                                AbnormalityController.to.getAbnormalityLists({
                                  "user_id": getLoginData()!.userdata!.first.id,
                                  "group_id": getLoginData()!.userdata!.first.groupId,
                                },callback: (){});
                              },
                              abnormalityId: widget.abnormality.abnormalityId,
                              actualSolution: solutionController.text,
                              completeDate:completeDate,
                              completeTime: "${selectedTime.hour}:${selectedTime.minute} ${selectedTime.period.name}",
                            );
                          }else{
                            showSnackBar(title: ApiConfig.error, message: "Please enter solution");
                          }
                        },
                        isLoading: false)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
