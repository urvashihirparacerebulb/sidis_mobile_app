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
  List<Department> searchedMyItems = [];

  @override
  void initState() {
    if(widget.myItems.isEmpty){
      if(widget.hintText == "Select Department"){
         DepartmentController.to.getDepartment(
             soleId: widget.soleId,
           callback: (){
             setState(() {
               searchedMyItems = List.from(widget.myItems);
             });
           }
         );
      }else{
        DepartmentController.to.getSubDepartment(departmentId: widget.departmentId.toString(),callback: (){
          setState(() {
            searchedMyItems = List.from(widget.myItems);
          });
        });
      }
    }else {
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
                if(value.isEmpty){
                  searchedMyItems = widget.myItems;
                }else{
                  searchedMyItems = widget.myItems.where((p0) => p0.departmentName!.toLowerCase().startsWith(value.toLowerCase())).toList();
                }
              });
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
                      title: searchedMyItems[index].departmentName ?? "",
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
