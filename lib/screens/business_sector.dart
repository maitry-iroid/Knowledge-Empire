import 'dart:convert';
import 'dart:ui';

import 'package:background_fetch/background_fetch.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knowledge_empire/commonview/common_view.dart';
import 'package:knowledge_empire/dialogs/display_dailogs.dart';
import 'package:knowledge_empire/helper/prefkeys.dart';
import 'package:knowledge_empire/helper/string_res.dart';
import 'package:knowledge_empire/helper/web_api.dart';
import 'package:knowledge_empire/injection/dependency_injection.dart';
import 'package:knowledge_empire/manager/media_manager.dart';
import 'package:knowledge_empire/models/manage_module_permission.dart';
import 'package:knowledge_empire/models/questions.dart';
import 'package:video_player/video_player.dart';

import '../helper/Utils.dart';
import '../helper/constant.dart';
import '../helper/res.dart';
import '../models/getDownloadQuestions.dart';
import '../models/get_learning_module.dart';

/*
*   created by Riddhi
*
*   - This class will fetch all the business sectors modules added for this company/user
*   - User can subscribe /unsubscribe any module
*   - Mange download setting to attempt questions in offline mode as well
*
* */

VideoPlayerController _controller;
ChewieController _chewieController;

class BusinessSectorPage extends StatefulWidget {
  const BusinessSectorPage({Key key}) : super(key: key);

  @override
  _BusinessSectorPageState createState() => _BusinessSectorPageState();
}

enum DownloadingStatus { download, downloading, downloded }

class _BusinessSectorPageState extends State<BusinessSectorPage> {
  List<LearningModuleData> arrLearningModules = List();
  List<LearningModuleData> arrFinalLearningModules = List();

  bool isLoading = false;
  TextEditingController searchController = TextEditingController();
  String searchText = "";
  LearningModuleData selectedModule = LearningModuleData();

  int maxVol, currentVol;

  bool isSwitched = false;
  bool _isLoading = false;
  String _pdfPath = '';

  @override
  void initState() {
    super.initState();

    showIntroDialog();
  }

  Future<void> initVideoController(String link) async {
    await Injector.cacheManager.getFileFromCache(link).then((fileInfo) {
      _controller = Utils.getCacheFile(link) != null ? VideoPlayerController.file(Utils.getCacheFile(link).file) : VideoPlayerController.network(link)
        ..initialize().then((_) {
          if (mounted)
            setState(() {
              _chewieController.play();
            });
        });
      _controller.setVolume(Injector.isSoundEnable ? 1.0 : 0.0);
      questionData.videoLoop == 1 ? _controller.setLooping(true) : _controller.setLooping(false);
      _chewieController = ChewieController(
          videoPlayerController: _controller,
          allowFullScreen: false,
          materialProgressColors: ChewieProgressColors(playedColor: ColorRes.header, handleColor: ColorRes.blue),
          cupertinoProgressColors: ChewieProgressColors(playedColor: ColorRes.header, handleColor: ColorRes.blue),
          looping: true);
    });
  }

  @override
  void dispose() {
    _controller?.pause();
    //TODO AUDIO
    // Injector.isSoundEnable && Injector.isBusinessMode ? Injector.audioPlayerBg.resume() : Injector.audioPlayerBg.stop();
    super.dispose();
  }

