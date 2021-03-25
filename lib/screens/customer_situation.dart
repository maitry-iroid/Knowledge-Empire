import 'dart:async';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/BLoC/challenge_question_bloc.dart';
import 'package:ke_employee/BLoC/get_question_bloc.dart';
import 'package:ke_employee/BLoC/navigation_bloc.dart';
import 'package:ke_employee/commonview/common_view.dart';
import 'package:ke_employee/commonview/challenge_header.dart';
import 'package:ke_employee/dialogs/display_dailogs.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/manager/encryption_manager.dart';
import 'package:ke_employee/manager/media_manager.dart';
import 'package:ke_employee/models/homedata.dart';
import 'package:ke_employee/screens/refreshAnimation.dart';
import 'package:video_player/video_player.dart';
import '../helper/constant.dart';
import '../helper/res.dart';
import '../commonview/common_view.dart';
import '../models/questions.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'home.dart';

/*
*   created by Riddhi
*
*   - This class will show the status of the answer of the attempted que either it is correct or wrong with sound and animation
*
* */

List<Answer> arrAnswerSituation = List();

QuestionData questionDataCustSituation = QuestionData();

VideoPlayerController _controller;
ChewieController _chewieController;

List abcdList = List();
List<QuestionData> existingQueList;

FileInfo fileInfo;

HomeData homeData;

correctWrongImage() {
  return questionDataCustSituation.isAnsweredCorrect == 1
      ? questionDataCustSituation.correctAnswerImage
      : questionDataCustSituation.inCorrectAnswerImage;
}

class CustomerSituationPage extends StatefulWidget {
  final HomeData homeData;
  final RefreshAnimation mRefreshAnimation;

  CustomerSituationPage({Key key, this.homeData, this.mRefreshAnimation})
      : super(key: key);

  @override
  _CustomerSituationPageState createState() => _CustomerSituationPageState();
}

