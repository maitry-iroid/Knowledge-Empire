import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ke_employee/BLoC/customer_value_bloc.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/header_utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/get_customer_value.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'challenge_header.dart';

ValueNotifier<bool> employeeDrainNotifier = ValueNotifier<bool>(false);
ValueNotifier<bool> saleDrainNotifier = ValueNotifier<bool>(false);
ValueNotifier<bool> serviceDrainNotifier = ValueNotifier<bool>(false);

Timer empAnimTimer;
Timer saleAnimTimer;
Timer serviceAnimTimer;

class DummyView extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool isShowMenu;
  final bool isChallenge;
  final int challengeCount;
  final int currentIndex;

  DummyView({this.scaffoldKey, this.isShowMenu, this.isChallenge, this.challengeCount, this.currentIndex});

  @override
  DummyViewState createState() => DummyViewState();
}

class DummyViewState extends State<DummyView> {
  @override
  void didUpdateWidget(DummyView oldWidget) {
    if (Injector.headerStreamController == null) Injector.headerStreamController = StreamController.broadcast();

    CustomerValueRequest rq = CustomerValueRequest();
    rq.userId = Injector.userData.userId;

    Injector.headerStreamController.stream.listen((data) {
      if (mounted) setState(() {});
    }, onDone: () {
      print("Task Done1");
    }, onError: (error) {
      print("Some Error1");
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return showDummyView(context);
  }

  Widget showDummyView(BuildContext context) {
    return Container(
      height: Utils.getHeaderHeight(context) + 150,
      color: Colors.transparent,
      child: StreamBuilder(
          stream: customerValueBloc.customerValue,
          builder: (context, AsyncSnapshot<CustomerValueData> snapshot) {
            if (snapshot.hasData) {
              return _buildSearchResults(snapshot?.data);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return _buildSearchResults(snapshot?.data);
          }),
    );
  }

  Widget showHeaderItem(String type, BuildContext context, valueListenable) {
    return Container(
      margin: EdgeInsets.only(top: 13.5),
      padding: EdgeInsets.symmetric(horizontal: Injector.isBusinessMode ? 4 : 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Injector.isBusinessMode ? Container() : Container(),
              Opacity(
                opacity: 0.0,
                child: Image(
                  image: AssetImage(Utils.getAssetsImg(HeaderUtils.getHeaderIcon(type))),
                  height: 26,
                ),
              ),
              valueListenable != null ? animatedPositioned(HeaderUtils.getHeaderIcon(type), valueListenable, context) : Container(),
            ],
          ),
          SizedBox(
            width: 4,
          ),
          type != Const.typeMoney
              ? Opacity(
                  opacity: 0.0,
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: <Widget>[
                      Container(
                        height: Injector.isBusinessMode ? 22 : 23,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: ColorRes.greyText,
                            borderRadius: BorderRadius.circular(12),
                            border: Injector.isBusinessMode ? null : Border.all(color: ColorRes.white, width: 1)),
                        padding: EdgeInsets.symmetric(vertical: 0, horizontal: Injector.isBusinessMode ? 0 : 1),
                        child: LinearPercentIndicator(
                          width: Utils.getDeviceWidth(context) / 12,
                          lineHeight: 22.0,
                          percent: HeaderUtils.getProgressInt(type)?.toDouble() ?? 0.toDouble(),
                          backgroundColor: Colors.transparent,
                          progressColor: Injector.isBusinessMode ? Colors.blue : ColorRes.titleBlueProf,
                        ),
                      ),
                      Positioned(
                        left: 4,
                        child: Text(
                          HeaderUtils.getProgress(type).toString() + (type == Const.typeBrandValue ? "%" : ""),
                          style: TextStyle(color: ColorRes.white, fontSize: 17),
                        ),
                      )
                    ],
                  ),
                )
              : Opacity(
                  opacity: 0.0,
                  child: Container(
                    width: Utils.getDeviceWidth(context) / 12,
                    child: Text(
                      Injector.customerValueData != null ? Injector.customerValueData.totalBalance.toString() : "00.00",
                      style: TextStyle(color: ColorRes.white, fontSize: 18),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  showProfile(BuildContext context) {
    return Expanded(
      child: Opacity(
        opacity: 0.0,
        child: Container(
          margin: EdgeInsets.only(top: 7.3),
          foregroundDecoration: null,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: Injector.userData == null || Injector.userData.profileImage == null || Injector.userData.profileImage.isEmpty
                            ? AssetImage(Utils.getAssetsImg('user_org'))
                            : Utils.getCacheNetworkImage(Injector.userData.profileImage),
                        fit: BoxFit.cover),
                    border: Border.all(color: ColorRes.textLightBlue)),
              ),
              showUserNameCompanyName(context),
            ],
          ),
        ),
      ),
    );
  }

