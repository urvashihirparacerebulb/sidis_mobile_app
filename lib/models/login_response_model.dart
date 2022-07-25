import 'dart:convert';

LoginResponseModel welcomeFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String welcomeToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
    this.userdata,
    this.currentPlants,
    this.allAssignedPlants,
    this.allMenus,
    this.res,
    this.status,
    this.message,
  });

  List<User>? userdata;
  List<Plant>? currentPlants;
  List<Plant>? allAssignedPlants;
  List<AllMenu>? allMenus;
  String? res;
  bool? status;
  String? message;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    userdata: List<User>.from(json["userdata"].map((x) => User.fromJson(x))),
    currentPlants: List<Plant>.from(json["current_plants"].map((x) => Plant.fromJson(x))),
    allAssignedPlants: List<Plant>.from(json["all_assigned_plants"].map((x) => Plant.fromJson(x))),
    allMenus: List<AllMenu>.from(json["all_menus"].map((x) => AllMenu.fromJson(x))),
    res: json["res"],
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "userdata": userdata == null ? [] : List<dynamic>.from(userdata!.map((x) => x.toJson())),
    "current_plants": currentPlants == null ? [] : List<dynamic>.from(currentPlants!.map((x) => x.toJson())),
    "all_assigned_plants": allAssignedPlants == null ? [] : List<dynamic>.from(allAssignedPlants!.map((x) => x.toJson())),
    "all_menus": allMenus == null ? [] :  List<dynamic>.from(allMenus!.map((x) => x.toJson())),
    "res": res,
    "status": status,
    "message": message,
  };
}

class Plant {
  Plant({
    this.companyId,
    this.bussinessId,
    this.plantId,
    this.name,
  });

  int? companyId;
  int? bussinessId;
  int? plantId;
  String? name;

  factory Plant.fromJson(Map<String, dynamic> json) => Plant(
    companyId: json["company_id"],
    bussinessId: json["bussiness_id"],
    plantId: json["plant_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "company_id": companyId,
    "bussiness_id": bussinessId,
    "plant_id": plantId,
    "name": name,
  };
}

class AllMenu {
  AllMenu({
    this.menuId,
    this.menuName,
    this.menuLink,
    this.menuIcon,
  });

  int? menuId;
  String? menuName;
  String? menuLink;
  String? menuIcon;

  factory AllMenu.fromJson(Map<String, dynamic> json) => AllMenu(
    menuId: json["menu_id"],
    menuName: json["menu_name"],
    menuLink: json["menu_link"],
    menuIcon: json["menu_icon"],
  );

  Map<String, dynamic> toJson() => {
    "menu_id": menuId,
    "menu_name": menuName,
    "menu_link": menuLink,
    "menu_icon": menuIcon,
  };
}

class User {
  User({
    this.username,
    this.sessionName,
    this.id,
    this.groupId,
    this.groupName,
    this.title,
    this.loggedIn,
  });

  String? username;
  String? sessionName;
  int? id;
  int? groupId;
  String? groupName;
  String? title;
  int? loggedIn;

  factory User.fromJson(Map<String, dynamic> json) => User(
    username: json["username"],
    sessionName: json["session_name"],
    id: json["id"],
    groupId: json["group_id"],
    groupName: json["group_name"],
    title: json["title"],
    loggedIn: json["logged_in"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "session_name": sessionName,
    "id": id,
    "group_id": groupId,
    "group_name": groupName,
    "title": title,
    "logged_in": loggedIn,
  };
}
