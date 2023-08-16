import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common_widgets/common_widget.dart';
import '../../../controllers/abnormality_controller.dart';
import '../../../controllers/product_requisition_controller.dart';
import '../../../models/activities_response_model.dart';
import '../../../textfields/common_bottom_string_view.dart';
import '../../../textfields/find_by_user_view_textfield.dart';
import '../../../theme/convert_theme_colors.dart';
import '../../../utility/color_utility.dart';
import '../../../utility/screen_utility.dart';

class ProductRequisitionFilter extends StatefulWidget {
  final String pillarFormId;
  const ProductRequisitionFilter({Key? key, required this.pillarFormId}) : super(key: key);

  @override
  State<ProductRequisitionFilter> createState() => _ProductRequisitionFilterState();
}

class _ProductRequisitionFilterState extends State<ProductRequisitionFilter> {

  String selectedStatus = "";
  UserFilterResponse? selectedUser;

  @override
  void initState() {
    if(AbnormalityController.to.userFilters!.isEmpty) {
      AbnormalityController.to.getUserFilters(callback: () {});
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return commonStructure(
      context: context,
      bgColor: blackColor,
      appBar: commonAppbar(context: context,title: "Product Requisition List"),
      bottomNavigation: Container(
        color: ConvertTheme.convertTheme.getBackGroundColor(),
        child: Padding(
          padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16,top: 10),
          child: Row(
            children: [
              Expanded(child: commonBorderButtonView(
                  context: context,
                  title: "Cancel",
                  height: 50,
                  tapOnButton: () {
                    Get.back();
                  },
                  isLoading: false)),
              commonHorizontalSpacing(),
              Expanded(child: commonFillButtonView(
                  context: context,
                  title: "Save",
                  width: getScreenWidth(context) - 40,
                  height: 50,
                  tapOnButton: () {
                    if(selectedUser != null && selectedStatus.isNotEmpty){
                      ProductRequisitionController.to.getProductRequisitionListData(
                          selectedFormId: widget.pillarFormId,
                          isFilter: true,
                          status: selectedStatus,
                          user: selectedUser!.userId.toString()
                      );
                      Get.back();
                    }
                  },
                  isLoading: false)
              ),
            ],
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            InkWell(
                onTap: (){
                  commonBottomView(context: context,
                      child: CommonBottomStringView(
                          hintText: "Select Status",
                          myItems: ProductRequisitionController.to.requisitionStatues,
                          selectionCallBack: (String val) {
                            setState((){selectedStatus = val;});
                          })
                  );
                },
                child: commonDecoratedTextView(
                  title: selectedStatus.isEmpty ? "Select Status" : selectedStatus,
                  isChangeColor: selectedStatus.isEmpty ? true : false,
                )
            ),

            InkWell(
                onTap: (){
                  commonBottomView(context: context,
                      child: FilterUserBottomView(
                          hintText: "Select User",
                          myItems: AbnormalityController.to.userFilters!,
                          selectionCallBack: (UserFilterResponse user) {
                            setState(() {
                              selectedUser = user;
                            });
                          }
                   ));
                },
                child: commonDecoratedTextView(
                  title: selectedUser == null ? "Select User" : "${selectedUser?.firstName ?? ""} ${selectedUser?.lastName ?? ""}",
                  isChangeColor: selectedUser == null ? true : false,
                )
            )
          ],
        ),
      )
    );
  }
}
