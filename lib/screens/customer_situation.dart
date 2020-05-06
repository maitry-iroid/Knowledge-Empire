import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/BLoC/challenge_question_bloc.dart';
import 'package:ke_employee/BLoC/navigation_bloc.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/commonview/challenge_header.dart';
import 'package:ke_employee/commonview/header.dart';
import 'package:ke_employee/commonview/my_home.dart';
import 'package:ke_employee/dialogs/display_dailogs.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/homedata.dart';
import 'package:ke_employee/screens/refreshAnimation.dart';

//import 'package:simple_pdf_viewer/simple_pdf_viewer.dart';
import 'package:video_player/video_player.dart';
import 'engagement_customer.dart';
import '../helper/constant.dart';
import '../helper/res.dart';

import '../commonview/background.dart';
import 'home.dart';
import '../models/questions.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

List<Answer> arrAnswerSituation = List();

QuestionData questionDataCustSituation = QuestionData();

VideoPlayerController _controller;

List abcdList = List();

FileInfo fileInfo;

HomeData homeData;

correctWrongImage() {
  if (homeData != null && homeData.isCameFromNewCustomer) {
    return questionDataCustSituation.correctAnswerImage;
  } else {
    return questionDataCustSituation.isAnsweredCorrect == true
        ? questionDataCustSituation.correctAnswerImage
        : questionDataCustSituation.inCorrectAnswerImage;
  }
}

class CustomerSituationPage extends StatefulWidget {
  final HomeData homeData;

  CustomerSituationPage({Key key, this.homeData}) : super(key: key);

  @override
  _CustomerSituationPageState createState() => _CustomerSituationPageState();
}

class _CustomerSituationPageState extends State<CustomerSituationPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  QuestionData questionDataCustomerSituation;
  bool isChallenge;
  bool isCameFromNewCustomer;

  int index = 1;

//  bool isGif = true;

  List alphaIndex = ['A', 'B', 'C', 'D'];

  selectItem(index) {}

//  int duration = 4;

  @override
  void initState() {
    questionDataCustomerSituation = widget.homeData.questionHomeData;
    isChallenge = widget.homeData.isChallenge;
    isCameFromNewCustomer = widget.homeData.isCameFromNewCustomer;
    homeData = widget.homeData;
    showIntroDialog();

    super.initState();
  }

  Future<void> showIntroDialog() async {
    questionDataCustSituation = questionDataCustomerSituation;
    arrAnswerSituation = questionDataCustomerSituation?.answer;

    abcdList = alphaIndex;

    correctWrongImage();

    if (questionDataCustSituation.isAnsweredCorrect == true) {
      if (Injector.introData == null ||
          Injector.introData.customerSituation == null ||
          Injector.introData.customerSituation == 0) {
        await DisplayDialogs.showIntroCustomerSituation(context);
        Injector.introData.customerSituation = 1;
        await Injector.setIntroData(Injector.introData);
      }

      if (isCameFromNewCustomer || isChallenge) {
        Utils.checkAudio(questionDataCustSituation.isAnsweredCorrect);
        if (!isChallenge ||
            (Injector.countList.length == questionData.questionCurrentIndex)) {
          Injector.homeStreamController?.add("${Const.typeMoneyAnim}");
        }
        Utils.checkAudio(questionData.isAnsweredCorrect);
      }

      int index = Injector.countList.indexWhere(
          (QuestionCountWithData questionCountWithData) =>
              questionCountWithData.questionIndex ==
              questionData.questionCurrentIndex);

      if (index != -1) {
        Injector.countList[index].color = ColorRes.greenDot;
        getChallengeQueBloc?.updateQuestions(index, true);
      }
    } else {
      if (isCameFromNewCustomer || isChallenge) {
        Utils.checkAudio(questionDataCustSituation.isAnsweredCorrect);
        int index = Injector.countList.indexWhere(
            (QuestionCountWithData questionCountWithData) =>
                questionCountWithData.questionIndex ==
                questionData.questionCurrentIndex);
        if (index != -1) {
          Injector.countList[index].color = ColorRes.red;
          getChallengeQueBloc?.updateQuestions(index, false);
        }

        Utils.checkAudio(questionData.isAnsweredCorrect);
      }
    }
    setState(() {});
  }

  String error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            isChallenge != null && isChallenge
                ? Container(
                    color: ColorRes.colorBgDark,
                  )
                : CommonView.showBackground(context),
            Column(
              children: <Widget>[
                showSubHeader(context),
                Expanded(
                    child: Row(
                  children: <Widget>[
                    showFirstHalf(context),
                    showSecondHalf(context),
                  ],
                )),
              ],
            ),
