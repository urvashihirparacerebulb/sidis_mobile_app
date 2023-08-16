import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_projects/common_widgets/common_widget.dart';
import 'package:my_projects/utility/constants.dart';
import '../../../common_widgets/common_textfield.dart';
import '../../../configurations/config_file.dart';
import '../../../controllers/business_controller.dart';
import '../../../controllers/dropdown_data_controller.dart';
import '../../../controllers/needle_controller.dart';
import '../../../models/business_data_model.dart';
import '../../../models/needle_response_model.dart';
import '../../../models/plants_response_model.dart';
import '../../../textfields/board_textfiled.dart';
import '../../../textfields/business_textfiled.dart';
import '../../../textfields/change_status_textfield.dart';
import '../../../textfields/plants_textfield.dart';
import '../../../theme/convert_theme_colors.dart';
import '../../../utility/color_utility.dart';
import '../../../utility/common_methods.dart';
import '../../../utility/screen_utility.dart';

class AddNeedleRecordView extends StatefulWidget {
  final bool isEdit;
  final String recordId;
  const AddNeedleRecordView({Key? key, required this.isEdit, required this.recordId}) : super(key: key);

  @override
  State<AddNeedleRecordView> createState() => _AddNeedleRecordViewState();
}

class _AddNeedleRecordViewState extends State<AddNeedleRecordView> {

  BusinessData? selectedBusiness;
  CompanyBusinessPlant? selectedPlant;
  TextEditingController needleConsumedController = TextEditingController();
  String selectedDate = "";
  NeedleBoardNumber? selectedBoardNumber;
  ChangeStatus? selectedChangeStatus;

  @override
  void initState() {
    if (BusinessController.to.businessData!.isEmpty) {
      BusinessController.to.getBusinesses();
    }
    Future.delayed(const Duration(seconds: 1), (){
      getBoardNumbers();
    });

    if(widget.isEdit){
      Future.delayed(const Duration(microseconds: 500), (){
        NeedleController.to.getBoardRecordDetail(boardId: widget.recordId,callback: (){
          var needleBoard = NeedleController.to.selectedNeedleRecord.value;
          BusinessData business  = BusinessData();
          business.businessId = needleBoard.businessId;
          business.businessName = needleBoard.bussinessName;
          selectedBusiness = business;
          CompanyBusinessPlant plant = CompanyBusinessPlant();
          plant.soleId = "${needleBoard.companyId} - ${needleBoard.plantId} - ${needleBoard.businessId}";
          plant.soleName = needleBoard.companyShortName;
          selectedPlant = plant;
          NeedleBoardNumber boardNumber = NeedleBoardNumber();
          boardNumber.boardId = needleBoard.boardNumber;
          boardNumber.boardNo = needleBoard.boardNo;
          selectedBoardNumber = boardNumber;
          ChangeStatus changeStatus = ChangeStatus();
          changeStatus.id = needleBoard.needleStatus;
          changeStatus.value = needleBoard.needleStatusName;
          selectedChangeStatus = changeStatus;
          selectedDate = DateFormat("dd MMM,yyyy").format(needleBoard.recordDate!);
          needleConsumedController.text = needleBoard.consumedNeedle ?? "";
          setState(() {});
        });
      });
    }
    super.initState();
  }

  getBoardNumbers(){
    NeedleController.to.getNeedleBoardNumber(
      businessId: selectedPlant == null ? '${getLoginData()!.currentPlants?.first.bussinessId}' : '${selectedPlant?.soleId?.split(' - ')[2]}',
      plantId: selectedPlant == null ? '${getLoginData()!.currentPlants?.first.plantId}' : '${selectedPlant?.soleId?.split(' - ')[1]}',
      companyId: selectedPlant == null ? '${getLoginData()!.currentPlants?.first.companyId}' : '${selectedPlant?.soleId?.split(' - ')[0]}',
    );
  }

