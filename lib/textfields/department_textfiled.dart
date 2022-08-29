import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_projects/models/department_response_model.dart';

import '../common_widgets/common_textfield.dart';
import '../common_widgets/common_widget.dart';
import '../controllers/department_controller.dart';

class DepartmentBottomView extends StatefulWidget {
  final String hintText;
  final List<Department> myItems;
  final Function? selectionCallBack;
  final String soleId;
  final String departmentId;
  const DepartmentBottomView({Key? key, required this.myItems, this.selectionCallBack, required this.hintText, this.soleId = "", this.departmentId = ""}) : super(key: key);

  @override
  State<DepartmentBottomView> createState() => _DepartmentBottomViewState();
}

class _DepartmentBottomViewState extends State<DepartmentBottomView> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    if(widget.myItems.isEmpty){
      if(widget.hintText == "Select Department"){
         DepartmentController.to.getDepartment(
             soleId: widget.soleId,
           callback: (){
             setState(() {});
           }
         );
      }else{
        DepartmentController.to.getSubDepartment(departmentId: widget.departmentId.toString(),callback: (){
          setState(() {
          });
        });
      }
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
          commonHeaderTitle(title: widget.hintText ,fontWeight: 2,fontSize: 1.5),
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
              itemCount: searchController.text.isEmpty ? widget.myItems.length : widget.myItems.where((element) => element.departmentName!.startsWith(searchController.text)).toList().length,
              itemBuilder: (context, index) => InkWell(
                onTap: (){
                  Get.back();
                  widget.selectionCallBack!(widget.myItems[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: commonHeaderTitle(
                      title: widget.myItems[index].departmentName ?? "",
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
