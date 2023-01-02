import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_projects/modules/dashboard/product_requisition/product_requisition_list.dart';
import '../../../common_widgets/common_widget.dart';
import '../../../controllers/dashboard_controller.dart';
import '../../../models/pillar_data_model.dart';
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
  final PillarResponse pillarCat;
  const ListDashboardView({Key? key, required this.pillarCat}) : super(key: key);

  @override
  State<ListDashboardView> createState() => _ListDashboardViewState();
}

class _ListDashboardViewState extends State<ListDashboardView> {

  @override
  void initState() {
    DashboardController.to.getPillarForm(selectedPillarId: widget.pillarCat.pillarCategoryId);
    super.initState();
  }

  // ExactAssetImage getMenuIcon(int index) {
  //   switch (index) {
  //     case 0:
  //       return dashboardIconImage;
  //     case 1:
  //       return clitaFillFormImage;
  //     case 2:
  //       return clitaNoListImage;
  //     case 3:
  //       return abnormalityFormImage;
  //     case 4:
  //       return assignedFormImage;
  //     case 5:
  //       return kaizenFormImage;
  //     default:
  //       return dashboardIconImage;
  //   }
  // }

  commonCardView({PillarForm? pillarForm}){
    return commonNeumorphicView(
      child: InkWell(
        onTap: (){
          if(pillarForm!.name == clitaFillFormText){
            Get.to(() => const CLITAFillFormView());
          }
          if(pillarForm.name == clitaActivityListText){
            Get.to(() => const CLITActivityListFormScreen());
          }
          if(pillarForm.name == clitaNoListText){
            Get.to(() => const CLITANoListView());
          }
          if(pillarForm.name == abnormalityFormText){
            Get.to(() => const AbnormalityListView());
          }
          if(pillarForm.name == assignedFormText){
            Get.to(() => const AddAssignedFormView());
          }
          if(pillarForm.name == kaizenFormText){
            Get.to(() => const KaizenListView());
          }
          if(pillarForm.name == needleRecordFormText){
            Get.to(() => const NeedleRecordFormList());
          }
          if(pillarForm.name == needleBoardText){
            Get.to(() => const NeedleBoardList());
          }
          if(pillarForm.name == productRequisitionText){
            Get.to(() => ProductRequisitionList(pillarForm: pillarForm));
          }
          if(pillarForm.name == "Ampere Log"){
            Get.to(() => const AmpereLogListView());
          }
          if(pillarForm.name == "Project Management"){
            Get.to(() => const ProjectManagementListView());
          }
        },
        child: Padding(
          padding: EdgeInsets.all(isTablet() ? 25 : 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: isTablet() ? 10 : 5),
                child: SvgPicture.string(pillarForm!.icon!,height: isTablet() ? 50 : 30,width: isTablet() ? 50 : 40,fit: BoxFit.contain)
                // Image(image: getMenuIcon(index!), height: isTablet() ? 50 : 30,
                //     width: isTablet() ? 50 : 40,fit: BoxFit.contain),
              ),
              commonVerticalSpacing(spacing: isTablet() ? 25 : 20),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: commonHeaderTitle(title: pillarForm.name ?? "",
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
      appBar: commonAppbar(context: context,title: widget.pillarCat.pillarName ?? ""),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
        child: Obx((){
          if(DashboardController.to.isLoadingForForm.value){
            return const Center(child: CircularProgressIndicator());
          }
          return GridView.builder(
            itemCount: DashboardController.to.pillarForms.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: isTablet() ? 20/9 : 16/10,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              crossAxisCount: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              return commonCardView(pillarForm: DashboardController.to.pillarForms[index]);
            },
          );
        }),
      )
    );
  }
}
