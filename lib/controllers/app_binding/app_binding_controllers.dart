import 'package:get/get.dart';
import 'package:my_projects/controllers/business_controller.dart';
import 'package:my_projects/controllers/general_controller.dart';
import 'package:my_projects/controllers/part_controller.dart';
import '../abnormality_controller.dart';
import '../authentication_controller.dart';
import '../dashboard_controller.dart';
import '../department_controller.dart';
import '../dropdown_data_controller.dart';
import '../kaizen_controller.dart';
import '../product_requisition_controller.dart';

class AppBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.put<AuthenticationController>(AuthenticationController(),
        permanent: true);
    Get.put<GeneralController>(GeneralController(),
        permanent: true);
    Get.put<DropDownDataController>(DropDownDataController(),
        permanent: true);
    Get.put<BusinessController>(BusinessController(),
        permanent: true);
    Get.put<DepartmentController>(DepartmentController(),
        permanent: true);
    Get.put<AbnormalityController>(AbnormalityController(),
        permanent: true);
    Get.put<PartController>(PartController(),
        permanent: true);
    Get.put<DashboardController>(DashboardController(),
        permanent: true);
    Get.put<KaizenController>(KaizenController(),
        permanent: true);
    Get.put<ProductRequisitionController>(ProductRequisitionController(),
        permanent: true);
  }
}
