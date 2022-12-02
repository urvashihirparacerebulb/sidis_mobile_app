import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_projects/models/pillar_data_model.dart';

import '../common_widgets/common_textfield.dart';
import '../common_widgets/common_widget.dart';

class PillarBottomView extends StatefulWidget {
  final List<PillarResponse> myItems;
  final Function? selectionCallBack;

  const PillarBottomView({Key? key, required this.myItems, this.selectionCallBack}) : super(key: key);

  @override
  State<PillarBottomView> createState() => _PillarBottomViewState();
}

class _PillarBottomViewState extends State<PillarBottomView> {

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          commonVerticalSpacing(spacing: 15),
          commonHeaderTitle(title: "Select Pillar",fontWeight: 2,fontSize: 1.5),
          commonVerticalSpacing(spacing: 15),
          CommonTextFiled(
            fieldTitleText: "Search",
            hintText: "Search",
            // isBorderEnable: false,
            isChangeFillColor: true,
            textEditingController: searchController,
            onChangedFunction: (String value){
              setState(() {
              });
            },
          ),
          commonVerticalSpacing(spacing: 30),
          ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemCount: searchController.text.isEmpty ? widget.myItems.length : widget.myItems.where((element) => element.pillarName!.startsWith(searchController.text)).toList().length,
              itemBuilder: (context, index) => InkWell(
                onTap: (){
                  Get.back();
                  widget.selectionCallBack!(widget.myItems[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: commonHeaderTitle(
                      title: widget.myItems[index].pillarName ?? "",
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
