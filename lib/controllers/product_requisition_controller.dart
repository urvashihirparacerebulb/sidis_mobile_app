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
  RxList<ProductRequisition> searchProductRequisitionList = RxList<ProductRequisition>();
  RxBool isProductReqLoading = false.obs;
  RxList<String> requisitionTypes = RxList<String>();
  RxList<String> requisitionStatues = RxList<String>();
  RxList<RequiredIn> requiredInData = RxList();

  void getProductRequisitionListData({String selectedFormId = "", bool isFilter = false,String status = "",String user = ""}) {
    productRequisitionList.clear();
    searchProductRequisitionList.clear();
    isProductReqLoading.value = true;
    apiServiceCall(
      params: isFilter ? {
        "user_id": getLoginData()!.userdata!.first.id,
        "group_id": getLoginData()!.userdata!.first.groupId,
        "form_id": selectedFormId,
        "company_id": getLoginData()!.currentPlants!.first.companyId,
        "bussiness_id": getLoginData()!.currentPlants!.first.bussinessId,
        "plant_id": getLoginData()!.currentPlants!.first.plantId,
        "pro_reqstatus": status,
        "pro_requser": user
      } : {
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
        searchProductRequisitionList.value = List.from(productRequisitionList);
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
        getRequisitionRequiredIn();
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: false,
      methodType: ApiConfig.methodPOST,
    );
  }

  void getRequisitionRequiredIn() {
    apiServiceCall(
      params: {
      },
      serviceUrl: ApiConfig.getRequisitionRequiredInURL,
      success: (dio.Response<dynamic> response) {
        RequisitionRequiredInModel requisitionItemResponseModel = RequisitionRequiredInModel.fromJson(jsonDecode(response.data));
        requiredInData.value = requisitionItemResponseModel.data!.requiredInData ?? [];
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: false,
      methodType: ApiConfig.methodPOST,
    );
  }

  Future<void> addProductRequisition({ProductRequisitionRequest? productRequisitionRequest, String? pillarId, bool isEdit = false}) async {
    dio.FormData formData = dio.FormData.fromMap({
      "po_no": productRequisitionRequest?.poNo,
      "user_id": productRequisitionRequest?.userId,
      "requisitiondate": productRequisitionRequest?.requisitionDate,
      "sole_id": productRequisitionRequest?.soleId,
      "department_id": productRequisitionRequest?.departmentId,
      "subdepartment_id": productRequisitionRequest?.subDepartmentId,
      "machine_id": productRequisitionRequest?.machineId,
      "itemid": productRequisitionRequest?.itemId,
      "remarks": productRequisitionRequest?.remarks,
      "otheritem": productRequisitionRequest?.otherItem,
      "requiredin": productRequisitionRequest?.requiredIn,
      "itemdescription": productRequisitionRequest?.itemDescription,
      "quantity": productRequisitionRequest?.quantity
    });
    if(productRequisitionRequest!.productImage != null) {
      formData.files.add(
        MapEntry("productimage", await dio.MultipartFile.fromFile(
            productRequisitionRequest.productImage!.path)),
      );
    }
    
    if(isEdit){
      formData.fields.add(MapEntry("updateid", productRequisitionRequest.updateId ?? ""));
    }
    apiServiceCall(
      params: {},
      formValues: formData,
      serviceUrl: ApiConfig.addProductRequisitionURL,
      success: (dio.Response<dynamic> response) {
        showSnackBar(title: ApiConfig.success, message: "Added Successfully");
        // BooleanResponseModel booleanResponseModel = BooleanResponseModel.fromJson(jsonDecode(response.data));
        Get.back();
        getProductRequisitionListData(selectedFormId: pillarId!);
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: false,
      methodType: ApiConfig.methodPOST,
    );
  }

  void deleteProductRequisition({String? id,selectedFormId}) {
    apiServiceCall(
      params: {
        "id": id,
        "manage_user_id": getLoginData()!.userdata?.first.id
      },
      serviceUrl: ApiConfig.deleteProductRequisitionURL,
      success: (dio.Response<dynamic> response) {
        showSnackBar(title: ApiConfig.success, message: "Deleted Successfully");
        getProductRequisitionListData(selectedFormId: selectedFormId);
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

  void getProductRequisitionDetail({String? requisitionId, Function? callback}) {
    apiServiceCall(
      params: {
        "product_requisition_id": requisitionId,
        "user_id": getLoginData()!.userdata?.first.id
      },
      serviceUrl: ApiConfig.productRequisitionDetailURL,
      success: (dio.Response<dynamic> response) {
        ProductRequisitionDetailResponse productRequisitionDetailResponse = ProductRequisitionDetailResponse.fromJson(jsonDecode(response.data));
        callback!(productRequisitionDetailResponse.data);
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

  void productRequisitionStatuses() {
    apiServiceCall(
      params: {},
      serviceUrl: ApiConfig.getProductRequisitionStatusURL,
      success: (dio.Response<dynamic> response) {
        RequisitionStatusResponseModel requisitionStatusResponseModel = RequisitionStatusResponseModel.fromJson(jsonDecode(response.data));
        requisitionStatues.value = requisitionStatusResponseModel.data!.statusdata!.first;
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: false,
      methodType: ApiConfig.methodPOST,
    );
  }

  void productRequisitionStatusUpdate({String? selectedFormId, selectedStatus, productRequisitionId}) {
    apiServiceCall(
      params: {
        "status_id": selectedStatus,
        "product_requisition_id": productRequisitionId,
        "manage_user_id": getLoginData()!.userdata?.first.id
      },
      serviceUrl: ApiConfig.productRequisitionStatusUpdateURL,
      success: (dio.Response<dynamic> response) {
        getProductRequisitionListData(selectedFormId: selectedFormId!);
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: false,
      methodType: ApiConfig.methodPOST,
    );
  }

}