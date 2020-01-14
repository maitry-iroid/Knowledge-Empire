import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/get_challenges.dart';
import 'package:ke_employee/screens/customer_situation.dart';
import 'package:path/path.dart';

import '../commonview/background.dart';

import 'package:video_player/video_player.dart';

import '../helper/constant.dart';
import '../helper/res.dart';
import 'home.dart';
import '../models/questions.dart';
import '../models/submit_answer.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import 'package:simple_pdf_viewer/simple_pdf_viewer.dart';

List<Answer> arrAnswer = List();

QuestionData questionData = QuestionData();

List abcdList = List();
VideoPlayerController _controller;

class EngagementCustomer extends StatefulWidget {
  final QuestionData questionDataEngCustomer;
  final int questionPosition;
  final int challengePosition;
  final List<GetChallengeData> getChallengeData;

  EngagementCustomer(
      {Key key,
      this.questionDataEngCustomer,
      this.questionPosition,
      this.challengePosition,
      this.getChallengeData})
      : super(key: key);

  @override
  _EngagementCustomerState createState() => _EngagementCustomerState();
}

class _EngagementCustomerState extends State<EngagementCustomer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List alphaIndex = ['A', 'B', 'C', 'D'];
  int _selectedDrawerIndex = 0;

  bool isLoading = false;

  String urlPDFPath = "";
  String assetPDFPath = "";

  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  PDFViewController _pdfViewController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    questionData = widget.questionDataEngCustomer;
    widget.questionDataEngCustomer.answer.shuffle();
    arrAnswer = widget.questionDataEngCustomer.answer;
    abcdList = alphaIndex;
    print(questionData.value);
//    downloadFile();
    initVideoController();