  showHelpView(BuildContext context) {
    return Opacity(
      opacity: 0.0,
      child: Container(
        height: 20,
        width: 20,
        padding: EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(Utils.getAssetsImg("question_mark_help")))),
      ),
    );
  }

  showUserNameCompanyName(BuildContext context) {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          Injector.userData != null ? Injector.userData.companyName : "",
          style: TextStyle(color: Injector.isBusinessMode ? ColorRes.textLightBlue : ColorRes.white, fontSize: 17),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          Injector.userData != null ? Injector.userData.name : "",
          style: TextStyle(color: Injector.isBusinessMode ? ColorRes.white : ColorRes.textLightBlue, fontSize: 17),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        )
      ],
    ));
  }

  showMenuView() {
    return widget.isShowMenu
        ? Container(
            height: Utils.getHeaderHeight(context),
            child: Image(
              image: AssetImage(
                Utils.getAssetsImg("menu"),
              ),
              fit: BoxFit.fill,
            ),
          )
        : Container();
  }

  _buildSearchResults(CustomerValueData data) {
    if (widget.isChallenge != null && widget.isChallenge) {
      if (widget.challengeCount != null) {
        int indexData = Injector.countList
            .indexWhere((QuestionCountWithData questionCountWithData) => questionCountWithData.questionIndex == widget.currentIndex);
        if (indexData == -1) {
          indexData = 0;
        }
        return ChallengeHeader(challengeCount: widget.challengeCount, currentIndex: indexData);
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        showMenuView(),
        showProfile(context),
        Utils.isFeatureOn(Const.typeOrg) ? showHeaderItem(Const.typeEmployee, context, employeeDrainNotifier) : Container(),
        Utils.isFeatureOn(Const.typeOrg) ? showHeaderItem(Const.typeSalesPersons, context, saleDrainNotifier) : Container(),
        Utils.isFeatureOn(Const.typeOrg) ? showHeaderItem(Const.typeServicesPerson, context, serviceDrainNotifier) : Container(),
        Opacity(opacity: 0.0, child: showHeaderItem(Const.typeBrandValue, context, null)),
        Opacity(opacity: 0.0, child: showHeaderItem(Const.typeMoney, context, null)),
        showHelpView(context)
      ],
    );
  }

  Widget animatedPositioned(String icon, valueListenable, BuildContext context) {
    print("valueAnimation listner " + valueListenable.toString());
    return ValueListenableBuilder(
      valueListenable: valueListenable,
      builder: (BuildContext context, value, Widget child) {
        print("valueAnimation" + value.toString());
        return AnimatedPositioned(
          top: value != null && value ? 50.0 : 0,
          duration: Duration(milliseconds: value ? 200 : 0),
          onEnd: () {
            valueListenable.value = false;
            valueListenable.notifyListeners();
          },
          child: Container(
            width: 26.0,
            height: 26.0,
            child: AnimatedOpacity(
                duration: Duration(milliseconds: value ? 200 : 0),
                opacity: value ? 0.0 : 1.0,
                child: Image.asset(Utils.getAssetsImg(icon), width: 26, height: 26)),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    employeeDrainNotifier.value = false;
    saleDrainNotifier.value = false;
    serviceDrainNotifier.value = false;
    super.dispose();
  }
}
