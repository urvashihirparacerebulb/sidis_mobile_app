import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common_widgets/common_widget.dart';
import '../../../utility/assets_utility.dart';
import '../../../utility/common_methods.dart';
import '../../../utility/constants.dart';
import '../abnormality_form/add_abnormaliry_view.dart';
import '../assigned_form/add_assigned_form_view.dart';
import '../clita module/add_clita_fill_form_view.dart';
import '../clita module/add_clita_no_list_view.dart';

class ListDashboardView extends StatefulWidget {
  const ListDashboardView({Key? key}) : super(key: key);

  @override
  State<ListDashboardView> createState() => _ListDashboardViewState();
}

class _ListDashboardViewState extends State<ListDashboardView> {

  ExactAssetImage getMenuIcon(int index) {
    switch (index) {
      case 0:
        return dashboardIconImage;
      case 1:
        return clitaFillFormImage;
      case 2:
        return clitaNoListImage;
      case 3:
        return abnormalityFormImage;
      case 4:
        return assignedFormImage;
      case 5:
        return kaizenFormImage;
      default:
        return dashboardImage;
    }
  }

  commonCardView({String title = "",int? index}){
    return commonNeumorphicView(
      child: InkWell(
        onTap: (){
          if(title == clitaFillFormText){
            Get.to(() => const CLITAFillFormView());
          }
          if(title == clitaNoListText){
            Get.to(() => const CLITANoListView());
          }
          if(title == abnormalityFormText){
            Get.to(() => const AddAbnormalityFormView());
          }
          if(title == assignedFormText){
            Get.to(() => const AddAssignedFormView());
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Image(image: getMenuIcon(index!)),
              ),
              commonVerticalSpacing(spacing: 20),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: commonHeaderTitle(title: title,
                    fontSize: 1.1,fontWeight: 2),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return commonStructure(
      context: context,
      appBar: commonAppbar(context: context,title: "JH"),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            GridView.builder(
              itemCount: getLoginData() == null ? 0 : getLoginData()!.allMenus?.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 16/9,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  crossAxisCount: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                return commonCardView(index: index, title: getLoginData()!.allMenus?[index].menuName ?? "");
              },
            ),

            Positioned(
              bottom: 20,
              right: 10,left: 10,
              child: Container(
                height: 65,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: watermarkImage,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
