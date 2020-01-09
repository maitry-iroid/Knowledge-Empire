import 'dart:convert';

import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/engagement_customer.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/manage_module_permission.dart';
import 'package:ke_employee/models/questions.dart';

import 'helper/Utils.dart';
import 'helper/constant.dart';
import 'helper/res.dart';
import 'models/getDownloadQuestions.dart';
import 'models/get_learning_module.dart';

class BusinessSectorPage extends StatefulWidget {
  @override
  _BusinessSectorPageState createState() => _BusinessSectorPageState();
}

class _BusinessSectorPageState extends State<BusinessSectorPage> {
//  var arrSector = ["Healthcare", "Industrials", "Technology", "Financials"];

  List<LearningModuleData> arrLearningModules = List();
  List<LearningModuleData> arrFinalLearningModules = List();

  bool isLoading = false;
  TextEditingController searchController = TextEditingController();
  String searchText = "";
  LearningModuleData selectedModule = LearningModuleData();

  int maxVol, currentVol;

  bool isSwitched;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Utils.isInternetConnectedWithAlert().then((isConnected) {
      if (isConnected) {
        fetchLearningModules();
      } else {
        if (Injector.prefs.getString(PrefKeys.learningModles) != null &&
            Injector.prefs
                .getString(PrefKeys.learningModles)
                .isNotEmpty) {
          arrFinalLearningModules = LearningModuleResponse
              .fromJson(
              jsonDecode(Injector.prefs.getString(PrefKeys.learningModles)))
              .data;
          print(arrFinalLearningModules);

          if (arrFinalLearningModules.length > 0)
            setState(() {

            });
        }
      }
    });

