import 'package:get/get.dart';

class GeneralController extends GetxController {
  static GeneralController get to => Get.find();

  RxBool isDarkMode = false.obs;
}