import 'package:flutter/material.dart';
import 'package:ke_employee/Debrief.dart' as prefix0;
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/home.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'commonview/header.dart';
import 'helper/constant.dart';
import 'helper/res.dart';
import 'Customer_Situation.dart';
import 'commonview/background.dart';
import 'models/Answer.dart';

class EngagementCustomer extends StatefulWidget {
  @override
  _EngagementCustomerState createState() => _EngagementCustomerState();
}

class _EngagementCustomerState extends State<EngagementCustomer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _selectedItem = 0;

  List<Answer> arrAnswer = List();

  selectItem(index) {
    setState(() {
      _selectedItem = index;
      print(selectItem.toString());
    });
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
                  fit: BoxFit.fill,
                )
              : Container(color:  ColorRes.bgProf,),
          Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 10),
                  child: CommonView.topThreeButton(context, StringRes.engagement, StringRes.next)
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
                            child: CommonView.image(
                                context, "vector_smart_object1"),
                          ),
                          Expanded(
                              child: CommonView.questionAndExplanation(
                                  context, "Question"))
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
                                return CategoryItem(
                                  selectItem,
                                  index: index,
                                  isSelected:
                                      _selectedItem == index ? true : false,
//                                  title: arrSector[index],
                                );
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
                            child: Text(
                              'Answers',
                              style: TextStyle(
                                  color: ColorRes.white, fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            ],
          )
        ],
      ),
    ));
  }
}

 class CategoryItem extends StatefulWidget {
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





//  var arrAnswers = ["A", "B", "C", "D"];



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.selectItem(widget.index);

        setState(() {
          arrAnswer[widget.index].isSelected = true;
        });

//        Navigator.push(context, MaterialPageRoute(builder: (context) => Customer()));
//        Navigator.push(
//          context,
//          MaterialPageRoute(
//              builder: (context) => HomePage(
//                    initialPageType: Const.typeDebrief,
//                  )),
//        );
      },
      child: ( arrAnswer[widget.index].isSelected ? Container(
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
                ? (DecorationImage(
                    image: AssetImage(Utils.getAssetsImg ("rounded_rectangle_8371")
//                      (widget.isSelected
//                        ? "rounded_rectangle_837_blue"
//                        : "rounded_rectangle_8371")
                    ),
                    fit: BoxFit.fill))
                : null),
        child: Row(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 5.0, right: 5.0)),
            Title(
                color: ColorRes.greenDot,
                child: new Text(arrAnswer[widget.index].text,
                    style: TextStyle(
//                        color: (widget.isSelected
//                            ? ColorRes.white
//                            : ColorRes.textProf)
                    ))),
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
      ) : Container(
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
                ? (DecorationImage(
                image: AssetImage(Utils.getAssetsImg ("rounded_rectangle_837_blue")
//                  (widget.isSelected
//                    ? "rounded_rectangle_837_blue"
//                    : "rounded_rectangle_8371")
                ),
                fit: BoxFit.fill))
                : null),
        child: Row(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 5.0, right: 5.0)),
            Title(
                color: ColorRes.greenDot,
                child: new Text(arrAnswer[widget.index].text,
                    style: TextStyle(
                        color: ColorRes.white
//                        (widget.isSelected
//                            ? ColorRes.white
//                            : ColorRes.textProf)
                    ))),
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
      )
    )
    );
  }
}
