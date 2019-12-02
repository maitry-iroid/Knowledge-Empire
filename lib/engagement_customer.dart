import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/questions_response.dart' ;
import 'commonview/header.dart';
import 'helper/res.dart';
import 'commonview/background.dart';
import 'models/questions_response.dart';

List<Answer> arrAnswer = List();

int _selectedItem = 0;

QuestionData questionData  =QuestionData();

List abcdList = List();

class EngagementCustomer extends StatefulWidget {
//  List<QuestionData> arrQuestions = List();

//  EngagementCustomer({Key key, this.arrQuestions}) : super(key: key);

  final  QuestionData questionDataEngCustomer;

  EngagementCustomer({Key key, this.questionDataEngCustomer}) : super(key: key);

  @override
  _EngagementCustomerState createState() => _EngagementCustomerState();
}

class _EngagementCustomerState extends State<EngagementCustomer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List abcdIndex = ['A','B','C','D'];
  int _selectedDrawerIndex = 0;

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

  @override
  void initState() {
    // TODO: implement initState

    questionData = widget.questionDataEngCustomer;
    arrAnswer = widget.questionDataEngCustomer.answer;
    abcdList = abcdIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Container(
                  margin: EdgeInsets.only(top: 10),
                  child: CommonView.topThreeButton(
                      context, StringRes.engagement, StringRes.next, _selectedItem, questionData)
//                  CommonView.showTitle(
//                      context, Utils.getText(context, StringRes.engagement))
              ),
              Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              Container(
                                  height: Utils.getDeviceHeight(context) / 2.3,
//                                    child: CommonView.image(
//                                        context, "vector_smart_object1"),
                                  child: CommonView.image(
                                      context, questionData.mediaLink)
                              ),
                              Expanded(
                                child: CommonView.questionAndExplanation(
                                    context, Utils.getText(context, StringRes.question), true, questionData.question),
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
                              margin: EdgeInsets.only(
                                  top: 20, bottom: 15, right: 15, left: 8),
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 15, bottom: 18),
                                decoration: BoxDecoration(
                                  color: Injector.isBusinessMode
                                      ? ColorRes.bgDescription
                                      : null,
                                  borderRadius: BorderRadius.circular(12),
                                  border:
                                  Border.all(color: ColorRes.white, width: 1),
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  itemCount: arrAnswer.length,
                                  itemBuilder: (BuildContext context, int index) {
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
                                    horizontal: Utils.getDeviceWidth(context) / 6,
                                    vertical: 5),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    borderRadius: Injector.isBusinessMode
                                        ? null
                                        : BorderRadius.circular(20),
                                    border: Injector.isBusinessMode
                                        ? null
                                        : Border.all(
                                        width: 1, color: ColorRes.white),
                                    color: Injector.isBusinessMode
                                        ? null
                                        : ColorRes.titleBlueProf,
                                    image: Injector.isBusinessMode
                                        ? DecorationImage(
                                        image: AssetImage(Utils.getAssetsImg(
                                            "eddit_profile")),
                                        fit: BoxFit.fill)

                                        : null),
                                child: Text(Utils.getText(context, StringRes.answers),
                                  style: TextStyle(
                                      color: ColorRes.white, fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            //Full Screen Alert Show Question : -
                            Align(
                              alignment: Alignment.bottomRight,
                              child: InkResponse(
                                onTap: () {
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
                                        image: Injector.isBusinessMode
                                            ? DecorationImage(
                                            image: AssetImage(Utils.getAssetsImg(
                                                "full_expand_question_answers")),
                                            fit: BoxFit.fill)
                                            : null)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          )
        ],
      )
    ));
  }

  Widget showItem(int index) {
    return GestureDetector(
        onTap: () {
          setState(() {
            arrAnswer[index].isSelected = !arrAnswer[index].isSelected;
          });
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
                      color: arrAnswer[index].isSelected
                          ? ColorRes.white
                          : ColorRes.fontGrey),
              color: Injector.isBusinessMode
                  ? null
                  : (arrAnswer[index].isSelected
                      ? ColorRes.greenDot
                      : ColorRes.white),
              image: Injector.isBusinessMode
                  ? (DecorationImage(
                      image: AssetImage(Utils.getAssetsImg(
                          arrAnswer[index].isSelected
                              ? "rounded_rectangle_837_blue"
                              : "rounded_rectangle_8371")),
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
                        fontSize: 12,
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
                          top: 15, bottom: 15, right: 15, left: 15),
                      child: Container(
                        height: Utils.getDeviceHeight(context) / 1.8,
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
                          itemCount: arrAnswer.length,
                          itemBuilder: (BuildContext context, int index) {
                            return showItemFullScree(index);
                          },
                        ),
                      ),
                    ),

                    Positioned(
                      top: 0,
//                      alignment: Alignment.topCenter,
                      child: Container(
                        alignment: Alignment.center,
                        height: 25,
                        margin: EdgeInsets.symmetric(
                            horizontal: Utils.getDeviceWidth(context) / 3,
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
                    Positioned(
                      top: 0,
                      right: 0,
//                    alignment: Alignment.bottomRight,
                      child: InkResponse(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            alignment: Alignment.center,
                            height: Utils.getDeviceWidth(context) / 40,
                            width: Utils.getDeviceWidth(context) / 40,
                            decoration: BoxDecoration(
                                image: Injector.isBusinessMode
                                    ? DecorationImage(
                                        image: AssetImage(Utils.getAssetsImg(
                                            "close_dialog")),
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
          setState(() {
            arrAnswer[index].isSelected = !arrAnswer[index].isSelected;
          });
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
                      color: arrAnswer[index].isSelected
                          ? ColorRes.white
                          : ColorRes.fontGrey),
              color: Injector.isBusinessMode
                  ? null
                  : (arrAnswer[index].isSelected
                      ? ColorRes.greenDot
                      : ColorRes.white),
              image: Injector.isBusinessMode
                  ? (DecorationImage(
                      image: AssetImage(Utils.getAssetsImg(
                          arrAnswer[index].isSelected
                              ? "rounded_rectangle_837_blue"
                              : "rounded_rectangle_8371")),
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
                          top: 15, bottom: 15, right: 15, left: 15),
                      child: Container(
                        height: Utils.getDeviceHeight(context) / 2,
                        width: Utils.getDeviceWidth(context) / 1.5,
                        margin: EdgeInsets.only(top: 0),
                        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                        decoration: BoxDecoration(
                          color: Injector.isBusinessMode
                              ? ColorRes.bgDescription
                              : null,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: ColorRes.white, width: 1),
                        ),
                        child: SingleChildScrollView(
                          child: Text(
                            "qwywer shankar riddhi govindbhaoqwywer shankar riddhi govindbhaoqwywer shankar riddhi govindbhaoqwywer shankar riddhi govindbhaoqwywer shankar riddhi govindbhaoqwywer shankar ",
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
                        height: 30,
                        margin: (checkimg == true
                            ? EdgeInsets.symmetric(
                                horizontal: Utils.getDeviceWidth(context) / 6)
                            : EdgeInsets.symmetric(
                                horizontal: Utils.getDeviceWidth(context) / 3)),
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
                          "Question",
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
                                              fit: BoxFit.fill)
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
                                              fit: BoxFit.fill)
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

// class CategoryItem extends StatefulWidget {
//  final String title;
//  final int index;
//  final bool isSelected;
//  Function(int) selectItem;
//
//  CategoryItem(
//    this.selectItem, {
//    Key key,
//    this.title,
//    this.index,
//    this.isSelected,
//  }) : super(key: key);
//
//  _CategoryItemState createState() => _CategoryItemState();
//}
//
//class _CategoryItemState extends State<CategoryItem> {
//
//
//
//
//
////  var arrAnswers = ["A", "B", "C", "D"];
//
//
//
//  @override
//  Widget build(BuildContext context) {
//    return GestureDetector(
//      onTap: () {
//        widget.selectItem(widget.index);
//
//        setState(() {
//          arrAnswer[widget.index].isSelected = true;
//        });
//
//      },
//      child: Container(
////          height: 60,
//        margin: EdgeInsets.only(left: 6, right: 6, top: 6),
//        padding: EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 6),
//        alignment: Alignment.center,
//        decoration: BoxDecoration(
//            borderRadius:
//                Injector.isBusinessMode ? null : BorderRadius.circular(15),
//            border: Injector.isBusinessMode
//                ? null
//                : Border.all(
//                    width: 1,
//                    color:
//                        widget.isSelected ? ColorRes.white : ColorRes.fontGrey),
//            color: Injector.isBusinessMode
//                ? null
//                : (widget.isSelected ? ColorRes.greenDot : ColorRes.white),
//            image: Injector.isBusinessMode
//                ? (DecorationImage(
//                    image: AssetImage(Utils.getAssetsImg ("rounded_rectangle_8371")
////                      (widget.isSelected
////                        ? "rounded_rectangle_837_blue"
////                        : "rounded_rectangle_8371")
//                    ),
//                    fit: BoxFit.fill))
//                : null),
//        child: Row(
//          children: <Widget>[
//            Padding(padding: EdgeInsets.only(left: 5.0, right: 5.0)),
//            Title(
//                color: ColorRes.greenDot,
//                child: new Text(arrAnswer[widget.index].text,
//                    style: TextStyle(
////                        color: (widget.isSelected
////                            ? ColorRes.white
////                            : ColorRes.textProf)
//                    ))),
//            Padding(padding: EdgeInsets.only(left: 5.0, right: 5.0)),
//            Expanded(
//              child: SingleChildScrollView(
//                child: new Text(
//                  "hellohellohellohellohellhellohellohelllohellohellohellohelloellohellohellohellohell",
//                  style: TextStyle(
//                      color: (widget.isSelected
//                          ? ColorRes.white
//                          : ColorRes.textProf)),
//                ),
//              ),
//            )
//          ],
//        ),
////        Text(
////          widget.title,
////          style: TextStyle(color: (widget.isSelected ? ColorRes.white : ColorRes.black), fontSize: 15),
////        ),
//      )
//
//    );
//  }
//}
