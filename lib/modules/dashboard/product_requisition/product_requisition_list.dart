import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_projects/utility/constants.dart';

import '../../../common_widgets/common_textfield.dart';
import '../../../common_widgets/common_widget.dart';
import '../../../theme/convert_theme_colors.dart';
import '../../../utility/color_utility.dart';
import '../../../utility/screen_utility.dart';
import 'add_product_requisition_view.dart';

class ProductRequisitionList extends StatefulWidget {
  const ProductRequisitionList({Key? key}) : super(key: key);

  @override
  State<ProductRequisitionList> createState() => _ProductRequisitionListState();
}

class _ProductRequisitionListState extends State<ProductRequisitionList> {
  TextEditingController searchController = TextEditingController();

  Widget productRequisitionView(){
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
                commonHeaderTitle(title: "000013",fontWeight: 3,fontSize: isTablet() ? 1.5 : 1.2),
                commonHorizontalSpacing(),
                commonHeaderTitle(title: "Line-8",fontWeight: 3,fontSize: isTablet() ? 1.5 : 1.2)
              ],
            ),
            commonVerticalSpacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonHeaderTitle(title: "SKAPS_Nonwoven_Unit2",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),
                commonHorizontalSpacing(),
                commonHeaderTitle(title: "Whenever Possible",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90)
              ],
            ),
            commonVerticalSpacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonHeaderTitle(title: "Spare",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),
                commonHorizontalSpacing(),
                commonHeaderTitle(title: "M seal",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90)
              ],
            ),
            commonVerticalSpacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonHeaderTitle(title: "Mahesh Valand",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),
                commonHorizontalSpacing(),
                commonHeaderTitle(title: "21-09-2022",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90)
              ],
            ),
            commonVerticalSpacing(),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      commonHeaderTitle(title: "Quantity: 2",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),
                      commonVerticalSpacing(),
                      commonHeaderTitle(title: "Request",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90)
                    ],
                  )
                ),

                Expanded(flex: 2,child: Align(
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
            value: 'Change Status',
            child: InkWell(
              onTap: (){
                Get.back();
              },
              child: Row(
                children: [
                  const Icon(Icons.sync),
                  commonHorizontalSpacing(),
                  const Text('Change Status'),
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
        appBar: commonAppbar(context: context,title: productRequisitionText),
        floatingAction: InkWell(
          onTap: (){
            Get.to(() => const AddProductRequisitionView());
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
                    itemBuilder: (context, index) => productRequisitionView()
                ),
              ),
            )
          ],
        )
    );
  }
}