//            gifImageShow(),
          ],
        ),
      ),
    );
  }

  showSubHeader(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
            top: Utils.getHeaderHeight(context) + 10, left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            isChallenge != null && isChallenge
                ? Row(
                    children: <Widget>[
                      Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: questionDataCustSituation.profileImage !=
                                            null &&
                                        questionDataCustSituation
                                            .profileImage.isNotEmpty
                                    ? Utils.getCacheNetworkImage(
                                        questionDataCustSituation.profileImage)
                                    : AssetImage(
                                        Utils.getAssetsImg('user_org')),
                                fit: BoxFit.fill),
                            border: Border.all(color: ColorRes.textLightBlue)),
                      ),
                      Text(
                        questionDataCustSituation.firstName +
                            " " +
                            questionDataCustSituation.lastName,
                        style: TextStyle(color: ColorRes.white, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                : Container(
                    width: 100,
                  ),
            Container(
              alignment: Alignment.center,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: Injector.isBusinessMode
                      ? null
                      : BorderRadius.circular(15),
                  color: Injector.isBusinessMode
                      ? null
                      : ColorRes.blueMenuSelected,
                  image: Injector.isBusinessMode
                      ? (DecorationImage(
                          image:
                              AssetImage(Utils.getAssetsImg("eddit_profile")),
                          fit: BoxFit.fill))
                      : null),
              child: Text(
                Utils.getText(context, StringRes.situation),
                style: TextStyle(color: ColorRes.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            InkResponse(
              child: Container(
                alignment: Alignment.center,
                width: 100,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Utils.getAssetsImg("bg_engage_now")),
                        fit: BoxFit.fill)),
                child: Text(
                  Utils.getText(context, StringRes.next),
                  style: TextStyle(color: ColorRes.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              onTap: () {
                Utils.playClickSound();
                if (isChallenge != null && isChallenge) {
                  Injector.homeStreamController
                      ?.add("${Const.openPendingChallengeDialog}");

                  /* if (nextChallengeQuestionData != null &&
                      nextChallengeQuestionData.challengeId != null) {

                    navigationBloc.updateNavigation(HomeData(
                        initialPageType: Const.typeEngagement,
                        isChallenge: isChallenge,
                        questionHomeData: nextChallengeQuestionData));
                  }*/
                } else if (isCameFromNewCustomer != null &&
                    isCameFromNewCustomer) {
                  navigationBloc.updateNavigation(
                      HomeData(initialPageType: Const.typeNewCustomer));
                } else {
                  navigationBloc.updateNavigation(
                      HomeData(initialPageType: Const.typeExistingCustomer));
                }
              },
            )
          ],
        ));
  }

  bool isAnswerCorrect(int index) {
    bool isAnswerCorrect = true;

    var arr = questionDataCustSituation.correctAnswerId.split(',');

    if (!arr.contains(arrAnswerSituation[index].option.toString())) {
      isAnswerCorrect = false;
      return false;
    }
    return isAnswerCorrect;
  }

  checkAnswerBusinessMode(int index) {
    if (isAnswerCorrect(index) == true) {
      return ColorRes.answerCorrect;
    } else if (!isAnswerCorrect(index) &&
        arrAnswerSituation[index].isSelected) {
      return ColorRes.greyText;
    } else {
      return ColorRes.white;
    }
  }

  Widget showItemC(int index) {
    return Container(
      height: 47,
      margin: EdgeInsets.only(left: 6, right: 6, top: 6),
      padding: EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 6),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius:
              Injector.isBusinessMode ? null : BorderRadius.circular(15),
          border: Injector.isBusinessMode
              ? null
              : Border.all(
                  width: 1,
                  color: isAnswerCorrect(index) ||
                          arrAnswerSituation[index].isSelected
                      ? ColorRes.white
                      : ColorRes.fontGrey),
          color:
              Injector.isBusinessMode ? null : checkAnswerBusinessMode(index),
          image: Injector.isBusinessMode
              ? (DecorationImage(
                  image: AssetImage(
                    checkAnswer(index),
                  ),
                  fit: BoxFit.fill))
              : null),
      child: Row(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(left: 5.0, right: 5.0)),
          Title(
              color: ColorRes.greenDot,
              child: new Text(
                abcdList[index],
                style: TextStyle(
                  fontSize: 15,
                  color: (checkTextColor(index)),
                ),
              )),
          Padding(padding: EdgeInsets.only(left: 5.0, right: 5.0)),
          Expanded(
            child: SingleChildScrollView(
              child: new Text(
                arrAnswerSituation[index].answer,
                style: TextStyle(fontSize: 15, color: (checkTextColor(index))),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ],
      ),
    );
  }

  showFirstHalf(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Card(
            color: ColorRes.bgProf,
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            margin: EdgeInsets.only(top: 15, bottom: 15, right: 15, left: 8),
            child: Container(
              alignment: Alignment.center,
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 18),
              decoration: BoxDecoration(
                color: Injector.isBusinessMode ? ColorRes.bgDescription : null,
                borderRadius: BorderRadius.circular(12),
                border: Injector.isBusinessMode
                    ? Border.all(color: ColorRes.white, width: 1)
                    : null,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: arrAnswerSituation.length,
                itemBuilder: (BuildContext context, index) {
                  return showItemC(index);
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              alignment: Alignment.center,
              height: 30,
              margin: EdgeInsets.symmetric(
                  horizontal: Utils.getDeviceWidth(context) / 6),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: Injector.isBusinessMode
                      ? null
                      : BorderRadius.circular(20),
                  border: Injector.isBusinessMode
                      ? null
                      : Border.all(width: 1, color: ColorRes.white),
                  color:
                      Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
                  image: Injector.isBusinessMode
                      ? DecorationImage(
                          image:
                              AssetImage(Utils.getAssetsImg("eddit_profile")),
                          fit: BoxFit.fill)
                      : null),
              child: Text(
                Utils.getText(context, StringRes.answers),
                style: TextStyle(color: ColorRes.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: InkResponse(
              onTap: () {
                Utils.playClickSound();
                showDialog(
                  context: context,
                  builder: (_) => AlertCheckAnswersCorrect(),
                );
              },
              child: Container(
                alignment: Alignment.center,
                height: Utils.getDeviceWidth(context) / 20,
                width: Utils.getDeviceWidth(context) / 20,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Injector.isBusinessMode
                            ? Utils.getAssetsImg("full_expand_question_answers")
                            : Utils.getAssetsImg("expand_pro")),
                        fit: BoxFit.fill)),
              ),
            ),
          )
        ],
      ),
    );
  }

  showMediaView(BuildContext context) {
    if (Utils.isImage(correctWrongImage())) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            image: DecorationImage(
              image: CachedNetworkImageProvider(correctWrongImage(),
                  scale: Const.imgScaleProfile,
                  cacheManager: Injector.cacheManager),
              fit: BoxFit.cover,
            )),
      );
    } else
      return Container();
  }

  showSecondHalf(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Column(
          children: <Widget>[
            showQueMedia(context),
            Expanded(
                child: CommonView.questionAndExplanation(
                    context,
                    Utils.getText(context, StringRes.explanation),
                    true,
                    questionDataCustSituation.description))
          ],
        ));
  }

  showQueMedia(BuildContext context) {
    return InkResponse(
        onTap: () {
          Utils.playClickSound();
          showDialog(
            context: context,
            builder: (_) =>
                CorrectWrongMediaAlert(widget.homeData.isCameFromNewCustomer),
          );
        },
        child: Stack(
          children: <Widget>[
            Card(
              elevation: 10,
              color: ColorRes.transparent.withOpacity(0.4),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              margin: EdgeInsets.only(top: 15, bottom: 10, right: 15, left: 10),
              child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height / 2.5,
                  padding:
                      EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
                  decoration: BoxDecoration(
//                              color:
//                              Injector.isBusinessMode ? ColorRes.bgDescription : null,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: ColorRes.white, width: 1)),
                  child: showMediaView(context)),
            ),
            showExpandIcon(context)
          ],
        ));
  }

  showExpandIcon(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: InkResponse(
        child: Container(
            alignment: Alignment.center,
            height: Utils.getDeviceWidth(context) / 20,
            width: Utils.getDeviceWidth(context) / 20,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Injector.isBusinessMode
                        ? Utils.getAssetsImg("full_expand_question_answers")
                        : Utils.getAssetsImg("expand_pro")),
                    fit: BoxFit.fill))),
        onTap: () {
          Utils.playClickSound();
          showDialog(
            context: context,
//              builder: (_) => ImageCorrectIncorrectAlert()
            builder: (_) =>
                CorrectWrongMediaAlert(widget.homeData.isCameFromNewCustomer),
          );
        },
      ),
    );
  }
}

