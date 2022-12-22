import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_projects/common_widgets/common_widget.dart';
import '../common_widgets/common_textfield.dart';
import '../controllers/dropdown_data_controller.dart';
import '../models/plants_response_model.dart';

class PlantBottomView extends StatefulWidget {
  final List<CompanyBusinessPlant> myItems;
  final Function? selectionCallBack;
  final String businessId;

  const PlantBottomView({Key? key, required this.myItems, this.selectionCallBack, this.businessId = ""}) : super(key: key);

  @override
  State<PlantBottomView> createState() => _PlantBottomViewState();
}

class _PlantBottomViewState extends State<PlantBottomView> {
  TextEditingController searchController = TextEditingController();
  List<CompanyBusinessPlant> searchedMyItems = [];

  @override
  void initState() {
    if(widget.myItems.isEmpty){
      DropDownDataController.to.getCompanyPlants(businessId: widget.businessId,successCallback: (){
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
          commonHeaderTitle(title: "Select Plant",fontWeight: 2,fontSize: 1.5),
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
                  searchedMyItems = widget.myItems.where((p0) => p0.soleName!.toLowerCase().startsWith(value.toLowerCase())).toList();
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
                      title: searchedMyItems[index].soleName ?? "",
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
