import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_projects/common_widgets/common_widget.dart';
import 'package:my_projects/modules/dashboard/needle/add_needle_record_view.dart';

import '../../../common_widgets/common_textfield.dart';
import '../../../controllers/needle_controller.dart';
import '../../../models/needle_response_model.dart';
import '../../../theme/convert_theme_colors.dart';
import '../../../utility/color_utility.dart';
import '../../../utility/constants.dart';
import '../../../utility/delete_dialog_view.dart';
import '../../../utility/screen_utility.dart';

class NeedleRecordFormList extends StatefulWidget {
  const NeedleRecordFormList({Key? key}) : super(key: key);

  @override
  State<NeedleRecordFormList> createState() => _NeedleRecordFormListState();
}

class _NeedleRecordFormListState extends State<NeedleRecordFormList> {
  TextEditingController searchController = TextEditingController();


  @override
  void initState() {
    NeedleController.to.getNeedleRecordListData();
    super.initState();
  }

  Widget needleRecordView({NeedleRecord? needleRecord}){
    return InkWell(
      onTap: (){
        showDialog(context: context, builder: (BuildContext context) => detailView(needleRecord: needleRecord));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20,left: 16,right: 16),
        decoration: neurmorphicBoxDecoration,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonHeaderTitle(title: needleRecord?.boardNo ?? "",fontWeight: 3,fontSize: isTablet() ? 1.5 : 1.2),
                  commonHorizontalSpacing(),
                  commonHeaderTitle(title: needleRecord?.companyShortName ?? "",fontWeight: 3,fontSize: isTablet() ? 1.5 : 1.2)
                ],
              ),
              commonVerticalSpacing(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonHeaderTitle(title: needleRecord?.bussinessName ?? "",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),
                  commonHorizontalSpacing(),
                  commonHeaderTitle(title: needleRecord?.plantShortName ?? "",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90)
                ],
              ),
              commonVerticalSpacing(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonHeaderTitle(title: "Status: ${needleRecord?.machineDetail}",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),
                  commonHorizontalSpacing(),
                  commonHeaderTitle(title: needleRecord?.recordDate ?? "",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90)
                ],
              ),
              commonVerticalSpacing(),
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: commonHeaderTitle(title: "Consumed Needle : ${needleRecord?.consumedNeedle}",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),
                  ),

                  Expanded(flex: 1,child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                          onTapDown: (TapDownDetails details) {
                            _showPopupMenu(details.globalPosition,needleRecord!.needleRecordId!.toString());
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
                ]
              )
            ],
          ),
        ),
      ),
    );
  }

  detailView({NeedleRecord? needleRecord}){
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
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
                    commonHeaderTitle(
                        title: "Board Detail",
                        color: blackColor,
                        isChangeColor: true,
                        fontSize: 1.7,
                        height: 1.4,
                        fontWeight: 2,align: TextAlign.center
                    ),
                    commonVerticalSpacing(spacing: 20),
                    commonDetailRowView(title: "Board No",subTitle: needleRecord?.boardNo ?? "-"),
                    commonVerticalSpacing(),
                    commonDetailRowView(title: "Needle Record Date",subTitle: needleRecord?.recordDate),
                    commonVerticalSpacing(),
                    commonDetailRowView(title: "Business Name",subTitle: needleRecord?.bussinessName ?? "-"),
                    commonVerticalSpacing(),
                    commonDetailRowView(title: "Plant Name",subTitle: needleRecord?.plantShortName ?? "-"),
                    commonVerticalSpacing(),
                    commonDetailRowView(title: "Company Name",subTitle: needleRecord?.companyShortName ?? "-"),
                    commonVerticalSpacing(),
                    commonDetailRowView(title: "Machine Detail",subTitle: needleRecord?.machineDetail ?? "-"),
                    commonVerticalSpacing(),
                    commonDetailRowView(title: "Consumed Needle",subTitle: needleRecord?.consumedNeedle ?? "-"),
                    commonVerticalSpacing(spacing: 20),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            right: 0.0,
            child: GestureDetector(
              onTap: (){
                Get.back();
              },
              child: const Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 14.0,
                  backgroundColor: blackColor,
                  child: Icon(Icons.close, color: whiteColor),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }


  void _showPopupMenu(Offset offset,String boardRecordId) async {
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
            value: 'Edit',
            child: InkWell(
              onTap: (){
                Get.back();
                Get.to(() => AddNeedleRecordView(isEdit: true,recordId: boardRecordId.toString()));
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
                  NeedleController.to.deleteNeedleBoardRecord(boardRecordId: boardRecordId);
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
      appBar: commonAppbar(context: context,title: "Needle Record List"),
      floatingAction: InkWell(
        onTap: (){
          Get.to(() => const AddNeedleRecordView(isEdit: false,recordId: ""));
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
      child: Column(
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
                    },
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
              child: Obx(() => NeedleController.to.needleRecordList.isEmpty ? Center(
                child: commonHeaderTitle(title: "Records Not Found",fontWeight: 3,fontSize: isTablet() ? 1.5 : 1.2),
              ) : ListView.builder(
                  itemCount: NeedleController.to.needleRecordList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => needleRecordView(
                    needleRecord: NeedleController.to.needleRecordList[index]
                  )
              ))
            ),
          )
        ],
      )
    );
  }
}