//------------------------------------------------------------
//Answers is correct or not Full screen in show

class AlertCheckAnswersCorrect extends StatefulWidget {
//  bool CheckQuestion;

  @override
  State<StatefulWidget> createState() => AlertCheckAnswersCorrectState();
}

class AlertCheckAnswersCorrectState extends State<AlertCheckAnswersCorrect>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      if (mounted) setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            decoration: ShapeDecoration(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Stack(
                  fit: StackFit.loose,
                  alignment: Alignment.center,
                  children: <Widget>[
                    Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      margin: EdgeInsets.only(
                          top: 25, bottom: 0, right: 25, left: 25),
                      child: Container(
                        height: Utils.getDeviceHeight(context) / 1.2,
                        width: Utils.getDeviceWidth(context) / 1.2,
                        margin: EdgeInsets.only(top: 0),
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 20, bottom: 13),
                        decoration: BoxDecoration(
                          color: Injector.isBusinessMode
                              ? ColorRes.bgDescription
                              : null,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: ColorRes.white, width: 1),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: arrAnswerSituation.length,
                          itemBuilder: (BuildContext context, int index) {
                            return showItemsFullScreen(index);
                          },
                        ),
                      ),
                    ),

                    Positioned(
                      top: 0,
                      child: Container(
                        alignment: Alignment.center,
                        height: 35,
                        margin: EdgeInsets.symmetric(
                            horizontal: Utils.getDeviceWidth(context) / 3,
                            vertical: 5),
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                            borderRadius: Injector.isBusinessMode
                                ? null
                                : BorderRadius.circular(20),
                            border: Injector.isBusinessMode
                                ? null
                                : Border.all(width: 1, color: ColorRes.white),
                            color: Injector.isBusinessMode
                                ? null
                                : ColorRes.titleBlueProf,
                            image: Injector.isBusinessMode
                                ? DecorationImage(
                                    image: AssetImage(
                                        Utils.getAssetsImg("eddit_profile")),
                                    fit: BoxFit.fill)
                                : null),
                        child: Text(
                          Utils.getText(context, StringRes.answers),
                          style: TextStyle(color: ColorRes.white, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    //Full Screen Alert Show Question : -
                    Positioned(
                      top: 0,
                      right: 0,
                      child: InkResponse(
                        onTap: () {
                          Utils.playClickSound();
                          //alert pop
                          Navigator.pop(context);
                        },
                        child: Container(
                            alignment: Alignment.center,
                            height: Utils.getDeviceWidth(context) / 30,
                            width: Utils.getDeviceWidth(context) / 30,
                            decoration: BoxDecoration(
                                image:
//                                Injector.isBusinessMode ?
                                    DecorationImage(
                                        image: AssetImage(
                                            Utils.getAssetsImg("close_dialog")),
                                        fit: BoxFit.fill)
//                                    : null
                                )),
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }

  bool isAnswerCorrect(int index) {
    bool isAnswerCorrect = true;

    var arr = questionDataCustSituation.correctAnswerId.split(',');

    if (!arr.contains(arrAnswerSituation[index].option.toString())) {
      isAnswerCorrect = false;
      return false;
    }

    return isAnswerCorrect;
  }

  checkAnswerBusinessMode(int index) {
    if (isAnswerCorrect(index) == true) {
      return ColorRes.answerCorrect;
    } else if (!isAnswerCorrect(index) &&
        arrAnswerSituation[index].isSelected) {
      return ColorRes.greyText;
    } else {
      return ColorRes.white;
    }
  }

  Widget showItemsFullScreen(int index) {
    return GestureDetector(
        onTap: () {},
        child: Container(
//          height: 50,
          margin: EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6),
          padding: EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius:
                  Injector.isBusinessMode ? null : BorderRadius.circular(18),
              border: Injector.isBusinessMode
                  ? null
                  : Border.all(
                      width: 1,
                      color: isAnswerCorrect(index) ||
                              arrAnswerSituation[index].isSelected
                          ? ColorRes.white
                          : ColorRes.fontGrey),
              color: Injector.isBusinessMode
                  ? null
                  : checkAnswerBusinessMode(index),
              image: Injector.isBusinessMode
                  ? (DecorationImage(
                      image: AssetImage(
                        checkAnswer(index),
                      ),
                      fit: BoxFit.fill))
                  : null),

          child: Row(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left: 5.0, right: 5.0)),
              Title(
                  color: ColorRes.greenDot,
                  child: new Text(
                    abcdList[index],
                    style: TextStyle(
                      fontSize: 18,
                      color: (checkTextColor(index)),
                    ),
                  )),
              Padding(padding: EdgeInsets.only(left: 5.0, right: 5.0)),
              Expanded(
                child: SingleChildScrollView(
                  child: new Text(
                    arrAnswerSituation[index].answer,
                    style:
                        TextStyle(fontSize: 18, color: (checkTextColor(index))),
                    overflow: TextOverflow.fade,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

checkTextColor(int index) {
  var arrCorrectAns = questionDataCustSituation.correctAnswerId.split(",");

  if (arrAnswerSituation[index].isSelected == true) {
    if (arrCorrectAns.contains(arrAnswerSituation[index].option.toString())) {
      return ColorRes.white;
    } else {
      return ColorRes.white;
    }
  } else if (arrCorrectAns
      .contains(arrAnswerSituation[index].option.toString())) {
    return ColorRes.white;
  } else {
    return ColorRes.textProf;
  }
}

checkAnswer(int index) {
  var arrCorrectAns = questionDataCustSituation.correctAnswerId.split(",");

//    Widget child;
  if (arrAnswerSituation[index].isSelected == true) {
    if (arrCorrectAns.contains(arrAnswerSituation[index].option.toString())) {
      return Utils.getAssetsImg("bg_green");
    } else {
      return Utils.getAssetsImg("rounded_rectangle_837gray");
    }
  } else if (arrCorrectAns
      .contains(arrAnswerSituation[index].option.toString())) {
    return Utils.getAssetsImg("bg_green");
  } else {
    return Utils.getAssetsImg("Answer_Alert_Background_White");
  }
}

//---------------------------------------------------------
//image show  in alert

class CorrectWrongMediaAlert extends StatefulWidget {
  final bool isFromExistingCustomer;

  const CorrectWrongMediaAlert(this.isFromExistingCustomer);

  @override
  State<StatefulWidget> createState() => CorrectWrongMediaAlertState();
}

class CorrectWrongMediaAlertState extends State<CorrectWrongMediaAlert>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  final Random random = Random();
  final int numberOfParticles = 20;

  @override
  void initState() {
//    List.generate(numberOfParticles, (index) {
//      particles.add(ParticleModel(random));
//    });

    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      if (mounted) setState(() {});
    });

    controller.forward();
    initVideoController1();
  }

  bool checkimg = true;

  void initVideoController1() async {
    if (Utils.isVideo(correctWrongImage())) {
      _controller = Utils.getCacheFile(correctWrongImage()) != null
          ? VideoPlayerController.file(
              Utils.getCacheFile(correctWrongImage()).file)
          : VideoPlayerController.network(correctWrongImage())
        ..initialize().then((_) {
          if (mounted)
            setState(() {
              _controller.pause();
            });
        });
      _controller.setVolume(Injector.isSoundEnable ? 1.0 : 0.0);
      questionDataCustSituation.videoLoop == 1
          ? _controller.setLooping(true)
          : _controller.setLooping(false);

      _controller.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            decoration: ShapeDecoration(
                color: Colors.transparent,
//                color: Colors.transparent.withOpacity(0.8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Stack(
                  fit: StackFit.loose,
                  alignment: Alignment.center,
                  children: <Widget>[
                    Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      margin: EdgeInsets.only(
                          top: 35, bottom: 15, right: 25, left: 25),
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 0, bottom: 0, left: 0, right: 0),
                        height: Utils.getDeviceHeight(context) / 1.5,
                        width: Utils.getDeviceWidth(context) / 1.2,
                        decoration: BoxDecoration(
                            color: Injector.isBusinessMode
                                ? ColorRes.black
                                : ColorRes.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Utils.isImage(correctWrongImage())
                                ? Border.all(color: ColorRes.white, width: 1)
                                : null),
                        child: showMediaView(context),
                      ),
                    ),

                    //Full Screen Alert Show
                    Positioned(
                      top: 0,
                      right: 0,
                      child: InkResponse(
                          onTap: () {
                            Utils.playClickSound();
                            Navigator.pop(context);
                          },
                          child: (checkimg == true
                              ? Container(
                                  alignment: Alignment.center,
                                  height: Utils.getDeviceWidth(context) / 30,
                                  width: Utils.getDeviceWidth(context) / 30,
                                  decoration: BoxDecoration(
                                      image:
//                                      Injector.isBusinessMode ?
                                          DecorationImage(
                                              image: AssetImage(
                                                  Utils.getAssetsImg(
                                                      "close_dialog")),
                                              fit: BoxFit.contain)
//                                          : null
                                      ))
                              : Container(
                                  alignment: Alignment.center,
                                  height: Utils.getDeviceWidth(context) / 30,
                                  width: Utils.getDeviceWidth(context) / 30,
                                  decoration: BoxDecoration(
                                      image:
//                                      Injector.isBusinessMode ?
                                          DecorationImage(
                                              image: AssetImage(
                                                  Utils.getAssetsImg(
                                                      "close_dialog")),
                                              fit: BoxFit.contain)
//                                          : null
                                      )))),
                    )
                  ],
                )
//              child: CommonView.questionAndExplanationFullAlert(
//                context, "Question"),
                ),
          ),
        ),
      ),
    );
  }

  showMediaView(BuildContext context) {
    if (Utils.isImage(correctWrongImage())) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            image: DecorationImage(
              image: CachedNetworkImageProvider(correctWrongImage(),
                  scale: Const.imgScaleProfile,
                  cacheManager: Injector.cacheManager),
              fit: BoxFit.cover,
            )),
      );
    } else if (Utils.isVideo(correctWrongImage()) &&
        _controller.value.initialized) {
      return AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              child: VideoPlayer(_controller),
            ),
            Container(
              child: MaterialButton(
                height: 100,
                onPressed: () {
                  setState(() {
                    questionDataCustSituation.videoPlay == 1
                        ? _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play()
                        : _controller.play();
                  });
                },
                child: Container(
                  width: Utils.getDeviceHeight(context) / 7,
                  height: Utils.getDeviceHeight(context) / 7,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            _controller.value.isPlaying
                                ? Utils.getAssetsImg("") //add_emp_check
                                : Utils.getAssetsImg("play_button"),
                          ),
                          fit: BoxFit.scaleDown)),
                ),
              ),
            )
          ],
        ),
      );
//    } else if (Utils.isPdf(correctWrongImage())) {
//      return SimplePdfViewerWidget(
//        completeCallback: (bool result) {
//          print("completeCallback,result:$result");
//        },
//        initialUrl: questionData.mediaLink,
//      );
//    }
    }
  }
}
