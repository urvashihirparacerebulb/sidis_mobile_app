import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_projects/common_widgets/common_widget.dart';
import 'package:my_projects/controllers/kaizen_controller.dart';

import '../../../common_widgets/common_textfield.dart';
import '../../../models/kaizen_response_model.dart';
import '../../../theme/convert_theme_colors.dart';
import '../../../utility/color_utility.dart';
import '../../../utility/constants.dart';
import '../../../utility/pdf_with_webview.dart';
import '../../../utility/screen_utility.dart';
import 'add_kaizen_form.dart';
import 'finish_kaizen_form_view.dart';

class KaizenListView extends StatefulWidget {
  const KaizenListView({Key? key}) : super(key: key);

  @override
  State<KaizenListView> createState() => _KaizenListViewState();
}

class _KaizenListViewState extends State<KaizenListView> {
  TextEditingController searchController = TextEditingController();
  RxList<KaizenList> searchKaizenList = RxList<KaizenList>();

  @override
  void initState() {
    KaizenController.to.getKaizenListData();
    super.initState();
  }

  Widget kaizenCardView({KaizenList? kaizen}){
    return Container(
      margin: const EdgeInsets.only(bottom: 20,left: 16,right: 16),
      decoration: neurmorphicBoxDecoration,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonHeaderTitle(title: kaizen!.requestNo ?? "",fontWeight: 3,fontSize: isTablet() ? 1.5 : 1.2),
                commonHorizontalSpacing(),
                commonHeaderTitle(title: kaizen.companyShortName ?? "",fontWeight: 3,fontSize: isTablet() ? 1.5 : 1.2)
              ],
            ),
            commonVerticalSpacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonHeaderTitle(title: kaizen.pillarName ?? "",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),
                commonHorizontalSpacing(),
                commonHeaderTitle(title: kaizen.plantShortName ?? "",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90)
              ],
            ),
            commonVerticalSpacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonHeaderTitle(title: kaizen.machineDetail ?? "",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),
                commonHorizontalSpacing(),
                commonHeaderTitle(title: kaizen.finishStatus ?? "",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90)
              ],
            ),
            commonVerticalSpacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonHeaderTitle(title: "Tej Patel",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),
                commonHorizontalSpacing(),
                commonHeaderTitle(title: kaizen.createdAt ?? "",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90)
              ],
            ),
            commonVerticalSpacing(),
            Row(
              children: [
                Expanded(
                  flex: 6,
                    child: commonHeaderTitle(title: kaizen.theme ?? "",fontWeight: 1,fontSize: isTablet() ? 1.11 : 0.90),
                ),

                Expanded(flex: 1,child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                        onTapDown: (TapDownDetails details) {
                          _showPopupMenu(details.globalPosition,kaizen);
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
            )
          ],
        ),
      ),
    );
  }

  void _showPopupMenu(Offset offset, KaizenList kaizen) async {
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
      context: context,
      color: ConvertTheme.convertTheme.getBackGroundColor(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),      position: RelativeRect.fromLTRB(left, top, 20, 0),
      items: [
        if(kaizen.finishStatus != "Complete")
          PopupMenuItem<String>(
              value: 'Edit',
              child: InkWell(
                onTap: (){
                  Get.back();
                  Get.to(() => AddKaizenFormView(isEdit: true,id: kaizen.kaizenId.toString()));
                },
                child: Row(
                  children: [
                    const Icon(Icons.edit),
                    commonHorizontalSpacing(),
                    const Text('Edit'),
                  ],
                )
              )),
        if(kaizen.finishStatus == "Complete")
           PopupMenuItem<String>(
            value: 'Edit Finish',
            child: InkWell(
              onTap: (){
                Get.back();
                Get.to(() => FinishKaizenFormView(kaizenList: kaizen));
              },
              child: Row(
                children: [
                  const Icon(Icons.edit),
                  commonHorizontalSpacing(),
                  const Text('Edit Finish'),
                ],
              ),
            )),
        PopupMenuItem<String>(
            value: 'View PDF',
            child: InkWell(
              onTap: (){
                Get.to(() => PDFViewWithWebView(kaizenId: kaizen.kaizenId.toString()));
              },
              child: Row(
                children: [
                  const Icon(Icons.delete_forever_outlined),
                  commonHorizontalSpacing(),
                  const Text('View PDF'),
                ],
              ),
            )),
      ],
      elevation: 8.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return commonStructure(
      context: context,
      bgColor: blackColor,
      appBar: commonAppbar(context: context,title: "Kaizen List"),
      floatingAction: InkWell(
        onTap: (){
          Get.to(() => const AddKaizenFormView());
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
      child: Column(
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
                        KaizenController.to.searchKaizenList.value = KaizenController.to.kaizenList;
                      }else{
                        KaizenController.to.searchKaizenList.value = KaizenController.to.kaizenList.where((p0) => p0.pillarName!.startsWith(value)
                            || p0.requestNo!.toLowerCase().startsWith(value) ||
                            p0.machineDetail!.toLowerCase().startsWith(value) ||
                            p0.companyShortName!.toLowerCase().startsWith(value) ||
                            p0.plantShortName!.toLowerCase().startsWith(value) || p0.theme!.toLowerCase().startsWith(value)).toList();
                      }
                    },
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
                if(KaizenController.to.isKaizenLoading.value){
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                    itemCount: KaizenController.to.searchKaizenList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => kaizenCardView(
                      kaizen: KaizenController.to.searchKaizenList[index]
                    )
                );
              })
            ),
          )
        ],
      )
    );
  }
}
