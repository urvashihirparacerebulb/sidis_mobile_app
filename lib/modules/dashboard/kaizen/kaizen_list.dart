import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_projects/common_widgets/common_widget.dart';

import '../../../common_widgets/common_textfield.dart';
import '../../../theme/convert_theme_colors.dart';
import '../../../utility/color_utility.dart';
import '../../../utility/constants.dart';
import '../../../utility/screen_utility.dart';
import 'add_kaizen_form.dart';

class KaizenListView extends StatefulWidget {
  const KaizenListView({Key? key}) : super(key: key);

  @override
  State<KaizenListView> createState() => _KaizenListViewState();
}

class _KaizenListViewState extends State<KaizenListView> {
  TextEditingController searchController = TextEditingController();

  Widget kaizenCardView(){
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
                commonHeaderTitle(title: "202279626",fontWeight: 3,fontSize: isTablet() ? 1.5 : 1.2),
                commonHorizontalSpacing(),
                commonHeaderTitle(title: "SKAPS",fontWeight: 3,fontSize: isTablet() ? 1.5 : 1.2)
              ],
            ),
            commonVerticalSpacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonHeaderTitle(title: "KK",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),
                commonHorizontalSpacing(),
                commonHeaderTitle(title: "Unit2",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90)
              ],
            ),
            commonVerticalSpacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonHeaderTitle(title: "Line-10",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),
                commonHorizontalSpacing(),
                commonHeaderTitle(title: "Complete",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90)
              ],
            ),
            commonVerticalSpacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonHeaderTitle(title: "Tej Patel",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),
                commonHorizontalSpacing(),
                commonHeaderTitle(title: "21-09-2022",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90)
              ],
            ),
            commonVerticalSpacing(),
            Row(
              children: [
                Expanded(
                  flex: 6,
                    child: commonHeaderTitle(title: "To reduce quality change over time for high heat product to low het product.",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),
                ),

                Expanded(flex: 1,child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                        onTapDown: (TapDownDetails details) {
                          _showPopupMenu(details.globalPosition);
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

  void _showPopupMenu(Offset offset) async {
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
                // Get.to(() => AddAbnormalityFormView(isEdit: true,abnormalityId: id.toString()));
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
      appBar: commonAppbar(context: context,title: "Kaizen List"),
      floatingAction: InkWell(
        onTap: (){
          Get.to(() => const AddKaizenFormView());
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
      child:  Column(
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
              child: ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => kaizenCardView()
              ),
            ),
          )
        ],
      )
    );
  }
}
