import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/background.dart';
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

  int questionAnswered = 1;
  int loyaltyBonus = 0;
  int resourceBonus = 0;
  int valueBonus = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Utils.isInternetConnectedWithAlert().then((isConnected) {
      if (isConnected) {
        getQuestions();
      } else {
        if (Injector.prefs.getStringList(PrefKeys.questionData) != null) {
          List<String> jsonQuestionData =
              Injector.prefs.getStringList(PrefKeys.questionData);

          jsonQuestionData.forEach((jsonQuestion) {
            arrQuestions.add(QuestionData.fromJson(json.decode(jsonQuestion)));
          });

          if (arrQuestions != null) {
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

    WebApi().getQuestions(rq.toJson()).then((data) {
      setState(() {
        isLoading = false;
      });

      if (data != null) {
        if (data.flag == "true") {
          arrQuestions = data.data;
        } else {
          Utils.showToast(data.msg);
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
                      ("${getValue(arrQuestions[index])} \$"),
                      style: TextStyle(
                          color: ColorRes.textRecordBlue, fontSize: 15),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      ("${getLoyalty(arrQuestions[index])} d"),
                      style: TextStyle(
                          color: ColorRes.textRecordBlue, fontSize: 15),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      getResource(arrQuestions[index]),
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
            if (Injector.userData.salesPersonCount >
                arrQuestions[index].resource) {
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

  getValue(QuestionData questionData) {
    var random = ((Random().nextInt(10))) / 10;

    var a = 500 + min(50 * questionData.daysInList, 350) + random * 150;
    var b = (1 + (0.01 * min(questionAnswered, 900)));
    var c = (1 + valueBonus);

    var finalValue = (a * b * c).toStringAsFixed(0);

    print("finalValue");
    print(finalValue);

    return finalValue;
  }

  getLoyalty(QuestionData questionData) {
    var random = ((Random().nextInt(10))) / 10;

    var a = max(pow(questionData.counter, 2), 1);
    var b = questionData.counter * random;
    var c = (1 + loyaltyBonus);

    var finalValue = (a + b * c).toStringAsFixed(0);

    print("finalValue");
    print(finalValue);

    return finalValue;
  }

  getResource(QuestionData questionData) {
//    =ROUND((MAX(MIN(K16,10)^1.2,1)+(MIN(K16,10)*RAND()))*(1+(0.01*MIN($K$12,900)))*(2-$N$14),0)

    var random = ((Random().nextInt(10))) / 10;

    var a = max(pow(min(questionData.counter, 10), 1.2), 1) +
        min(questionData.counter, 10) * random;
    var b = (1 + (0.01 * min(questionAnswered, 900)));
    var c = (2 - resourceBonus);

    var finalValue = (a * b * c).toStringAsFixed(0);

    print("finalValue");
    print(finalValue);

    return finalValue;
  }
}