//    audioManager = AudioManager.STREAM_SYSTEM;
//    initPlatformState();
//    updateVolumes();
  }

  @override
  void dispose() {
    try {
//      _controller?.dispose();
    } catch (e) {
      print(e);
    }
    super.dispose();
  }

  selectItem(index) {
    setState(() {
//      _selectedItem = index;
      print(selectItem.toString());
    });
  }

  openProfile() {
    if (mounted) {
      setState(() => _selectedDrawerIndex = 10);
//      setState(() => _selectedItem = 10);
    }
  }

  refresh() {
    setState(() {});
  }

  pdfShow() {
    return isPdf(questionData.mediaLink)
        ? SimplePdfViewerWidget(
            completeCallback: (bool result) {
              print("completeCallback,result:$result");
            },
            initialUrl: Utils.getCacheFile(questionData.mediaLink) != null
                ? Utils.getCacheFile(questionData.mediaLink)
                : questionData.mediaLink,
          )
        : Container();
  }

  void initVideoController() {
    if (isVideo(questionData.mediaLink)) {
      _controller = Utils.getCacheFile(questionData.mediaLink) != null
          ? VideoPlayerController.file(
              Utils.getCacheFile(questionData.mediaLink).file)
          : VideoPlayerController.network(questionData.mediaLink)
        ..initialize().then((_) {
          setState(() {
            _controller.pause();
          });
        });

      questionData.videoLoop == 1
          ? _controller.setLooping(true)
          : _controller.setLooping(false);

      _controller.pause();
    }
  }

  FileInfo fileInfo;
  String error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CommonView.showBackground(context),
          Column(
            children: <Widget>[
              showSubHeader(context),
              showMainBody(context),
            ],
          ),
          CommonView.showCircularProgress(isLoading)
        ],
      ),
    );
  }

  Widget showItem(int index) {
    return GestureDetector(
        onTap: () {
          Utils.playClickSound();
          setState(() {
            arrAnswer[index].isSelected = !arrAnswer[index].isSelected;
          });
        },
        child: Container(
          height: 48,
          margin: EdgeInsets.only(left: 6, right: 6, top: 6),
          padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius:
                  Injector.isBusinessMode ? null : BorderRadius.circular(15),
              border: Injector.isBusinessMode
                  ? null
                  : Border.all(
                      width: 1,
                      color: arrAnswer[index].isSelected
                          ? ColorRes.white
                          : ColorRes.fontGrey),
              color: Injector.isBusinessMode
                  ? null
                  : (arrAnswer[index].isSelected
                      ? ColorRes.blueMenuSelected
                      : ColorRes.white),
              image: Injector.isBusinessMode
                  ? (DecorationImage(
                      image: AssetImage(checkAnswer(index)), fit: BoxFit.fill))
                  : null),
          child: Row(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left: 5.0, right: 5.0)),
              Title(
                  color: ColorRes.greenDot,
                  child: new Text(
                    abcdList[index],
                    style: TextStyle(
                      color: (arrAnswer[index].isSelected
                          ? ColorRes.white
                          : ColorRes.textProf),
                    ),
                  )),
              Padding(padding: EdgeInsets.only(left: 5.0, right: 5.0)),
              Expanded(
                child: SingleChildScrollView(
                  child: new Text(
                    arrAnswer[index].answer,
                    style: TextStyle(
                        fontSize: 14,
                        color: (arrAnswer[index].isSelected
                            ? ColorRes.white
                            : ColorRes.textProf)),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
            ],
          ),
//        Text(
//          widget.title,
//          style: TextStyle(color: (widget.isSelected ? ColorRes.white : ColorRes.black), fontSize: 15),
//        ),
        ));
  }

  void performSubmitAnswer(BuildContext context) async {
    Utils.playClickSound();

    List<Answer> selectedAnswer =
        arrAnswer.where((answer) => answer.isSelected).toList();

    if (selectedAnswer.length == 0) {
      Utils.showToast("Please select at least one option");
      return;
    }

    questionData.isAnsweredCorrect = isAnswerCorrect(selectedAnswer);

    SubmitAnswerRequest rq =
        Injector.prefs.getString(PrefKeys.answerData) != null
            ? SubmitAnswerRequest.fromJson(
                jsonDecode(Injector.prefs.getString(PrefKeys.answerData)))
            : SubmitAnswerRequest();

    SubmitAnswerRequest rqFinal = getSubmitAnswerRequest(rq);

    await Injector.prefs
        .setString(PrefKeys.answerData, json.encode(rqFinal.toJson()));

    Utils.isInternetConnected().then((isConnected) {
      Injector.customerValueData.totalBalance = questionData.value;

      if (isConnected) {
        callSubmitAnswerApi(context);
      } else {
        navigateToSituation(context);
      }
    });
  }

  void callSubmitAnswerApi(BuildContext context) {
    SubmitAnswerRequest rq = SubmitAnswerRequest.fromJson(
        jsonDecode(Injector.prefs.getString(PrefKeys.answerData)));

    setState(() {
      isLoading = true;
    });

    WebApi().submitAnswers(context, rq).then((data) async {
      setState(() {
        isLoading = false;
      });

      if (data != null) {
        Injector.customerValueData = data;
      }
      await Injector.prefs.remove(PrefKeys.answerData);

      Injector.streamController.add("submit answer");

      navigateToSituation(context);
    }).catchError((e) {
      print(e);
      setState(() {
        isLoading = false;
      });
      Utils.showToast(e.toString());
    });
  }

  isImage(String path) {
    return extension(path) == ".png" ||
        extension(path) == ".jpeg" ||
        extension(path) == ".jpg";
  }

  isVideo(String path) {
    return extension(path) == ".mp4";
  }

  isPdf(String path) {
    return extension(path) == ".pdf";
  }