  Future<void> showIntroDialog() async {
    if (Injector.introData != null && Injector.introData.learningModule1 == 0) await DisplayDialogs.showIntroLearningModule1(context);

    //TODO for testing, don't remove this
//    await DisplayDialogs.showIntroPL1(context); //  PL
//    await DisplayDialogs.showIntroOrg1(context); //  org
//    await DisplayDialogs.showIntroCustomerSituation(context); //  customer situation
//    await DisplayDialogs.showIntroExisting1(context); // existing
//    await DisplayDialogs.showIntroNewCustomer1(context); //new
//    await DisplayDialogs.showIntroOrg1(context);  //org
//    await DisplayDialogs.showIntroRewards(context);  //reward
//    await DisplayDialogs.showIntroRanking1(context);  //ranking
//    await DisplayDialogs.showIntroChallenge1(context);  //challenge
//    await DisplayDialogs.showIntroTeam1(context);  //team
//    await DisplayDialogs.showIntroProfile1(context); // profile

    Utils.isInternetConnectedWithAlert(context).then((isConnected) async {
      if (isConnected) {
        fetchLearningModules();
      } else {
        if (Injector.prefs.getString(PrefKeys.learningModles) != null && Injector.prefs.getString(PrefKeys.learningModles).isNotEmpty) {
          arrFinalLearningModules = LearningModuleResponse.fromJson(jsonDecode(Injector.prefs.getString(PrefKeys.learningModles))).data;
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
        CommonView.showLoderView(isLoading)
      ],
    );
  }

  Container showSubHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      margin: EdgeInsets.only(left: 20, right: 10, bottom: 10),
      decoration: BoxDecoration(
          color: Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
          borderRadius: Injector.isBusinessMode ? null : BorderRadius.circular(20),
          image: Injector.isBusinessMode ? DecorationImage(image: AssetImage(Utils.getAssetsImg("business_sec_header")), fit: BoxFit.fill) : null),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Text(
              Utils.getText(context, StringRes.sector),
              style: TextStyle(color: ColorRes.white, fontSize: 17),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              Utils.getText(context, StringRes.size),
              style: TextStyle(color: ColorRes.white, fontSize: 17),
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
            image: (selectedModule.moduleId == arrFinalLearningModules[index].moduleId)
                ? DecorationImage(image: AssetImage(Utils.getAssetsImg(Injector.isBusinessMode ? "bs_bg" : "bg_bs_prof")), fit: BoxFit.fill)
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
                      borderRadius: Injector.isBusinessMode ? null : BorderRadius.circular(20),
                      image: Injector.isBusinessMode
                          ? DecorationImage(image: AssetImage(Utils.getAssetsImg("bg_bus_sector_item")), fit: BoxFit.fill)
                          : null),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        arrFinalLearningModules[index].moduleName,
                        style: TextStyle(
                          color: Injector.isBusinessMode ? ColorRes.blue : ColorRes.textProf,
                          fontSize: 15,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Opacity(
                        opacity: arrFinalLearningModules[index].isAssign == 1 ? 1.0 : 0.0,
                        child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              Utils.getText(context, StringRes.subscribed),
                              style: TextStyle(
                                color: Injector.isBusinessMode ? ColorRes.bgHeader : ColorRes.blue,
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
                    color: Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
                    borderRadius: Injector.isBusinessMode ? null : BorderRadius.circular(20),
                    image: Injector.isBusinessMode ? DecorationImage(image: AssetImage(Utils.getAssetsImg("value")), fit: BoxFit.fill) : null),
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
            if (Utils.isVideo(selectedModule.mediaLink)) {
              Injector.audioPlayerBg.stop();
              Future.delayed(Duration.zero, () async {
                await this.initVideoController(selectedModule.mediaLink);
              });
            }
          });
      },
    );
  }

  showFirstHalf() {
    return Expanded(
      flex: 1,
      child: ListView(
        children: <Widget>[
          SizedBox(height: 10),
          CommonView.showTitle(context, StringRes.businessSector),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.only(left: 20, right: 10, top: 2, bottom: 2),
//            color: ColorRes.lightBg,

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Container(
                        height: 33,
                        padding: EdgeInsets.only(top: 13, left: 10),
                        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: ColorRes.white),
                        child: Theme(
                            data: ThemeData(accentColor: ColorRes.colorPrimary),
                            child: TextField(
                                onChanged: (text) {
                                  arrFinalLearningModules.clear();
                                  searchText = text;

                                  if (mounted)
                                    setState(() {
                                      if (text.isEmpty) {
                                        arrFinalLearningModules.addAll(arrLearningModules);
                                      } else {
                                        searchData();
                                      }
                                    });
                                },
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                controller: searchController,
                                style: TextStyle(fontSize: 16, color: ColorRes.hintColor),
                                decoration: InputDecoration(
                                    hintText: Utils.getText(context, StringRes.searchForKeywords),
                                    hintStyle: TextStyle(color: ColorRes.hintColor),
                                    border: InputBorder.none))))),
                SizedBox(
                  width: 5,
                ),
                Image(
                    height: 35,
                    image: AssetImage(
                      Utils.getAssetsImg(Injector.isBusinessMode ? "search" : 'search_prof'),
                    ),
                    fit: BoxFit.fill)
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
        children: <Widget>[showImageView(context), showDescriptionView(), showDownloadSubscribeOptions()],
      ),
    );
  }

  void fetchLearningModules() async {
    if (mounted)
      setState(() {
        isLoading = true;
      });

    GetLearningModuleRequest rq = GetLearningModuleRequest();
    rq.userId = Injector.userId;

    WebApi().callAPI(WebApi.rqGetLearningModule_v2, rq.toJson()).then((data) async {
      if (mounted)
        setState(() {
          isLoading = false;
        });

      if (data != null) {
        List<LearningModuleData> arrData = new List<LearningModuleData>();

        int i = 0;
        data.forEach((v) {
          LearningModuleData module = LearningModuleData.fromJson(v);
          module.index = i;
          arrData.add(module);
          i++;
        });

        saveModulesLocally(arrData);

        if (mounted)
          setState(() {
            arrLearningModules.clear();
            arrFinalLearningModules.clear();

            arrLearningModules.addAll(arrData);
            arrFinalLearningModules.addAll(arrData);

            if (arrLearningModules.length > 0 && (selectedModule.moduleId == null)) {
              selectedModule = arrLearningModules[0];
              isSwitched = selectedModule.isDownloadEnable == 1;

              if (Utils.isVideo(selectedModule.mediaLink)) {
                Injector.audioPlayerBg.stop();
                Future.delayed(Duration.zero, () async {
                  await this.initVideoController(selectedModule.mediaLink);
                });
              }
            }
          });

//        downloadQuestions(null);
      }
    }).catchError((e) {
      print("getLeariningModule_" + e.toString());
      if (mounted)
        setState(() {
          isLoading = false;
        });
      // Utils.showToast(e.toString());
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
          Utils.showToast(Utils.getText(context, StringRes.subscribedSuccess));
          selectedModule.isAssign = 1;
        } else {
          Utils.showToast(Utils.getText(context, StringRes.unSubscribedSuccess));
          selectedModule.isAssign = 0;
        }

        arrLearningModules.firstWhere((module) => module.moduleId == selectedModule.moduleId).isAssign = selectedModule.isAssign;

        saveModulesLocally(arrLearningModules);
        if (mounted) setState(() {});
      }
    }).catchError((e) {
      if (mounted)
        setState(() {
          isLoading = false;
        });
      // Utils.showToast(e.toString());
    });
  }

  void searchData() {
    var data = arrLearningModules.where((module) => module.moduleName.toLowerCase().contains(searchText.toLowerCase())).toList();

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

        arrLearningModules[selectedModule.index].isDownloadEnable = isSwitched ? 1 : 0;
        selectedModule.isDownloadEnable = isSwitched ? 1 : 0;

        if (rq.type == 0)
          removeDownloadedQuestion();
        else
          downloadQuestions(selectedModule.moduleId);

        saveModulesLocally(arrLearningModules);

        if (mounted) setState(() {});
      }
    });
  }

  List<QuestionData> arrQuestions = List();

  downloadQuestions(int moduleId) {
    if (mounted)
      setState(() {
        isLoading = true;
      });

    DownloadQuestionsRequest rq = DownloadQuestionsRequest();
    rq.userId = Injector.userData.userId;
    rq.moduleId = moduleId ?? 0;

    WebApi().callAPI(WebApi.rqGetDownloadQuestions, rq.toJson()).then((data) async {
      if (mounted)
        setState(() {
          isLoading = false;
        });

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

          await Injector.prefs.setString(PrefKeys.questionData, jsonEncode(questionsResponse.toJson()));

          //TODO remove media also

          //Injector.cacheManager.emptyCache();

          for (int i = 0; i < arrQuestions.length; i++) {
//            PushNotificationHelper(context).showLocalNotification(
//                101, Utils.getText(context, StringRes.downloading));

            await BackgroundFetch.start().then((int status) async {
//              if (mounted)setState(() {
//                arrLearningModules
//                    .firstWhere((module) => module.moduleId == moduleId)
//                    .isDownloading = true;
//              });

              await Injector.prefs.setString("datta", "scsdc");
              await Injector.cacheManager.getSingleFile(arrQuestions[i].mediaLink);
            }).catchError((e) {
              if (moduleId != null) {
//                if (mounted)setState(() {
//                  arrLearningModules
//                      .firstWhere((module) => module.moduleId == moduleId)
//                      .isDownloading = false;
//                });
              }
            }).whenComplete(() {
              if (i == arrQuestions.length - 1) Injector.flutterLocalNotificationsPlugin.cancel(101);

//              if (mounted)setState(() {
//                arrLearningModules
//                    .firstWhere((module) => module.moduleId == moduleId)
//                    .isDownloading = false;
//              });
            });
            await BackgroundFetch.start().then((int status) async {
              await Injector.cacheManager.getSingleFile(arrQuestions[i].inCorrectAnswerImage);
            });
            await BackgroundFetch.start().then((int status) async {
              await Injector.cacheManager.getSingleFile(arrQuestions[i].correctAnswerImage);
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
      if (mounted)
        setState(() {
          isLoading = false;
        });
      // Utils.showToast(e.toString());
    });
  }

  void removeDownloadedQuestion() async {
    List<QuestionData> arrQuestions = Utils.getQuestionsLocally(Const.getNewQueType);

    arrQuestions.removeWhere((question) => question.questionId == selectedModule.moduleId);

    QuestionsResponse questionsResponse = QuestionsResponse();
    questionsResponse.data = arrQuestions;

    await Injector.prefs.setString(PrefKeys.questionData, json.encode(questionsResponse.toJson()));
  }

  showConfirmDialog() {
    String message = Utils.subscribeText(selectedModule.moduleName);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            content: Text(message),
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
    Utils.isInternetConnectedWithAlert(context).then((isConnected) {
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
            color: Injector.isBusinessMode ? ColorRes.whiteDarkBg : ColorRes.white,
            margin: EdgeInsets.only(top: 20),
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 10),
              decoration: BoxDecoration(
                color: Injector.isBusinessMode ? ColorRes.bgDescription : ColorRes.white,
                borderRadius: BorderRadius.circular(12),
                border: Injector.isBusinessMode ? Border.all(color: ColorRes.white, width: 1) : null,
              ),
              child: SingleChildScrollView(
                child: Text(
                  selectedModule.moduleDescription,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Injector.isBusinessMode ? ColorRes.white : ColorRes.textProf, fontSize: 17),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  top: Injector.isBusinessMode ? 3 : 5, left: Utils.getDeviceWidth(context) / 9, right: Utils.getDeviceWidth(context) / 9),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
                  borderRadius: BorderRadius.circular(20),
                  image: Injector.isBusinessMode ? DecorationImage(image: AssetImage(Utils.getAssetsImg("bg_blue")), fit: BoxFit.fill) : null),
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
                  style: TextStyle(color: Injector.isBusinessMode ? ColorRes.white : ColorRes.fontDarkGrey),
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
                  Utils.isInternetConnectedWithAlert(context).then((isConnected) {
                    if (isConnected) {
                      if (mounted)
                        setState(() {
                          isSwitched = value;
                        });
                      updatePermission();
                    }
                  });
                },
                activeTrackColor: selectedModule.isSubscribedFromBackend == 1 ? ColorRes.lightGrey : ColorRes.white,
                inactiveTrackColor: ColorRes.lightGrey,
                activeColor: selectedModule.isSubscribedFromBackend == 1 ? ColorRes.lightGrey : ColorRes.white,
              )
            : Container(),
      ],
    );
  }

  showSubscribeView() {
    return selectedModule.index == null
        ? Container()
        : InkResponse(
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
                    borderRadius: Injector.isBusinessMode ? null : BorderRadius.circular(20),
                    image: Injector.isBusinessMode
                        ? DecorationImage(
                            image:
                                AssetImage(Utils.getAssetsImg(selectedModule.isSubscribedFromBackend == 1 ? "bg_disable_subscribe" : "bg_subscribe")),
                            fit: BoxFit.fill)
                        : null),
                child: Text(
                  Utils.getText(context, selectedModule.isAssign == 0 ? StringRes.subscribe : StringRes.unSubscribe),
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

  showContactExpertView() {
    return selectedModule.expertEmail != null && selectedModule.expertEmail != ""
        ? CommonView.showContactExpert(context, Utils.getText(context, StringRes.contactExpert), true,
            selectedModule?.expertEmail ?? "Contact Expert", true, this.selectedModule.moduleName, "", false, this.selectedModule.moduleId.toString())
        : Container();
  }

  showMoreInformationView() {
    return selectedModule.additionalInfoLink != null && selectedModule.additionalInfoLink != ""
        ? CommonView.showMoreInformation(context, Utils.getText(context, StringRes.moreInformation), true,
            selectedModule?.additionalInfoLink ?? "More Information", true, this.selectedModule.moduleId.toString())
        : Container();
  }

  showImageView(BuildContext context) {
    if ((selectedModule?.mediaLink ?? "") != "" && (selectedModule?.mediaThumbImage ?? "") != "") {
      if (Utils.isPdf(selectedModule?.mediaLink)) {
        return Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: MediaManager().showQueMedia(context, ColorRes.white, selectedModule.mediaLink, selectedModule.mediaThumbImage,
              isPdfLoading: _isLoading, pdfFilePath: selectedModule.mediaLink),
        );
      } else if (Utils.isVideo(selectedModule?.mediaLink)) {
        return Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: MediaManager().showQueMedia(context, ColorRes.white, selectedModule.mediaLink, selectedModule.mediaThumbImage,
              videoPlayerController: _controller, chewieController: _chewieController),
        );
      } else {
        return Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: MediaManager().showQueMedia(context, ColorRes.white, selectedModule.mediaLink, selectedModule.mediaThumbImage),
        );
      }
    } else {
      return Container();
    }
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
          showDownloadStatus(),
          showDownloadSwitch(),
          showSubscribeView(),
          showContactExpertView(),
          showMoreInformationView()
        ],
      ),
    );
  }

  showDownloadStatus() {
    return Opacity(
      opacity: selectedModule != null ? (selectedModule.isDownloading ? 1 : 0) : 0,
      child: Text(
        Utils.getText(context, StringRes.downloading),
        style: TextStyle(color: ColorRes.white, fontSize: 17),
      ),
    );
  }

  showFileSize() {
    return selectedModule != null && selectedModule.fileSize != null
        ? Text(
            Utils.getText(context, StringRes.downloadText) + " " + selectedModule.fileSize.toString() + Utils.getText(context, StringRes.sizeInKb),
            style: TextStyle(color: Injector.isBusinessMode ? ColorRes.white : ColorRes.blue, fontSize: 17),
          )
        : Container();
  }

  void saveModulesLocally(List<LearningModuleData> arrLearningModules) async {
    LearningModuleResponse learningModuleResponse = LearningModuleResponse();
    learningModuleResponse.data = arrLearningModules;

    await Injector.prefs.setString(PrefKeys.learningModles, jsonEncode(learningModuleResponse.toJson()));
  }
}