    isSwitched = Global.shared.isInstructionView;
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
        CommonView.showCircularProgress(isLoading)
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
              style: TextStyle(color: ColorRes.white),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              Utils.getText(context, StringRes.size),
              style: TextStyle(color: ColorRes.white),
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
                  height: Injector.isBusinessMode ? 33 : 35,
                  margin: EdgeInsets.only(top: Injector.isBusinessMode ? 2 : 0),
                  padding: EdgeInsets.symmetric(horizontal: 8),
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
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Positioned(
                        left: 5,
                        right: 5,
                        child: Text(
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
                      ),
                      arrFinalLearningModules[index].isAssign == 1
                          ? Positioned(
                        right: 5,
                        bottom: Injector.isBusinessMode ? 5 : 2,
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
                        ),
                      )
                          : Container()
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
        setState(() {
          selectedModule = arrFinalLearningModules[index];
//          isSwitched = ;
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
                        height: 30,
//                        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 0),
                        padding: EdgeInsets.only(top: 13, left: 10),
                        margin:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: ColorRes.white,
                        ),
//                        alignment: Alignment.center,
                        child: TextField(
                          onChanged: (text) {
                            arrFinalLearningModules.clear();
                            searchText = text;

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
                            fontSize: 14,
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
          Container(
            padding: EdgeInsets.all(20),
            child: Stack(
              fit: StackFit.passthrough,
              children: <Widget>[
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Injector.isBusinessMode
                      ? ColorRes.whiteDarkBg
                      : ColorRes.white,
                  margin: EdgeInsets.only(top: 20),
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 30, bottom: 10),
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
                                : ColorRes.textProf),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    alignment: Alignment.center,
                    height: Utils.getTitleHeight(),
                    margin: EdgeInsets.only(
                        top: Injector.isBusinessMode ? 3 : 5,
                        left: Utils.getDeviceWidth(context) / 10,
                        right: Utils.getDeviceWidth(context) / 10),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: Injector.isBusinessMode
                            ? null
                            : ColorRes.titleBlueProf,
                        borderRadius: BorderRadius.circular(20),
                        image: Injector.isBusinessMode
                            ? DecorationImage(
                            image:
                            AssetImage(Utils.getAssetsImg("bg_blue")),
                            fit: BoxFit.fill)
                            : null),
                    child: Text(
                      Utils.getText(context, StringRes.description),
                      style: TextStyle(color: ColorRes.white, fontSize: 17),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    selectedModule.isAssign == 1
                        ? InkResponse(
                      child: Text(
                          Utils.getText(context, StringRes.downLoad)),
                      onTap: () {
                        Utils.playClickSound();
                      },
                    )
                        : Container(),
                    Switch(
                      value: isSwitched,
                      onChanged: (bool value) {
                        setState(() {
                          isSwitched = value;
                          Global.shared.isInstructionView = value;
                          value = !value;
                        });
                        updatePermission();
                      },
//                      value: selectedModule.isDownloadEnable == 1,
//                      onChanged: (value) {
//                        setState(() {
//                          isSwitched = value;
//                        });
//                        updatePermission();
//                      },
                      activeTrackColor: ColorRes.white,
                      inactiveTrackColor: ColorRes.lightGrey,
                      activeColor: Colors.white,
                    ),
                  ],
                ),
                InkResponse(
                    child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: Injector.isBusinessMode
                                ? null
                                : ColorRes.headerBlue,
                            borderRadius: Injector.isBusinessMode
                                ? null
                                : BorderRadius.circular(20),
                            image: Injector.isBusinessMode
                                ? DecorationImage(
                                image: AssetImage(
                                    Utils.getAssetsImg("bg_subscribe")),
                                fit: BoxFit.fill)
                                : null),
                        child: Text(
                          Utils.getText(
                              context,
                              selectedModule.isAssign == 0
                                  ? StringRes.subscribe
                                  : StringRes.subscribed),
                          style: TextStyle(color: ColorRes.white, fontSize: 17),
                          textAlign: TextAlign.center,
                        )),
                    onTap: () {
                      Utils.playClickSound();
                      if (selectedModule.isAssign == 0) {
                        assignUserToModule(Const.subscribe);
                      } else {
                        assignUserToModule(Const.unSubscribe);
                      }
                    })
              ],
            ),
          )
        ],
      ),
    );
  }

  void fetchLearningModules() async {
    setState(() {
      isLoading = true;
    });

    WebApi().getLearningModule().then((data) async {
      setState(() {
        isLoading = false;
      });

      if (data != null) {
        if (data.flag == "true") {
          await Injector.prefs
              .setString(PrefKeys.learningModles, json.encode(data));

          setState(() {
            arrLearningModules.clear();
            arrFinalLearningModules.clear();

            arrLearningModules.addAll(data.data);
            arrFinalLearningModules.addAll(data.data);

            if (arrLearningModules.length > 0 &&
                (selectedModule.moduleId == null)) {
              selectedModule = arrLearningModules[0];
            }
          });
        }
      } else
        Utils.showToast("Something went wrong");
    }).catchError((e) {
      print(e);
      setState(() {
        isLoading = false;
      });
      Utils.showToast(e.toString());
    });
  }

  //
  void assignUserToModule(String type) async {
    setState(() {
      isLoading = true;
    });

    WebApi()
        .assignUserToModule(
        selectedModule.moduleId, type, selectedModule.companyId)
        .then((data) {
      setState(() {
        isLoading = false;
      });

      if (data != null) {
        if (data.flag == "true") {
          if (type == Const.subscribe) {
            Utils.showToast("Subscribed successfully!");
            selectedModule.isAssign = 1;
          } else {
            Utils.showToast("Unsubscribed successfully!");
            selectedModule.isAssign = 0;
          }
          setState(() {});
        }

//          setState(() {
//
//          });  arrLearningModules
////                    .where(
////                        (module) => module.moduleId == selectedModule.moduleId)
////                    .first
////                    .isAssign ==
////                "1";

        fetchLearningModules();
      } else
        Utils.showToast(Utils.getText(context, StringRes.somethingWrong));
    }).catchError((e) {
      print(e);
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

    print("search_data___" + data.length.toString());

    arrFinalLearningModules.addAll(data);
  }

  void downloadAllQuestions() async {
    int dataSize = 0;

    setState(() {
      isLoading = true;
    });

    QuestionRequest rq = QuestionRequest();
    rq.userId = Injector.userData.userId;
    rq.moduleId = selectedModule.moduleId;

    WebApi().getQuestions(rq.toJson()).then((questionResponse) async {
      setState(() {
        isLoading = false;
      });

      if (questionResponse != null) {
        if (questionResponse.flag == "true") {
          print("length" + questionResponse
              .toJson()
              .length
              .toString());

          List<QuestionData> arrQuestions = questionResponse.data;

          for (int i = 0; i < questionResponse.data.length; i++) {
            arrQuestions[i].value = Utils.getValue(arrQuestions[i]);
            arrQuestions[i].loyalty = Utils.getLoyalty(arrQuestions[i]);
            arrQuestions[i].resources = Utils.getResource(arrQuestions[i]);

            print(arrQuestions[i].value);
          }

          questionResponse.data = arrQuestions;
          print("arraquestionsss =============>>>>>>>  $questionResponse.data");


          if (isSwitched) {
            await Injector.prefs.setString(
                PrefKeys.questionData, json.encode(questionResponse.toJson()));
          } else {
            await Injector.prefs.remove(PrefKeys.questionData);
          }


          questionResponse.data.forEach((questionData) async {
            if (questionData.mediaLink.isNotEmpty)
              await DefaultCacheManager()
                  .downloadFile(questionData.mediaLink)
                  .then((fileInfo) {
                dataSize += fileInfo.file.lengthSync();
                print("hello $dataSize");
              });
          });

//          if(isSwitched == false) {
//            questionResponse.data.forEach((questionData) async {
//              await DefaultCacheManager().emptyCache();
//            });
//          }


          print(dataSize);

          Utils.showToast("Downloaded successfully");
        }
      }
    }).catchError((e) {
      print(e);
      setState(() {
        isLoading = false;
      });
      Utils.showToast(e.toString());
    });
  }

  Future<void> updatePermission() async {
    setState(() {
      isLoading = true;
    });

    ManageModulePermissionRequest rq = ManageModulePermissionRequest();
    rq.userId = Injector.userData.userId.toString();
    rq.type = isSwitched ? "1" : "0";
    rq.moduleId = selectedModule.moduleId.toString();

    WebApi().manageModulePermission(context, rq).then((response) {
      setState(() {
        isLoading = false;
      });

      if (response != null) {
        if (response.flag == "true") {
          Utils.showToast("Permission updated Successfully!");

          if (isSwitched) {
//            downloadAllQuestions();
            getQuestions();
          } else {
//            Injector.cacheManager.emptyCache();
          }
        } else {
          Utils.showToast(response.msg);
        }
      }
    });

    if(isSwitched == false) {
      return await Injector.prefs.remove(PrefKeys.questionData);
//      return  Injector.cacheManager.emptyCache();
    }

  }

  List<QuestionData> arrQuestions = List();

  Future<FileInfo> downloadFile(String url) async {
//    print("123 =>> $url");
    return await Injector.cacheManager.downloadFile(url);
  }

  getQuestions() {
    setState(() {
      isLoading = true;
    });

    DownloadQuestionsRequest rq = DownloadQuestionsRequest();
    rq.userId = Injector.userData.userId;

    WebApi().getDownloadQuestions(rq.toJson()).then((data) async {
      setState(() {
        isLoading = false;
      });

      if (data != null) {
        if (data.flag == "true") {


//          arrQuestions = data.data;
          List<QuestionData> arrQuestions = data.data;

//          if (isSwitched) {
            await Injector.prefs.setString(
                PrefKeys.questionData, json.encode(data.toJson()));

          BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);


//          }
//          else {
//            await Injector.prefs.remove(PrefKeys.questionData);
//          }
          
//          for()
//          Injector.cacheManager.downloadFile(url)
          for(int i = 0; i < arrQuestions.length ; i++) {
            Injector.cacheManager.emptyCache();
            downloadFile(arrQuestions[i].mediaLink);
          }


          
          Utils.showToast("Downloaded successfully");

        } else {
          Utils.showToast(data.msg);
        }
      } else {
        Utils.showToast(Utils.getText(context, StringRes.somethingWrong));
      }
    }).catchError((e) {
      print(e);
      setState(() {
        isLoading = false;
      });
      Utils.showToast(e.toString());
    });
  }
}


/// This "Headless Task" is run when app is terminated.
void backgroundFetchHeadlessTask() async {
  print('[BackgroundFetch] Headless event received.');
  print("Hey Pawan Background headless fetch is successful");

  // Read fetch_events from SharedPreferences
  List<String> events = [];
  String json = Injector.prefs.getString(PrefKeys.download);
  if (json != null) {
    events = jsonDecode(json).cast<String>();
  }
  // Add new event.
  events.insert(0, new DateTime.now().toString() + ' [Headless]');
  // Persist fetch events in SharedPreferences
  Injector.prefs.setString(PrefKeys.download, jsonEncode(events));

  BackgroundFetch.finish();
}



class Global {
  static final shared = Global();
  bool isInstructionView = false;
}
