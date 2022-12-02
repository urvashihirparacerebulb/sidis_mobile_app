import 'dart:convert';

import 'package:get/get.dart';

import '../configurations/api_service.dart';
import '../configurations/config_file.dart';
import '../models/kaizen_response_model.dart';
import '../utility/common_methods.dart';
import 'package:dio/dio.dart' as dio;

import 'authentication_controller.dart';

class KaizenController extends GetxController {
  static KaizenController get to => Get.find();

  RxList<KaizenList> kaizenList = RxList<KaizenList>();
  RxList<KaizenAnalysis> kaizenAnalysisList = RxList<KaizenAnalysis>();
  RxBool isKaizenLoading = false.obs;
  RxList<String> kaizenResultArea = RxList<String>();

  void getKaizenListData() {
    isKaizenLoading.value = true;
    apiServiceCall(
      params: {
        "user_id": getLoginData()!.userdata!.first.id,
        "group_id": getLoginData()!.userdata!.first.groupId
      },
      serviceUrl: ApiConfig.getKaizenListURL,
      success: (dio.Response<dynamic> response) {
        KaizenResponseModel kaizenResponseModel = KaizenResponseModel.fromJson(jsonDecode(response.data));
        isKaizenLoading.value = false;
        kaizenList.value = kaizenResponseModel.data!.data!;
      },
      error: (dio.Response<dynamic> response) {
        isKaizenLoading.value = false;
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

   void getKaizenResultArea() {
      apiServiceCall(
        params: {},
        serviceUrl: ApiConfig.getKaizenResultAreaURL,
        success: (dio.Response<dynamic> response) {
          KaizenResultAreaModel kaizenResultAreaModel = KaizenResultAreaModel.fromJson(jsonDecode(response.data));
          kaizenResultArea.value = kaizenResultAreaModel.data?.resultdata?.first ?? [];
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST,
      );
    }

  void addManageKaizenAnalysis({String? kaizenId, why,answer, bool isEdit = false, String? kaizenAnalysisId,int? index}) {
    Map<String, dynamic> mappingParam = {};
    if(isEdit){
      mappingParam = {
        "why": why,
        "answer": answer,
        "kaizen_analysis_id": kaizenAnalysisId
      };
    }else{
      mappingParam = {
        "kaizen_id" : kaizenId,
        "why": why,
        "answer": answer,
      };
    }
    apiServiceCall(
      params: mappingParam,
      serviceUrl: ApiConfig.manageKaizenAnalysisURL,
      success: (dio.Response<dynamic> response) {
        String decodedString = jsonDecode(response.data);
        var replacingString = decodedString.replaceAll("\"{", "{");
        var endString = replacingString.replaceAll('}"', "}");
        KaizenAnalysisModel kaizenAnalysisModel = KaizenAnalysisModel.fromJson(jsonDecode(endString));
        if(isEdit){
          kaizenAnalysisList[index!] = kaizenAnalysisModel.data!;
        }else {
          kaizenAnalysisList.add(kaizenAnalysisModel.data!);
        }
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

  Future<void> addKaizenData({AddKaizenModelRequest? addKaizenModelRequest}) async {
    dio.FormData formData = dio.FormData.fromMap({
      "pillar_category_id": addKaizenModelRequest?.pillarCategoryId,
      "sole_id": addKaizenModelRequest?.soleId,
      "department_id": addKaizenModelRequest?.departmentId,
      "subdepartment_id": addKaizenModelRequest?.subDepartmentId,
      "machine_id": addKaizenModelRequest?.machineId,
      "loss_no_step": addKaizenModelRequest?.lossNoStep,
      "result_area": addKaizenModelRequest?.resultArea,
      "kaizen_theme": addKaizenModelRequest?.kaizenTheme,
      "kaizen_idea": addKaizenModelRequest?.kaizenIdea,
      "present_problem": addKaizenModelRequest?.presentProblem,
      "countermeasure": addKaizenModelRequest?.countermeasure,
      "bench_mark": addKaizenModelRequest?.benchMark,
      "target": addKaizenModelRequest?.target,
      "start_date": addKaizenModelRequest?.startDate,
      "team_member_id": addKaizenModelRequest?.teamMemberId,
      "root_cause": addKaizenModelRequest?.rootCause,
      "finish_status": addKaizenModelRequest?.finishStatus,
      "manage_user_id": addKaizenModelRequest?.manageUserId,
      "edit_kaizen_id": addKaizenModelRequest?.editKaizenId,
      "remarks": addKaizenModelRequest?.remarks
    });
    formData.files.add(
      MapEntry("present_problem_image", await dio.MultipartFile.fromFile(addKaizenModelRequest!.presentProblemImage!.path)),
    );
    formData.files.add(
      MapEntry("countermeasure_image", await dio.MultipartFile.fromFile(addKaizenModelRequest.countermeasureImage!.path)),
    );
    apiServiceCall(
      params: {},
      formValues: formData,
      serviceUrl: ApiConfig.manageKaizenURL,
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