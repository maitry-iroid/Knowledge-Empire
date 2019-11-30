import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'engagement_customer.dart';
import 'helper/res.dart';
import 'commonview/header.dart';

import 'package:flutter/material.dart';
import 'package:ke_employee/Debrief.dart' as prefix0;
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/home.dart';
import 'commonview/header.dart';
import 'helper/constant.dart';
import 'helper/res.dart';
import 'Customer_Situation.dart';
import 'commonview/background.dart';
import 'models/questions_response.dart';

List<Answer> arrAnswer = List();

int _selectedItem = 0;

QuestionData questionData;

class CustomerSituationPage extends StatefulWidget {

//  final int selectedIndex;
//  CustomerSituationPage({Key key, this.selectedIndex}) : super(key: key);

  final  QuestionData questionData;

  CustomerSituationPage({Key key, this.questionData}) : super(key: key);

  @override
  _CustomerSituationPageState createState() => _CustomerSituationPageState();
}

class _CustomerSituationPageState extends State<CustomerSituationPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

//  int _selectedItem = 0;

  openProfile() {
    if (mounted) {
//      setState(() => _selectedDrawerIndex = 10);
      setState(() => _selectedItem = 10);
    }
  }

  selectItem(index) {
    setState(() {
//      _selectedItem = index;
//    _selectedItem = index;
      print(selectItem.toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
//    _selectedItem = widget.selectedIndex;

    questionData = widget.questionData;
    super.initState();
  }

//  int _selectedDrawerIndex = 0;
//
//  selectItem(index) {
//    setState(() {
//      _selectedItem = index;
//      print(selectItem.toString());
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        backgroundColor: ColorRes.colorBgDark,
        body: SafeArea(
            child: Column(
      children: <Widget>[
        HeaderView(
          scaffoldKey: _scaffoldKey,
          isShowMenu: true,
          openProfile: openProfile,
        ),
        Expanded(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Injector.isBusinessMode
                  ? Image(
                      image:
                          AssetImage(Utils.getAssetsImg('bg_dashboard_trans')),
                      fit: BoxFit.fill,
                    )
                  : Container(
                      color: ColorRes.bgProf,
                    ),
              Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      child: CommonView.showTitle(
                          context, Utils.getText(context, StringRes.debrief))),
                  Expanded(
                      child: Row(
                    children: <Widget>[
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
                                  border: Border.all(
                                      color: ColorRes.white, width: 1),
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  itemCount: 4,
                                  itemBuilder:
                                      (BuildContext context, int index) {
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
                                    horizontal:
                                        Utils.getDeviceWidth(context) / 6,
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
                                            image: AssetImage(
                                                Utils.getAssetsImg(
                                                    "eddit_profile")),
                                            fit: BoxFit.fill)
                                        : null),
                                child: Text(
                                  'Answers',
                                  style: TextStyle(
                                      color: ColorRes.white, fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: InkResponse(
                                onTap: () {
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
                                        image: Injector.isBusinessMode
                                            ? DecorationImage(
                                                image: AssetImage(
                                                    Utils.getAssetsImg(
                                                        "full_expand_question_answers")),
                                                fit: BoxFit.fill)
                                            : null)),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: Utils.getDeviceHeight(context) / 2.2,
                                child: CommonView.image(
                                    context, "vector_smart_object1"),
                              ),
                              Expanded(
                                  child: CommonView.questionAndExplanation(
                                      context, "Question", true, null))
                            ],
                          )),
                    ],
                  )),
                ],
              )
            ],
          ),
        )
      ],
    )));
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
                    "A",
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
                            return showItems(index);
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
                          'Answers',
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
//  List<Answer> arrAnswer = List();

//  selectItem(index) {
//    setState(() {
//      _selectedItem = index;
//      print(selectItem.toString());
//    });
//  }

  Widget showItems(int index) {
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
                    "A",
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
