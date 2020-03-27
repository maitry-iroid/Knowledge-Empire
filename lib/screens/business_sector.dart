import 'dart:convert';
import 'dart:ui';

import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/dialogs/display_dailogs.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/manage_module_permission.dart';
import 'package:ke_employee/models/questions.dart';
import 'package:ke_employee/push_notification/PushNotificationHelper.dart';
import 'package:ke_employee/screens/refreshAnimation.dart';

import '../helper/Utils.dart';
import '../helper/constant.dart';
import '../helper/res.dart';
import '../models/getDownloadQuestions.dart';
import '../models/get_learning_module.dart';

class BusinessSectorPage extends StatefulWidget {
  const BusinessSectorPage({Key key}) : super(key: key);

  @override
  _BusinessSectorPageState createState() => _BusinessSectorPageState();
}

enum DownloadingStatus { download, downloading, downloded }

class _BusinessSectorPageState extends State<BusinessSectorPage> {
//  var arrSector = ["Healthcare", "Industrials", "Technology", "Financials"];

  List<LearningModuleData> arrLearningModules = List();
  List<LearningModuleData> arrFinalLearningModules = List();

  bool isLoading = false;
  TextEditingController searchController = TextEditingController();
  String searchText = "";
  LearningModuleData selectedModule = LearningModuleData();

  int maxVol, currentVol;

  bool isSwitched = false;

  @override
  void initState() {
    super.initState();

    showIntroDialog();
  }

