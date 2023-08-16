import 'dart:convert';

import 'package:get/get.dart';
import 'package:my_projects/models/root_cause_model.dart';

import '../configurations/api_service.dart';
import '../configurations/config_file.dart';
import '../models/kaizen_response_model.dart';
import '../models/team_member_model.dart';
import '../modules/dashboard/kaizen/finish_kaizen_form_view.dart';
import '../utility/common_methods.dart';
import 'package:dio/dio.dart' as dio;

import '../utility/pdf_with_webview.dart';
import 'authentication_controller.dart';

class KaizenController extends GetxController {
  static KaizenController get to => Get.find();

  RxList<KaizenList> kaizenList = RxList<KaizenList>();
  RxList<KaizenList> searchKaizenList = RxList<KaizenList>();
  RxList<String> rootCauseList = RxList<String>();
  RxList<KaizenAnalysis> kaizenAnalysisList = RxList<KaizenAnalysis>();
  RxList<KaizenTeamData> plantMembersList = RxList<KaizenTeamData>();
  RxList<BenifitsData> benifitsData = RxList<BenifitsData>();
  RxBool isKaizenLoading = false.obs;
  RxList<String> kaizenResultArea = RxList<String>();
  RxList<String> kaizenResultInList = RxList<String>();
  Rx<KaizenDetail> kaizenDetail = KaizenDetail().obs;

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
        searchKaizenList.value = List.from(kaizenList);
      },
      error: (dio.Response<dynamic> response) {
        isKaizenLoading.value = false;
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

   void getKaizenResultArea({Function? callback}) {
      apiServiceCall(
        params: {},
        serviceUrl: ApiConfig.getKaizenResultAreaURL,
        success: (dio.Response<dynamic> response) {
          KaizenResultAreaModel kaizenResultAreaModel = KaizenResultAreaModel.fromJson(jsonDecode(response.data));
          kaizenResultArea.value = kaizenResultAreaModel.data?.resultdata?.first ?? [];
          getRootCauses();
          callback!();
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

  Future<void> addKaizenData({AddKaizenModelRequest? addKaizenModelRequest, bool? isEdit}) async {
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
      "team_member_id[]": addKaizenModelRequest?.teamMemberId,
      "root_cause": addKaizenModelRequest?.rootCause,
      "finish_status": addKaizenModelRequest?.finishStatus,
      "manage_user_id": addKaizenModelRequest?.manageUserId,
      "remarks": addKaizenModelRequest?.remarks
    });

    if(isEdit!){
      formData.fields.add(MapEntry("edit_kaizen_id", addKaizenModelRequest?.editKaizenId ?? ""));
    }
    if(addKaizenModelRequest!.presentProblemImage != null){
      formData.files.add(
        MapEntry("present_problem_image", await dio
            .MultipartFile.fromFile(addKaizenModelRequest.presentProblemImage!
            .path)),);
    }

    if(addKaizenModelRequest.countermeasureImage != null){
      formData.files.add(
        MapEntry("countermeasure_image", await dio.MultipartFile.fromFile(addKaizenModelRequest.countermeasureImage!.path)),
      );
    }

    apiServiceCall(
      params: {},
      formValues: formData,
      serviceUrl: ApiConfig.manageKaizenURL,
      success: (dio.Response<dynamic> response) {
        // BooleanResponseModel booleanResponseModel = BooleanResponseModel.fromJson(jsonDecode(response.data));
        showSnackBar(title: ApiConfig.success, message: "Added Successfully");
        Get.back();
        getKaizenListData();
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

  Future<void> finishKaizenForm({KaizenFinishRequestModel? kaizenFinishRequestModel}) async {

    List<String> values = [];
    if(KaizenController.to.kaizenResultInList.contains("Text")){
      values.add("Text");
    }
    if(KaizenController.to.kaizenResultInList.contains("Table")){
      values.add("Table");
    }
    if(KaizenController.to.kaizenResultInList.contains("Chart")){
      values.add("Chart");
    }

    dio.FormData formData = dio.FormData.fromMap({
      "kaizen_id": kaizenFinishRequestModel?.kaizenId,
      "plant_id": kaizenFinishRequestModel?.plantId,
      "pillar_category_id": kaizenFinishRequestModel?.pillarCategoryId,
      "department_id": kaizenFinishRequestModel?.departmentId,
      "plant_short_name": kaizenFinishRequestModel?.plantShortName,
      "pillarname": kaizenFinishRequestModel?.pillarName,
      "department_name": kaizenFinishRequestModel?.departmentName,
      "finish_date": kaizenFinishRequestModel?.finishDate,
      "resultin[]": values.join(','),
      "kaizentheme": kaizenFinishRequestModel?.kaizenTheme,
      "manage_user_id": kaizenFinishRequestModel?..manageUserId
    });

    if(KaizenController.to.kaizenResultInList.contains("Text")){
      formData.fields.add(MapEntry("text_result", kaizenFinishRequestModel?.textResult ?? ""));
    }

    if(KaizenController.to.kaizenResultInList.contains("Table")){
      List<String> allRows = [];
      kaizenFinishRequestModel?.showTableResult?.rows?.forEach((element) {
        allRows.add(element.join(","));
      });
      formData.fields.add(MapEntry("table_result_coloum", kaizenFinishRequestModel?.tableResultColoum ?? ""));
      formData.fields.add(MapEntry("table_result_rows", kaizenFinishRequestModel?.tableResultRows ?? ""));
      formData.fields.add(MapEntry("show_result_tables", jsonEncode({
        "Columns": kaizenFinishRequestModel?.showTableResult?.columns?.join(','),
        "Rows": allRows
      })));
    }
    if(KaizenController.to.kaizenResultInList.contains("Chart")){
      formData.fields.add(MapEntry("chart_title", kaizenFinishRequestModel?.chartTitle ?? ""));
      formData.fields.add(MapEntry("chart_result_x", kaizenFinishRequestModel?.chartResultX ?? ""));
      formData.fields.add(MapEntry("chart_result_y", kaizenFinishRequestModel?.chartResultY ?? ""));
    }

    apiServiceCall(
      params: {},
      formValues: formData,
      serviceUrl: ApiConfig.finishKaizenURL,
      success: (dio.Response<dynamic> response) {
        // BooleanResponseModel booleanResponseModel = BooleanResponseModel.fromJson(jsonDecode(response.data));
        showSnackBar(title: ApiConfig.success, message: "Added Successfully");
        Get.back();
        Get.to(() => PDFViewWithWebView(kaizenId: kaizenFinishRequestModel?.kaizenId.toString() ?? ""));
        getKaizenListData();
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

  void getRootCauses() {
    apiServiceCall(
      params: {
      },
      serviceUrl: ApiConfig.getRootCauseURL,
      success: (dio.Response<dynamic> response) {
        RootCauseModel rootCauseModel = RootCauseModel.fromJson(jsonDecode(response.data));
        rootCauseList.value = rootCauseModel.data!.rootdata!.first;
        getDefaultKaizenAnalysis();
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: false,
      methodType: ApiConfig.methodPOST,
    );
  }

  void getDefaultKaizenAnalysis() {
    kaizenAnalysisList.clear();
    apiServiceCall(
      params: {
        'kaizen_id': 0
      },
      serviceUrl: ApiConfig.getDefaultKaizenAnalysisURL,
      success: (dio.Response<dynamic> response) {
        KaizenAnalysisResponse kaizenAnalysisResponse = KaizenAnalysisResponse.fromJson(jsonDecode(response.data));
        kaizenAnalysisList.addAll(kaizenAnalysisResponse.data!.analysisData ?? []);
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: false,
      methodType: ApiConfig.methodPOST,
    );
  }

  void deleteKaizenBenifits({String? benifitId,kaizenId}) {
    apiServiceCall(
      params: {
        'benifits_id': benifitId
      },
      serviceUrl: ApiConfig.deleteKaizenBenifit,
      success: (dio.Response<dynamic> response) {
        // BooleanResponseModel booleanResponseModel = BooleanResponseModel.fromJson(jsonDecode(response.data));
        getKaizenOtherBenifits(kaizenId: kaizenId);
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

  void deleteKaizenAnalysis({String? analysisId, Function? callback}) {
    apiServiceCall(
      params: {
        'analysis_id': analysisId
      },
      serviceUrl: ApiConfig.deleteKaizenAnalysis,
      success: (dio.Response<dynamic> response) {
        callback!();
        getDefaultKaizenAnalysis();
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

  void deleteKaizenData({String? kaizenId}) {
    apiServiceCall(
      params: {
        'Kaizen_id': kaizenId,
        "manage_user_id": getLoginData()!.userdata?.first.id
      },
      serviceUrl: ApiConfig.deleteKaizenData,
      success: (dio.Response<dynamic> response) {
        getKaizenListData();
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

  void getTeamMembers({String? plantId, String? departmentId, String? subDepartmentId}) {
    apiServiceCall(
      params: {
        "plant_id": plantId,
        "department_id": departmentId,
        "subdepartment_id": subDepartmentId
      },
      serviceUrl: ApiConfig.getTeamMembersURL,
      success: (dio.Response<dynamic> response) {
        TeamMembersResponseModel teamMembersResponseModel = TeamMembersResponseModel.fromJson(jsonDecode(response.data));
        plantMembersList.value = teamMembersResponseModel.data!.kaizenTeamData ?? [];
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: false,
      methodType: ApiConfig.methodPOST,
    );
  }

  void getKaizenDetail({String? kaizenId, Function? callback}) {
    apiServiceCall(
      params: {
        "id": kaizenId
      },
      serviceUrl: ApiConfig.getKaizenDetailURL,
      success: (dio.Response<dynamic> response) {
        KaizenDetailResponse kaizenDetailResponse = KaizenDetailResponse.fromJson(jsonDecode(response.data));
        kaizenDetail.value = kaizenDetailResponse.data!;
        callback!();
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

  void getKaizenOtherBenifits({String? kaizenId, Function? callback}) {
    benifitsData.clear();
    apiServiceCall(
      params: {
        "kaizen_id": kaizenId
      },
      serviceUrl: ApiConfig.getKaizenBenifitsURL,
      success: (dio.Response<dynamic> response) {
        OtherBenifitsResponseModel otherBenifitsResponseModel = OtherBenifitsResponseModel.fromJson(jsonDecode(response.data));
        benifitsData.value = otherBenifitsResponseModel.data!.benifitsData ?? [];
        callback!();
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

  void getManageKaizenBenifits({
    String? kaizenId,
    String? editOtherKaizenId,
    String? otherBenifitsText,
    bool isEdit = false}) {
    Map<String, String> params = {};
    if(isEdit){
      params = {
        "kaizen_benifits_id": editOtherKaizenId!,
        "edit_kaizen_id": kaizenId!,
        "other_benifits": otherBenifitsText ?? ""
      };
    }else{
      params = {
        "edit_kaizen_id": kaizenId!,
        "other_benifits": otherBenifitsText ?? ""
      };
    }
    apiServiceCall(
      params: params,
      serviceUrl: ApiConfig.getManageKaizenBenifitsURL,
      success: (dio.Response<dynamic> response) {
        getKaizenOtherBenifits(kaizenId: kaizenId);
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: false,
      methodType: ApiConfig.methodPOST,
    );
  }
}