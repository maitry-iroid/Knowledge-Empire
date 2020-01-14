import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/get_challenges.dart';
import 'package:path/path.dart';
import 'package:simple_pdf_viewer/simple_pdf_viewer.dart';
import 'package:video_player/video_player.dart';
import 'engagement_customer.dart';
import '../helper/constant.dart';
import '../helper/res.dart';

import '../commonview/background.dart';
import 'home.dart';
import '../models/questions.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

//import 'package:ke_employee/simple_animations.dart';
//import 'package:simple_animations_example_app/widgets/example_page.dart';

List<Answer> arrAnswerSituation = List();

int _selectedItem = 0;

QuestionData questionDataCustSituation = QuestionData();

VideoPlayerController _controller;

List abcdList = List();

FileInfo fileInfo;

int currentVol;

//customer answer show screen : -

class CustomerSituationPage extends StatefulWidget {
  final QuestionData questionDataCustomerSituation;

  final int questionPosition;
  final int challengePosition;
  final List<GetChallengeData> getChallengeData;

  CustomerSituationPage(
      {Key key,
      this.questionDataCustomerSituation,
      this.questionPosition,
      this.challengePosition,
      this.getChallengeData})
      : super(key: key);

  @override
  _CustomerSituationPageState createState() => _CustomerSituationPageState();
}

class _CustomerSituationPageState extends State<CustomerSituationPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

//  int _selectedItem = 0;

  int index = 1;

  List abcdIndex = ['A', 'B', 'C', 'D'];

  openProfile() {
    if (mounted) {
      setState(() => _selectedItem = 12);
    }
  }

  selectItem(index) {}

  @override
  void initState() {
    questionDataCustSituation = widget.questionDataCustomerSituation;
    arrAnswerSituation = widget.questionDataCustomerSituation.answer;

    abcdList = abcdIndex;

    super.initState();
    checkAudio();

    downloadFile();
    correctWrongImage();

//    Utils.isInternetConnected().then((isConnected) {
//      if(isConnected == false) {
//      }
//    });
  }

  String error;

  downloadFile() {
    var cacheVideo = correctWrongImage();

    print(cacheVideo);
    DefaultCacheManager().getFile(cacheVideo).listen((f) {
      if (mounted) {
        setState(() {
          fileInfo = f;
          print(fileInfo);
          error = null;
        });
      }
    }).onError((e) {
      setState(() {
        fileInfo = null;
        error = e.toString();
      });
    });
  }

  correctWrongImage() {
    if (questionData.isAnsweredCorrect == true) {
      return questionDataCustSituation.correctAnswerImage;
    } else {
      return questionDataCustSituation.inCorrectAnswerImage;
    }
  }

//  int _selectedDrawerIndex = 0;
//
//  selectItem(index) {
//    setState(() {
//      _selectedItem = index;
//      print(selectItem.toString());
//    });
//  }

  checkAudio() {
    if (currentVol != 0) {
      if (Injector.isBusinessMode) {
        if (questionData.isAnsweredCorrect == true) {
          return Utils.correctAnswerSound();
        } else {
          return Utils.incorrectAnswerSound();
        }
      } else {
        if (questionData.isAnsweredCorrect == true) {
          return Utils.procorrectAnswerSound();
        } else {
          return Utils.proincorrectAnswerSound();
        }
      }
    }
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

  pdfShow() {
    return isPdf(correctWrongImage())
        ? SimplePdfViewerWidget(
            completeCallback: (bool result) {
              print("completeCallback,result:$result");
            },
            initialUrl: correctWrongImage(),
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
//    var path = "N/A";
//    if (fileInfo?.file != null) {
//      path = fileInfo.file.path;
//    }
//
//    var from = "N/A";
//    if (fileInfo != null) {
//      from = fileInfo.source.toString();
//    }

//    print("$path =>>>>>  $from");

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CommonView.showBackground(context),
          Padding(
            padding: EdgeInsets.only(top: Utils.getHeaderHeight(context)),
            child: Column(
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
          ),

          gifImageShow(),

//        Positioned.fill(child: Particles(30)),
//        Rendering(
//          builder: (context, time) {
//            _simulateParticles(time);
//            return CustomPaint(
//              painter: ParticlePainter(particles, time),
//            );
//          },
//        )
        ],
      ),
    );
  }

