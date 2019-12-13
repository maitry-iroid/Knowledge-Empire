import 'dart:convert';
import 'dart:math';

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:notifier/notifier_provider.dart';
import 'package:path/path.dart';

import 'commonview/background.dart';

import 'package:video_player/video_player.dart';

import 'helper/constant.dart';
import 'helper/res.dart';
import 'home.dart';
import 'models/questions.dart';
import 'models/submit_answer.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import 'package:notifier/main_notifier.dart';

import 'package:simple_pdf_viewer/simple_pdf_viewer.dart';

List<Answer> arrAnswer = List();

int _selectedItem = 0;

QuestionData questionData = QuestionData();

List abcdList = List();
VideoPlayerController _controller;

Notifier _notifier;

class EngagementCustomer extends StatefulWidget {
  final QuestionData questionDataEngCustomer;

  final Notifier notifier;

  EngagementCustomer({Key key, this.questionDataEngCustomer, this.notifier})
      : super(key: key);

  @override
  _EngagementCustomerState createState() => _EngagementCustomerState();
}

class _EngagementCustomerState extends State<EngagementCustomer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List abcdIndex = ['A', 'B', 'C', 'D'];
  int _selectedDrawerIndex = 0;

//  VideoPlayerController _controller;
  bool isLoading = false;

  String urlPDFPath = "";
  String assetPDFPath = "";

  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  PDFViewController _pdfViewController;

  selectItem(index) {
    setState(() {
      _selectedItem = index;
      print(selectItem.toString());
    });
  }

  openProfile() {
    if (mounted) {
      setState(() => _selectedDrawerIndex = 10);
//      setState(() => _selectedItem = 10);
    }
  }

  pdfShow() {
    return isPdf(questionData.mediaLink)
        ? SimplePdfViewerWidget(
            completeCallback: (bool result) {
              print("completeCallback,result:${result}");
            },
            initialUrl: questionData.mediaLink,
          )
        : Container();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    questionData = widget.questionDataEngCustomer;
    arrAnswer = widget.questionDataEngCustomer.answer;
    abcdList = abcdIndex;

    if (isVideo(questionData.mediaLink)) {
      _controller = Utils.getCacheFile(questionData.mediaLink) != null
          ? VideoPlayerController.file(
              Utils.getCacheFile(questionData.mediaLink).file)
          : VideoPlayerController.network(questionData.mediaLink)
        ..initialize().then((_) {
          setState(() {
            _controller.play();
          });
        });
      _controller.play();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _notifier = NotifierProvider.of(context);

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Injector.isBusinessMode
                ? Image(
                    image: AssetImage(Utils.getAssetsImg('bg_dashboard_trans')),
//                  image: AssetImage(Utils.getAssetsImg(arrQuestions.question)),
                    fit: BoxFit.fill,
                  )
                : Container(
                    color: ColorRes.bgProf,
                  ),
            Column(
              children: <Widget>[
                showSubHeader(context),
                showMainBody(context),
              ],
            ),
            CommonView.showCircularProgress(isLoading)
          ],
        ),
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
//          height: Utils.getDeviceWidth(context) / 5,
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
          //bg_blue
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
                json.decode(Injector.prefs.getString(PrefKeys.answerData)))
            : SubmitAnswerRequest();

    SubmitAnswerRequest rqFinal = getSubmitAnswerRequest(rq);

    await Injector.prefs
        .setString(PrefKeys.answerData, json.encode(rqFinal.toJson()));

    Utils.isInternetConnected().then((isConnected) {
      if (isConnected) {
        callSubmitAnswerApi(context);
      } else {
        navigateToSituation(context);
      }
    });
  }

  void callSubmitAnswerApi(BuildContext context) {
    SubmitAnswerRequest rq = SubmitAnswerRequest.fromJson(
        json.decode(Injector.prefs.getString(PrefKeys.answerData)));

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
      navigateToSituation(context);
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

  showSubHeader(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: InkResponse(
                child: Image(
                  image: AssetImage(Utils.getAssetsImg(
                      Injector.isBusinessMode ? "back" : 'back_prof')),
                  width: DimenRes.titleBarHeight,
                ),
                onTap: () {
                  Utils.playClickSound();
                  Utils.performBack(context);
                },
              ),
              alignment: Alignment.center,
              height: 30,
              width: 40,
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
                height: 30,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
        Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                InkResponse(
                  onTap: () {
                    Utils.playClickSound();
                    showDialog(
                      context: context,
                      builder: (_) => ImageShowAlert(),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        top: 18, bottom: 10, left: 10, right: 12),
                    height: Utils.getDeviceHeight(context) / 2.7,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: isImage(questionData.mediaLink)
                            ? DecorationImage(
                                image: Utils.getCacheFile(
                                            questionData.mediaLink) !=
                                        null
                                    ? FileImage(Utils.getCacheFile(
                                            questionData.mediaLink)
                                        .file)
                                    : NetworkImage(questionData.mediaLink),
                                fit: BoxFit.fill)
                            : null,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: ColorRes.white, width: 1)),
                    child: isVideo(questionData.mediaLink) &&
                            _controller.value.initialized
                        ? AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          )
                        : Container(),
                  ),
                ),
                Expanded(
                  child: CommonView.questionAndExplanation(
                      context,
                      Utils.getText(context, StringRes.question),
                      true,
                      questionData.question),
                ),
              ],
            )),
        Expanded(
          flex: 1,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                margin:
                    EdgeInsets.only(top: 20, bottom: 15, right: 15, left: 8),
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

//                  child: ListView.builder(
//                    shrinkWrap: true,
//                    physics: ClampingScrollPhysics(),
//                    itemCount: arrAnswer.length,
//                    itemBuilder: (BuildContext context, int index) {
//                      return showItem(index);
//                    },
//                  ),
                  child:
                      Notifier.of(context).register<String>('action', (data) {
//                    print(data.data);
//                    return Text('${data.data}');
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: arrAnswer.length,
                      itemBuilder: (BuildContext context, int index) {
                        return showItem(index);
                      },
                    );
                  }),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  alignment: Alignment.center,
                  height: 30,
                  margin: EdgeInsets.symmetric(
                      horizontal: Utils.getDeviceWidth(context) / 6,
                      vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 10),
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
              Align(
                alignment: Alignment.bottomRight,
                child: InkResponse(
                  onTap: () {
                    Utils.playClickSound();
                    showDialog(
                      context: context,
                      builder: (_) => FunkyOverlayAnswers(),
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
                                  image: AssetImage(Utils.getAssetsImg(
                                      "full_expand_question_answers")),
                                  fit: BoxFit.fill)
//                                  : null
                          )),
                ),
              )
            ],
          ),
        ),
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
    rq.userId = Injector.userData.userId;

    SubmitAnswer submitAnswer = SubmitAnswer();

    submitAnswer.questionId = questionData.questionId;
    submitAnswer.moduleId = questionData.moduleId;
    submitAnswer.counter = max(
        questionData.isAnsweredCorrect
            ? (questionData.counter + 1)
            : (questionData.counter ~/ 2).round(),
        0);
    submitAnswer.loyalty = questionData.loyalty;
    submitAnswer.isAnsweredCorrect = questionData.isAnsweredCorrect;
    submitAnswer.value = questionData.value;
    submitAnswer.resources = questionData.resource;
    submitAnswer.attemptTime = Utils.getCurrentFormattedDate();

    if (rq.answer == null) rq.answer = List<SubmitAnswer>();
    rq.answer.add(submitAnswer);

    rq.totalQuestionAnswered = rq.answer.length;

    return rq;
  }

  void navigateToSituation(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  initialPageType: Const.typeDebrief,
                  questionDataSituation: questionData,
                )),
        ModalRoute.withName('/home'));
  }
}

