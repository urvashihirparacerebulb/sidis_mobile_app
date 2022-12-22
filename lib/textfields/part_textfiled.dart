import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_projects/models/part_response_model.dart';
import '../common_widgets/common_textfield.dart';
import '../common_widgets/common_widget.dart';
import '../controllers/part_controller.dart';

class PartBottomView extends StatefulWidget {
  final String hintText;
  final String machineId;
  final List<PartArray> myItems;
  final Function? selectionCallBack;

  const PartBottomView({Key? key, required this.myItems, this.selectionCallBack, required this.hintText, this.machineId = ""}) : super(key: key);

  @override
  State<PartBottomView> createState() => _PartBottomViewState();
}

class _PartBottomViewState extends State<PartBottomView> {
  TextEditingController searchController = TextEditingController();
  List<PartArray> searchedMyItems = [];

  @override
  void initState() {
    if(widget.myItems.isEmpty){
      PartController.to.getPartList(machineId: widget.machineId,callback: (){
        setState(() {
          searchedMyItems = List.from(widget.myItems);
        });
      });
    }else{
      searchedMyItems = List.from(widget.myItems);
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
          commonHeaderTitle(title: widget.hintText,fontWeight: 2,fontSize: 1.5),
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
                  searchedMyItems = widget.myItems.where((p0) => p0.partName!.toLowerCase().startsWith(value.toLowerCase())).toList();
                }
              });
            },
            onFieldSubmit: (text){
              Get.back();
              widget.selectionCallBack!(PartArray(partName: text));
            },
          ),
          commonVerticalSpacing(spacing: 30),
          ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              shrinkWrap: true,
              itemCount: searchedMyItems.length,
              itemBuilder: (context, index) => InkWell(
                onTap: (){
                  Get.back();
                  widget.selectionCallBack!(searchedMyItems[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: commonHeaderTitle(
                      title:searchedMyItems[index].partName ?? "",
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
