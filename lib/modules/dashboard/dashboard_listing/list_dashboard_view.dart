import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_projects/modules/dashboard/product_requisition/product_requisition_list.dart';

import '../../../common_widgets/common_widget.dart';
import '../../../utility/assets_utility.dart';
import '../../../utility/common_methods.dart';
import '../../../utility/constants.dart';
import '../../../utility/screen_utility.dart';
import '../abnormality_form/abnormality_list_view.dart';
import '../ampere_log/ampere_log_list_view.dart';
import '../assigned_form/add_assigned_form_view.dart';
import '../clita module/add_clita_activity_list_view.dart';
import '../clita module/add_clita_fill_form_view.dart';
import '../clita module/add_clita_no_list_view.dart';
import '../kaizen/kaizen_list.dart';
import '../needle/needle_board_list.dart';
import '../needle/needle_record_form_list.dart';
import '../project_management/project_management_list.dart';

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
        return dashboardIconImage;
    }
  }

  commonCardView({String title = "",int? index}){
    return commonNeumorphicView(
      child: InkWell(
        onTap: (){
          if(title == clitaFillFormText){
            Get.to(() => const CLITAFillFormView());
          }
          if(title == clitaActivityListText){
            Get.to(() => const CLITActivityListFormScreen());
          }
          if(title == clitaNoListText){
            Get.to(() => const CLITANoListView());
          }
          if(title == abnormalityFormText){
            Get.to(() => const AbnormalityListView());
          }
          if(title == assignedFormText){
            Get.to(() => const AddAssignedFormView());
          }
          if(title == kaizenFormText){
            Get.to(() => const KaizenListView());
          }
          if(title == needleRecordFormText){
            Get.to(() => const NeedleRecordFormList());
          }
          if(title == needleBoardText){
            Get.to(() => const NeedleBoardList());
          }
          if(title == productRequisitionText){
            Get.to(() => const ProductRequisitionList());
          }
          if(title == "Ampere Log"){
            Get.to(() => const AmpereLogListView());
          }
          if(title == "Project Management"){
            Get.to(() => const ProjectManagementListView());
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: isTablet() ? 10 : 5),
                child: Image(image: getMenuIcon(index!), height: isTablet() ? 50 : 30,width: isTablet() ? 50 : 40,fit: BoxFit.contain),
              ),
              commonVerticalSpacing(spacing: isTablet() ? 25 : 20),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: commonHeaderTitle(title: title,
                    fontSize: isTablet() ? 1.5 : 1.1,fontWeight: 2),
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
        child: GridView.builder(
          itemCount: getLoginData() == null ? 0 : (getLoginData()!.allMenus?.length)! + 2,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: isTablet() ? 20/9 : 16/10,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              crossAxisCount: 2,
          ),
          itemBuilder: (BuildContext context, int index) {
            return commonCardView(index: index, title: index == getLoginData()!.allMenus?.length ? "Ampere Log" : (index == (getLoginData()!.allMenus?.length)! + 1) ? "Project Management" : getLoginData()!.allMenus?[index].menuName ?? "");
          },
        ),
      )
    );
  }
}
