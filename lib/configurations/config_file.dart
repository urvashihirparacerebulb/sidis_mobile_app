class ApiConfig {

  // static const String baseURL = "https://sidis.cerebulb.com/api/";
  static const String baseURL = "http://sidis.skapsindia.com/test/api/";
  static const String loginURL = "${baseURL}ajax-login";
  static const String businessListURL = "${baseURL}fetch-bussiness";
  static const String plantsListURL = "${baseURL}fetch-plant-bussiness";
  static const String machineListURL = "${baseURL}fetch-machine";
  static const String subMachineListURL = "${baseURL}fetch-sub-machine";
  static const String activityListURL = "${baseURL}activity-check-list";
  static const String intervalListURL = "${baseURL}interval-list";
  static const String departmentListURL = "${baseURL}fetch-department";
  static const String subDepartmentListURL = "${baseURL}fetch-sub-department";
  static const String getAbnormalityGraphURL = "${baseURL}get-dashboard-abnormality-data";
  static const String getKaizenGraphURL = "${baseURL}get-dashboard-kaizen-data";
  static const String getAbnormalityTypeURL = "${baseURL}get-abnormality-type";
  static const String addNewAbnormalityURL = "${baseURL}manage-abnormality";
  static const String abnormalityListURL = "${baseURL}fetch-abnormality";
  static const String getPartDataURL = "${baseURL}get-part-data";
  static const String getAbnormalityDetailURL = "${baseURL}get-abnormality";
  static const String getPillarListURL = "${baseURL}get-pillar-list";
  static const String getPillarFormURL = "${baseURL}get-pillar-form";
  static const String getKaizenListURL = "${baseURL}fetch-kaizen";
  static const String getProductRequisitionURL = "${baseURL}fetch-product-requisition";
  static const String getRequisitionItemTypeURL = "${baseURL}get-requisition-item-type";
  static const String getRequisitionRequiredInURL = "${baseURL}get-requisition-required-in";
  static const String addProductRequisitionURL = "${baseURL}manage-product-requisition";
  static const String getKaizenResultAreaURL = "${baseURL}get-kaizen-result-area";
  static const String manageKaizenAnalysisURL = "${baseURL}manage-kaizen-analysis";
  static const String manageKaizenURL = "${baseURL}manage-kaizen";
  static const String getRootCauseURL = "${baseURL}get-kaizen-root-cause";
  static const String getTeamMembersURL = "${baseURL}get-plant-users";
  static const String getKaizenBenifitsURL = "${baseURL}fetch-kaizen-benifits";
  static const String getManageKaizenBenifitsURL = "${baseURL}manage-kaizen-benifits";
  static const String getDefaultKaizenAnalysisURL = "${baseURL}fetch-kaizen-analysis";
  static const String deleteKaizenBenifit = "${baseURL}delete-kaizen-benifits";
  static const String deleteKaizenAnalysis = "${baseURL}delete-kaizen-analysis";
  static const String needleRecordListURL = "${baseURL}get-needlerecord-fetch";
  static const String needleBoardNumberURL = "${baseURL}ajax-get-board_number";
  static const String needleChangeStatusURL = "${baseURL}needles-changed-status";
  static const String manageNeedleRecordURL = "${baseURL}ajax-insert-needleboard";
  static const String getLinesURL = "${baseURL}fetch-line";
  static const String getLoomsURL = "${baseURL}fetch-looms";
  static const String getMachineLocationURL = "${baseURL}ajax-get-machine-location";

  static const String methodPOST = "post";
  static const String methodGET = "get";
  static const String methodPUT = "put";
  static const String methodDELETE = "delete";

  static const String error = "Error";
  static const String success = "Success";
  static const String warning = "Warning";

  static const String loginPref = "loginPref";
}
