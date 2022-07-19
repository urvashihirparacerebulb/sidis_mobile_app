import 'package:flutter/material.dart';
import 'package:my_projects/utility/constants.dart';

import '../../../common_widgets/common_widget.dart';
import '../../../utility/color_utility.dart';

class AddAssignedFormView extends StatefulWidget {
  const AddAssignedFormView({Key? key}) : super(key: key);

  @override
  State<AddAssignedFormView> createState() => _AddAssignedFormViewState();
}

class _AddAssignedFormViewState extends State<AddAssignedFormView> {

  Widget assignedCardView({int? index}){
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      color: whiteColor,
      elevation: 7.0,
      shadowColor: greyColor.withOpacity(0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonHeaderTitle(title: "202294538",fontWeight: 2,fontSize: 1.2,color: fontColor),
                commonHeaderTitle(title: "Part 2",fontWeight: 2,fontSize: 1.2,color: fontColor)
              ],
            ),
            commonVerticalSpacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonHeaderTitle(title: "CEREBULB_Stiching_FB",fontWeight: 3,fontSize: 0.90,color: subFontColor),
                commonHeaderTitle(title: "Fiber Glass Fiber Fabric",fontWeight: 3,fontSize: 0.90,color: subFontColor)
              ],
            ),
            commonVerticalSpacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonHeaderTitle(title: "Maintenance_Extruder",fontWeight: 3,fontSize: 0.90,color: subFontColor),
                commonHeaderTitle(title: "Maintenance_Extruder",fontWeight: 3,fontSize: 0.90,color: subFontColor)
              ],
            ),
            commonVerticalSpacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonHeaderTitle(title: "Activity 1",fontWeight: 3,fontSize: 0.90,color: subFontColor),
                commonHeaderTitle(title: "05-07-2022,11:27 AM",fontWeight: 3,fontSize: 0.90,color: subFontColor)
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
                    commonHeaderTitle(title: "Assign to: CEREBULB ADMIN(CEREBULB001)",fontWeight: 3,fontSize: 0.90,color: subFontColor),
                    commonVerticalSpacing(),
                    commonHeaderTitle(title: "Tag: Red",fontWeight: 3,fontSize: 0.90,color: subFontColor),
                  ],
                )),
                
                Expanded(flex: 1,child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                        onTapDown: (TapDownDetails details) {
                          _showPopupMenu(details.globalPosition);
                        },
                        child: const Icon(Icons.dashboard_outlined,color: greyColor))))
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
        child: commonRoundedContainer(
          context: context,
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                        itemCount: 10,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => assignedCardView(index: index)),
                    // Positioned(
                    //   bottom: 20,
                    //   right: 10,left: 10,
                    //   child: Container(
                    //     height: 65,
                    //     decoration: BoxDecoration(
                    //       image: DecorationImage(
                    //         image: watermarkImage,
                    //         fit: BoxFit.contain,
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
