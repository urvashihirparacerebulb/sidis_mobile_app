import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_projects/models/activities_response_model.dart';

import '../common_widgets/common_textfield.dart';
import '../common_widgets/common_widget.dart';
import '../controllers/abnormality_controller.dart';

class AbnormalityTypeBottomView extends StatefulWidget {
  final List<AbnormalityType> myItems;
  final Function? selectionCallBack;
  const AbnormalityTypeBottomView({Key? key, required this.myItems, this.selectionCallBack}) : super(key: key);

  @override
  State<AbnormalityTypeBottomView> createState() => _AbnormalityTypeBottomViewState();
}

class _AbnormalityTypeBottomViewState extends State<AbnormalityTypeBottomView> {
  TextEditingController searchController = TextEditingController();
  List<AbnormalityType> searchedItems = [];

  @override
  void initState() {
    if(widget.myItems.isEmpty){
      AbnormalityController.to.getAbnormalityType(callback: (){setState(() {
        searchedItems = List.from(widget.myItems);
      });});
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          commonVerticalSpacing(spacing: 15),
          commonHeaderTitle(title: "Select Abnormality Type",fontWeight: 2,fontSize: 1.5),
          commonVerticalSpacing(spacing: 15),
          CommonTextFiled(
            fieldTitleText: "Search",
            hintText: "Search",
            // isBorderEnable: false,
            isChangeFillColor: true,
            textEditingController: searchController,
            onChangedFunction: (String value){
              setState(() {
                if(value.isEmpty){
                  searchedItems = widget.myItems;
                }else{
                  searchedItems = widget.myItems.where((p0) => p0.typeName!.toLowerCase().startsWith(value.toLowerCase())).toList();
                }
              });
            },
          ),
          commonVerticalSpacing(spacing: 30),
          ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              shrinkWrap: true,
              itemCount: searchedItems.length,
              itemBuilder: (context, index) => InkWell(
                onTap: (){
                  Get.back();
                  widget.selectionCallBack!(searchedItems[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: commonHeaderTitle(
                      title: searchedItems[index].typeName ?? "",
                      fontSize: 1.2
                  ),
                ),
              )
          ),
          commonVerticalSpacing(spacing: 30),
        ],
      ),
    );
  }
}