  recordFormView(){
    return Column(
      children: [
        InkWell(
          onTap: (){
            commonBottomView(context: context,child: BusinessBottomView(myItems: BusinessController.to.businessData!,selectionCallBack: (BusinessData business){
              selectedBusiness = business;
              selectedPlant = null;
              setState(() {});
              if(selectedBusiness?.businessId != null) {
                DropDownDataController.to.getCompanyPlants(businessId: selectedBusiness?.businessId.toString(),successCallback: (){
                  getBoardNumbers();
                });
              }
            }));
          },
          child: commonDecoratedTextView(
              title: selectedBusiness?.businessId == null ? "Select Business *" : selectedBusiness?.businessName ?? "",
              isChangeColor: selectedBusiness?.businessId == null ? true : false
          )
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
                          getBoardNumbers();
                          setState(() {});
                        }));
              }
            },
            child: commonDecoratedTextView(
              title: selectedPlant == null ? "Select Plant *" : selectedPlant!.soleName ?? "",
              isChangeColor: selectedPlant == null ? true : false,
            )
        ),
        InkWell(
          onTap: (){
            commonBottomView(context: context,child: BoardBottomView(myItems: NeedleController.to.needleBoardList,selectionCallBack: (NeedleBoardNumber boardNo){
              selectedBoardNumber = boardNo;
              setState(() {});
            }));
          },
          child: commonDecoratedTextView(
              title: selectedBoardNumber?.boardId == null ? "Select Board Number *" : selectedBoardNumber?.boardNo ?? "",
              isChangeColor: selectedBoardNumber?.boardId == null ? true : false
          )
        ),
        InkWell(
          onTap: (){
            commonBottomView(context: context,child: ChangeStatusBottomView(myItems: NeedleController.to.changeStatusList,selectionCallBack: (ChangeStatus statusChange){
              selectedChangeStatus = statusChange;
              setState(() {});
            }));
          },
          child: commonDecoratedTextView(
              title: selectedChangeStatus?.id == null ? "Needles Changed Status * " : selectedChangeStatus?.value ?? "",
              isChangeColor: selectedChangeStatus?.id == null ? true : false
          )
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
                        title: selectedDate.isEmpty ? "Date *" : selectedDate)
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
                            selectedDate = DateFormat("dd MMM,yyyy").format(value);
                          });
                        });
                      },
                      child: Icon(Icons.calendar_month, color: blackColor.withOpacity(0.4)),
                    )),
              ]
            )),
        commonVerticalSpacing(spacing: 20),
        CommonTextFiled(
            fieldTitleText: "No of Needles Consumed *",
            hintText: "No of Needles Consumed *",
            // isBorderEnable: false,
            isChangeFillColor: true,
            keyboardType: TextInputType.number,
            inputFormatter: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            textEditingController: needleConsumedController,
            onChangedFunction: (String value){
            },
            validationFunction: (String value) {
              return value.toString().isEmpty
                  ? notEmptyFieldMessage
                  : null;
            }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return commonStructure(
      context: context,
      bgColor: blackColor,
      appBar: commonAppbar(context: context,title: needleRecordFormText),
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
                  isLoading: false)
              ),
              commonHorizontalSpacing(),
              Expanded(child: commonFillButtonView(
                  context: context,
                  title: "Save",
                  width: getScreenWidth(context) - 40,
                  height: 50,
                  tapOnButton: () {
                    if(selectedBusiness != null){
                      if(selectedPlant != null){
                        if(selectedBoardNumber != null){
                          if(selectedChangeStatus != null){
                            if(selectedDate.isNotEmpty){
                              if(needleConsumedController.text.isNotEmpty){
                                AddNeedleRecordRequest addNeedleRecordReq = AddNeedleRecordRequest();
                                addNeedleRecordReq.userId = getLoginData()!.userdata?.first.id.toString();
                                addNeedleRecordReq.businessId = selectedPlant?.soleId?.split(" - ")[2].toString();
                                addNeedleRecordReq.plantId = selectedPlant?.soleId?.split(" - ")[1].toString();
                                addNeedleRecordReq.plantId = selectedPlant?.soleId?.split(" - ")[1].toString();
                                addNeedleRecordReq.companyId = selectedPlant?.soleId?.split(" - ")[0].toString();
                                addNeedleRecordReq.needleConsumed = needleConsumedController.text;
                                addNeedleRecordReq.needleBoardNumber = selectedBoardNumber?.boardId.toString();
                                addNeedleRecordReq.needleStatus = selectedChangeStatus?.id.toString();
                                addNeedleRecordReq.needleRecordAddDate = selectedDate;
                                if(widget.isEdit){
                                  addNeedleRecordReq.needleRecordId = widget.recordId;
                                }
                                NeedleController.to.addNeedleRecordData(
                                    addNeedleRecordRequest: addNeedleRecordReq,
                                    isEdit: widget.isEdit
                                );
                              }else{
                                showSnackBar(title: ApiConfig.error, message: "Please enter number of needle consumed");
                              }
                            }else{
                              showSnackBar(title: ApiConfig.error, message: "Please select date");
                            }
                          }else{
                            showSnackBar(title: ApiConfig.error, message: "Please select change status");
                          }
                        }else{
                          showSnackBar(title: ApiConfig.error, message: "Please select board number");
                        }
                      }else{
                        showSnackBar(title: ApiConfig.error, message: "Please select plant");
                      }
                    }else{
                      showSnackBar(title: ApiConfig.error, message: "Please select business");
                    }
                  },
                  isLoading: false)
              ),
            ],
          ),
        ),
      ), child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24.0,right: 24.0,top: 24.0),
              child: recordFormView(),
            )
          ],
      ),
    );
  }
}

class AddNeedleRecordRequest{
  String? companyId;
  String? plantId;
  String? businessId;
  String? needleRecordAddDate;
  String? needleStatus;
  String? needleBoardNumber;
  String? needleConsumed;
  String? userId;
  String? needleRecordId;
}