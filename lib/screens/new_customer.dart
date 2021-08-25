import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/BLoC/get_question_bloc.dart';
import 'package:ke_employee/BLoC/navigation_bloc.dart';
import 'package:ke_employee/commonview/common_view.dart';
import 'package:ke_employee/dialogs/display_dailogs.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/homedata.dart';

import '../helper/constant.dart';
import '../helper/string_res.dart';
import '../models/questions.dart';

class NewCustomerPage extends StatefulWidget {
  @override
  _NewCustomerPageState createState() => _NewCustomerPageState();
}

class _NewCustomerPageState extends State<NewCustomerPage> {
  List<QuestionData> arrQuestions = List();

  int questionAnswered = 0;
  int loyaltyBonus = 0;
  int resourceBonus = 0;
  int valueBonus = 0;
  bool isAscSelected = false;
  bool isDescSelected = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    showIntroDialog();
  }

  Future<void> showIntroDialog() async {
    if (Injector.introData != null && Injector.introData.newCustomer1 == 0) {
      await DisplayDialogs.showIntroNewCustomer1(context);
    }

    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              CommonView.showBackground(context),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: Utils.getHeaderHeight(context)),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    showTitle(context, StringRes.newCustomers),
//                    showValueText("value bonus : " +
//                        Injector.customerValueData.valueBonus.toString()),
//                    showValueText("loyalty bonus : " +
//                        Injector.customerValueData.loyaltyBonus.toString()),
//                    showValueText("resource bonus : " +
//                        Injector.customerValueData.resourceBonus.toString()),
//                    showValueText("total attempted que : " +
//                        Injector.customerValueData.totalAttemptedQuestion
//                            .toString()),
                    showSubHeader(context),
                    showItems(context)
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Expanded showItems(BuildContext context) {
    return Expanded(
        child: StreamBuilder(
            stream: getQuestionsBloc?.getQuestions,
            builder: (context, AsyncSnapshot<List<QuestionData>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CommonView.showShimmer();
              } else if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData)
                  return showData(snapshot?.data);
                else
                  Container();
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Container();
            }));
  }

  Container showSubHeader(BuildContext context) {
    return Container(
      height: Injector.isBusinessMode ? 35 : 30,
      margin: EdgeInsets.only(left: 0, right: 4, top: 8, bottom: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
          image: Injector.isBusinessMode ? DecorationImage(image: AssetImage(Utils.getAssetsImg("bg_rounded")), fit: BoxFit.fill) : null),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: AutoSizeText(
              Utils.getText(context, StringRes.name),
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
              maxLines: 1,
              minFontSize: 4,
            ),
          ),
          Expanded(
            flex: 4,
            child: AutoSizeText(
              Utils.getText(context, StringRes.sector),
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
              maxLines: 1,
              minFontSize: 4,
            ),
          ),
          Expanded(
            flex: 3,
            child: AutoSizeText(
              Utils.getText(context, "Level"),
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
              maxLines: 1,
              minFontSize: 4,
            ),
          ),
          Expanded(
            flex: 4,
            child: AutoSizeText(
              Utils.getText(context, "Retention"),
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
              maxLines: 1,
              minFontSize: 4,
            ),
          ),
          Expanded(
            flex: 2,
            child: AutoSizeText(
              Utils.getText(context, "DaysInLimit"),
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
              maxLines: 1,
              minFontSize: 4,
            ),
          ),
          Expanded(
            flex: 4,
            child: AutoSizeText(
              Utils.getText(context, StringRes.points),
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
              maxLines: 1,
              minFontSize: 4,
            ),
          ),
          Utils.isFeatureOn(Const.typeOrg)
              ? Expanded(
                  flex: 3,
                  child: AutoSizeText(
                    Utils.getText(context, StringRes.resources),
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget showItem(int index) {
    return InkResponse(
      onTap: () {
        Utils.playClickSound();

        if (Utils.isFeatureOn(Const.typeOrg)) {
          if ((Injector.customerValueData.remainingSalesPerson >= arrQuestions[index].resources &&
              Injector.customerValueData.remainingCustomerCapacity > 0)) {
            attemptQuestion(index);
          } else {
            Utils.showToast(Utils.getQueValidationToast(arrQuestions[index].resources));
          }
        } else {
          attemptQuestion(index);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
//          showValueText("counter : " + arrQuestions[index].counter.toString()),
//          showValueText(
//              "daysInList : " + arrQuestions[index].daysInList.toString()),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                    height: Injector.isBusinessMode ? 35 : 30,
                    padding: EdgeInsets.only(left: 10),
                    margin: EdgeInsets.symmetric(vertical: 3),
                    decoration: BoxDecoration(
                        color: Injector.isBusinessMode ? null : ColorRes.white,
                        borderRadius: Injector.isBusinessMode ? null : BorderRadius.circular(20),
                        image: Injector.isBusinessMode
                            ? DecorationImage(image: AssetImage(Utils.getAssetsImg("bg_record_white")), fit: BoxFit.fill)
                            : null),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: AutoSizeText(
                            arrQuestions[index].title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            minFontSize: 8,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ColorRes.textRecordBlue,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: AutoSizeText(
                            arrQuestions[index].moduleName,
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            minFontSize: 4,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: ColorRes.textRecordBlue, fontSize: 18),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: AutoSizeText(
                            arrQuestions[index].targetLevel.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            minFontSize: 4,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: ColorRes.textRecordBlue, fontSize: 18),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: AutoSizeText(
                            arrQuestions[index].currentRetention.toString() + " %",
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            minFontSize: 4,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: ColorRes.textRecordBlue, fontSize: 18),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            ("${arrQuestions[index].daysInList.toString()}"),
                            style: TextStyle(color: ColorRes.textRecordBlue, fontSize: 18),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: kePoint(index),
                        ),
                        Utils.isFeatureOn(Const.typeOrg)
                            ? Expanded(
                                flex: 3,
                                child: Text(
                                  arrQuestions[index].resources.toString(),
                                  style: TextStyle(color: ColorRes.textRecordBlue, fontSize: 18),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                ),
                              )
                            : Container(),
                      ],
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  showTitle(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkResponse(
            child: Image(
              image: AssetImage(Utils.getAssetsImg(Injector.isBusinessMode ? "back" : 'back_prof')),
              width: 30,
            ),
            onTap: () {
              Utils.playClickSound();
              Utils.performBack(context);
            },
          ),
          Spacer(),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            margin: title == StringRes.challenges ? EdgeInsets.only(right: 60) : EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: Injector.isBusinessMode ? null : BorderRadius.circular(20),
                border: Injector.isBusinessMode ? null : Border.all(width: 1, color: ColorRes.white),
                color: Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
                image: Injector.isBusinessMode
                    ? DecorationImage(
                        image: AssetImage(
                          Utils.getAssetsImg("bg_blue"),
                        ),
                        fit: BoxFit.fill)
                    : null),
            child: Text(
              Utils.getText(context, Utils.getText(context, title)),
              style: TextStyle(
                color: ColorRes.white,
                fontSize: DimenRes.titleTextSize,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Spacer(),
          InkWell(
            onTap: () async {
              if (isDescSelected) {
                isDescSelected = false;
              }
              isAscSelected = !isAscSelected;
              if (isAscSelected) {
                arrQuestions.sort((a, b) => (a.daysInList).compareTo(b.daysInList));
                getQuestionsBloc.getQuestionSubject.sink.add(arrQuestions);
              } else {
                QuestionRequest rq = QuestionRequest();
                rq.userId = Injector.userData.userId;
                rq.type = Const.getNewQueType;
                await getQuestionsBloc.getQuestion(rq);
              }
              setState(() {});
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              margin: title == StringRes.challenges ? EdgeInsets.only(right: 60) : EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                  borderRadius: Injector.isBusinessMode ? null : BorderRadius.circular(20),
                  border: Injector.isBusinessMode ? null : Border.all(width: 1, color: ColorRes.white),
                  color: Injector.isBusinessMode ? null : (isAscSelected ? ColorRes.titleBlueProf : ColorRes.lightGrey),
                  image: Injector.isBusinessMode
                      ? DecorationImage(
                          image: AssetImage(
                            Utils.getAssetsImg("bg_blue"),
                          ),
                          fit: BoxFit.fill)
                      : null),
              child: Text(
                "Asc",
                style: TextStyle(
                  color: ColorRes.white,
                  fontSize: DimenRes.titleTextSize,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              if (isAscSelected) {
                isAscSelected = false;
              }
              isDescSelected = !isDescSelected;
              if (isDescSelected) {
                arrQuestions.sort((a, b) => (b.daysInList).compareTo(a.daysInList));
                getQuestionsBloc.getQuestionSubject.sink.add(arrQuestions);
              } else {
                QuestionRequest rq = QuestionRequest();
                rq.userId = Injector.userData.userId;
                rq.type = Const.getNewQueType;
                await getQuestionsBloc.getQuestion(rq);
              }
              setState(() {});
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              margin: title == StringRes.challenges ? EdgeInsets.only(right: 60) : EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                  borderRadius: Injector.isBusinessMode ? null : BorderRadius.circular(20),
                  border: Injector.isBusinessMode ? null : Border.all(width: 1, color: ColorRes.white),
                  color: Injector.isBusinessMode ? null : (isDescSelected ? ColorRes.titleBlueProf : ColorRes.lightGrey),
                  image: Injector.isBusinessMode
                      ? DecorationImage(
                          image: AssetImage(
                            Utils.getAssetsImg("bg_blue"),
                          ),
                          fit: BoxFit.fill)
                      : null),
              child: Text(
                "Desc",
                style: TextStyle(
                  color: ColorRes.white,
                  fontSize: DimenRes.titleTextSize,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget kePoint(int index) {
    if (Injector.userData.language == "Chinese") {
      return Text(
        ("${arrQuestions[index].value.toString()}"),
        style: TextStyle(color: ColorRes.textRecordBlue, fontSize: 18),
        textAlign: TextAlign.center,
        maxLines: 1,
      );
    }
    return Text(
      ("${arrQuestions[index].value.toString()} ${!Injector.isBusinessMode ? Utils.getText(context, StringRes.strKp) : "\$"}"),
      style: TextStyle(color: ColorRes.textRecordBlue, fontSize: 18),
      textAlign: TextAlign.center,
      maxLines: 1,
    );
  }

  void initData() {
    questionAnswered = Injector.customerValueData?.totalAttemptedQuestion;
    loyaltyBonus = Injector.customerValueData?.loyaltyBonus;
    resourceBonus = Injector.customerValueData?.resourceBonus;
    valueBonus = Injector.customerValueData?.valueBonus;

    Utils.isInternetConnected().then((isConnected) async {
      if (isConnected) {
        QuestionRequest rq = QuestionRequest();
        rq.userId = Injector.userData.userId;
        rq.type = Const.getNewQueType;
        await getQuestionsBloc.getQuestion(rq);
//        getQuestions(_scaffoldKey.currentContext);
      } else {
        arrQuestions = Utils.getQuestionsLocally(Const.getNewQueType);

        if (arrQuestions != null && arrQuestions.length > 0) {
          getQuestionsBloc.updateQuestions(arrQuestions);

//          if (mounted) setState(() {});
        }
      }
    });
  }

  showValueText(String s) {
    return Injector.isDev
        ? Text(
            s,
            style: TextStyle(color: ColorRes.white),
          )
        : Container();
  }

  showData(List<QuestionData> data) {
    arrQuestions = data;
    return ListView.builder(
      itemCount: arrQuestions.length,
      itemBuilder: (BuildContext context, int index) {
        return showItem(index);
      },
    );
  }

  void attemptQuestion(int index) {
    HomeData homeData = HomeData(initialPageType: Const.typeEngagement, questionHomeData: arrQuestions[index], value: arrQuestions[index].value);

    navigationBloc.updateNavigation(homeData);
  }
}
