import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common_widgets/common_textfield.dart';
import '../common_widgets/common_widget.dart';
import '../models/needle_response_model.dart';

class BoardBottomView extends StatefulWidget {
  final List<NeedleBoardNumber> myItems;
  final Function? selectionCallBack;

  const BoardBottomView({Key? key, required this.myItems, this.selectionCallBack}) : super(key: key);

  @override
  State<BoardBottomView> createState() => _BoardBottomViewState();
}

class _BoardBottomViewState extends State<BoardBottomView> {

  TextEditingController searchController = TextEditingController();
  List<NeedleBoardNumber> searchedItems = [];

  @override
  void initState() {
    searchedItems = List.from(widget.myItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: ListView(
        shrinkWrap: true,
        children: [
          commonVerticalSpacing(spacing: 15),
          commonHeaderTitle(title: "Select Board Number",fontWeight: 2,fontSize: 1.5),
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
                  searchedItems = widget.myItems.where((p0) => p0.boardNo!.toLowerCase().startsWith(value.toLowerCase())).toList();
                }
              });
            },
          ),
          commonVerticalSpacing(spacing: 30),
          ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemCount: searchedItems.length,
              itemBuilder: (context, index) => InkWell(
                onTap: (){
                  Get.back();
                  widget.selectionCallBack!(searchedItems[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: commonHeaderTitle(
                      title: searchedItems[index].boardNo ?? "",
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
