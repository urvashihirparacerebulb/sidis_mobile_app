import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_projects/controllers/product_requisition_controller.dart';
import 'package:my_projects/utility/common_methods.dart';
import 'package:my_projects/utility/constants.dart';
import '../../../common_widgets/common_textfield.dart';
import '../../../common_widgets/common_widget.dart';
import '../../../models/pillar_data_model.dart';
import '../../../models/product_requisition_response_model.dart';
import '../../../textfields/common_bottom_string_view.dart';
import '../../../theme/convert_theme_colors.dart';
import '../../../utility/color_utility.dart';
import '../../../utility/delete_dialog_view.dart';
import '../../../utility/screen_utility.dart';
import 'add_product_requisition_view.dart';
import 'product_requisition_filter.dart';

class ProductRequisitionList extends StatefulWidget {
  final PillarForm pillarForm;
  const ProductRequisitionList({Key? key, required this.pillarForm}) : super(key: key);

  @override
  State<ProductRequisitionList> createState() => _ProductRequisitionListState();
}

class _ProductRequisitionListState extends State<ProductRequisitionList> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    ProductRequisitionController.to.getProductRequisitionListData(selectedFormId: widget.pillarForm.id.toString());
    Future.delayed(const Duration(seconds: 2), (){
      ProductRequisitionController.to.productRequisitionStatuses();
    });
    super.initState();
  }

  Widget productRequisitionView({ProductRequisition? productRequisition}){
    return InkWell(
      onTap: (){
        showDialog(context: context, builder: (BuildContext context) => detailView(productRequisition: productRequisition));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20,left: 16,right: 16),
        decoration: neurmorphicBoxDecoration,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonHeaderTitle(title: productRequisition!.poNo ?? "-",fontWeight: 3,fontSize: isTablet() ? 1.5 : 1.2),
                  commonHorizontalSpacing(),
                  commonHeaderTitle(title: productRequisition.requisitionDate ?? "",fontWeight: 3,fontSize: isTablet() ? 1.5 : 1.2)
                ],
              ),
              commonVerticalSpacing(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonHeaderTitle(title: productRequisition.companyBussinessPlant ?? "",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),
                  commonHorizontalSpacing(),
                  commonHeaderTitle(title: productRequisition.machineDetail ?? "",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90)
                ],
              ),
              commonVerticalSpacing(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonHeaderTitle(title: productRequisition.itemType ?? "",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),
                  commonHorizontalSpacing(),
                  commonHeaderTitle(title: productRequisition.itemStatus ?? "",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90)
                ],
              ),
              commonVerticalSpacing(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonHeaderTitle(title: "Quantity: ${productRequisition.quantity.toString()}",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),
                  commonVerticalSpacing(),
                  commonHeaderTitle(title: productRequisition.username ?? "",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90)
                ],
              ),
              commonVerticalSpacing(),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: commonHeaderTitle(title: "Required In: ${productRequisition.requiredIn}",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90)
                  ),

                  Expanded(flex: 2,child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                          onTapDown: (TapDownDetails details) {
                            _showPopupMenu(details.globalPosition,productRequisition);
                          },
                          child: Container(
                              padding: const EdgeInsets.all(5.0),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffD9D9D9)
                              ),
                              child: Icon(Icons.more_vert_rounded,size: isTablet() ? 28 : 20))
                      )
                  ))
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  void _showPopupMenu(Offset offset, ProductRequisition productRequisition) async {
    double left = offset.dx;
    double top = offset.dy;
    String selectedStatus = "";
    await showMenu(
      context: context,
      color: ConvertTheme.convertTheme.getBackGroundColor(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),      position: RelativeRect.fromLTRB(left, top, 20, 0),
      items: [
        if(productRequisition.itemStatus == "Request" && (productRequisition.requestedUserId == getLoginData()!.userdata!.first.id))
          PopupMenuItem<String>(
              value: 'Edit',
              child: InkWell(
                onTap: (){
                  Get.back();
                  Get.to(() => AddProductRequisitionView(
                      pillarId: widget.pillarForm.id.toString(),
                      isEdit: true,
                      requisitionId: productRequisition.productRequisitionId.toString(),
                  ));
                },
                child: Row(
                  children: [
                    const Icon(Icons.edit),
                    commonHorizontalSpacing(),
                    const Text('Edit'),
                  ],
                ),
              )),
        PopupMenuItem<String>(
            value: 'Delete',
            child: InkWell(
              onTap: (){
                Get.back();
                showDialog(context: context, builder: (BuildContext context) => DeleteDialogView(doneCallback: (){
                  ProductRequisitionController.to.deleteProductRequisition(
                      id: productRequisition.productRequisitionId.toString(),
                      selectedFormId: widget.pillarForm.id.toString()
                  );
                }));
              },
              child: Row(
                children: [
                  const Icon(Icons.delete_forever_outlined),
                  commonHorizontalSpacing(),
                  const Text('Delete'),
                ],
              ),
            )),
        PopupMenuItem<String>(
            value: 'Change Status',
            child: InkWell(
              onTap: (){
                Get.back();
                showDialog(context: context, builder: (BuildContext context) => Dialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                  child: Container(
                    margin: const EdgeInsets.only(left: 0.0,right: 0.0),
                    child: Container(
                      padding: const EdgeInsets.only(top: 18.0,),
                      margin: const EdgeInsets.only(top: 13.0,right: 8.0),
                      decoration: BoxDecoration(
                          color: whiteColor,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 0.0,
                              offset: Offset(0.0, 0.0),
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            commonHeaderTitle(
                                title: "Change Product Requisition",
                                color: blackColor,
                                isChangeColor: true,
                                fontSize: 1.7,
                                fontWeight: 2
                            ),
                            commonVerticalSpacing(spacing: 20),
                            StatefulBuilder(builder: (context, newSetState) {
                              return InkWell(
                                  onTap: (){
                                    commonBottomView(context: context,
                                        child: CommonBottomStringView(
                                            hintText: "Select Status",
                                            myItems: ProductRequisitionController.to.requisitionStatues,
                                            selectionCallBack: (
                                                String val) {
                                              newSetState((){
                                                selectedStatus = val;
                                              });
                                            })
                                    );
                                  },
                                  child: commonDecoratedTextView(
                                    title: selectedStatus.isEmpty ? "Select Status" : selectedStatus,
                                    isChangeColor: selectedStatus.isEmpty ? true : false,
                                  )
                              );
                            }),
                            commonVerticalSpacing(spacing: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: commonBorderButtonView(
                                      context: context,
                                      title: "Cancel",
                                      height: 50,
                                      tapOnButton: () {
                                        Get.back();
                                      },
                                      isLoading: false),
                                ),
                                commonHorizontalSpacing(spacing: 10),
                                Expanded(
                                  child: commonFillButtonView(
                                      context: context,
                                      title: "Save",
                                      height: 50,
                                      color: primaryColor,
                                      fontColor: blackColor,
                                      tapOnButton: () {
                                        Get.back();
                                        ProductRequisitionController.to.productRequisitionStatusUpdate(
                                            selectedFormId: widget.pillarForm.id.toString(),
                                            productRequisitionId: productRequisition.productRequisitionId.toString(),
                                            selectedStatus: selectedStatus
                                        );
                                      },
                                      isLoading: false),
                                )
                              ],
                            ),
                            commonVerticalSpacing(spacing: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
              },
              child: Row(
                children: [
                  const Icon(Icons.sync),
                  commonHorizontalSpacing(),
                  const Text('Change Status'),
                ],
              ),
            )),
      ],
      elevation: 8.0,
    );
  }

  detailView({ProductRequisition? productRequisition}){
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 0.0,right: 0.0),
            child: Container(
              padding: const EdgeInsets.only(top: 18.0,),
              margin: const EdgeInsets.only(top: 13.0,right: 8.0),
              decoration: BoxDecoration(
                  color: whiteColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 0.0,
                      offset: Offset(0.0, 0.0),
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    commonHeaderTitle(
                        title: "Product Requisition Detail",
                        color: blackColor,
                        isChangeColor: true,
                        fontSize: 1.7,
                        height: 1.4,
                        fontWeight: 2,align: TextAlign.center
                    ),
                    commonVerticalSpacing(spacing: 20),
                    commonDetailRowView(title: "Po No",subTitle: productRequisition?.poNo ?? ""),
                    commonVerticalSpacing(),
                    commonDetailRowView(title: "Requisition Date",subTitle: productRequisition?.requisitionDate ?? ""),
                    commonVerticalSpacing(),
                    commonDetailRowView(title: "Business Name",subTitle: (productRequisition?.companyBussinessPlant ?? "").split('_')[1]),
                    commonVerticalSpacing(),
                    commonDetailRowView(title: "Plant Name",subTitle: (productRequisition?.companyBussinessPlant ?? "").split('_')[2]),
                    commonVerticalSpacing(),
                    commonDetailRowView(title: "Company Name",subTitle: (productRequisition?.companyBussinessPlant ?? "").split('_')[0]),
                    commonVerticalSpacing(),
                    commonDetailRowView(title: "Machine Detail",subTitle: productRequisition?.machineDetail ?? ""),
                    commonVerticalSpacing(),
                    commonDetailRowView(title: "Item Type",subTitle: productRequisition?.itemType ?? ""),
                    commonVerticalSpacing(),
                    commonDetailRowView(title: "Item Description",subTitle: productRequisition?.itemDesc ?? ""),
                    commonVerticalSpacing(),
                    commonDetailRowView(title: "Quantity",subTitle: productRequisition?.quantity.toString() ?? ""),
                    commonVerticalSpacing(),
                    commonDetailRowView(title: "Required In",subTitle: productRequisition?.requiredIn ?? ""),
                    commonVerticalSpacing(),
                    commonDetailRowView(title: "Item Status",subTitle: productRequisition?.itemStatus ?? ""),
                    commonVerticalSpacing(),
                    commonDetailRowView(title: "Requested By",subTitle: productRequisition?.username ?? ""),
                    commonVerticalSpacing(),
                    productRequisition?.img != null && productRequisition?.img != "" ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        commonHeaderTitle(title: "Product Image: ",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),
                        commonVerticalSpacing(),
                        Expanded(child: Image.network((productRequisition?.img ?? ""),
                            height: 100))
                      ],
                    ) : Container(),
                    commonVerticalSpacing(spacing: 20),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            right: 0.0,
            child: GestureDetector(
              onTap: (){
                Get.back();
              },
              child: const Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 14.0,
                  backgroundColor: blackColor,
                  child: Icon(Icons.close, color: whiteColor),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return commonStructure(
        context: context,
        bgColor: blackColor,
        appBar: commonAppbar(context: context,title: productRequisitionText),
        floatingAction: InkWell(
          onTap: (){
            Get.to(() => AddProductRequisitionView(pillarId: widget.pillarForm.id.toString(),));
          },
          child: Container(
              height: 60,width: 60,
              decoration: const BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle
              ),
              child: const Icon(Icons.add,color: blackColor,size: 30)
          ),
        ),
        child:  Column(
          mainAxisSize: MainAxisSize.min,
          // alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonHeaderTitle(title: "Search",fontSize: isTablet() ? 1.5 : 1.2,fontWeight: 2,color: darkFontColor),
                  commonHorizontalSpacing(),
                  Expanded(
                    child: CommonTextFiled(
                      fieldTitleText: "Search here..",
                      hintText: "Search here..",
                      // isBorderEnable: false,
                      isChangeFillColor: true,
                      textEditingController: searchController,
                      onChangedFunction: (String val){
                        String value = val.toLowerCase();
                        if(value.isEmpty){
                          ProductRequisitionController.to.searchProductRequisitionList.value = ProductRequisitionController.to.productRequisitionList;
                        }else{
                          ProductRequisitionController.to.searchProductRequisitionList.value = ProductRequisitionController.to.productRequisitionList.where((p0) => p0.username!.startsWith(value)
                              || p0.poNo!.toLowerCase().startsWith(value) ||
                              p0.machineDetail!.toLowerCase().startsWith(value) ||
                              p0.requiredIn!.toLowerCase().startsWith(value) ||
                              p0.companyBussinessPlant!.toLowerCase().startsWith(value) ||
                              p0.requisitionDate!.toLowerCase().startsWith(value) ||
                              p0.itemStatus!.toLowerCase().startsWith(value)).toList();
                        }
                      },
                      suffixIcon: InkWell(
                        onTap: (){
                          Get.to(() => ProductRequisitionFilter(pillarFormId: widget.pillarForm.id.toString()));
                        },
                        child: const Icon(Icons.filter_list_alt,color: blackColor),
                      ),
                      validationFunction: (String value) {
                        return value.toString().isEmpty
                            ? notEmptyFieldMessage
                            : null;
                      },),
                  )
                ],
              ),
            ),
            commonVerticalSpacing(spacing: 20),
            Expanded(
              child: SizedBox(
                height: getScreenHeight(context) - 150,
                child: Obx((){
                  if(ProductRequisitionController.to.isProductReqLoading.value){
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                      itemCount: ProductRequisitionController.to.searchProductRequisitionList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => productRequisitionView(
                        productRequisition: ProductRequisitionController.to.searchProductRequisitionList[index]
                      )
                  );
                }),
              ),
            )
          ],
        )
    );
  }
}
