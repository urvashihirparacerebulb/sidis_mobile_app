
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common_widgets/common_textfield.dart';
import '../common_widgets/common_widget.dart';
import '../controllers/dropdown_data_controller.dart';
import '../models/machines_response_model.dart';

class MachineBottomView extends StatefulWidget {
  final String hintText;
  final String soleId;
  final int machineId;
  final List<MachineData> myItems;
  final Function? selectionCallBack;

  const MachineBottomView({Key? key, required this.myItems, this.selectionCallBack,
    required this.hintText, this.soleId = "", this.machineId = 0}) : super(key: key);

  @override
  State<MachineBottomView> createState() => _MachineBottomViewState();
}

class _MachineBottomViewState extends State<MachineBottomView> {

  TextEditingController searchController = TextEditingController();
  List<MachineData> selectedItems = [];

  @override
  void initState() {
    if(widget.myItems.isEmpty){
      if(widget.hintText == "Select Machine") {
        DropDownDataController.to.getMachines(
            plantId: widget.soleId,
            successCallback: () {
              setState(() {
                selectedItems.addAll(DropDownDataController.to.machinesList ?? []);
              });
            });
      }else{
        DropDownDataController.to.getSubMachines(plantId: widget.soleId,
            machineId: widget.machineId,successCallback: (){
              setState(() {
                selectedItems.addAll(DropDownDataController.to.subMachinesList ?? []);
              });
            });
      }
    }else{
      selectedItems = widget.myItems;
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
              });
            },
          ),
          commonVerticalSpacing(spacing: 30),
          ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              shrinkWrap: true,
              itemCount: searchController.text.isEmpty ? selectedItems.length : selectedItems.where((element) => element.machineName!.startsWith(searchController.text)).toList().length,
              itemBuilder: (context, index) => InkWell(
                onTap: (){
                  Get.back();
                  widget.selectionCallBack!(selectedItems[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: commonHeaderTitle(
                      title: selectedItems[index].machineName ?? "",
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