  Future<void> showIntroDialog() async {
    if (Injector.introData == null || Injector.introData.learningModule1 == 0) {
      await DisplayDialogs.showCustomerRelationshipManagement(context);
    }
    Utils.isInternetConnectedWithAlert().then((isConnected) async {
      if (isConnected) {
        fetchLearningModules();
      } else {
        if (Injector.prefs.getString(PrefKeys.learningModles) != null &&
            Injector.prefs.getString(PrefKeys.learningModles).isNotEmpty) {
          arrFinalLearningModules = LearningModuleResponse.fromJson(
                  jsonDecode(Injector.prefs.getString(PrefKeys.learningModles)))
              .data;
          print(arrFinalLearningModules);
          if (arrFinalLearningModules.length > 0) if (mounted) setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CommonView.showBackground(context),
        Padding(
          padding: EdgeInsets.only(top: Utils.getHeaderHeight(context)),
          child: Row(
            children: <Widget>[
              showFirstHalf(),
              Expanded(
                flex: 1,
                child: Injector.isBusinessMode
                    ? Card(
                        color: Colors.transparent,
                        elevation: 20,
                        child: showSecondHalf(),
                      )
                    : showSecondHalf(),
              )
            ],
          ),
        ),
      ],
    );
  }

  Container showSubHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      margin: EdgeInsets.only(left: 20, right: 10, bottom: 10),
      decoration: BoxDecoration(
          color: Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
          borderRadius:
              Injector.isBusinessMode ? null : BorderRadius.circular(20),
          image: Injector.isBusinessMode
              ? DecorationImage(
                  image: AssetImage(Utils.getAssetsImg("business_sec_header")),
                  fit: BoxFit.fill)
              : null),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Text(
              Utils.getText(context, StringRes.sector),
              style: TextStyle(color: ColorRes.white,fontSize: 17),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              Utils.getText(context, StringRes.size),
              style: TextStyle(color: ColorRes.white,fontSize: 17),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget showItem(int index) {
    return InkResponse(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 20, right: 10),
        padding: EdgeInsets.only(top: 6, bottom: 6, left: 8),
        decoration: BoxDecoration(
            image: (selectedModule.moduleId ==
                    arrFinalLearningModules[index].moduleId)
                ? DecorationImage(
                    image: AssetImage(Utils.getAssetsImg(
                        Injector.isBusinessMode ? "bs_bg" : "bg_bs_prof")),
                    fit: BoxFit.fill)
                : null),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 9,
              child: Container(
//                  height: Injector.isBusinessMode ? 33 : 35,
                  margin: EdgeInsets.only(top: Injector.isBusinessMode ? 2 : 0),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Injector.isBusinessMode ? null : ColorRes.white,
                      borderRadius: Injector.isBusinessMode
                          ? null
                          : BorderRadius.circular(20),
                      image: Injector.isBusinessMode
                          ? DecorationImage(
                              image: AssetImage(
                                  Utils.getAssetsImg("bg_bus_sector_item")),
                              fit: BoxFit.fill)
                          : null),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        arrFinalLearningModules[index].moduleName,
                        style: TextStyle(
                          color: Injector.isBusinessMode
                              ? ColorRes.blue
                              : ColorRes.textProf,
                          fontSize: 15,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Opacity(
                        opacity: arrFinalLearningModules[index].isAssign == 1
                            ? 1.0
                            : 0.0,
                        child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              Utils.getText(context, StringRes.subscribed),
                              style: TextStyle(
                                color: Injector.isBusinessMode
                                    ? ColorRes.bgHeader
                                    : ColorRes.blue,
                                fontSize: 10,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )),
                      )
                    ],
                  )),
            ),
            Expanded(
              flex: 3,
              child: Container(
                height: 30,
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 5, right: 10, top: 2, bottom: 2),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                    color:
                        Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
                    borderRadius: Injector.isBusinessMode
                        ? null
                        : BorderRadius.circular(20),
                    image: Injector.isBusinessMode
                        ? DecorationImage(
                            image: AssetImage(Utils.getAssetsImg("value")),
                            fit: BoxFit.fill)
                        : null),
                child: Text(
                  arrFinalLearningModules[index].question,
                  style: TextStyle(
                    color: ColorRes.white,
                    fontSize: 22,
                  ),
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Utils.playClickSound();
        if (mounted)
          setState(() {
            selectedModule = arrFinalLearningModules[index];
            isSwitched = selectedModule.isDownloadEnable == 1;
          });
      },
    );
  }

  showFirstHalf() {
    return Expanded(
      flex: 1,
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          CommonView.showTitle(context, StringRes.businessSector),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.only(left: 20, right: 10, top: 2, bottom: 2),
//            color: ColorRes.lightBg,

            child: Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                        height: 33,
//                        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 0),
                        padding: EdgeInsets.only(top: 13, left: 10),
                        margin:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: ColorRes.white,
                        ),
//                        alignment: Alignment.center,
                        child: TextField(
                          onChanged: (text) {
                            arrFinalLearningModules.clear();
                            searchText = text;

                            if (mounted)
                              setState(() {
                                if (text.isEmpty) {
                                  arrFinalLearningModules
                                      .addAll(arrLearningModules);
                                } else {
//                              present = 0;
                                  searchData();
                                }
                              });
                          },
//                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          controller: searchController,
                          style: TextStyle(
                            fontSize: 17,
                            color: ColorRes.hintColor,
                          ),
                          decoration: InputDecoration(
//                              contentPadding:  EdgeInsets.symmetric(horizontal: 5),
                              hintText: Utils.getText(
                                  context, StringRes.searchForKeywords),
                              hintStyle: TextStyle(color: ColorRes.hintColor),
                              border: InputBorder.none),
                        ))),
                SizedBox(
                  width: 5,
                ),
                Image(
                  height: 35,
                  image: AssetImage(
                    Utils.getAssetsImg(
                        Injector.isBusinessMode ? "search" : 'search_prof'),
                  ),
                  fit: BoxFit.fill,
                )
              ],
            ),
          ),
          showSubHeader(),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: arrFinalLearningModules.length,
            itemBuilder: (BuildContext context, int index) {
              return showItem(index);
            },
          )
        ],
      ),
    );
  }

  showSecondHalf() {
    return Container(
      color: Injector.isBusinessMode ? null : Color(0xFFeaeaea),
      child: ListView(
        children: <Widget>[
          showDescriptionView(),
          showDownloadSubscribeOptions()
        ],
      ),
    );
  }

  void fetchLearningModules() async {
    CommonView.showCircularProgress(true, context);

    GetLearningModuleRequest rq = GetLearningModuleRequest();
    rq.userId = Injector.userId;

    WebApi()
        .callAPI(WebApi.rqGetLearningModule, rq.toJson())
        .then((data) async {
      CommonView.showCircularProgress(false, context);

      if (data != null) {
        List<LearningModuleData> arrData = new List<LearningModuleData>();

        int i = 0;
        data.forEach((v) {
          LearningModuleData module = LearningModuleData.fromJson(v);
          module.index = i;
          arrData.add(module);
          i++;
        });

        LearningModuleResponse learningModuleResponse =
            LearningModuleResponse();
        learningModuleResponse.data = arrData;

        await Injector.prefs.setString(PrefKeys.learningModles,
            jsonEncode(learningModuleResponse.toJson()));

        if (mounted)
          setState(() {
            arrLearningModules.clear();
            arrFinalLearningModules.clear();

            arrLearningModules.addAll(arrData);
            arrFinalLearningModules.addAll(arrData);

            if (arrLearningModules.length > 0 &&
                (selectedModule.moduleId == null)) {
              selectedModule = arrLearningModules[0];
              isSwitched = selectedModule.isDownloadEnable == 1;
            }
          });

//        downloadQuestions(null);
      }
    }).catchError((e) {
      print("getLeariningModule_" + e.toString());
      CommonView.showCircularProgress(false, context);
      Utils.showToast(e.toString());
    });
  }

  //
  void assignUserToModule(int type) async {
    if (mounted)
      setState(() {
        isLoading = true;
      });

    AssignModuleRequest rq = AssignModuleRequest();
    rq.userId = Injector.userId;
    rq.companyId = selectedModule.companyId;
    rq.moduleId = selectedModule.moduleId;
    rq.type = type;

    WebApi().callAPI(WebApi.rqAssignUserToModule, rq.toJson()).then((data) {
      if (mounted)
        setState(() {
          isLoading = false;
        });

      if (data != null) {
        if (type == Const.subscribe) {
          Utils.showToast(StringRes.subscribedSuccess);
          selectedModule.isAssign = 1;
        } else {
          Utils.showToast(StringRes.unSubscribedSuccess);
          selectedModule.isAssign = 0;
        }

        if (mounted)
          setState(() {
            arrLearningModules
                .firstWhere(
                    (module) => module.moduleId == selectedModule.moduleId)
                .isAssign = selectedModule.isAssign;
          });
      }
    }).catchError((e) {
      print("assignUserModule_" + e.toString());

      if (mounted)
        setState(() {
          isLoading = false;
        });
      Utils.showToast(e.toString());
    });
  }

  void searchData() {
    var data = arrLearningModules
        .where((module) =>
            module.moduleName.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    arrFinalLearningModules.addAll(data);
  }

  Future<void> updatePermission() async {
    if (mounted)
      setState(() {
        isLoading = true;
      });

    ManageModulePermissionRequest rq = ManageModulePermissionRequest();
    rq.userId = Injector.userData.userId;
    rq.type = isSwitched ? 1 : 0;
    rq.moduleId = selectedModule.moduleId;

    WebApi().callAPI(WebApi.rqUpdateModulePermission, rq.toJson()).then((data) {
      if (mounted)
        setState(() {
          isLoading = false;
        });

      if (data != null) {
//        Utils.showToast(Utils.getText(context, StringRes.alertActionPerformed));

        arrLearningModules[selectedModule.index].isDownloadEnable =
            isSwitched ? 1 : 0;
        selectedModule.isDownloadEnable = isSwitched ? 1 : 0;

        if (rq.type == 0)
          removeDownloadedQuestion();
        else
          downloadQuestions(selectedModule.moduleId);

        if (mounted) setState(() {});
      }
    });
  }

  List<QuestionData> arrQuestions = List();

  downloadQuestions(int moduleId) {
    CommonView.showCircularProgress(true, context);

    if (mounted)
      setState(() {
        isLoading = true;
      });

    DownloadQuestionsRequest rq = DownloadQuestionsRequest();
    rq.userId = Injector.userData.userId;
    rq.moduleId = moduleId ?? 0;

    WebApi()
        .callAPI(WebApi.rqGetDownloadQuestions, rq.toJson())
        .then((data) async {
      CommonView.showCircularProgress(false, context);

      if (data != null) {
        List<QuestionData> arrQuestions = new List<QuestionData>();

        data.forEach((v) {
          arrQuestions.add(QuestionData.fromJson(v));
        });

        if (arrQuestions.isNotEmpty) {
          if (moduleId != null) {
//            if (mounted)setState(() {
//              arrLearningModules
//                  .firstWhere((module) => module.moduleId == moduleId)
//                  .isDownloading = true;
//            });
          }

          for (int i = 0; i < arrQuestions.length; i++) {
            arrQuestions[i].value = Utils.getValue(arrQuestions[i]);
            arrQuestions[i].loyalty = Utils.getLoyalty(arrQuestions[i]);
            arrQuestions[i].resources = Utils.getResource(arrQuestions[i]);

            print(arrQuestions[i].value);
          }

          QuestionsResponse questionsResponse = QuestionsResponse();
          questionsResponse.data = arrQuestions;

          await Injector.prefs.setString(
              PrefKeys.questionData, jsonEncode(questionsResponse.toJson()));

          //TODO remove media also

//          Injector.cacheManager.emptyCache();

          for (int i = 0; i < arrQuestions.length; i++) {
            PushNotificationHelper(context, "").showLocalNotification(
                101, Utils.getText(context, StringRes.downloading));

            await BackgroundFetch.start().then((int status) async {
//              if (mounted)setState(() {
//                arrLearningModules
//                    .firstWhere((module) => module.moduleId == moduleId)
//                    .isDownloading = true;
//              });

              await Injector.prefs.setString("datta", "scsdc");

              await Injector.cacheManager
                  .getSingleFile(arrQuestions[i].mediaLink);
              print("complted");
            }).catchError((e) {
              print('[BackgroundFetch] setSpentTime start FAILURE: $e');
              if (moduleId != null) {
//                if (mounted)setState(() {
//                  arrLearningModules
//                      .firstWhere((module) => module.moduleId == moduleId)
//                      .isDownloading = false;
//                });
              }
            }).whenComplete(() {
              if (i == arrQuestions.length - 1)
                Injector.flutterLocalNotificationsPlugin.cancel(101);

//              if (mounted)setState(() {
//                arrLearningModules
//                    .firstWhere((module) => module.moduleId == moduleId)
//                    .isDownloading = false;
//              });
            });
            await BackgroundFetch.start().then((int status) async {
              await Injector.cacheManager
                  .getSingleFile(arrQuestions[i].inCorrectAnswerImage);
            });
            await BackgroundFetch.start().then((int status) async {
              await Injector.cacheManager
                  .getSingleFile(arrQuestions[i].correctAnswerImage);
            });
          }

          if (moduleId != null) {
//            if (mounted)setState(() {
//              arrLearningModules
//                  .firstWhere((module) => module.moduleId == moduleId)
//                  .isDownloading = false;
//            });
          }
        }
      }
    }).catchError((e) {
      print("downloadQuestion_" + e.toString());

      CommonView.showCircularProgress(false, context);

      Utils.showToast(e.toString());
    });
  }

  void removeDownloadedQuestion() async {
    List<QuestionData> arrQuestions =
        Utils.getQuestionsLocally(Const.getNewQueType);

    arrQuestions.removeWhere(
        (question) => question.questionId == selectedModule.moduleId);

    QuestionsResponse questionsResponse = QuestionsResponse();
    questionsResponse.data = arrQuestions;

    await Injector.prefs.setString(
        PrefKeys.questionData, json.encode(questionsResponse.toJson()));
  }

  showConfirmDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            content: Text(
                Utils.getText(context, StringRes.alertWantToSubscribe1) +
                    selectedModule.moduleName +
                    Utils.getText(context, StringRes.alertWantToSubscribe2) +
                    Utils.getText(context, StringRes.newCustomers)),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text(Utils.getText(context, StringRes.yes)),
                onPressed: () {
                  performSubscribeUnsubscribe();

                  Navigator.pop(context);
                },
              ),
              CupertinoDialogAction(
                child: Text(Utils.getText(context, StringRes.no)),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }

  void performSubscribeUnsubscribe() {
    Utils.isInternetConnectedWithAlert().then((isConnected) {
      if (isConnected) {
        if (selectedModule.isAssign == 0) {
          assignUserToModule(Const.subscribe);
        } else {
          assignUserToModule(Const.unSubscribe);
        }
      }
    });
  }

  showDescriptionView() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color:
                Injector.isBusinessMode ? ColorRes.whiteDarkBg : ColorRes.white,
            margin: EdgeInsets.only(top: 20),
            child: Container(
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 10),
              decoration: BoxDecoration(
                color: Injector.isBusinessMode
                    ? ColorRes.bgDescription
                    : ColorRes.white,
                borderRadius: BorderRadius.circular(12),
                border: Injector.isBusinessMode
                    ? Border.all(color: ColorRes.white, width: 1)
                    : null,
              ),
              child: SingleChildScrollView(
                child: Text(
                  selectedModule.moduleDescription,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Injector.isBusinessMode
                          ? ColorRes.white
                          : ColorRes.textProf,fontSize: 17),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  top: Injector.isBusinessMode ? 3 : 5,
                  left: Utils.getDeviceWidth(context) / 9,
                  right: Utils.getDeviceWidth(context) / 9),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color:
                      Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
                  borderRadius: BorderRadius.circular(20),
                  image: Injector.isBusinessMode
                      ? DecorationImage(
                          image: AssetImage(Utils.getAssetsImg("bg_blue")),
                          fit: BoxFit.fill)
                      : null),
              child: Text(
                Utils.getText(context, StringRes.description),
                style: TextStyle(color: ColorRes.white, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  showDownloadSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        selectedModule.isAssign == 1
            ? InkResponse(
                child: Text(
                  Utils.getText(context, StringRes.downLoad),
                  style: TextStyle(
                      color: Injector.isBusinessMode
                          ? ColorRes.white
                          : ColorRes.fontDarkGrey),
                ),
                onTap: () {
                  Utils.playClickSound();
                },
              )
            : Container(),
        selectedModule.isAssign == 1
            ? Switch(
                value: isSwitched,
                onChanged: (value) {
                  Utils.isInternetConnectedWithAlert().then((isConnected) {
                    if (isConnected) {
                      if (mounted)
                        setState(() {
                          isSwitched = value;
                        });
                      updatePermission();
                    }
                  });
                },
                activeTrackColor: selectedModule.isSubscribedFromBackend == 1
                    ? ColorRes.lightGrey
                    : ColorRes.white,
                inactiveTrackColor: ColorRes.lightGrey,
                activeColor: selectedModule.isSubscribedFromBackend == 1
                    ? ColorRes.lightGrey
                    : ColorRes.white,
              )
            : Container(),
      ],
    );
  }

  showSubscribeView() {
    return InkResponse(
        child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 50),
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: Injector.isBusinessMode
                    ? null
                    : selectedModule.isSubscribedFromBackend == 1
                        ? ColorRes.greyText
                        : ColorRes.headerBlue,
                borderRadius:
                    Injector.isBusinessMode ? null : BorderRadius.circular(20),
                image: Injector.isBusinessMode
                    ? DecorationImage(
                        image: AssetImage(Utils.getAssetsImg(
                            selectedModule.isSubscribedFromBackend == 1
                                ? "bg_disable_subscribe"
                                : "bg_subscribe")),
                        fit: BoxFit.fill)
                    : null),
            child: Text(
              Utils.getText(
                  context,
                  selectedModule.isAssign == 0
                      ? StringRes.subscribe
                      : StringRes.unSubscribe),
              style: TextStyle(color: ColorRes.white, fontSize: 20),
              textAlign: TextAlign.center,
            )),
        onTap: () {
          Utils.playClickSound();

          if (selectedModule.isSubscribedFromBackend == 0) {
            if (selectedModule.isAssign == 1)
              showConfirmDialog();
            else
              performSubscribeUnsubscribe();
          } else {
            Utils.showToast(Utils.getText(context, StringRes.alertNotAllowed));
          }
        });
  }

  showDownloadSubscribeOptions() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          showFileSize(),
//          showDownloadStatus(),
//          showDownloadSwitch(),
          showSubscribeView()
        ],
      ),
    );
  }

  showDownloadStatus() {
    return Opacity(
      opacity:
          selectedModule != null ? (selectedModule.isDownloading ? 1 : 0) : 0,
      child: Text(
        Utils.getText(context, StringRes.downloading),
        style: TextStyle(color: ColorRes.white, fontSize: 17),
      ),
    );
  }

  showFileSize() {
    return selectedModule != null && selectedModule.fileSize != null
        ? Text(
            Utils.getText(context, StringRes.thisModuleWillOccupie) +
                selectedModule.fileSize.toString() +
                "",
            style: TextStyle(color: ColorRes.white, fontSize: 17),
          )
        : Container();
  }
}