//  List <String> photos = ["add_emp_check",""];
//  int _pos = 0;
//  Timer _timer;
//  imageChanges() {
//    _timer = new Timer(const Duration(seconds: 5), () {
//      setState(() {
//        _pos = (_pos + 1) % photos.length;
//      });
//    });
//  }

  showSubHeader(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: Utils.getHeaderHeight(context) + 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 80,
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
                Utils.getText(
                    context,
                    Injector.isBusinessMode
                        ? StringRes.engagement
                        : StringRes.engagement),
                style: TextStyle(color: ColorRes.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            InkResponse(
              child: Container(
                alignment: Alignment.center,
                width: 80,
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
//                if(currentVol != 0) {
                Utils.playClickSound();
//                }
                performSubmitAnswer(context);
              },
            )
          ],
        ));
  }

  showMainBody(BuildContext context) {
    return Expanded(
        child: Row(
      children: <Widget>[
        showFirstHalf(context),
        showSecondHalf(context),
      ],
    ));
  }

  bool isAnswerCorrect(List<Answer> selectedAnswer) {
    bool isAnswerCorrect = true;

    var arr = questionData.correctAnswerId.split(',');

    if (arr.length != selectedAnswer.length) {
      return false;
    }

    for (var ans in selectedAnswer) {
      if (!arr.contains(ans.option.toString())) {
        isAnswerCorrect = false;
        return false;
      }
    }

    return isAnswerCorrect;
  }

  SubmitAnswerRequest getSubmitAnswerRequest(SubmitAnswerRequest rq) {
    rq.userId = Injector.userData.userId.toString();
    rq.challengeId = 0;
    rq.isChallenge = 0;

    SubmitAnswer submitAnswer = SubmitAnswer();

    submitAnswer.questionId = questionData.questionId;
    submitAnswer.moduleId = questionData.moduleId;
    if (widget.getChallengeData == null) {
      submitAnswer.counter = max(
          questionData.isAnsweredCorrect
              ? (questionData.counter + 1)
              : (questionData.counter ~/ 2).round(),
          0);
      submitAnswer.loyalty = questionData.loyalty;
      submitAnswer.value = questionData.value;
      submitAnswer.resources = questionData.resources;
    }
    submitAnswer.isAnsweredCorrect = questionData.isAnsweredCorrect;
    submitAnswer.attemptTime = Utils.getCurrentFormattedDate();

    if (rq.answer == null) rq.answer = List<SubmitAnswer>();
    rq.answer.add(submitAnswer);

    rq.totalQuestionAnswered = rq.answer.length;

    Utils.isInternetConnected().then((isConnected) {
      if (!isConnected) {
        Utils.updateAttemptTimeInQuestionDataLocally(
            questionData.questionId, submitAnswer.attemptTime);
      }
    });

    return rq;
  }

  void navigateToSituation(BuildContext context) {
    if (widget.getChallengeData == null) {
      Navigator.pushAndRemoveUntil(
          context,
          FadeRouteHome(
              initialPageType: Const.typeDebrief,
              questionDataSituation: questionData),
          ModalRoute.withName("/home"));
    } else {
      showCustomerSituationDialog(_scaffoldKey, widget.getChallengeData,
          widget.challengePosition, widget.questionPosition);
    }
  }

  static showCustomerSituationDialog(
    GlobalKey<ScaffoldState> _scaffoldKey,
    List<GetChallengeData> data,
    int challengePosition,
    int questionPosition,
  ) async {
    Navigator.pop(_scaffoldKey.currentContext);
    await showDialog(
        context: _scaffoldKey.currentContext,
        builder: (BuildContext context) => CustomerSituationPage(
            questionDataCustomerSituation:
                data[challengePosition].challenge[questionPosition],
            challengePosition: challengePosition,
            questionPosition: questionPosition,
            getChallengeData: data));
  }

  showFirstHalf(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Column(
          children: <Widget>[
            showQueMedia(context),
            showQueDescription(context)
          ],
        ));
  }

  showSecondHalf(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            margin: EdgeInsets.only(top: 12, bottom: 15, right: 15, left: 8),
            child: Container(
                alignment: Alignment.center,
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 18),
                decoration: BoxDecoration(
                  color:
                      Injector.isBusinessMode ? ColorRes.bgDescription : null,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: ColorRes.white, width: 1),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: arrAnswer.length,
                  itemBuilder: (BuildContext context, int index) {
                    return showItem(index);
                  },
                )),
          ),

          Align(
            alignment: Alignment.topCenter,
            child: Container(
              alignment: Alignment.center,
              height: 30,
              margin: EdgeInsets.symmetric(
                  horizontal: Utils.getDeviceWidth(context) / 6, vertical: 0),
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
          //Full Screen Alert Show Question : -
          Align(
            alignment: Alignment.bottomRight,
            child: InkResponse(
              onTap: () {
//                if(currentVol != 0) {
                Utils.playClickSound();
//                }
                showDialog(
                  context: context,
                  builder: (_) =>
                      FunkyOverlayAnswers(engagementCustomerState: this),
                );
              },
              child: Container(
                  alignment: Alignment.center,
                  height: Utils.getDeviceWidth(context) / 20,
                  width: Utils.getDeviceWidth(context) / 20,
                  decoration: BoxDecoration(
                      image:
//                                  Injector.isBusinessMode ?
                          DecorationImage(
                              image: AssetImage(Injector.isBusinessMode
                                  ? Utils.getAssetsImg(
                                      "full_expand_question_answers")
                                  : Utils.getAssetsImg("expand_pro")),
                              fit: BoxFit.fill))),
            ),
          )
        ],
      ),
    );
  }

  showQueDescription(BuildContext context) {
    return Expanded(
      child: CommonView.questionAndExplanation(
          context,
          Utils.getText(context, StringRes.question),
          true,
          questionData.question),
    );
  }

  showQueMedia(BuildContext context) {
    return InkResponse(
        onTap: () {
//        if(currentVol != 0) {
          Utils.playClickSound();
//        }
          performImageClick(context);
        },
        child: Stack(
          children: <Widget>[
            Card(
              elevation: 10,
              color: ColorRes.transparent.withOpacity(0.4),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              margin: EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 10),
              child: Container(
                  height: MediaQuery.of(context).size.height / 2.5,
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: ColorRes.white, width: 1)),
                  child: showMediaView(context)),
            ),
            showExpandIcon(context)
          ],
        ));
  }

  showMediaView(BuildContext context) {
    if (isImage(questionData.mediaLink)) {
      return Image(
        image: isImage(questionData.mediaLink)
            ? Utils.getCacheFile(questionData.mediaLink) != null
                ? FileImage(Utils.getCacheFile(questionData.mediaLink).file)
                : NetworkImage(questionData.mediaLink)
            : AssetImage(Utils.getAssetsImg('back')),
      );
    } else if (isVideo(questionData.mediaLink) &&
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
                  questionData.videoPlay == 1
                      ? setState(() {
                          _controller.value.isPlaying
                              ? _controller.pause()
                              : _controller.play();
                        })
                      : setState(() {
                          _controller.play();
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
    } else if (isPdf(questionData.mediaLink)) {
      return SimplePdfViewerWidget(
        completeCallback: (bool result) {
          print("completeCallback,result:${result}");
        },
        initialUrl: questionData.mediaLink,
      );
    }
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
          showDialog(context: context, builder: (_) => ExpandMedia());
        },
      ),
    );
  }

  void performImageClick(BuildContext context) {
    Utils.playClickSound();
    isImage(questionData.mediaLink)
        ? showDialog(
            context: context,
            builder: (_) => ExpandMedia(),
          )
        : Container();
  }
}

