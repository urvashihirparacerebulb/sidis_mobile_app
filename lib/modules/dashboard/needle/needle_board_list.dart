import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_projects/modules/dashboard/needle/add_needle_board_view.dart';

import '../../../common_widgets/common_textfield.dart';
import '../../../common_widgets/common_widget.dart';
import '../../../controllers/needle_controller.dart';
import '../../../models/needle_response_model.dart';
import '../../../theme/convert_theme_colors.dart';
import '../../../utility/color_utility.dart';
import '../../../utility/constants.dart';
import '../../../utility/delete_dialog_view.dart';
import '../../../utility/screen_utility.dart';

class NeedleBoardList extends StatefulWidget {
  const NeedleBoardList({Key? key}) : super(key: key);

  @override
  State<NeedleBoardList> createState() => _NeedleBoardListState();
}

class _NeedleBoardListState extends State<NeedleBoardList> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    NeedleController.to.getNeedleBoardListData();
    super.initState();
  }

  Widget needleBoardView({NeedleBoard? needleBoard}){
    return InkWell(
      onTap: (){
        showDialog(context: context, builder: (BuildContext context) => detailView(needleBoard: needleBoard));
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
                  commonHeaderTitle(title: needleBoard?.lineName ?? "-",fontWeight: 3,fontSize: isTablet() ? 1.5 : 1.2),
                  commonHorizontalSpacing(),
                  commonHeaderTitle(title: needleBoard?.machineName ?? "",fontWeight: 3,fontSize: isTablet() ? 1.5 : 1.2)
                ],
              ),
              commonVerticalSpacing(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonHeaderTitle(title: needleBoard?.submachineName ?? "",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),
                  commonHorizontalSpacing(),
                  commonHeaderTitle(title: needleBoard?.location ?? "",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90)
                ],
              ),
              commonVerticalSpacing(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonHeaderTitle(title: "Old Board No: ${needleBoard?.oldBoardNo ?? ""}",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),
                  commonHorizontalSpacing(),
                  commonHeaderTitle(title: "New Board No: ${needleBoard?.newBoardNo ?? ""}",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90)
                ],
              ),
              commonVerticalSpacing(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonHeaderTitle(title: "Charged Board: ${needleBoard?.changeBoard ?? ""}",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),
                ],
              ),
              commonVerticalSpacing(),
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: commonHeaderTitle(title: needleBoard!.date!.replaceAll('<br>', ' '),fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90)
                  ),
                  Expanded(flex: 1,child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                          onTapDown: (TapDownDetails details) {
                            _showPopupMenu(details.globalPosition,needleBoard.needleRecordId.toString());
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
      ),
    );
  }

  detailView({NeedleBoard? needleBoard}){
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
                    commonDetailRowView(title: "Line Name",subTitle: needleBoard?.lineName ?? "-"),
                    commonVerticalSpacing(),
                    commonDetailRowView(title: "Needle Board Date",subTitle: needleBoard?.date!.replaceAll('<br>', ' ')),
                    commonVerticalSpacing(),
                    commonDetailRowView(title: "Looms name",subTitle: needleBoard?.loomsName ?? "-"),
                    commonVerticalSpacing(),
                    commonDetailRowView(title: "Business Name",subTitle: needleBoard?.bussinessName ?? "-"),
                    commonVerticalSpacing(),
                    commonDetailRowView(title: "Plant Name",subTitle: needleBoard?.plantShortName ?? "-"),
                    commonVerticalSpacing(),
                    commonDetailRowView(title: "Company Name",subTitle: needleBoard?.companyShortName ?? "-"),
                    commonVerticalSpacing(),
                    commonDetailRowView(title: "Machine Detail",subTitle: needleBoard?.machineName ?? "-"),
                    commonVerticalSpacing(),
                    commonDetailRowView(title: "Sub Machine Name",subTitle: needleBoard?.submachineName ?? "-"),
                    commonVerticalSpacing(),
                    commonDetailRowView(title: "Is Change Board?",subTitle: needleBoard?.changeBoard ?? "-"),
                    commonVerticalSpacing(),
                    commonDetailRowView(title: "Location",subTitle: needleBoard?.location ?? "-"),
                    commonVerticalSpacing(),
                    commonDetailRowView(title: "Old Board No",subTitle: needleBoard?.oldBoardNo ?? "-"),
                    commonVerticalSpacing(),
                    commonDetailRowView(title: "New Board No",subTitle: needleBoard?.newBoardNo ?? "-"),
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

  void _showPopupMenu(Offset offset, String boardId) async {
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
            value: 'Delete',
            child: InkWell(
              onTap: (){
                Get.back();
                showDialog(context: context, builder: (BuildContext context) => DeleteDialogView(doneCallback: (){
                  NeedleController.to.deleteNeedleBoard(boardId: boardId);
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
        appBar: commonAppbar(context: context,title: "Needle Board List"),
        floatingAction: InkWell(
          onTap: (){
            Get.to(() => const AddNeedleBoardView());
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
                child: Obx(() => NeedleController.to.needleBoards.isEmpty ? Center(
                  child: commonHeaderTitle(title: "Boards Not Found",fontWeight: 3,fontSize: isTablet() ? 1.5 : 1.2),
                ) : ListView.builder(
                    itemCount: NeedleController.to.needleBoards.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => needleBoardView(needleBoard: NeedleController.to.needleBoards[index])
                )),
              ),
            )
          ],
        )
    );
  }
}
