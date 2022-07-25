import 'package:get/get.dart';
import '../authentication_controller.dart';

class AppBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.put<AuthenticationController>(AuthenticationController(),
        permanent: true);
  }
}
