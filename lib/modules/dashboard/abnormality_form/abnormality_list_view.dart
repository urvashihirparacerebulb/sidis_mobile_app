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
                commonHeaderTitle(title: "202294538",fontWeight: 3,fontSize: 1.2),
                commonHeaderTitle(title: "Part 2",fontWeight: 3,fontSize: 1.2)
              ],
            ),
            commonVerticalSpacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonHeaderTitle(title: "CEREBULB_Stiching_FB",fontWeight: 1,fontSize: 0.90),
                commonHeaderTitle(title: "Fiber Glass Fiber Fabric",fontWeight: 1,fontSize: 0.90)
              ],
            ),
            commonVerticalSpacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonHeaderTitle(title: "Maintenance_Extruder",fontWeight: 1,fontSize: 0.90),
                commonHeaderTitle(title: "Maintenance_Extruder",fontWeight: 1,fontSize: 0.90)
              ],
            ),
            commonVerticalSpacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonHeaderTitle(title: "Activity 1",fontWeight: 1,fontSize: 0.90),
                commonHeaderTitle(title: "05-07-2022,11:27 AM",fontWeight: 1,fontSize: 0.90)
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
                        commonHeaderTitle(title: "Assign to: CEREBULB ADMIN(CEREBULB001)",fontWeight: 1,fontSize: 0.90),
                        commonVerticalSpacing(),
                        commonHeaderTitle(title: "Tag: Red",fontWeight: 1,fontSize: 0.90),
                      ],
                    )),

                Expanded(flex: 1,child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                        onTapDown: (TapDownDetails details) {
                          _showPopupMenu(details.globalPosition);
                        },
                        child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffD9D9D9)
                            ),
                            child: const Icon(Icons.more_vert_rounded,size: 16)))))
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
            child: Row(
              children: [
                const Icon(Icons.edit),
                commonHorizontalSpacing(),
                const Text('Edit'),
              ],
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
            Get.to(() => const AddAbnormalityFormView());
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
          return  Column(
            // alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    commonHeaderTitle(title: "Departments",fontSize: 1.2,fontWeight: 2,color: darkFontColor),
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
              commonVerticalSpacing(),
              SizedBox(
                height: getScreenHeight(context) - 150,
                child: ListView.builder(
                    itemCount: AbnormalityController.to.allAbnormalities!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => abnormalityCardView(abnormality: AbnormalityController.to.allAbnormalities![index])),
              ),
            ],
          );
        })
    );
  }
}
