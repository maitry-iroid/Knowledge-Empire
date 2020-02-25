import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/BLoC/learning_module_bloc.dart';
import 'package:ke_employee/models/get_customer_value.dart';

import '../commonview/background.dart';
import '../helper/Utils.dart';
import '../helper/constant.dart';

import '../helper/res.dart';
import '../helper/string_res.dart';
import '../helper/web_api.dart';
import '../injection/dependency_injection.dart';
import '../models/questions.dart';
import '../models/releaseResource.dart';

class ExistingCustomerPage extends StatefulWidget {
  @override
  _ExistingCustomerPageState createState() => _ExistingCustomerPageState();
}

class _ExistingCustomerPageState extends State<ExistingCustomerPage> {
  List<QuestionData> arrQuestions = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Utils.isInternetConnected().then((isConnected) {
      if (isConnected) {
        getQuestions();
      } else {
        arrQuestions = Utils.getQuestionsLocally(Const.getExistingQueTYpe);

        if (arrQuestions != null && arrQuestions.length > 0) {
          arrQuestions = arrQuestions;
          setState(() {});
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

//    _notifier.dispose();
    super.dispose();
  }

  void releaseResource(int index) {
    Utils.isInternetConnectedWithAlert().then((_) {
      QuestionData questionData = arrQuestions[index];

      ReleaseResourceRequest rq = ReleaseResourceRequest();
      rq.userId = Injector.userData.userId;
      rq.questionId = questionData.questionId;
      rq.moduleId = questionData.moduleId;
      rq.resources = questionData.resources;
      rq.value = questionData.value;

//      customerValueBloc?.releaseResource(rq);

      CommonView.showCircularProgress(true, context);
      WebApi().callAPI(WebApi.rqReleaseResource, rq.toJson()).then((data) {
        CommonView.showCircularProgress(false, context);

        if (data != null) {

          CommonView.showCircularProgress(false, context);

          CustomerValueData customerValueData =
              CustomerValueData.fromJson(data);

          Injector.setCustomerValueData(customerValueData);

          Injector.streamController.add("release resources");

          setState(() {
            arrQuestions.removeAt(index);


          });
        } else {
          Utils.showToast(Utils.getText(context, StringRes.somethingWrong));
        }
      }).catchError((e) {
        print("releaseResources_" + e.toString());
        CommonView.showCircularProgress(false, context);
        Utils.showToast(e.toString());
      });
    });
  }

  getQuestions() {
    CommonView.showCircularProgress(true, context);

    QuestionRequest rq = QuestionRequest();
    rq.userId = Injector.userData.userId;
    rq.type = Const.getExistingQueTYpe;

    WebApi().callAPI(WebApi.rqGetQuestions, rq.toJson()).then((data) {
      CommonView.showCircularProgress(false, context);

      if (data != null) {
        data.forEach((v) {
          arrQuestions.add(QuestionData.fromJson(v));
        });

        if(arrQuestions.isNotEmpty)
          setState(() {

          });

      }
    }).catchError((e) {
      print("getQuestions_" + e.toString());
      CommonView.showCircularProgress(false, context);
      Utils.showToast(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorRes.colorBgDark,
        body: Stack(
          children: <Widget>[
            CommonView.showBackground(context),
            Container(
              margin: EdgeInsets.only(
                  left: 30, right: 30, top: Utils.getHeaderHeight(context)),
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
      margin: EdgeInsets.only(top: 8, bottom: 5),
      padding: EdgeInsets.only(right: 3),
      decoration: BoxDecoration(
          color: Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
          borderRadius:
              Injector.isBusinessMode ? null : BorderRadius.circular(20),
          image: Injector.isBusinessMode
              ? DecorationImage(
                  image: AssetImage(Utils.getAssetsImg("bg_rounded")),
                  fit: BoxFit.fill)
              : null),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Text(
              Utils.getText(context, StringRes.name),
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          Expanded(
            flex: 7,
            child: Text(
              Utils.getText(context, StringRes.sector),
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              Utils.getText(context, StringRes.value),
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              Utils.getText(context, StringRes.loyalty),
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              Utils.getText(context, StringRes.endRel),
              style: TextStyle(color: Colors.white),
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
          child: Container(
              height: Injector.isBusinessMode ? 30 : 25,
              margin: EdgeInsets.symmetric(vertical: 5),
              alignment: Alignment.center,
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
                    flex: 5,
                    child: Text(
                      arrQuestions[index].title,
                      style: TextStyle(
                        color: ColorRes.blue,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      arrQuestions[index].moduleName,
                      style: TextStyle(color: ColorRes.blue, fontSize: 15),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      arrQuestions[index].value.toString() + ' \$',
                      style: TextStyle(
                        color: ColorRes.blue,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      arrQuestions[index].loyalty.toString() + ' d',
                      style: TextStyle(color: ColorRes.blue, fontSize: 15),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ),
                ],
              )),
        ),
        InkResponse(
          child: Container(
            height: 35,
            width: 35,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 15, right: 20),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Utils.getAssetsImg("close")),
                    fit: BoxFit.fill)),
          ),
          onTap: () {
            Utils.isInternetConnectedWithAlert().then((isConnected) {
              if (isConnected) {
                releaseResource(index);
              }
            });
          },
        )
      ],
    );
  }
}
