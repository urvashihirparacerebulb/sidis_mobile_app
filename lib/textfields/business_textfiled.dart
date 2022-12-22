import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common_widgets/common_textfield.dart';
import '../common_widgets/common_widget.dart';
import '../models/business_data_model.dart';

class BusinessBottomView extends StatefulWidget {
  final List<BusinessData> myItems;
  final Function? selectionCallBack;

  const BusinessBottomView({Key? key, required this.myItems, this.selectionCallBack}) : super(key: key);

  @override
  State<BusinessBottomView> createState() => _BusinessBottomViewState();
}

class _BusinessBottomViewState extends State<BusinessBottomView> {

  TextEditingController searchController = TextEditingController();
  List<BusinessData> searchedMyItems = [];

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
          commonHeaderTitle(title: "Select Business",fontWeight: 2,fontSize: 1.5),
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
                  searchedMyItems = widget.myItems.where((p0) => p0.businessName!.toLowerCase().startsWith(value.toLowerCase())).toList();
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
                      title: searchedMyItems[index].businessName ?? "",
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