class _CustomerSituationPageState extends State<CustomerSituationPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // QuestionData questionDataCustomerSituation;
  bool isChallenge;
  bool isCameFromNewCustomer = false;
  int existingQuesIndex = 0;
  int index = 1;

  List alphaIndex = ['A', 'B', 'C', 'D'];

  selectItem(index) {}

  @override
  void initState() {
    questionDataCustSituation = widget.homeData.questionHomeData;
    isChallenge = widget.homeData.isChallenge;
    isCameFromNewCustomer = widget.homeData.isCameFromNewCustomer;
    homeData = widget.homeData;
    existingQueList = homeData.existingQueList;
    print("========homedata====");
    print(homeData.questionHomeData.toJson());
    print(homeData.questionHomeData.answer[0].answer);
    initContent();

    super.initState();
  }

  void initContent() async {
    String firstName = await EncryptionManager()
        .stringDecryption(questionDataCustSituation.firstName);
    String lastName = await EncryptionManager()
        .stringDecryption(questionDataCustSituation.lastName);
    if ((firstName?.length ?? 0) > 0) {
      questionDataCustSituation.firstName = firstName;
    }
    if ((lastName?.length ?? 0) > 0) {
      questionDataCustSituation.lastName = lastName;
    }
    // questionDataCustSituation.firstName = await EncryptionManager().stringDecryption(questionDataCustomerSituation.firstName);
    // questionDataCustSituation.lastName = await EncryptionManager().stringDecryption(questionDataCustomerSituation.lastName);
    //

    arrAnswerSituation = questionDataCustSituation?.answer;

    abcdList = alphaIndex;

    correctWrongImage();

    showIntroDialog();
  }

  Future<void> showIntroDialog() async {
    if (questionDataCustSituation.isAnsweredCorrect == 1) {
      if (Injector.introData != null &&
          Injector.introData.customerSituation != null &&
          Injector.introData.customerSituation == 0) {
        await DisplayDialogs.showIntroCustomerSituation(context);
        Injector.introData.customerSituation = 1;
        await Injector.setIntroData(Injector.introData);
      }

      updateChallenge(true);
    } else {
      if (isCameFromNewCustomer || isChallenge) {
        Utils.checkAudio(questionDataCustSituation.isAnsweredCorrect == 1);
        updateChallenge(false);
      }
    }
    setState(() {});
  }

  void updateChallenge(bool isAnswer) {
    int index = Injector.countList.indexWhere(
        (QuestionCountWithData questionCountWithData) =>
            questionCountWithData.questionIndex ==
            questionDataCustSituation.questionCurrentIndex);

    if (index != -1) {
      Injector.countList[index].color =
          isAnswer ? ColorRes.greenDot : ColorRes.red;
      getChallengeQueBloc?.updateQuestions(index, isAnswer);
    }

    if (widget.homeData.isCameFromNewCustomer) {
      if (isAnswer) {
        widget.mRefreshAnimation.onRefreshAchievement(Const.typeServices);
        widget.mRefreshAnimation.onRefreshAchievement(Const.typeSales);
        // Future.delayed(Duration(seconds: 1));

        if (isCameFromNewCustomer || isChallenge) {
          Utils.checkAudio(questionDataCustSituation.isAnsweredCorrect == 1);

          if (!isChallenge ||
              (Injector.countList.length ==
                  questionDataCustSituation.questionCurrentIndex)) {
            Injector.homeStreamController?.add("${Const.typeMoneyAnim}");
          }
        }
      } else {
        widget.mRefreshAnimation.onRefreshAchievement(Const.typeSales);
      }
    }
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
                ? Container(color: ColorRes.colorBgDark)
                : CommonView.showBackground(context),
            Column(
              children: <Widget>[
                showSubHeader(context),
                SizedBox(
                  height: 8,
                ),
                homeData.questionHomeData.answerType == Const.typeAnswerText ||
                        homeData.questionHomeData.answerType ==
                            Const.typeAnswerMediaWithQuestion
                    ? showTextAnswer(context)
                    : showMediaAnswer(context, false),
              ],
            ),
//            gifImageShow(),
          ],
        ),
      ),
    );
  }

  showTextAnswer(BuildContext context) {
    return Expanded(
        child: Row(
      children: <Widget>[
        showFirstHalf(context),
        showSecondHalf(context),
      ],
    ));
  }

  showMediaAnswer(BuildContext context, bool isMediaWithQuestion) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GridView.count(
                crossAxisCount: isMediaWithQuestion ? 1 : 2,
                childAspectRatio: 2,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                // Generate 100 widgets that display their index in the List.
                children: List.generate(questionDataCustSituation.answer.length,
                    (index) {
                  return MediaManager().showQueMedia(
                      context,
                      isAnswerCorrect(index)
                          ? ColorRes.greenDot
                          : arrAnswerSituation[index].isSelected
                              ? ColorRes.fontGrey
                              : isAnswerCorrect(index) &&
                                      !arrAnswerSituation[index].isSelected
                                  ? ColorRes.greenDot
                                  : ColorRes.white,
                      questionDataCustSituation.answer.elementAt(index).answer,
                      questionDataCustSituation.answer
                              .elementAt(index)
                              .thumbImage ??
                          "https://www.speedsecuregcc.com/uploads/products/default.jpg");
                }),
              ),
              // GridView.builder(
              //     physics: NeverScrollableScrollPhysics(),
              //     shrinkWrap: true,
              //     itemCount: questionDataCustSituation.answer.length,
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: isMediaWithQuestion ? 1 : 2, childAspectRatio: 2, crossAxisSpacing: 0, mainAxisSpacing: 0),
              //     itemBuilder: (context, index) {
              //       return MediaManager().showQueMedia(
              //           context,
              //           isAnswerCorrect(index)
              //               ? ColorRes.greenDot
              //               : arrAnswerSituation[index].isSelected
              //                   ? ColorRes.fontGrey
              //                   : isAnswerCorrect(index) && !arrAnswerSituation[index].isSelected
              //                       ? ColorRes.greenDot
              //                       : ColorRes.white,
              //           questionDataCustSituation.answer.elementAt(index).answer,
              //           questionDataCustSituation.answer.elementAt(index).thumbImage ??
              //               "https://www.speedsecuregcc.com/uploads/products/default.jpg");
              //     }),
              Row(children: <Widget>[
                Expanded(
                    child: questionDataCustSituation.expertEmail != null &&
                            questionDataCustSituation.expertEmail != ""
                        ? CommonView.showContactExpert(
                            context,
                            Utils.getText(context, StringRes.contactExpert),
                            true,
                            questionDataCustSituation?.expertEmail ?? "",
                            false,
                            questionDataCustSituation.title,
                            questionDataCustSituation.question,
                            true,
                            questionDataCustSituation.questionId.toString())
                        : Container()),
                Expanded(
                    child: questionDataCustSituation.additionalInfoLink !=
                                null &&
                            questionDataCustSituation.additionalInfoLink != ""
                        ? CommonView.showMoreInformation(
                            context,
                            Utils.getText(context, StringRes.moreInformation),
                            true,
                            questionDataCustSituation?.additionalInfoLink ?? "",
                            false,
                            questionDataCustSituation.questionId.toString())
                        : Container()),
              ]),
              SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }

  showMediaAnswersView(BuildContext context, String path) {
    if (Utils.isImage(path)) {
      print("isImage = true");
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            image: DecorationImage(
              image: CachedNetworkImageProvider(path,
                  scale: Const.imgScaleProfile,
                  cacheManager: Injector.cacheManager),
              fit: BoxFit.cover,
            )),
      );
    } else if (Utils.isVideo(path) &&
        _controller != null &&
        _controller.value.initialized) {
      print("isVideo = true");

      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            child: Chewie(
              controller: _chewieController,
            ),
          ),
          Container(
            child: MaterialButton(
              height: 100,
              onPressed: () {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();

                if (mounted) setState(() {});
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
      );
    }
  }

  showSubHeader(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
            top: Utils.getHeaderHeight(context) + 10, left: 20, right: 20),
        child: isChallenge != null && isChallenge
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
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
                  ),
                  InkResponse(
                    child: Container(
                      alignment: Alignment.center,
                      width: 145,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  Utils.getAssetsImg("bg_engage_now")),
                              fit: BoxFit.fill)),
                      child: Text(
                        Utils.getText(context, StringRes.backToList),
                        style: TextStyle(color: ColorRes.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: () async {
                      Utils.playClickSound();
                      navigationBloc.updateNavigation(HomeData(
                          initialPageType: isCameFromNewCustomer
                              ? Const.typeNewCustomer
                              : Const.typeExistingCustomer));
                    },
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
                                image: AssetImage(
                                    Utils.getAssetsImg("eddit_profile")),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  Utils.getAssetsImg("bg_engage_now")),
                              fit: BoxFit.fill)),
                      child: Text(
                        Utils.getText(context, StringRes.next),
                        style: TextStyle(color: ColorRes.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: () async {
                      Utils.playClickSound();
                      if (isChallenge != null && isChallenge) {
                        Injector.homeStreamController
                            ?.add("${Const.openPendingChallengeDialog}");

                        /* if (nextChallengeQuestionData != null &&
                      nextChallengeQuestionData.challengeId != null) {

                    navigationBloc.updateNavigation(HomeData(
                        initialPageType: Const.typeEngagement,
                        isChallenge: isChallenge,mani
                        questionHomeData: nextChallengeQuestionData));
                  }*/
                      } else if (isCameFromNewCustomer != null &&
                          isCameFromNewCustomer) {
                        QuestionRequest rq = QuestionRequest();
                        rq.userId = Injector.userData.userId;
                        rq.type = Const.getNewQueType;
                        List<QuestionData> arrQuestions =
                            await getQuestionsBloc.getQuestion(rq);

                        print(
                            "======================= perform next ======================");
                        print(arrQuestions.length);

                        if (arrQuestions != null && arrQuestions.length > 0) {
                          HomeData homeData = HomeData(
                              initialPageType: Const.typeEngagement,
                              questionHomeData: arrQuestions[0],
                              value: arrQuestions[0].value);

                          navigationBloc.updateNavigation(homeData);
                        } else
                          navigationBloc.updateNavigation(
                              HomeData(initialPageType: Const.typeHome));
                      } else {
                        navigationBloc.updateNavigation(HomeData(
                            initialPageType: Const.typeExistingCustomer));
                      }
                    },
                  )
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkResponse(
                    child: Container(
                      alignment: Alignment.center,
                      width: 145,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  Utils.getAssetsImg("bg_engage_now")),
                              fit: BoxFit.fill)),
                      child: Text(
                        Utils.getText(context, StringRes.backToList),
                        style: TextStyle(color: ColorRes.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: () async {
                      Utils.playClickSound();
                      navigationBloc.updateNavigation(HomeData(
                          initialPageType: isCameFromNewCustomer
                              ? Const.typeNewCustomer
                              : Const.typeExistingCustomer));
                    },
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
                                image: AssetImage(
                                    Utils.getAssetsImg("eddit_profile")),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  Utils.getAssetsImg("bg_engage_now")),
                              fit: BoxFit.fill)),
                      child: Text(
                        Utils.getText(context, StringRes.next),
                        style: TextStyle(color: ColorRes.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: () async {
                      Utils.playClickSound();
                      if (isChallenge != null && isChallenge) {
                        Injector.homeStreamController
                            ?.add("${Const.openPendingChallengeDialog}");

                        /* if (nextChallengeQuestionData != null &&
                      nextChallengeQuestionData.challengeId != null) {

                    navigationBloc.updateNavigation(HomeData(
                        initialPageType: Const.typeEngagement,
                        isChallenge: isChallenge,mani
                        questionHomeData: nextChallengeQuestionData));
                  }*/
                      } else if (isCameFromNewCustomer != null &&
                          isCameFromNewCustomer) {
                        QuestionRequest rq = QuestionRequest();
                        rq.userId = Injector.userData.userId;
                        rq.type = Const.getNewQueType;
                        List<QuestionData> arrQuestions =
                            await getQuestionsBloc.getQuestion(rq);

                        print(
                            "======================= perform next ======================");
                        print(arrQuestions.length);

                        if (arrQuestions != null && arrQuestions.length > 0) {
                          HomeData homeData = HomeData(
                              initialPageType: Const.typeEngagement,
                              questionHomeData: arrQuestions[0],
                              value: arrQuestions[0].value);

                          navigationBloc.updateNavigation(homeData);
                        } else
                          navigationBloc.updateNavigation(
                              HomeData(initialPageType: Const.typeHome));
                      } else if (!isCameFromNewCustomer != null &&
                          !isCameFromNewCustomer) {
                        // QuestionRequest rq = QuestionRequest();
                        // rq.userId = Injector.userData.userId;
                        // rq.type = Const.getExistingQueType;
                        // List<QuestionData> arrQuestions =
                        //     await getQuestionsBloc.getQuestion(rq);

                        print(
                            "======================= perform next existing======================");
                        print(existingQueList.length);
                        if (existingQueList != null &&
                            existingQueList.length > 0) {
                          existingQuesIndex = existingQuesIndex + 1;

                          if (existingQuesIndex < existingQueList.length) {
                            print(
                                "------------- ::::::::: ${existingQueList[existingQuesIndex].toJson()}");
                            // HomeData homeData = HomeData(
                            //     initialPageType: Const.typeCustomerSituation,
                            //     questionHomeData:
                            //         arrQuestions[existingQuesIndex],
                            //     value: arrQuestions[existingQuesIndex].value,
                            //     existingQueIndex: existingQuesIndex);
                            // navigationBloc.updateNavigation(homeData);
                            questionDataCustSituation =
                                existingQueList[existingQuesIndex];

                            arrAnswerSituation =
                                questionDataCustSituation?.answer;
                            print(
                                "------------ type :::::::: ${questionDataCustSituation.answerType}");
                            setState(() {});
                          } else {
                            navigationBloc.updateNavigation(HomeData(
                                initialPageType: Const.typeExistingCustomer));
                          }
                        } else {
                          print(
                              "======================= Questions not found ======================");
                        }
                      } else {
                        navigationBloc.updateNavigation(HomeData(
                            initialPageType: Const.typeExistingCustomer));
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
      margin: EdgeInsets.only(left: 6, right: 6, top: 6),
      padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
              width: 1,
              color:
                  isAnswerCorrect(index) || arrAnswerSituation[index].isSelected
                      ? ColorRes.white
                      : ColorRes.fontGrey),
          color:
              Injector.isBusinessMode ? null : checkAnswerBusinessMode(index),
          image: Injector.isBusinessMode
              ? (DecorationImage(
                  image: AssetImage(
                    checkAnswer(index),
                  ),
                  fit: BoxFit.cover))
              : null),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: Title(
                color: ColorRes.greenDot,
                child: new Text(
                  abcdList[index],
                  style: TextStyle(
                    fontSize: 15,
                    color: (checkTextColor(index)),
                  ),
                )),
          ),
          Expanded(
            child: Padding(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: new Text(
                  arrAnswerSituation[index].answer,
                  style:
                      TextStyle(fontSize: 17, color: (checkTextColor(index))),
                )),
          )
        ],
      ),
    );
  }

  showFirstHalf(BuildContext context) {
    print("answer====");
    print(questionDataCustSituation.answer[0].answer);
    return Expanded(
      flex: 1,
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Stack(
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
                  color:
                      Injector.isBusinessMode ? ColorRes.bgDescription : null,
                  borderRadius: BorderRadius.circular(12),
                  border: Injector.isBusinessMode
                      ? Border.all(color: ColorRes.white, width: 1)
                      : null,
                ),
                child: questionDataCustSituation.answerType ==
                        Const.typeAnswerText
                    ? ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: arrAnswerSituation.length,
                        itemBuilder: (BuildContext context, index) {
                          return showItemC(index);
                        },
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: questionDataCustSituation.answer.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 2,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0),
                        itemBuilder: (context, index) {
                          return MediaManager().showQueMedia(
                              context,
                              isAnswerCorrect(index)
                                  ? ColorRes.greenDot
                                  : arrAnswerSituation[index].isSelected
                                      ? ColorRes.fontGrey
                                      : isAnswerCorrect(index) &&
                                              !arrAnswerSituation[index]
                                                  .isSelected
                                          ? ColorRes.greenDot
                                          : ColorRes.white,
                              questionDataCustSituation.answer
                                  .elementAt(index)
                                  .answer,
                              questionDataCustSituation.answer
                                      .elementAt(index)
                                      .thumbImage ??
                                  "https://www.speedsecuregcc.com/uploads/products/default.jpg");
                        }),
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
                              ? Utils.getAssetsImg(
                                  "full_expand_question_answers")
                              : Utils.getAssetsImg("expand_pro")),
                          fit: BoxFit.fill)),
                ),
              ),
            )
          ],
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
    } else
      return Container();
  }

  showSecondHalf(BuildContext context) {
    return Expanded(
        flex: 1,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              showQueMedia(context),
              CommonView.questionAndExplanation(
                  context,
                  Utils.getText(context, StringRes.explanation),
                  true,
                  questionDataCustSituation.description),
              questionDataCustSituation.expertEmail != null &&
                      questionDataCustSituation.expertEmail != ""
                  ? CommonView.showContactExpert(
                      context,
                      Utils.getText(context, StringRes.contactExpert),
                      true,
                      questionDataCustSituation?.expertEmail ?? "",
                      false,
                      questionDataCustSituation.title,
                      questionDataCustSituation.question,
                      false,
                      questionDataCustSituation.questionId.toString())
                  : Container(),
              questionDataCustSituation.additionalInfoLink != null &&
                      questionDataCustSituation.additionalInfoLink != ""
                  ? CommonView.showMoreInformation(
                      context,
                      Utils.getText(context, StringRes.moreInformation),
                      true,
                      questionDataCustSituation?.additionalInfoLink ?? "",
                      false,
                      questionDataCustSituation.questionId.toString())
                  : Container()
            ],
          ),
        ));
  }

  showQueMedia(BuildContext context) {
    return InkResponse(
        onTap: () {
          Utils.playClickSound();
          showDialog(
            context: context,
            builder: (_) => CorrectWrongMediaAlert(),
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
            builder: (_) => CorrectWrongMediaAlert(),
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
    return Container(
      margin: EdgeInsets.only(left: 6, right: 6, top: 6),
      padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
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
          Padding(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: Title(
                color: ColorRes.greenDot,
                child: new Text(
                  abcdList[index],
                  style: TextStyle(
                    fontSize: 15,
                    color: (checkTextColor(index)),
                  ),
                )),
          ),
          Expanded(
            child: Padding(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: new Text(
                  arrAnswerSituation[index].answer,
                  style:
                      TextStyle(fontSize: 17, color: (checkTextColor(index))),
                )),
          )
        ],
      ),
    );
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
  const CorrectWrongMediaAlert();

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
          // fit: StackFit.expand,
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