//------------------------------------------------------------
//Answers Select Full screen in show

class FunkyOverlayAnswers extends StatefulWidget {
//  FunkyOverlayAnswers(_EngagementCustomerState _engagementCustomerState);

//  final _EngagementCustomerState;
//
//  FunkyOverlayAnswers({ Key key, this._EngagementCustomerState }) : super(key: key);

//  bool CheckQuestion;

  FunkyOverlayAnswers({Key key, this.engagementCustomerState})
      : super(key: key);
  final _EngagementCustomerState engagementCustomerState;

  @override
  State<StatefulWidget> createState() => FunkyOverlayAnswersState();
}

class FunkyOverlayAnswersState extends State<FunkyOverlayAnswers>
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
      setState(() {});
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
                              left: 10, right: 10, top: 25, bottom: 13),
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
                            itemCount: arrAnswer.length,
                            itemBuilder: (BuildContext context, int index) {
                              return showItemFullScree(index);
                            },
                          )
//                          })
                          ),
                    ),
                    Positioned(
                      top: 0,
//                      alignment: Alignment.topCenter,
                      child: Container(
                        alignment: Alignment.center,
                        height: 35,
                        margin: EdgeInsets.symmetric(
                            horizontal: Utils.getDeviceWidth(context) / 3,
                            vertical: 5),
                        padding: EdgeInsets.symmetric(horizontal: 27),
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
                    Positioned(
                      top: 0,
                      right: 0,
                      child: InkResponse(
                        onTap: () {
                          Utils.playClickSound();
                          Navigator.pop(context);
                        },
                        child: Container(
                            alignment: Alignment.center,
                            height: Utils.getDeviceWidth(context) / 40,
                            width: Utils.getDeviceWidth(context) / 40,
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

//  int _selectedItem = 0;
//
//  List<Answer> arrAnswer = List();

//  selectItem(index) {
//    setState(() {
//      _selectedItem = index;
//      print(selectItem.toString());
//    });
//  }

  Widget showItemFullScree(int index) {
    return GestureDetector(
        onTap: () {
//          if(currentVol != 0) {
          Utils.playClickSound();
//          }
          setState(() {
            arrAnswer[index].isSelected = !arrAnswer[index].isSelected;
          });

          widget.engagementCustomerState.refresh();
        },
        child: Container(
//          height: 45,
          margin: EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6),
          padding: EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
          alignment: Alignment.center,
          decoration: BoxDecoration(
//              borderRadius:
//                  Injector.isBusinessMode ? null : BorderRadius.circular(15),
              borderRadius:
                  Injector.isBusinessMode ? null : BorderRadius.circular(18),
              border: Injector.isBusinessMode
                  ? null
                  : Border.all(
                      width: 1,
                      color: arrAnswer[index].isSelected
                          ? ColorRes.white
                          : ColorRes.fontGrey),
              color: Injector.isBusinessMode
                  ? null
                  : (arrAnswer[index].isSelected
                      ? ColorRes.blueMenuSelected
                      : ColorRes.white),
              image: Injector.isBusinessMode
                  ? (DecorationImage(
                      image: AssetImage(checkAnswerAlert(index)),
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
                      color: (arrAnswer[index].isSelected
                          ? ColorRes.white
                          : ColorRes.textProf),
                    ),
                  )),
              Padding(padding: EdgeInsets.only(left: 5.0, right: 5.0)),
              Expanded(
                child: SingleChildScrollView(
                  child: new Text(
                    arrAnswer[index].answer,
                    style: TextStyle(
                        color: (arrAnswer[index].isSelected
                            ? ColorRes.white
                            : ColorRes.textProf)),
//                    maxLines: 3,
                    overflow: TextOverflow.fade,
                  ),
                ),
              )
            ],
          ),
//        Text(
//          widget.title,
//          style: TextStyle(color: (widget.isSelected ? ColorRes.white : ColorRes.black), fontSize: 15),
//        ),
        ));
  }
}

checkAnswerAlert(int index) {
  if (arrAnswer[index].isSelected == true) {
    return Utils.getAssetsImg("Answer_Alert_Background_Blue");
  } else {
    return Utils.getAssetsImg("Answer_Alert_Background_White");
  }
}

checkAnswer(int index) {
  if (arrAnswer[index].isSelected == true) {
    return Utils.getAssetsImg("rounded_rectangle_837_blue");
  } else {
    return Utils.getAssetsImg("Answer_Alert_Background_White");
  }
}

//----------------------------------------
//Question full screen show Alertdialog

class FunkyOverlay extends StatefulWidget {
//  bool CheckQuestion;

  final String title;

  FunkyOverlay({Key key, this.title}) : super(key: key);

//  EngagementCustomer({Key key, this.questionDataEngCustomer, this.notifier})
//      : super(key: key);

  @override
  State<StatefulWidget> createState() => FunkyOverlayState();
}

class FunkyOverlayState extends State<FunkyOverlay>
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
      setState(() {});
    });

    controller.forward();
  }

  bool checkimg = true;

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
                          top: 20, bottom: 15, right: 25, left: 25),
                      child: Container(
                        height: Utils.getDeviceHeight(context) / 1.6,
                        width: Utils.getDeviceWidth(context) / 1.5,
                        margin: EdgeInsets.only(top: 0),
                        padding: EdgeInsets.only(left: 25, right: 10, top: 25),
                        decoration: BoxDecoration(
                          color: Injector.isBusinessMode
                              ? ColorRes.bgDescription
                              : null,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: ColorRes.white, width: 1),
                        ),
                        child: SingleChildScrollView(
                          child: Text(
                            questionData.question,
                            style: TextStyle(
                                color: Injector.isBusinessMode
                                    ? ColorRes.white
                                    : ColorRes.textProf,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      child: Container(
                        alignment: Alignment.center,
                        height: 35,
                        margin: (checkimg == true
                            ? EdgeInsets.symmetric(
                                horizontal: Utils.getDeviceWidth(context) / 6)
                            : EdgeInsets.symmetric(
                                horizontal: Utils.getDeviceWidth(context) / 3)),
                        padding: EdgeInsets.symmetric(horizontal: 30),
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
                          Utils.getText(context, widget.title),
                          style: TextStyle(color: ColorRes.white, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    //Full Screen Alert Show
                    Positioned(
                      top: 0,
                      right: 0,
//                    alignment: (checkimg == true ? Alignment.bottomRight : Alignment
//                        .topRight),
//          Alignment.bottomRight,
                      child: InkResponse(
                          onTap: () {
//                            if(currentVol != 0) {
                            Utils.playClickSound();
//                            }
                            //alert pop
                            Navigator.pop(context);

//                          (checkimg == true ? showDialog(
//                            context: context,
//                            builder: (_) => FunkyOverlay(),
//                          ) : null );
                          },
                          child: (checkimg == true
                              ? Container(
                                  alignment: Alignment.center,
                                  height: Utils.getDeviceWidth(context) / 40,
                                  width: Utils.getDeviceWidth(context) / 40,
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
                                  height: Utils.getDeviceWidth(context) / 40,
                                  width: Utils.getDeviceWidth(context) / 40,
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
}

//======================================
//image show  in alert

class ExpandMedia extends StatefulWidget {
//  bool CheckQuestion;

  @override
  State<StatefulWidget> createState() => ExpandMediaState();
}

class ExpandMediaState extends State<ExpandMedia>
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
      setState(() {});
    });

    controller.forward();
  }

  bool checkimg = true;

  pdfShow() {
    return isPdf(questionData.mediaLink)
        ? SimplePdfViewerWidget(
            completeCallback: (bool result) {
              print("completeCallback,result:$result");
            },
            initialUrl: questionData.mediaLink,
          )
        : Container();
  }

  isImage(String path) {
    return extension(path) == ".png" ||
        extension(path) == ".jpeg" ||
        extension(path) == ".jpg";
  }

  isVideo(String path) {
    return extension(path) == ".mp4";
  }

  isPdf(String path) {
    return extension(path) == ".pdf";
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
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: isImage(questionData.mediaLink)
                              ? DecorationImage(
                                  image: NetworkImage(questionData.mediaLink),
                                  fit: BoxFit.fill)
                              : null,
                          borderRadius: BorderRadius.circular(10),
                          /* border:
                                Border.all(color: ColorRes.white, width: 1)*/
                        ),
                        child: isVideo(questionData.mediaLink) &&
                                _controller.value.initialized
                            ? AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: VideoPlayer(_controller),
                              )
                            : pdfShow(),
                      ),
                    ),

                    //Full Screen Alert Show
                    Positioned(
                      top: 0,
                      right: 0,
//                    alignment: (checkimg == true ? Alignment.bottomRight : Alignment
//                        .topRight),
//          Alignment.bottomRight,
                      child: InkResponse(
                          onTap: () {
//                            if(currentVol != 0) {
                            Utils.playClickSound();
//                            }
                            //alert pop
                            Navigator.pop(context);

//                          (checkimg == true ? showDialog(
//                            context: context,
//                            builder: (_) => FunkyOverlay(),
//                          ) : null );
                          },
                          child: (checkimg == true
                              ? Container(
                                  alignment: Alignment.center,
                                  height: Utils.getDeviceWidth(context) / 40,
                                  width: Utils.getDeviceWidth(context) / 40,
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
                                  height: Utils.getDeviceWidth(context) / 40,
                                  width: Utils.getDeviceWidth(context) / 40,
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
}
