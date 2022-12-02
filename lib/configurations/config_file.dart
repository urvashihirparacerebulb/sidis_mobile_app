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

  static const String methodPOST = "post";
  static const String methodGET = "get";
  static const String methodPUT = "put";
  static const String methodDELETE = "delete";

  static const String error = "Error";
  static const String success = "Success";
  static const String warning = "Warning";

  static const String loginPref = "loginPref";
}
