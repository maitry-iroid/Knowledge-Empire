import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:path/path.dart';
import 'package:path/path.dart' as prefix0;
import 'package:video_player/video_player.dart';
import 'engagement_customer.dart';
import 'helper/constant.dart';
import 'helper/res.dart';

import 'commonview/background.dart';
import 'home.dart';
import 'models/questions.dart';

List<Answer> arrAnswerSituation = List();

int _selectedItem = 0;

QuestionData questionDataCustSituation = QuestionData();

VideoPlayerController _controller;

List abcdList = List();

class CustomerSituationPage extends StatefulWidget {
  final QuestionData questionDataCustomerSituation;

  CustomerSituationPage({Key key, this.questionDataCustomerSituation})
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
//      setState(() => _selectedDrawerIndex = 10);
      setState(() => _selectedItem = 12);
    }
  }

  selectItem(index) {}

  @override
  void initState() {
    // TODO: implement initState
//    _selectedItem = widget.selectedIndex;

    questionDataCustSituation = widget.questionDataCustomerSituation;
    arrAnswerSituation = widget.questionDataCustomerSituation.answer;

    abcdList = abcdIndex;

    super.initState();
    checkAudio();
//    correctWrongImage();
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
    if (questionData.isAnsweredCorrect == true) {
      return Utils.correctAnswerSound();
    } else {
      return Utils.incorrectAnswerSound();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        backgroundColor: ColorRes.colorBgDark,
        body: SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Injector.isBusinessMode
              ? Image(
                  image: AssetImage(Utils.getAssetsImg('bg_dashboard_trans')),
                  fit: BoxFit.fill,
                )
              : Container(
                  color: ColorRes.bgProf,
                ),
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
          )
        ],
      ),
    ));
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
                  gotoMainScreen(context);
                },
              ),

              alignment: Alignment.center,
              height: 30,
              width: 40,
//                        child: Icon(Icons.chevron_left, color: ColorRes.white,),
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
                Utils.playClickSound();
                gotoMainScreen(context);
              },
            )
          ],
        )
//                  CommonView.showTitle(
//                      context, Utils.getText(context, StringRes.engagement))
        );
  }

  checkAnswerBusinessMode(int index) {
//    Widget child;

    if (arrAnswerSituation[index].isSelected == true) {
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
    }
    return Utils.getAssetsImg("bg_green");
  }

  Widget showItem(int index) {
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
                      color: arrAnswerSituation[index].isSelected
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
                        fontSize: 12,
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
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            margin: EdgeInsets.only(top: 20, bottom: 15, right: 5, left: 8),
            child: Container(
              alignment: Alignment.center,
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 18),
              decoration: BoxDecoration(
                color: Injector.isBusinessMode ? ColorRes.bgDescription : null,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: ColorRes.white, width: 1),
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
                  return showItem(index);
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
                      image:
//                                    Injector.isBusinessMode ?
                          DecorationImage(
                              image: AssetImage(Utils.getAssetsImg(
                                  "full_expand_question_answers")),
                              fit: BoxFit.fill)
//                                        : null
                      )),
            ),
          )
        ],
      ),
    );
  }

  showSecondHalf(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 18, bottom: 10, left: 12, right: 12),
              height: Utils.getDeviceHeight(context) / 2.7,
              decoration: BoxDecoration(
                  image: DecorationImage(
//                        image: correctWrongImage(),
//                      image: NetworkImage(questionData.mediaLink),
                      image: NetworkImage(correctWrongImage()),

                      fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: ColorRes.white, width: 1)),
            ),
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
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  initialPageType: Const.typeHome,
                  questionDataSituation: null,
                )),
        ModalRoute.withName('home'));

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => HomePage(
                initialPageType: Const.typeNewCustomer,
                questionDataSituation: null,
              )),
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
                          top: 25, bottom: 15, right: 25, left: 25),
                      child: Container(
                        height: Utils.getDeviceHeight(context) / 1.6,
                        width: Utils.getDeviceWidth(context) / 1.2,
                        margin: EdgeInsets.only(top: 0),
                        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
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
                          Utils.playClickSound();
                          Navigator.pop(context);
                        },
                        child: Container(
                            alignment: Alignment.center,
                            height: Utils.getDeviceWidth(context) / 40,
                            width: Utils.getDeviceWidth(context) / 40,
                            decoration: BoxDecoration(
                                image: Injector.isBusinessMode
                                    ? DecorationImage(
                                        image: AssetImage(
                                            Utils.getAssetsImg("close_dialog")),
                                        fit: BoxFit.fill)
                                    : null)),
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
//  List<Answer> arrAnswerSituation = List();

