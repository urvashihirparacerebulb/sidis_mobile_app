import 'package:get/get.dart';
import 'package:my_projects/controllers/general_controller.dart';
import '../authentication_controller.dart';
import '../dropdown_data_controller.dart';

class AppBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.put<AuthenticationController>(AuthenticationController(),
        permanent: true);
    Get.put<GeneralController>(GeneralController(),
        permanent: true);
    Get.put<DropDownDataController>(DropDownDataController(),
        permanent: true);
  }
}