//  _simulateParticles(Duration time) {
//    particles.forEach((particle) => particle.maintainRestart(time));
//  }

  bool isGif = true;

  gifImageShow() {
    if (questionData.isAnsweredCorrect == true) {
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          setState(() {
            isGif = false;
          });
        }
      });

      return Visibility(
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Image(
                    image: AssetImage("assets/images/dollar.gif"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ],
          ),
        ),
        visible: isGif,
      );
    }
  }

  showSubHeader(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 70,
            ),
            Container(
              alignment: Alignment.center,
              height: 30,
//                          margin: EdgeInsets.only(left: 50.0, right: 50.0),
//                      color: Injector.isBusinessMode ? null : ColorRes.blueMenuSelected,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: Injector.isBusinessMode
                      ? null
                      : BorderRadius.circular(15),
//                          border: Injector.isBusinessMode
//                              ? null
//                              : Border.all(
//                              width: 1,
//                              color: ColorRes.blueMenuSelected),
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
                Utils.getText(context, StringRes.debrief),
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
                          image:
                              AssetImage(Utils.getAssetsImg("bg_engage_now")),
                          fit: BoxFit.fill)),
                  child: Center(
                    child: Text(
                      Utils.getText(context, StringRes.next),
                      style: TextStyle(color: ColorRes.white, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  )),
              onTap: () {
                if (currentVol != 0) {
                  Utils.playClickSound();
                }
                gotoMainScreen(context);
              },
            )
          ],
        )