//  selectItem(index) {
//    setState(() {
//      _selectedItem = index;
//      print(selectItem.toString());
//    });
//  }

  checkAnswerBusinessMode(int index) {
//    Widget child;

    if (arrAnswerSituation[index].isSelected == true) {
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
    }
    return Utils.getAssetsImg("bg_green");
  }

  Widget showItemsFullScreen(int index) {
    return GestureDetector(
        onTap: () {
//          setState(() {
//            arrAnswerSituation[index].isSelected = !arrAnswerSituation[index].isSelected;
//          });
        },
        child: Container(
          height: 50,
          margin: EdgeInsets.only(left: 6, right: 6, top: 6),
          padding: EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius:
                  Injector.isBusinessMode ? null : BorderRadius.circular(15),
              border: Injector.isBusinessMode
                  ? null
                  : Border.all(
                      width: 1,
                      color: arrAnswerSituation[index].isSelected
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
                      image: AssetImage(checkAnswer(index)
//                          Utils.getAssetsImg(
//                          arrAnswerSituation[index].isSelected
//                              ? "rounded_rectangle_837_blue"
//                              : "rounded_rectangle_8371")
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
                        color: (checkTextColor(index)
//                            arrAnswerSituation[index].isSelected
//                            ? ColorRes.white
//                            : ColorRes.textProf
                            )),
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
                              image: NetworkImage(questionData.isAnsweredCorrect
                                  ? questionData.correctAnswerImage
                                  : questionData.inCorrectAnswerImage),
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
                                      image: Injector.isBusinessMode
                                          ? DecorationImage(
                                              image: AssetImage(
                                                  Utils.getAssetsImg(
                                                      "close_dialog")),
                                              fit: BoxFit.contain)
                                          : null))
                              : Container(
                                  alignment: Alignment.center,
                                  height: Utils.getDeviceWidth(context) / 40,
                                  width: Utils.getDeviceWidth(context) / 40,
                                  decoration: BoxDecoration(
                                      image: Injector.isBusinessMode
                                          ? DecorationImage(
                                              image: AssetImage(
                                                  Utils.getAssetsImg(
                                                      "close_dialog")),
                                              fit: BoxFit.contain)
                                          : null)))),
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

/*class CategoryItem extends StatefulWidget {
  final String title;
  final int index;
  final bool isSelected;
  Function(int) selectItem;

  CategoryItem(
    this.selectItem, {
    Key key,
    this.title,
    this.index,
    this.isSelected,
  }) : super(key: key);

  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  var _indexShow = ["A", "B", "C", "D"];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.selectItem(widget.index);
//        Navigator.push(context, MaterialPageRoute(builder: (context) => Customer()));
//        Navigator.push(
//          context,
//          MaterialPageRoute(
//              builder: (context) => HomePage(
//                    initialPageType: Const.typeDebrief,
//                  )),
//        );
      },
      child: Container(
//          height: 60,
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
                    color:
                        widget.isSelected ? ColorRes.white : ColorRes.fontGrey),
            color: Injector.isBusinessMode
                ? null
                : (widget.isSelected ? ColorRes.greenDot : ColorRes.white),
            image: Injector.isBusinessMode
                ? DecorationImage(
                    image: AssetImage(Utils.getAssetsImg(widget.isSelected
                        ? "bg_green"
                        : "rounded_rectangle_8371")),
                    fit: BoxFit.fill)
                : null),
        child: Row(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 5.0, right: 5.0)),
            Title(
                color: ColorRes.greenDot,
                child: new Text(_indexShow[widget.index],
                    style: TextStyle(
                        color: (widget.isSelected
                            ? ColorRes.white
                            : ColorRes.textProf)))),
            Padding(padding: EdgeInsets.only(left: 5.0, right: 5.0)),
            Expanded(
              child: SingleChildScrollView(
                child: new Text(
                  "hellohellohellohellohellhellohellohelllohellohellohellohelloellohellohellohellohell",
                  style: TextStyle(
                      color: (widget.isSelected
                          ? ColorRes.white
                          : ColorRes.textProf)),
                ),
              ),
            )
          ],
        ),
//        Text(
//          widget.title,
//          style: TextStyle(color: (widget.isSelected ? ColorRes.white : ColorRes.black), fontSize: 15),
//        ),
      ),
    );
  }
}*/