//------------------------------------------------------------
//Answers Select Full screen in show

class FunkyOverlayAnswers extends StatefulWidget {
//  bool CheckQuestion;

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
    _notifier = NotifierProvider.of(context);

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
//                padding: const EdgeInsets.only(
//                    top: 0, bottom: 0, right: 0, left: 00),
                child: Stack(
                  fit: StackFit.loose,
                  alignment: Alignment.center,
                  children: <Widget>[
                    Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      margin: EdgeInsets.only(
                          top: 25, bottom: 15, right: 25, left: 25),
                      child: Container(
                          height: Utils.getDeviceHeight(context) / 1.6,
                          width: Utils.getDeviceWidth(context) / 1.2,
                          margin: EdgeInsets.only(top: 0),
                          padding:
                              EdgeInsets.only(left: 10, right: 10, top: 25, bottom: 20),
                          decoration: BoxDecoration(
                            color: Injector.isBusinessMode
                                ? ColorRes.bgDescription
                                : null,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: ColorRes.white, width: 1),
                          ),
                          child: Notifier.of(context).register<String>('action',
                              (data) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: arrAnswer.length,
                              itemBuilder: (BuildContext context, int index) {
                                return showItemFullScree(index);
                              },
                            );
                          })),
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
                    //Full Screen Alert Show Question : -
                    Positioned(
                      top: 0,
                      right: 0,
//                    alignment: Alignment.bottomRight,
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

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
          Utils.playClickSound();
          _notifier.notify('action', '');
          setState(() {
            arrAnswer[index].isSelected = !arrAnswer[index].isSelected;
          });
        },
        child: Container(
          height: 45,
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
                        color: (arrAnswer[index].isSelected
                            ? ColorRes.white
                            : ColorRes.textProf)),
                    maxLines: 3,
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

checkAnswer(int index) {
  if (arrAnswer[index].isSelected == true) {
    return Utils.getAssetsImg("Answer_Alert_Background_Blue");
  } else {
    return Utils.getAssetsImg("Answer_Alert_Background_White");
  }
}
//rounded_rectangle_837_blue,rounded_rectangle_8371

//----------------------------------------
//Question full screen show Alertdialog

class FunkyOverlay extends StatefulWidget {
//  bool CheckQuestion;

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
                        height: Utils.getDeviceHeight(context) / 2,
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
                                fontSize: 14),
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
                          Utils.getText(context, StringRes.question),
                          style: TextStyle(color: ColorRes.white, fontSize: 18),
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
                            Utils.playClickSound();
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

class ImageShowAlert extends StatefulWidget {
//  bool CheckQuestion;

  @override
  State<StatefulWidget> createState() => ImageShowAlertState();
}

class ImageShowAlertState extends State<ImageShowAlert>
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
                            Utils.playClickSound();
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
