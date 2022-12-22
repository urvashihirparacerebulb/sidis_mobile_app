import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_projects/common_widgets/common_widget.dart';
import '../common_widgets/common_textfield.dart';
import '../controllers/kaizen_controller.dart';
import '../models/team_member_model.dart';

class TeamMemberBottomView extends StatefulWidget {
  final List<KaizenTeamData> myItems;
  final Function? selectionCallBack;
  final String plantId;
  final String departmentId;
  final String subDepartmentId;

  const TeamMemberBottomView({Key? key, required this.myItems,
    this.selectionCallBack, this.plantId = "", this.departmentId = "", this.subDepartmentId = ""}) : super(key: key);

  @override
  State<TeamMemberBottomView> createState() => _TeamMemberBottomViewState();
}

class _TeamMemberBottomViewState extends State<TeamMemberBottomView> {
  TextEditingController searchController = TextEditingController();
  List<KaizenTeamData> searchedMyItems = [];

  @override
  void initState() {
    if(widget.myItems.isEmpty){
      KaizenController.to.getTeamMembers(plantId: widget.plantId,departmentId: widget.departmentId.toString(),subDepartmentId: widget.subDepartmentId.toString());
    }
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
          commonHeaderTitle(title: "Select Team Member",fontWeight: 2,fontSize: 1.5),
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
                  searchedMyItems = widget.myItems.where((p0) => p0.userName!.toLowerCase().startsWith(value.toLowerCase())).toList();
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
                      title: searchedMyItems[index].userName ?? "",
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
