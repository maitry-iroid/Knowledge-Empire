import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/BLoC/customer_value_bloc.dart';
import 'package:ke_employee/BLoC/get_question_bloc.dart';
import 'package:ke_employee/BLoC/navigation_bloc.dart';
import 'package:ke_employee/dialogs/display_dailogs.dart';
import 'package:ke_employee/models/get_customer_value.dart';
import 'package:ke_employee/models/homedata.dart';

import '../commonview/common_view.dart';
import '../helper/Utils.dart';
import '../helper/constant.dart';

import '../helper/res.dart';
import '../helper/string_res.dart';
import '../helper/web_api.dart';
import '../injection/dependency_injection.dart';
import '../models/questions.dart';
import '../models/releaseResource.dart';

/*
*   created by Riddhi
*
*   All Correct attempted questions will b displayed here until its locality finishes
*   User can stop getting locality by and can release the resource to attempt other questions
*
* */

class ExistingCustomerPage extends StatefulWidget {
  @override
  _ExistingCustomerPageState createState() => _ExistingCustomerPageState();
}

class _ExistingCustomerPageState extends State<ExistingCustomerPage> {
  List<QuestionData> arrQuestions = List();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    initContent();
  }

  Future initContent() async {
    if (Injector.introData != null && Injector.introData.existingCustomer1 == 0) {
      await DisplayDialogs.showIntroExisting1(context);
    }

    QuestionRequest rq = QuestionRequest();
    rq.userId = Injector.userData.userId;
    rq.type = Const.getExistingQueType;
    await getQuestionsBloc?.getQuestion(rq);
  }

  void releaseResource(int index) {
    Utils.isInternetConnectedWithAlert(context).then((_) {
      QuestionData questionData = arrQuestions[index];

      ReleaseResourceRequest rq = ReleaseResourceRequest();
      rq.userId = Injector.userData.userId;
      rq.questionId = questionData.questionId;
      rq.moduleId = questionData.moduleId;
      rq.resources = questionData.resources;
      rq.value = questionData.value;

//      customerValueBloc?.releaseResource(rq);

      CommonView.showCircularProgress(true, context);
      WebApi().callAPI(WebApi.rqReleaseResource, rq.toJson()).then((data) async {
        CommonView.showCircularProgress(false, context);

        if (data != null) {
          CustomerValueData customerValueData = CustomerValueData.fromJson(data);

          customerValueBloc?.setCustomerValue(customerValueData);

          arrQuestions.removeAt(index);
          getQuestionsBloc?.updateQuestions(arrQuestions);
        } else {
          Utils.showToast(Utils.getText(context, StringRes.somethingWrong));
        }
      }).catchError((e) {
        print("releaseResources_" + e.toString());
        CommonView.showCircularProgress(false, context);
        // Utils.showToast(e.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: ColorRes.colorBgDark,
        body: Stack(
          children: <Widget>[
            CommonView.showBackground(context),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, top: Utils.getHeaderHeight(context)),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  CommonView.showTitle(context, StringRes.existingCustomers),
                  showSubHeader(),
                  showItems(),
                ],
              ),
            ),
          ],
        ));
  }

  Expanded showItems() {
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
          }),
    );
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

  Container showSubHeader() {
    return Container(
      height: Injector.isBusinessMode ? 35 : 30,
      margin: EdgeInsets.only(top: 8, bottom: 5),
      padding: EdgeInsets.only(right: 3),
      decoration: BoxDecoration(
          color: Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
          borderRadius: Injector.isBusinessMode ? null : BorderRadius.circular(20),
          image: Injector.isBusinessMode ? DecorationImage(image: AssetImage(Utils.getAssetsImg("bg_rounded")), fit: BoxFit.fill) : null),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Text(
              Utils.getText(context, StringRes.name),
              overflow: TextOverflow.fade,
              softWrap: false,
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          Expanded(
            flex: 7,
            child: Text(
              Utils.getText(context, StringRes.sector),
              overflow: TextOverflow.fade,
              softWrap: false,
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              Utils.getText(context, StringRes.value),
              overflow: TextOverflow.fade,
              softWrap: false,
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              Utils.getText(context, StringRes.loyalty),
              overflow: TextOverflow.fade,
              softWrap: false,
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              Utils.getText(context, StringRes.endRel),
              overflow: TextOverflow.fade,
              softWrap: false,
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
    return Row(
      children: <Widget>[
        Expanded(
          child: InkResponse(
            child: Container(
                height: Injector.isBusinessMode ? 35 : 30,
                margin: EdgeInsets.symmetric(vertical: 3),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Injector.isBusinessMode ? null : ColorRes.white,
                    borderRadius: Injector.isBusinessMode ? null : BorderRadius.circular(20),
                    image:
                        Injector.isBusinessMode ? DecorationImage(image: AssetImage(Utils.getAssetsImg("bg_record_white")), fit: BoxFit.fill) : null),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Text(
                        arrQuestions[index].title,
                        style: TextStyle(
                          color: ColorRes.blue,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Text(
                        arrQuestions[index].moduleName,
                        style: TextStyle(color: ColorRes.blue, fontSize: 18),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        arrQuestions[index].value.toString() + ' ${!Injector.isBusinessMode ? Utils.getText(context, StringRes.strKp) : "\$"}',
                        style: TextStyle(
                          color: ColorRes.blue,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        arrQuestions[index].loyalty.toString() + ' d',
                        style: TextStyle(color: ColorRes.blue, fontSize: 18),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                    ),
                  ],
                )),
            onTap: () {
              HomeData homeData = HomeData(
                  initialPageType: Const.typeCustomerSituation,
                  questionHomeData: arrQuestions[index],
                  isCameFromNewCustomer: false,
                  isChallenge: false);

//              Navigator.push(context, FadeRouteHome(homeData: homeData));
//              Navigator.push(_scaffoldKey.currentContext,
//                  FadeRouteHome(homeData: homeData));
              navigationBloc.updateNavigation(homeData);
            },
          ),
        ),
        InkResponse(
          child: Container(
            height: 35,
            width: 35,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 15, right: 20),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage(Utils.getAssetsImg("close")), fit: BoxFit.fill)),
          ),
          onTap: () {
            Utils.isInternetConnectedWithAlert(context).then((isConnected) {
              if (isConnected) {
                _asyncConfirmDialog(context, index);
              }
            });
          },
        )
      ],
    );
  }

  _asyncConfirmDialog(BuildContext context, int index) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            Utils.getText(context, StringRes.alertReleaseResources),
            style: TextStyle(fontSize: 20),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(Utils.getText(context, StringRes.ok), style: TextStyle(fontSize: 20)),
              onPressed: () {
                //alert pop
                Navigator.of(context).pop();
                releaseResource(index);
              },
            ),
            FlatButton(
              child: Text(
                Utils.getText(context, StringRes.cancel),
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                //alert pop
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
