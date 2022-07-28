class PlantsResponseModel {
  PlantsResponseModel({
    this.companyBusinessPlants,
  });

  List<CompanyBusinessPlant>? companyBusinessPlants;

  factory PlantsResponseModel.fromJson(Map<String, dynamic> json) => PlantsResponseModel(
    companyBusinessPlants: List<CompanyBusinessPlant>.from(json["COMPANY_BUSINESS_PLANTS"].map((x) => CompanyBusinessPlant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "COMPANY_BUSINESS_PLANTS": companyBusinessPlants == null ? [] : List<dynamic>.from(companyBusinessPlants!.map((x) => x.toJson())),
  };
}

class CompanyBusinessPlant {
  CompanyBusinessPlant({
    this.soleId,
    this.soleName,
  });

  String? soleId;
  String? soleName;

  factory CompanyBusinessPlant.fromJson(Map<String, dynamic> json) => CompanyBusinessPlant(
    soleId: json["sole_id"],
    soleName: json["sole_name"],
  );

  Map<String, dynamic> toJson() => {
    "sole_id": soleId,
    "sole_name": soleName,
  };
}
