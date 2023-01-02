import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_projects/controllers/needle_controller.dart';
import 'package:my_projects/utility/constants.dart';
import '../../../common_widgets/common_widget.dart';
import '../../../configurations/config_file.dart';
import '../../../controllers/business_controller.dart';
import '../../../controllers/dropdown_data_controller.dart';
import '../../../models/business_data_model.dart';
import '../../../models/needle_response_model.dart';
import '../../../models/plants_response_model.dart';
import '../../../textfields/board_textfiled.dart';
import '../../../textfields/business_textfiled.dart';
import '../../../textfields/line_bottom_textfield.dart';
import '../../../textfields/looms_bottom_textfield.dart';
import '../../../textfields/plants_textfield.dart';
import '../../../theme/convert_theme_colors.dart';
import '../../../utility/color_utility.dart';
import '../../../utility/common_methods.dart';
import '../../../utility/screen_utility.dart';

class AddNeedleBoardView extends StatefulWidget {
  const AddNeedleBoardView({Key? key}) : super(key: key);

  @override
  State<AddNeedleBoardView> createState() => _AddNeedleBoardViewState();
}

class _AddNeedleBoardViewState extends State<AddNeedleBoardView> {

  BusinessData? selectedBusiness;
  CompanyBusinessPlant? selectedPlant;
  TextEditingController needleConsumedController = TextEditingController();
  LineData? selectedLine;
  LoomsData? selectedLoom;
  LocationData? selectedMachineLocation;
  String selectedDate = DateFormat("dd-MM-yyyy hh:mm").format(DateTime.now());
  final RxString _selectedGender = "1".obs;

  @override
  void initState() {
    if (BusinessController.to.businessData!.isEmpty) {
      BusinessController.to.getBusinesses();
    }
    super.initState();
  }

  boardFormView(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: (){
            commonBottomView(context: context,child: BusinessBottomView(myItems: BusinessController.to.businessData!,selectionCallBack: (BusinessData business){
              selectedBusiness = business;
              selectedPlant = null;
              setState(() {});
              if(selectedBusiness?.businessId != null) {
                DropDownDataController.to.getCompanyPlants(businessId: selectedBusiness?.businessId.toString(),successCallback: (){
                  // getActivityList();
                });
              }
            }));
          },
          child: commonDecoratedTextView(
              title: selectedBusiness?.businessId == null ? "Select Business" : selectedBusiness?.businessName ?? "",
              isChangeColor: selectedBusiness?.businessId == null ? true : false
          ),
        ),
        InkWell(
            onTap: (){
              if(selectedBusiness?.businessId != null) {
                commonBottomView(context: context,
                    child: PlantBottomView(
                        myItems: DropDownDataController.to
                            .companyBusinessPlants!,
                        businessId: selectedBusiness!.businessId.toString(),
                        selectionCallBack: (
                            CompanyBusinessPlant plant) {
                          selectedPlant = plant;
                          setState(() {});
                          if(selectedBusiness != null && selectedPlant != null){
                            List<String> ids = selectedPlant!.soleId!.split(" - ");
                            // business plant seq changed due to backend
                            NeedleController.to.getLines(
                              companyId: ids.first,
                              businessId: ids.last,
                              plantId: ids[1]
                            );
                          }
                        }));
              }
            },
            child: commonDecoratedTextView(
              title: selectedPlant == null ? "Select Plant" : selectedPlant!.soleName ?? "",
              isChangeColor: selectedPlant == null ? true : false,
            )
        ),

        InkWell(
          onTap: (){
            commonBottomView(context: context,child: LineBottomView(myItems: NeedleController.to.lineDataList,selectionCallBack: (LineData lineData){
              selectedLine = lineData;
              if(selectedLine != null){
                List<String> ids = selectedPlant!.soleId!.split(" - ");
                NeedleController.to.getLoomsByLine(
                  companyId: ids.first,
                  businessId: ids.last,
                  plantId: ids[1],
                  lineId: selectedLine!.lineId.toString()
                );
              }
              setState(() {});
            }));
          },
          child: commonDecoratedTextView(
              title: selectedLine?.lineId == null ? "Select Line * " : selectedLine?.lineNo ?? "",
              isChangeColor: selectedLine?.lineId == null ? true : false
          ),
        ),

