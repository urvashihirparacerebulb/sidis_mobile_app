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
  List<PillarResponse> searchedMyItems = [];

  @override
  void initState() {
    searchedMyItems = List.from(widget.myItems);
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
                if(value.isEmpty){
                  searchedMyItems = widget.myItems;
                }else{
                  searchedMyItems = widget.myItems.where((p0) => p0.pillarName!.toLowerCase().startsWith(value.toLowerCase())).toList();
                }
              });
            },
          ),
          commonVerticalSpacing(spacing: 30),
          ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemCount: searchedMyItems.length,
              itemBuilder: (context, index) => InkWell(
                onTap: (){
                  Get.back();
                  widget.selectionCallBack!(searchedMyItems[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: commonHeaderTitle(
                      title: searchedMyItems[index].pillarName ?? "",
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
