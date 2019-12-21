import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/engagement_customer.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/questions.dart';

import 'helper/Utils.dart';
import 'helper/constant.dart';
import 'helper/res.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Utils.isInternetConnectedWithAlert().then((isConnected) {
      if (isConnected) {
        fetchLearningModules();
      } else {

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,

//      decoration: CommonView.getBGDecoration(context),

      child: Stack(
        children: <Widget>[
          CommonView.showBackground(context),
          Row(
            children: <Widget>[
              showFirstHalf(),
              Expanded(
                flex: 1,
                child: Injector.isBusinessMode
                    ? Card(
                        color: Colors.transparent,
                        elevation: 20,
                        margin: EdgeInsets.only(top: Utils.getHeaderHeight(context)),
                        child: showSecondHalf(),
                      )
                    : showSecondHalf(),
              )
            ],
          ),
          CommonView.showCircularProgress(isLoading)
        ],
      ),
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
                      arrFinalLearningModules[index].isAssign == "1"
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
            height: Utils.getHeaderHeight(context)+10,
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
            height: 35,
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                selectedModule.isAssign == "1"
                    ? InkResponse(
                        child: Image(
                          image: AssetImage(Utils.getAssetsImg('ic_download')),
                          width: 40,
                        ),
                        onTap: () {
                          Utils.playClickSound();
                          downloadAllQuestions();
                        },
                      )
                    : Container(),
                InkResponse(
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 10),
                      padding: EdgeInsets.symmetric(horizontal: 30),
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
                      child: Row(
                        children: <Widget>[
                          Text(
                            Utils.getText(
                                context,
                                selectedModule.isAssign == "0"
                                    ? StringRes.subscribe
                                    : StringRes.subscribed),
                            style:
                                TextStyle(color: ColorRes.white, fontSize: 17),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Utils.playClickSound();
                      if (selectedModule.isAssign == "0") {
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
                (selectedModule.moduleId == null ||
                    selectedModule.moduleId.isEmpty)) {
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
            selectedModule.isAssign = "1";
          } else {
            Utils.showToast("Unsubscribed successfully!");
            selectedModule.isAssign = "0";
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
          await Injector.prefs.setString(
              PrefKeys.questionData, json.encode(questionResponse.toJson()));

          questionResponse.data.forEach((questionData) async {
            if (questionData.mediaLink.isNotEmpty)
              await DefaultCacheManager().downloadFile(questionData.mediaLink);
          });

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
}