        InkWell(
          onTap: (){
            commonBottomView(context: context,child: LoomsBottomView(myItems: NeedleController.to.loomsDataList,selectionCallBack: (LoomsData loomData){
              selectedLoom = loomData;
              if(selectedLoom != null && selectedLine != null){
                List<String> ids = selectedPlant!.soleId!.split(" - ");
                NeedleController.to.getMachineLocations(
                  lineId: selectedLine!.lineId.toString(),
                  loomID: selectedLoom!.loopsId.toString(),
                  companyId: ids.first,
                  businessId: ids.last,
                  plantId: ids[1],
                  date: selectedDate
                );
              }
              setState(() {});
            }));
          },
          child: commonDecoratedTextView(
              title: selectedLoom?.loopsId == null ? "Select Looms * " : selectedLoom?.loopsNo ?? "",
              isChangeColor: selectedLoom?.loopsId == null ? true : false
          ),
        ),

        Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: commonHorizontalPadding),
            decoration: neurmorphicBoxDecoration,
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: commonHeaderTitle(
                        fontSize: isTablet() ? 1.3 : 1,
                        title: selectedDate.isEmpty ? "Date Time" : selectedDate)
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        openCalendarView(
                          context,
                          initialDate: DateTime.now().toString(),
                        ).then((value) {
                          setState(() {
                            selectedDate = DateFormat("dd-MM-yyyy hh:mm").format(value);
                          });
                        });
                      },
                      child: Icon(Icons.calendar_month, color: blackColor.withOpacity(0.4)),
                    )),
              ],
            )),
        commonVerticalSpacing(spacing: 30),
        Align(
          alignment: Alignment.centerLeft,
          child: commonHeaderTitle(title: "Did You Changed Needle Board?",color: blackColor,fontSize: 1.2,fontWeight: 1,align: TextAlign.start),
        ),
        commonVerticalSpacing(spacing: 10),
        SizedBox(
          height: 50,
          width: getScreenWidth(context) - 40,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ListTile(
                  leading: Obx(() => Radio<String>(
                    value: '1',
                    groupValue: _selectedGender.value,
                    activeColor: primaryColor,
                    onChanged: (value) {
                      _selectedGender.value = value!;
                    },
                  )),
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text('Yes'),
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: Obx(() => Radio<String>(
                    value: '2',
                    groupValue: _selectedGender.value,
                    activeColor: primaryColor,
                    onChanged: (value) {
                      _selectedGender.value = value!;
                    },
                  )),
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text('No'),
                ),
              ),
            ],
          ),
        ),
        commonVerticalSpacing(spacing: 20),
        Visibility(
          visible: NeedleController.to.machineLocationList.isNotEmpty,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                commonHeaderTitle(
                    title: "Location",
                    color: blackColor,
                    align: TextAlign.start,
                    fontWeight: 1,
                    fontSize: 1.3,
                    isChangeColor: true
                )
              ],
            )
        ),
        commonVerticalSpacing(spacing: 20),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: NeedleController.to.machineLocationList.length,
          itemBuilder: (context, index) {
          return Container(
            decoration: neurmorphicBoxDecoration,
            padding: const EdgeInsets.all(16),
            child: StatefulBuilder(
              builder: (context, newSetState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonHeaderTitle(title: NeedleController.to.machineLocationList[index].locationLabel ?? "",color: blackColor,fontSize: 1.2,fontWeight: 1,align: TextAlign.start),
                    commonVerticalSpacing(spacing: 20),
                    commonHeaderTitle(title: "Old Needle Board Number Which you are swapping? *",color: blackColor,fontSize: 1.2,fontWeight: 1,align: TextAlign.start),
                    commonVerticalSpacing(),
                    InkWell(
                      onTap: (){
                        commonBottomView(context: context,child: BoardBottomView(myItems: NeedleController.to.machineLocationList[index].oldBoard ?? [],selectionCallBack: (NeedleBoardNumber board){
                          if(!NeedleController.to.locationIds.contains(NeedleController.to.machineLocationList[index].locationId)) {
                            NeedleController.to.locationIds.add(
                                NeedleController.to.machineLocationList[index]
                                    .locationId ?? "");
                          }
                          if(NeedleController.to.machineLocationList[index].selectedOldBoard == null){
                            SelectedLocationBoardReq selectedBoard = SelectedLocationBoardReq();
                            selectedBoard.index = index;
                            selectedBoard.selectedNewBoard = [];
                            selectedBoard.selectedOldBoard = [];
                            selectedBoard.selectedOldBoard!.add(board);
                            NeedleController.to.machineLocationList[index].selectedOldBoard = selectedBoard;
                          }else{
                            NeedleController.to.machineLocationList[index].selectedOldBoard!.index = index;
                            NeedleController.to.machineLocationList[index].selectedOldBoard!.selectedOldBoard!.add(board);
                          }
                          newSetState((){});
                        }));
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          commonDecoratedTextView(
                            title: "Select old board needle number",
                            isChangeColor: true,
                          ),
                          Obx(() => Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            runAlignment: WrapAlignment.start,
                            children: NeedleController.to.machineLocationList[index].selectedOldBoard == null ? [] : NeedleController.to.machineLocationList[index].selectedOldBoard!.selectedOldBoard!.map((i) => Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                              child: Text('${i.boardNo}',style: const TextStyle(
                                  color: blackColor,
                                  fontSize: 14
                              )),
                            )).toList(),
                          )),
                          commonVerticalSpacing(spacing: NeedleController.to.machineLocationList[index].selectedOldBoard == null ? 0 :NeedleController.to.machineLocationList[index].selectedOldBoard!.selectedOldBoard!.isEmpty ? 0 : 20),
                        ],
                      ),
                    ),
                    commonVerticalSpacing(),
                    commonHeaderTitle(title: "New Needle Board Number Which you are swapping? *",color: blackColor,fontSize: 1.2,fontWeight: 1,align: TextAlign.start),
                    commonVerticalSpacing(),
                    InkWell(
                      onTap: (){
                        commonBottomView(context: context,child: BoardBottomView(myItems: NeedleController.to.machineLocationList[index].newBoard ?? [],selectionCallBack: (NeedleBoardNumber board){
                          if(!NeedleController.to.locationIds.contains(NeedleController.to.machineLocationList[index].locationId)) {
                            NeedleController.to.locationIds.add(
                                NeedleController.to.machineLocationList[index].locationId ?? "");
                          }
                          if(NeedleController.to.machineLocationList[index].selectedNewBoard == null){
                            SelectedLocationBoardReq selectedBoard = SelectedLocationBoardReq();
                            selectedBoard.index = index;
                            selectedBoard.selectedOldBoard = [];
                            selectedBoard.selectedNewBoard = [];
                            selectedBoard.selectedNewBoard!.add(board);
                            NeedleController.to.machineLocationList[index].selectedNewBoard = selectedBoard;
                          }else{
                            NeedleController.to.machineLocationList[index].selectedNewBoard?.index = index;
                            NeedleController.to.machineLocationList[index].selectedNewBoard?.selectedNewBoard!.add(board);
                          }
                          newSetState((){});
                        }));
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          commonDecoratedTextView(
                            title: "Select new board needle number",
                            isChangeColor: true,
                          ),
                          Obx(() => Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            runAlignment: WrapAlignment.start,
                            children: NeedleController.to.machineLocationList[index].selectedNewBoard == null ? [] :NeedleController.to.machineLocationList[index].selectedNewBoard!.selectedNewBoard!.map((i) => Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                              child: Text('${i.boardNo}',style: const TextStyle(
                                  color: blackColor,
                                  fontSize: 14
                              )),
                            )).toList(),
                          )),
                          commonVerticalSpacing(spacing: NeedleController.to.machineLocationList[index].selectedNewBoard== null ? 0 : NeedleController.to.machineLocationList[index].selectedNewBoard!.selectedNewBoard!.isEmpty ? 0 : 20),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return commonStructure(
      context: context,
      bgColor: blackColor,
      appBar: commonAppbar(context: context,title: needleBoardText),
      bottomNavigation: Container(
        color: ConvertTheme.convertTheme.getBackGroundColor(),
        child: Padding(
          padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16,top: 10),
          child: Row(
            children: [
              Expanded(child: commonBorderButtonView(
                  context: context,
                  title: "Cancel",
                  height: 50,
                  tapOnButton: () {
                    Get.back();
                  },
                  isLoading: false)),
              commonHorizontalSpacing(),
              Expanded(child: commonFillButtonView(
                  context: context,
                  title: "Save",
                  width: getScreenWidth(context) - 40,
                  height: 50,
                  tapOnButton: () {
                    if(selectedBusiness != null){
                      if(selectedPlant != null){
                        if(selectedLine != null){
                          if(selectedLoom != null){
                            if(selectedDate.isNotEmpty){
                              AddNeedleBoardRequest addNeedleBoardReq = AddNeedleBoardRequest();
                              addNeedleBoardReq.userId = getLoginData()!.userdata?.first.id.toString();
                              addNeedleBoardReq.businessId = selectedPlant?.soleId?.split(" - ")[2].toString();
                              addNeedleBoardReq.plantId = selectedPlant?.soleId?.split(" - ")[1].toString();
                              addNeedleBoardReq.companyId = selectedPlant?.soleId?.split(" - ")[0].toString();
                              addNeedleBoardReq.lineId = selectedLine?.lineId.toString();
                              addNeedleBoardReq.loomId = selectedLoom?.loopsId.toString();
                              addNeedleBoardReq.locationId = NeedleController.to.locationIds.join(",");
                              NeedleController.to.addNeedleBoardData(
                                addNeedleRecordRequest: addNeedleBoardReq
                              );
                            }else{
                              showSnackBar(title: ApiConfig.error, message: "Please select date");
                            }
                          }else{
                            showSnackBar(title: ApiConfig.error, message: "Please select loom");
                          }
                        }else{
                          showSnackBar(title: ApiConfig.error, message: "Please select line");
                        }
                      }else{
                        showSnackBar(title: ApiConfig.error, message: "Please select plant");
                      }
                    }else{
                      showSnackBar(title: ApiConfig.error, message: "Please select business");
                    }
                  },
                  isLoading: false)),
            ],
          ),
        ),
      ), child: ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24.0,right: 24.0,top: 24.0),
          child: boardFormView(),
        )
      ],
    ),
    );
  }
}

class AddNeedleBoardRequest{
  String? companyId;
  String? plantId;
  String? businessId;
  String? lineId;
  String? loomId;
  String? needleBoardDate;
  String? boardConfirm;
  String? locationId;
  LocationData? locationData;
  String? userId;
}
