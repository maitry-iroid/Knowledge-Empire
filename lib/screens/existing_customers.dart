import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  bool isLoading = false;

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

      setState(() {
        isLoading = true;
      });

      WebApi().releaseResource(context, rq).then((getReleaseResourceData) {
        setState(() {
          isLoading = false;
        });

        if (getReleaseResourceData != null) {
          if (getReleaseResourceData.flag == "true") {
            Injector.customerValueData = getReleaseResourceData.data;
//          arrOrganization = getreleaseresourceData.organization;

            Injector.streamController.add("release resources");

            setState(() {
              arrQuestions.removeAt(index);

              isLoading = false;
            });
          } else {
            Utils.showToast(getReleaseResourceData.msg);
          }
        } else {
          Utils.showToast(Utils.getText(context, StringRes.somethingWrong));
        }
      }).catchError((e) {
        print("releaseResources_"+e.toString());
        setState(() {
          isLoading = false;
        });
        Utils.showToast(e.toString());
      });
    });
  }

  getQuestions() {
    setState(() {
      isLoading = true;
    });

    QuestionRequest rq = QuestionRequest();
    rq.userId = Injector.userData.userId;
    rq.type = Const.getExistingQueTYpe;

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
    }).catchError((e) {
      print("getQuestions_"+e.toString());
      setState(() {
        isLoading = false;
      });
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
            CommonView.showCircularProgress(isLoading)
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
              style: Theme.of(context).textTheme.body1,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          Expanded(
            flex: 7,
            child: Text(
              Utils.getText(context, StringRes.sector),
              style: Theme.of(context).textTheme.body1,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              Utils.getText(context, StringRes.value),
              style: Theme.of(context).textTheme.body1,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              Utils.getText(context, StringRes.loyalty),
              style: Theme.of(context).textTheme.body1,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              Utils.getText(context, StringRes.endRel),
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
