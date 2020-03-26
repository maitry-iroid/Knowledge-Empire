import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/BLoC/get_question_bloc.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/dialogs/display_dailogs.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/models/homedata.dart';
import 'package:ke_employee/screens/home.dart';
import 'package:ke_employee/injection/dependency_injection.dart';

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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    showIntroDialog();
  }

  Future<void> showIntroDialog() async {
    if (Injector.introData == null || Injector.introData.newCustomer1 == 0)
      await DisplayDialogs.showIntroHeartOfTheBusiness(context);

    initData();
  }

//  getQuestions(BuildContext context) {
//    CommonView.showCircularProgress(true, context);
//    QuestionRequest rq = QuestionRequest();
//    rq.userId = Injector.userData.userId;
//
//    rq.type = Const.getNewQueType;
//
//    WebApi().callAPI(WebApi.rqGetQuestions, rq.toJson()).then((data) async {
//      CommonView.showCircularProgress(false, context);
//
//      if (data != null) {
//        arrQuestions.clear();
//
//        data.forEach((v) {
//          arrQuestions.add(QuestionData.fromJson(v));
//        });
//
//        for (int i = 0; i < arrQuestions.length; i++) {
//          arrQuestions[i].value = Utils.getValue(arrQuestions[i]);
//          arrQuestions[i].loyalty = Utils.getLoyalty(arrQuestions[i]);
//          arrQuestions[i].resources = Utils.getResource(arrQuestions[i]);
//
//          print(arrQuestions[i].value);
//        }
//
//        if (mounted) setState(() {});
//      } else {
////        Utils.showToast(Utils.getText(
////            _scaffoldKey?.currentContext, StringRes.somethingWrong));
//
//      }
//    }).catchError((e) {
//      print("getQuestions_" + e.toString());
//      if (mounted) {
//        CommonView.showCircularProgress(false, context);
//      }
//      Utils.showToast(e.toString());
//    });
//  }

  @override
  Widget build(BuildContext context) {
//    showCupertinoDialog<String>(
//      context: context,
//      builder: (BuildContext context) => Particles(),
//    );

    return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              CommonView.showBackground(context),
              Container(
                margin: EdgeInsets.only(
                    left: 20, right: 20, top: Utils.getHeaderHeight(context)),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    CommonView.showTitle(context, StringRes.newCustomers),
                    showValueText("value bonus : " +
                        Injector.customerValueData.valueBonus.toString()),
                    showValueText("loyalty bonus : " +
                        Injector.customerValueData.loyaltyBonus.toString()),
                    showValueText("resource bonus : " +
                        Injector.customerValueData.resourceBonus.toString()),
                    showValueText("total attempted que : " +
                        Injector.customerValueData.totalAttemptedQuestion
                            .toString()),
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
              if (snapshot.hasData) {
                return showData(snapshot?.data);
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return CommonView.showShimmer();
            }));
  }

  Container showSubHeader(BuildContext context) {
    return Container(
      height: Injector.isBusinessMode ? 35 : 30,
      margin: EdgeInsets.only(left: 0, right: 4, top: 8, bottom: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
          image: Injector.isBusinessMode
              ? DecorationImage(
                  image: AssetImage(Utils.getAssetsImg("bg_rounded")),
                  fit: BoxFit.fill)
              : null),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              Utils.getText(context, StringRes.name),
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              Utils.getText(context, StringRes.sector),
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              Utils.getText(context, StringRes.value),
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              Utils.getText(context, StringRes.loyalty),
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              Utils.getText(context, StringRes.resources),
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              Utils.getText(context, StringRes.engage),
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget showItem(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        showValueText("counter : " + arrQuestions[index].counter.toString()),
        showValueText(
            "daysInList : " + arrQuestions[index].daysInList.toString()),
        InkResponse(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                    height: Injector.isBusinessMode ? 35 : 30,
                    padding: EdgeInsets.only(left: 10),
                    margin: EdgeInsets.symmetric(vertical: 3),
                    decoration: BoxDecoration(
                        color: Injector.isBusinessMode ? null : ColorRes.white,
                        borderRadius: Injector.isBusinessMode
                            ? null
                            : BorderRadius.circular(20),
                        image: Injector.isBusinessMode
                            ? DecorationImage(
                                image: AssetImage(
                                    Utils.getAssetsImg("bg_record_white")),
                                fit: BoxFit.fill)
                            : null),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: Text(
//                      Utils.getText(context, StringRes.newCustomers),
                            arrQuestions[index].title,
                            style: TextStyle(
                              color: ColorRes.textRecordBlue,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            arrQuestions[index].moduleName,
                            style: TextStyle(
                                color: ColorRes.textRecordBlue, fontSize: 18),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            ("${arrQuestions[index].value.toString()} \$"),
                            style: TextStyle(
                                color: ColorRes.textRecordBlue, fontSize: 18),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            ("${arrQuestions[index].loyalty.toString()} d"),
                            style: TextStyle(
                                color: ColorRes.textRecordBlue, fontSize: 18),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            arrQuestions[index].resources.toString(),
                            style: TextStyle(
                                color: ColorRes.textRecordBlue, fontSize: 18),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    )),
              ),
              InkResponse(
                child: Container(
                    height: Injector.isBusinessMode ? 35 : 28,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 10, right: 2),
                    padding: EdgeInsets.only(left: 15, right: 15),
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
                                    Utils.getAssetsImg("bg_engage_now")),
                                fit: BoxFit.fill)
                            : null),
                    child: Text(
                      Utils.getText(
                          _scaffoldKey.currentContext, StringRes.engageNow),
                      style: TextStyle(color: ColorRes.white, fontSize: 16),
                    )),
                onTap: () {
                  Utils.playClickSound();

                  if (Injector.customerValueData.remainingSalesPerson >=
                          arrQuestions[index].resources &&
                      Injector.customerValueData.remainingCustomerCapacity >
                          0) {
                    HomeData homeData = HomeData(
                        initialPageType: Const.typeEngagement,
                        questionDataHomeScr: arrQuestions[index],
                        value: arrQuestions[index].value);

                    Navigator.push(_scaffoldKey.currentContext,
                        FadeRouteHome(homeData: homeData));
                  } else {
                    Utils.showToast("You need atleast " +
                        arrQuestions[index].resources.toString() +
                        " Sales persons and 1 Service person to attempt this Question. You can add more Sales persons from the Organization.");
                  }
                },
              ),
            ],
          ),
          onTap: () {
            {
              Utils.playClickSound();

              if (Injector.customerValueData.remainingSalesPerson >=
                      arrQuestions[index].resources &&
                  Injector.customerValueData.remainingCustomerCapacity > 0) {
                HomeData homeData = HomeData(
                    initialPageType: Const.typeEngagement,
                    questionDataHomeScr: arrQuestions[index],
                    value: arrQuestions[index].value);

                Navigator.push(_scaffoldKey.currentContext,
                    FadeRouteHome(homeData: homeData));
              } else {
                Utils.showToast("You need atleast " +
                    arrQuestions[index].resources.toString() +
                    " Sales persons and 1 Service person to attempt this Question. You can add more Sales persons from the Organization.");
              }
            }
          },
        ),
      ],
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
}