//                  CommonView.showTitle(
//                      context, Utils.getText(context, StringRes.engagement))
        );
  }

  bool isAnswerCorrect(int index) {
//    List<Answer> selectedAnswer =
//        questionData.answer.where((answer) => answer.isSelected).toList();
//
    bool isAnswerCorrect = true;

    var arr = questionData.correctAnswerId.split(',');
//
//    if (arr.length != selectedAnswer.length) {
//      return false;
//    }

    if (!arr.contains(arrAnswerSituation[index].option.toString())) {
      isAnswerCorrect = false;
      return false;
    }

    return isAnswerCorrect;
  }

  checkAnswerBusinessMode(int index) {
//    Widget child;
    var correctAnserId;
//    = int.parse(questionDataCustSituation.correctAnswerId);

//    foreach(var s in str.Split(',')) {
////    int num;
//    if (int.TryParse(s, out correctAnserId))
//    return correctAnserId;
//    }

    if (isAnswerCorrect(index) == true) {
      return ColorRes.answerCorrect;
//       if (questionData.isAnsweredCorrect == true) {
//         return ColorRes.answerCorrect;
//       } else {
//         return ColorRes.greyText;
//       }
    } else if (!isAnswerCorrect(index) &&
        arrAnswerSituation[index].isSelected) {
      return ColorRes.greyText;
    } else {
      return ColorRes.white;
    }

    /* if (arrAnswerSituation[index].isSelected == true) {
      if (questionDataCustSituation.correctAnswerId ==
          arrAnswerSituation[index].answerId) {
        return ColorRes.answerCorrect;
      } else {
        return ColorRes.greyText;
      }
    } else if (questionDataCustSituation.correctAnswerId ==
        arrAnswerSituation[index].answerId) {
      return ColorRes.answerCorrect;
    } else {
      return ColorRes.white;
    }*/
    return Utils.getAssetsImg("bg_green");
  }

  Widget showItemC(int index) {
    return GestureDetector(
        onTap: () {
//          setState(() {
//            arrAnswerSituation[index].isSelected = !arrAnswerSituation[index].isSelected;
//          });
        },
        child: Container(
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
              color: Injector.isBusinessMode
                  ? null
                  : checkAnswerBusinessMode(index),
//              (arrAnswerSituation[index].isSelected
//                      ? ColorRes.greenDot
//                      : ColorRes.white),
              image: Injector.isBusinessMode
                  ? (DecorationImage(
                      image: AssetImage(
                        checkAnswer(index),
//                          Utils.getAssetsImg(
//                          arrAnswerSituation[index].isSelected
//                              ? "rounded_rectangle_837_blue"
//                              : "rounded_rectangle_8371"
//                      )
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
                      color: (checkTextColor(index)
//                          arrAnswerSituation[index].isSelected
//                          ? ColorRes.white
//                          : ColorRes.textProf
                          ),
                    ),
                  )),
              Padding(padding: EdgeInsets.only(left: 5.0, right: 5.0)),
              Expanded(
                child: SingleChildScrollView(
                  child: new Text(
                    arrAnswerSituation[index].answer,
                    style: TextStyle(
                        fontSize: 14,
                        color: (checkTextColor(index)
//                            arrAnswerSituation[index].isSelected
//                            ? ColorRes.white
//                            : ColorRes.textProf
                            )),
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
            margin: EdgeInsets.only(top: 20, bottom: 15, right: 15, left: 8),
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
//                                return CategoryItem(
//                                  selectItem,
//                                  index: index,
//                                  isSelected:
//                                      _selectedItem == index ? true : false,
////                                  title: arrSector[index],
//                                );
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
                  horizontal: Utils.getDeviceWidth(context) / 6, vertical: 5),
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
                if (currentVol != 0) {
                  Utils.playClickSound();
                }
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
                      image:
//                                    Injector.isBusinessMode ?
                          DecorationImage(
                              image: AssetImage(Injector.isBusinessMode
                                  ? Utils.getAssetsImg(
                                      "full_expand_question_answers")
                                  : Utils.getAssetsImg("expand_pro")),
                              fit: BoxFit.fill)
//                                        : null
                      )),
            ),
          )
        ],
      ),
    );
  }

  showMediaView(BuildContext context) {
    if (isImage(correctWrongImage())) {
//      return BoxDecoration(
//        image: DecorationImage(image: fileInfo.file.path != null ? NetworkImage(correctWrongImage())  :  AssetImage(fileInfo.file.path))
//      );
      return Image(
        image: NetworkImage(correctWrongImage()), fit: BoxFit.fill,
//        fileInfo.file.path == null ? NetworkImage(correctWrongImage()) : AssetImage(fileInfo.file.path)
      );
    } else if (isVideo(correctWrongImage()) && _controller.value.initialized) {
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
//                                            minWidth: Utils.getDeviceHeight(context) / 7,
//                                            height: Utils.getDeviceHeight(context) / 7,
//                                            color: Colors.transparent.withOpacity(0.0),
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

  showSecondHalf(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Column(
          children: <Widget>[
            showQueMedia(context),
            /* InkResponse(
              onTap: () {
                Utils.playClickSound();
                showDialog(
                  context: context,
                  builder: (_) => CorrectWrongImageAlert(),
//                  builder: (_) => CorrectWrongImageAlert(img: correctWrongImage()),
                );
              },
              child: Container(
                margin:
                    EdgeInsets.only(top: 18, bottom: 10, left: 0, right: 0),
                height: Utils.getDeviceHeight(context) / 2.7,
                decoration: BoxDecoration(

////                                Utils.getCacheFile(correctWrongImage()) != null
////                                    ? FileImage(
////                                        Utils.getCacheFile(correctWrongImage())
////                                            .file)
////                                    : NetworkImage(correctWrongImage()),
//
//                            fit: BoxFit.fill)
//                        : null,
                    borderRadius: BorderRadius.circular(10),
                    border: isImage(questionData.mediaLink)
                        ? Border.all(color: ColorRes.white, width: 1)
                        : null),
                child: showMediaView(context),
              ),
            ),*/

            Expanded(
                child: CommonView.questionAndExplanation(
                    context,
                    Utils.getText(context, StringRes.explanation),
                    true,
                    questionDataCustSituation.question))
          ],
        ));
  }

  void gotoMainScreen(BuildContext context) {
    if (widget.getChallengeData != null) {
      Navigator.pushAndRemoveUntil(
          context, FadeRouteHome(), ModalRoute.withName("home"));

      Navigator.push(
          context,
          FadeRouteHome(
              initialPageType: Const.typeNewCustomer,
              questionDataSituation: null));
    } else {
      if (widget.questionPosition + 1 <
          widget.getChallengeData[widget.challengePosition].challenge.length -
              1) {
        Utils.showChallengeQuestionDialog(_scaffoldKey, widget.getChallengeData,
            widget.challengePosition, widget.questionPosition);
      }
    }
  }

  showQueMedia(BuildContext context) {
    return InkResponse(
        onTap: () {
          if (currentVol != 0) {
            Utils.playClickSound();
          }
          showDialog(
            context: context,
//            builder: (_) => correctWrongImage() != null ? CorrectWrongMeidaAlertt() : Container(),
            builder: (_) => CorrectWrongMediaAlert(),

//              CorrectWrongMeidaAlertt()
//                  builder: (_) => CorrectWrongImageAlert(img: correctWrongImage()),
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
          if (currentVol != 0) {
            Utils.playClickSound();
          }
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
//                      alignment: Alignment.topCenter,
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
//                    alignment: Alignment.bottomRight,
                      child: InkResponse(
                        onTap: () {
                          if (currentVol != 0) {
                            Utils.playClickSound();
                          }
                          //alert pop
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

  bool isAnswerCorrect(int index) {
//    List<Answer> selectedAnswer =
//        questionData.answer.where((answer) => answer.isSelected).toList();
//
    bool isAnswerCorrect = true;

    var arr = questionData.correctAnswerId.split(',');
//
//    if (arr.length != selectedAnswer.length) {
//      return false;
//    }

    if (!arr.contains(arrAnswerSituation[index].option.toString())) {
      isAnswerCorrect = false;
      return false;
    }

    return isAnswerCorrect;
  }

  checkAnswerBusinessMode(int index) {
//    Widget child;
    var correctAnserId;
//    = int.parse(questionDataCustSituation.correctAnswerId);

//    foreach(var s in str.Split(',')) {
////    int num;
//    if (int.TryParse(s, out correctAnserId))
//    return correctAnserId;
//    }

    if (isAnswerCorrect(index) == true) {
      return ColorRes.answerCorrect;
//       if (questionData.isAnsweredCorrect == true) {
//         return ColorRes.answerCorrect;
//       } else {
//         return ColorRes.greyText;
//       }
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
                      color: (checkTextColor(index)),
                    ),
                  )),
              Padding(padding: EdgeInsets.only(left: 5.0, right: 5.0)),
              Expanded(
                child: SingleChildScrollView(
                  child: new Text(
                    arrAnswerSituation[index].answer,
                    style: TextStyle(color: (checkTextColor(index))),
                    overflow: TextOverflow.fade,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

//======================================
//image show  in alert

class ImageCorrectIncorrectAlert extends StatefulWidget {
//  bool CheckQuestion;

  @override
  State<StatefulWidget> createState() => ImageCorrectIncorrectAlertState();
}

class ImageCorrectIncorrectAlertState extends State<ImageCorrectIncorrectAlert>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;
  bool checkimg = true;

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

    correctWrongImage();
  }

  correctWrongImage() {
    if (questionData.isAnsweredCorrect == true) {
      return questionDataCustSituation.correctAnswerImage;
    } else {
      return questionDataCustSituation.inCorrectAnswerImage;
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
                padding: const EdgeInsets.all(50.0),
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
                        margin: EdgeInsets.only(
                            top: 0, bottom: 0, left: 0, right: 0),
                        height: Utils.getDeviceHeight(context) / 2.7,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                              image: NetworkImage(correctWrongImage()),
//                              fileInfo.file.path != null ? AssetImage(fileInfo.file.path) : NetworkImage(correctWrongImage()),

//                              NetworkImage(questionData.isAnsweredCorrect
//                                  ? questionData.correctAnswerImage
//                                  : questionData.inCorrectAnswerImage),

                              fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(10),
                          /* border:
                                Border.all(color: ColorRes.white, width: 1)*/
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
                            if (currentVol != 0) {
                              Utils.playClickSound();
                            }
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
//                                      Injector.isBusinessMode  ?
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
//                                      Injector.isBusinessMode  ?
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
      setState(() {});
    });

    controller.forward();
    initVideoController1();
  }

  bool checkimg = true;

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

  pdfShow() {
    return isPdf(correctWrongImage())
        ? SimplePdfViewerWidget(
            completeCallback: (bool result) {
              print("completeCallback,result:$result");
            },
            initialUrl: correctWrongImage(),
          )
        : Container();
  }

  correctWrongImage() {
    if (questionData.isAnsweredCorrect == true) {
      return questionDataCustSituation.correctAnswerImage;
    } else {
      return questionDataCustSituation.inCorrectAnswerImage;
    }
  }

  void initVideoController1() {
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

  showMediaView(BuildContext context) {
    if (isImage(correctWrongImage())) {
      return Image(image: NetworkImage(correctWrongImage())
//          fileInfo.file.path != null
//              ? AssetImage(fileInfo.file.path)
//              : NetworkImage(correctWrongImage())
          );
    } else if (isVideo(correctWrongImage()) && _controller.value.initialized) {
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
    } else if (isPdf(correctWrongImage())) {
      return SimplePdfViewerWidget(
        completeCallback: (bool result) {
          print("completeCallback,result:${result}");
        },
        initialUrl: questionData.mediaLink,
      );
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
                            borderRadius: BorderRadius.circular(10),
                            border: isImage(questionData.mediaLink)
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
                            if (currentVol != 0) {
                              Utils.playClickSound();
                            }
                            Navigator.pop(context);
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

/*
class ParticleBackgroundApp extends StatelessWidget {
  final QuestionData questionDataCustomerSituation;

  ParticleBackgroundApp({Key key, this.questionDataCustomerSituation})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Positioned.fill(child: CustomerSituationPage(questionDataCustomerSituation: questionDataCustomerSituation,)),
//      Positioned.fill(child: AnimatedBackground()),
//      Positioned.fill(child: AnimatedBackground(questionDataParticles: questionDataCustomerSituation)),
      Positioned.fill(child: Particles(20)),
    ]);
  }
}


// animation code
class Particles extends StatefulWidget {
  final int numberOfParticles;

//  final QuestionData questionDataParticles;

  Particles(this.numberOfParticles,);

  @override
  _ParticlesState createState() => _ParticlesState();
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "hello"
      ),
    );
  }
}

class _ParticlesState extends State<Particles> {
  final Random random = Random();

  final List<ParticleModel> particles = [];

  @override
  void initState() {
    List.generate(widget.numberOfParticles, (index) {
      particles.add(ParticleModel(random));
    });
    super.initState();
    init();

//    context.current.trim();

//    new Future.delayed(
//        const Duration(seconds: 5),
//            () => Navigator.push(context,
//          MaterialPageRoute(builder: (context) => CustomerSituationPage()),
//        ));
      Navigator.of(context).pop();
  }

  //image show top to bottom
  ui.Image image;
  bool isImageloaded = false;

  Future <Null> init() async {
    final ByteData data = await rootBundle.load('assets/images/add_emplyee.png');
    image = await loadImage(new Uint8List.view(data.buffer));
  }

  Future<ui.Image> loadImage(List<int> img) async {
    final Completer<ui.Image> completer = new Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      setState(() {
        isImageloaded = true;
      });
      return completer.complete(img);
    });
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Rendering(
      startTime: Duration(seconds: 50),
      onTick: _simulateParticles,
      builder: (context, time) {
        return CustomPaint(
          painter: ParticlePainter(particles, time, image),
        );
      },
    );
  }

  _simulateParticles(Duration time) {
    particles.forEach((particle) => particle.maintainRestart(time));
  }
}

class ParticleModel {
  Animatable tween;
  double size;
  AnimationProgress animationProgress;
  Random random;

  ParticleModel(this.random) {
    restart();
  }

  restart({Duration time = Duration.zero}) {
    //random.nextDouble()
    final startPosition = Offset(-0.2 + 1.4 * random.nextDouble(), 0.0);
    final endPosition = Offset(-0.2 + 1.4 * random.nextDouble(), 1.2);
    final duration = Duration(milliseconds: 300 + random.nextInt(3000));

    tween = MultiTrackTween([
      Track("x").add(
          duration, Tween(begin: startPosition.dx, end: endPosition.dx),
          curve: Curves.easeInOutSine),
      Track("y").add(
          duration, Tween(begin: startPosition.dy, end: endPosition.dy),
          curve: Curves.easeIn),
    ]);
    animationProgress = AnimationProgress(duration: duration, startTime: time);
    size = 0.5 + random.nextDouble() * 0.01;
  }

  maintainRestart(Duration time) {
    if (animationProgress.progress(time) == 1.0) {
      restart(time: time);
    }
  }
}

class ParticlePainter extends CustomPainter {
  List<ParticleModel> particles;
  Duration time;
  ui.Image image;
  ParticlePainter(this.particles, this.time, this.image);

  @override
  void paint(Canvas canvas, Size size) {
//    final paint = Paint()..color = Colors.white.withAlpha(50);
    final paint = Paint()..color = Colors.cyan;
//    final paint = paintImage(canvas: null, rect: null, image: null);


//    final paint = paintImage(canvas: null, rect: null, image: )

    particles.forEach((particle) {
      var progress = particle.animationProgress.progress(time);
      final animation = particle.tween.transform(progress);
      final position =
      Offset(animation["x"] * size.width, animation["y"] * size.height);
//      canvas.drawCircle(position, size.width * 0.2 * particle.size, paint);
      canvas.drawImage(image, position, new Paint());

    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
*/
