import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_projects/controllers/abnormality_controller.dart';
import '../../../common_widgets/common_textfield.dart';
import '../../../common_widgets/common_widget.dart';
import '../../../models/abnormality_response_model.dart';
import '../../../theme/convert_theme_colors.dart';
import '../../../utility/color_utility.dart';
import '../../../utility/constants.dart';
import '../../../utility/screen_utility.dart';
import 'add_abnormaliry_view.dart';

class AbnormalityListView extends StatefulWidget {
  const AbnormalityListView({Key? key}) : super(key: key);

  @override
  State<AbnormalityListView> createState() => _AbnormalityListViewState();
}

class _AbnormalityListViewState extends State<AbnormalityListView> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    AbnormalityController.to.getAbnormalityLists();
    super.initState();
  }

  Widget abnormalityCardView({Abnormality? abnormality}){
    return Container(
      margin: const EdgeInsets.only(bottom: 20,left: 16,right: 16),
      decoration: neurmorphicBoxDecoration,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonHeaderTitle(title: abnormality!.requestNo ?? "",fontWeight: 3,fontSize: isTablet() ? 1.5 : 1.2),
                commonHeaderTitle(title: abnormality.companyShortName ?? "",fontWeight: 3,fontSize: isTablet() ? 1.5 : 1.2)
              ],
            ),
            commonVerticalSpacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonHeaderTitle(title: abnormality.plantShortName ?? "",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),
                commonHeaderTitle(title: abnormality.bussinessName ?? "",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90)
              ],
            ),
            commonVerticalSpacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonHeaderTitle(title: abnormality.departmentName ?? "",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),
                commonHeaderTitle(title: abnormality.partsName ?? "",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90)
              ],
            ),
            commonVerticalSpacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonHeaderTitle(title: abnormality.abnormalityTitle ?? "",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),
                commonHeaderTitle(title: abnormality.createdAt ?? "",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90)
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
                        commonHeaderTitle(title: "Assign to: CEREBULB ADMIN(CEREBULB001)",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),
                        commonVerticalSpacing(),
                        commonHeaderTitle(title: "Tag: Red",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),
                      ],
                    )),

                Expanded(flex: 1,child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                        onTapDown: (TapDownDetails details) {
                          _showPopupMenu(details.globalPosition,abnormality.abnormalityId!);
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

  void _showPopupMenu(Offset offset,int id) async {
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
            child: Row(
              children: [
                const Icon(Icons.delete_forever_outlined),
                commonHorizontalSpacing(),
                const Text('Delete'),
              ],
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
                    commonHeaderTitle(title: "Departments",fontSize: isTablet() ? 1.5 : 1.2,fontWeight: 2,color: darkFontColor),
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
                  child: ListView.builder(
                      itemCount: AbnormalityController.to.allAbnormalities!.length,
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
