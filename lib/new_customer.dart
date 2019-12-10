import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/engagement_customer.dart' as prefix0;
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/home.dart';
import 'package:ke_employee/injection/dependency_injection.dart';

import 'helper/constant.dart';
import 'helper/string_res.dart';
import 'helper/web_api.dart';
import 'models/questions.dart';

class NewCustomerPage extends StatefulWidget {
  @override
  _NewCustomerPageState createState() => _NewCustomerPageState();
}

class _NewCustomerPageState extends State<NewCustomerPage> {
  bool isLoading = false;

  List<QuestionData> arrQuestions = List();

  int questionAnswered = 0;
  int loyaltyBonus = 0;
  int resourceBonus = 0;
  int valueBonus = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    questionAnswered = Injector.customerValueData.totalAttemptedQuestion;
    loyaltyBonus = Injector.customerValueData.loyaltyBonus;
    resourceBonus = Injector.customerValueData.resourceBonus;
    valueBonus = Injector.customerValueData.valueBonus;

//    getQuestions();

    Utils.isInternetConnected().then((isConnected) {
      if (isConnected) {
        getQuestions();
      } else {
        if (Injector.prefs.getString(PrefKeys.questionData) != null) {
          arrQuestions = QuestionsResponse.fromJson(
                  json.decode(Injector.prefs.getString(PrefKeys.questionData)))
              .data;

//          arrQuestions.forEach((question) {
//
//            if (questionData.attemptTime == 0 ||
//                questionData.attemptTime -
//                        DateTime.now().millisecondsSinceEpoch >
//                    24) arrQuestions.add(questionData);
//          });

          if (arrQuestions != null && arrQuestions.length > 0) {
            setState(() {});
          }
        }
      }
    });
  }

  getQuestions() {
    setState(() {
      isLoading = true;
    });

    QuestionRequest rq = QuestionRequest();
    rq.userId = Injector.userData.userId;

    rq.type = Const.getNewQueType;

    WebApi().getQuestions(rq.toJson()).then((questionResponse) {
      setState(() {
        isLoading = false;
      });

      if (questionResponse != null) {
        if (questionResponse.flag == "true") {
          arrQuestions = questionResponse.data;

        } else {
          Utils.showToast(questionResponse.msg);
        }
      } else {
        Utils.showToast(Utils.getText(context, StringRes.somethingWrong));
      }
    });
  }

  Widget showCircularProgress() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

//  CommonView.showCircularProgress(isLoading)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: <Widget>[
          Align(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: CommonView.getBGDecoration(),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    CommonView.showTitle(context, StringRes.newCustomers),
                    showSubHeader(),
                    showItems()
                  ],
                ),
              ),
            ),
          ),
          Container(child: showCircularProgress()),
        ],
      ),
    ));
  }

  Expanded showItems() {
    return Expanded(
      child: ListView.builder(
        itemCount: arrQuestions.length,
        itemBuilder: (BuildContext context, int index) {
          return showItem(index);
        },
      ),
    );
  }

  Container showSubHeader() {
    return Container(
      height: Injector.isBusinessMode ? 30 : 25,
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
              style: Theme.of(context).textTheme.body1,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              Utils.getText(context, StringRes.sector),
              style: Theme.of(context).textTheme.body1,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              Utils.getText(context, StringRes.value),
              style: Theme.of(context).textTheme.body1,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              Utils.getText(context, StringRes.loyalty),
              style: Theme.of(context).textTheme.body1,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              Utils.getText(context, StringRes.resources),
              style: Theme.of(context).textTheme.body1,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              Utils.getText(context, StringRes.engage),
              style: Theme.of(context).textTheme.body1,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget showItem(int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
              height: Injector.isBusinessMode ? 30 : 25,
              padding: EdgeInsets.only(left: 10),
              margin: EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                  color: Injector.isBusinessMode ? null : ColorRes.white,
                  borderRadius: Injector.isBusinessMode
                      ? null
                      : BorderRadius.circular(20),
                  image: Injector.isBusinessMode
                      ? DecorationImage(
                          image:
                              AssetImage(Utils.getAssetsImg("bg_record_white")),
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
                        fontSize: 15,
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
                          color: ColorRes.textRecordBlue, fontSize: 15),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      ("${getValue(index).toString()} \$"),
                      style: TextStyle(
                          color: ColorRes.textRecordBlue, fontSize: 15),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      ("${getLoyalty(index).toString()} d"),
                      style: TextStyle(
                          color: ColorRes.textRecordBlue, fontSize: 15),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      getResource(index).toString(),
                      style: TextStyle(
                          color: ColorRes.textRecordBlue, fontSize: 15),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ),
                ],
              )),
        ),
        InkResponse(
          child: Container(
              height: Injector.isBusinessMode ? 32 : 25,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 10, right: 2),
              padding: EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                  color: Injector.isBusinessMode ? null : ColorRes.headerBlue,
                  borderRadius: Injector.isBusinessMode
                      ? null
                      : BorderRadius.circular(20),
                  image: Injector.isBusinessMode
                      ? DecorationImage(
                          image:
                              AssetImage(Utils.getAssetsImg("bg_engage_now")),
                          fit: BoxFit.fill)
                      : null),
              child: Text(
                Utils.getText(context, StringRes.engageNow),
                style: TextStyle(color: ColorRes.white, fontSize: 14),
              )),
          onTap: () {
            Utils.playClickSound();
            if (Utils.getSalesPersonCount() > arrQuestions[index].resource) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(
                            initialPageType: Const.typeEngagement,
                            questionDataHomeScr: arrQuestions[index],
                          )));
            } else {
              Utils.showToast("You need atleast " +
                  arrQuestions[index].resource.toString() +
                  " Sales persons to attempt this Question. You can add more Sales persons from the Organization.");
            }
          },
        ),
      ],
    );
  }

  getValue(int index) {
    QuestionData questionData = arrQuestions[index];

    var random = ((Random().nextInt(10))) / 10;

    var a = 500 + min(50 * questionData.daysInList, 350) + random * 150;
    var b = (1 + (0.01 * min(questionAnswered, 900)));
    var c = (1 + valueBonus);

    int finalValue = (a * b * c).round();

    questionData.value = finalValue;

    arrQuestions[index] = questionData;

    return finalValue;
  }

  getLoyalty(int index) {
    QuestionData questionData = arrQuestions[index];

    var random = ((Random().nextInt(10))) / 10;

    var a = max(pow(questionData.counter, 2), 1);
    var b = questionData.counter * random;
    var c = (1 + loyaltyBonus);

    int finalValue = (a + b * c).round();

    questionData.loyalty = finalValue;

    arrQuestions[index] = questionData;

    return finalValue;
  }

  getResource(int index) {
    QuestionData questionData = arrQuestions[index];

//    =ROUND((MAX(MIN(K16,10)^1.2,1)+(MIN(K16,10)*RAND()))*(1+(0.01*MIN($K$12,900)))*(2-$N$14),0)

    var random = ((Random().nextInt(10))) / 10;

    var a = max(pow(min(questionData.counter, 10), 1.2), 1) +
        min(questionData.counter, 10) * random;
    var b = (1 + (0.01 * min(questionAnswered, 900)));
    var c = (2 - resourceBonus);

    int finalValue = (a * b * c).round();

    questionData.resource = finalValue;

    arrQuestions[index] = questionData;

    return finalValue;
  }
}
