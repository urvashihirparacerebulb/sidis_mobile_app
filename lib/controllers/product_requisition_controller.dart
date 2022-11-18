import 'dart:convert';

import 'package:get/get.dart';
import 'package:my_projects/modules/dashboard/product_requisition/add_product_requisition_view.dart';

import '../configurations/api_service.dart';
import '../configurations/config_file.dart';
import '../models/product_requisition_response_model.dart';
import '../utility/common_methods.dart';
import 'package:dio/dio.dart' as dio;

import 'authentication_controller.dart';

class ProductRequisitionController extends GetxController {
  static ProductRequisitionController get to => Get.find();

  RxList<ProductRequisition> productRequisitionList = RxList<ProductRequisition>();
  RxBool isProductReqLoading = false.obs;
  RxList<String> requisitionTypes = RxList<String>();

  void getProductRequisitionListData({String selectedFormId = ""}) {
    isProductReqLoading.value = true;
    apiServiceCall(
      params: {
        "user_id": getLoginData()!.userdata!.first.id,
        "group_id": getLoginData()!.userdata!.first.groupId,
        "form_id": selectedFormId,
        "company_id": getLoginData()!.currentPlants!.first.companyId,
        "bussiness_id": getLoginData()!.currentPlants!.first.bussinessId,
        "plant_id": getLoginData()!.currentPlants!.first.plantId
      },
      serviceUrl: ApiConfig.getProductRequisitionURL,
      success: (dio.Response<dynamic> response) {
        ProductRequisitionResponseModel productRequisitionResponseModel = ProductRequisitionResponseModel.fromJson(jsonDecode(response.data));
        isProductReqLoading.value = false;
        productRequisitionList.value = productRequisitionResponseModel.data!.data!;
      },
      error: (dio.Response<dynamic> response) {
        isProductReqLoading.value = false;
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

  void getRequisitionType({String selectedFormId = ""}) {
    apiServiceCall(
      params: {
      },
      serviceUrl: ApiConfig.getRequisitionItemTypeURL,
      success: (dio.Response<dynamic> response) {
        RequisitionItemResponseModel requisitionItemResponseModel = RequisitionItemResponseModel.fromJson(jsonDecode(response.data));
        requisitionTypes.value = requisitionItemResponseModel.data!.typedata!.first;
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: false,
      methodType: ApiConfig.methodPOST,
    );
  }

  Future<void> addProductRequisition({ProductRequisitionRequest? productRequisitionRequest}) async {
    dio.FormData formData = dio.FormData.fromMap({
      "user_id": productRequisitionRequest?.userId,
      "requisitiondate": productRequisitionRequest?.requisitionDate,
      "sole_id": productRequisitionRequest?.soleId,
      "department_id": productRequisitionRequest?.departmentId,
      "subdepartment_id": productRequisitionRequest?.subDepartmentId,
      "machine_id": productRequisitionRequest?.machineId,
      "itemid": productRequisitionRequest?.itemId,
      "otheritem": productRequisitionRequest?.otherItem,
      "requiredin": productRequisitionRequest?.requiredIn,
      "itemdescription": productRequisitionRequest?.itemDescription,
      "quantity": productRequisitionRequest?.quantity
    });
    formData.files.add(
        MapEntry("productimage", await dio.MultipartFile.fromFile(productRequisitionRequest!.productImage!.path)),
    );
    apiServiceCall(
      params: {},
      formValues: formData,
      serviceUrl: ApiConfig.addProductRequisitionURL,
      success: (dio.Response<dynamic> response) {
        // BooleanResponseModel booleanResponseModel = BooleanResponseModel.fromJson(jsonDecode(response.data));
        Get.back();
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: false,
      methodType: ApiConfig.methodPOST,
    );
  }

}