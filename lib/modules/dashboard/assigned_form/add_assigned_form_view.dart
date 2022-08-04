import 'package:flutter/material.dart';
import 'package:my_projects/theme/convert_theme_colors.dart';
import 'package:my_projects/utility/constants.dart';
import 'package:my_projects/utility/screen_utility.dart';

import '../../../common_widgets/common_textfield.dart';
import '../../../common_widgets/common_widget.dart';
import '../../../utility/assets_utility.dart';
import '../../../utility/color_utility.dart';

class AddAssignedFormView extends StatefulWidget {
  const AddAssignedFormView({Key? key}) : super(key: key);

  @override
  State<AddAssignedFormView> createState() => _AddAssignedFormViewState();
}

class _AddAssignedFormViewState extends State<AddAssignedFormView> {
  TextEditingController searchController = TextEditingController();
  List<AssignedSelection> assignedFilters = [
    AssignedSelection("All", true),
    AssignedSelection("Maintenance", false),
    AssignedSelection("Process", false),
    AssignedSelection("Quality", false),
    AssignedSelection("Procurement", false),
    AssignedSelection("Test New", false),
    AssignedSelection("Test Short", false),
  ];

  Widget assignedCardView({int? index}){
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
                            child: Image(image: dashboardIconImage,height: 16,width: 16)))))
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
            value: 'Abnormality Detail',
            child: Row(
              children: [
                const Icon(Icons.remove_red_eye_outlined),
                commonHorizontalSpacing(),
                const Text('Abnormality Detail'),
              ],
            )),
        PopupMenuItem<String>(
            value: 'Assign to User',
            child: Row(
              children: [
                const Icon(Icons.assignment_turned_in_outlined),
                commonHorizontalSpacing(),
                const Text('Assign to User'),
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
        appBar: commonAppbar(context: context,title: assignedFormText),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Column(
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
                Container(
                    height: 50,
                    margin: const EdgeInsets.only(left: 10),
                    width: getScreenWidth(context),
                    child:ListView.builder(
                        shrinkWrap: true,
                        itemCount: assignedFilters.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => InkWell(
                          onTap: (){
                            for (var element in assignedFilters) {
                              element.isSelection = false;
                            }
                            setState((){
                              assignedFilters[index].isSelection = !assignedFilters[index].isSelection;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10,top: 5,bottom: 5),
                            padding: const EdgeInsets.only(left: 15,right: 15,top: 5),
                            decoration: neurmorphicBoxDecoration.copyWith(
                                color: assignedFilters[index].isSelection ? primaryColor : bgColor.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(24)
                            ),
                            child: Center(
                              child: commonHeaderTitle(title: assignedFilters[index].title ?? "",fontSize: 1.2,fontWeight: 1,
                                  color: blackColor),
                            ),
                          ),
                        ))
                ),
                commonVerticalSpacing(spacing: 20),
                SizedBox(
                  height: getScreenHeight(context) - 230,
                  child: ListView.builder(
                      itemCount: 10,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => assignedCardView(index: index)),
                ),
              ],
            ),
          ],
        )
    );
  }
}

class AssignedSelection{
  String? title;
  bool isSelection = false;
  AssignedSelection(this.title,this.isSelection);
}
