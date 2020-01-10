import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/screens/home.dart';
import 'package:ke_employee/injection/dependency_injection.dart';

import '../helper/constant.dart';
import '../helper/string_res.dart';
import '../helper/web_api.dart';
import '../models/questions.dart';


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
              jsonDecode(Injector.prefs.getString(PrefKeys.questionData)))
              .data;

          arrQuestions.forEach((questionData) {

            DateTime newDateTimeObj2 = new DateFormat("dd/MM/yyyy HH:mm:ss").parse(questionData.attemptTime);
            print("question date string : -    ${questionData.attemptTime}");


            if (questionData.attemptTime.isEmpty ||
                newDateTimeObj2.millisecondsSinceEpoch
                   - DateTime.now().millisecondsSinceEpoch
                    >
                    24) arrQuestions.add(questionData);
          });

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
    rq.type = Const.getNewQueType;

    WebApi().getQuestions(rq.toJson()).then((questionResponse) async {
      if (questionResponse != null) {
        if (questionResponse.flag == "true") {
          arrQuestions = questionResponse.data;

          for (int i = 0; i < arrQuestions.length; i++) {
            arrQuestions[i].value = Utils.getValue(arrQuestions[i]);
            arrQuestions[i].loyalty = Utils.getLoyalty(arrQuestions[i]);
            arrQuestions[i].resources = Utils.getResource(arrQuestions[i]);

            print(arrQuestions[i].value);
//            print(arrQuestions[i].mediaLink);
          }

          setState(() {
            isLoading = false;
          });
        } else {
          Utils.showToast(questionResponse.msg);
          setState(() {
            isLoading = false;
          });
        }
      } else {
        Utils.showToast(Utils.getText(context, StringRes.somethingWrong));
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((e) {
      print(e);
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      Utils.showToast(e.toString());
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
                showSubHeader(),
                showItems()
              ],
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
//          print(("${getValue(index).toString()} \$"));
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
                      ("${arrQuestions[index].value.toString()} \$"),
                      style: TextStyle(
                          color: ColorRes.textRecordBlue, fontSize: 15),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      ("${arrQuestions[index].loyalty.toString()} d"),
                      style: TextStyle(
                          color: ColorRes.textRecordBlue, fontSize: 15),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      arrQuestions[index].resources.toString(),
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
//            if (currentVol != 0) {
            Utils.playClickSound();
//            }

            if (Injector.customerValueData.remainingSalesPerson >=
                    arrQuestions[index].resources &&
                Injector.customerValueData.remainingCustomerCapacity > 0) {
              Navigator.push(
                  context,
                  FadeRouteHome(
                      initialPageType: Const.typeEngagement,
                      questionDataHomeScr: arrQuestions[index],
                      value: arrQuestions[index].value));

/*              Navigator.push(
            if (Utils.getSalesPersonCount() >= arrQuestions[index].resources &&
                Utils.getServicesPersonCount() > 0) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(

                            initialPageType: Const.typeEngagement,
                            questionDataHomeScr: arrQuestions[index],
                          )));*/

            } else {
              Utils.showToast("You need atleast " +
                  arrQuestions[index].resources.toString() +
                  " Sales persons and 1 Service person to attempt this Question. You can add more Sales persons from the Organization.");
            }
          },
        ),
      ],
    );
  }
}

/*class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: RaisedButton(
          child: Text('Go Back!'),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}*/
