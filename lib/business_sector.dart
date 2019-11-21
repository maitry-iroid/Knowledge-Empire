import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';

import 'helper/Utils.dart';
import 'helper/res.dart';

class BusinessSectorPage extends StatefulWidget {
  @override
  _BusinessSectorPageState createState() => _BusinessSectorPageState();
}

class _BusinessSectorPageState extends State<BusinessSectorPage> {
  var arrSector = ["Healthcare", "Industrials", "Technology", "Financials"];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: CommonView.getBGDecoration(),
      child: Row(
        children: <Widget>[
          showFirstHalf(),
          Expanded(
            flex: 1,
            child: Injector.isBusinessMode
                ? Card(
                    color: Colors.transparent,
                    elevation: 20,
                    margin: EdgeInsets.all(0),
                    child: showSecondHalf(),
                  )
                : showSecondHalf(),
          )
        ],
      ),
    );
  }


  Container showSubHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
          color: Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
          borderRadius:
              Injector.isBusinessMode ? null : BorderRadius.circular(20),
          image: Injector.isBusinessMode
              ? DecorationImage(
                  image: AssetImage(Utils.getAssetsImg("business_sec_header")),
                  fit: BoxFit.fill)
              : null),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Text(
              Utils.getText(context, StringResBusiness.sector),
              style: TextStyle(color: ColorRes.white),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              Utils.getText(context, StringResBusiness.size),
              style: TextStyle(color: ColorRes.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget showItem(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 9,
          child: Container(
            height: Utils.getTitleHeight(),
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 10, top: 5, right: 10),
            decoration: BoxDecoration(
                color: Injector.isBusinessMode ? null : ColorRes.white,
                borderRadius:
                    Injector.isBusinessMode ? null : BorderRadius.circular(20),
                image: Injector.isBusinessMode
                    ? DecorationImage(
                        image: AssetImage(
                            Utils.getAssetsImg("bg_new_customer_item")),
                        fit: BoxFit.fill)
                    : null),
            child: Text(
              arrSector[index],
              style: TextStyle(
                  color: Injector.isBusinessMode
                      ? ColorRes.blue
                      : ColorRes.textProf,
                  fontSize: 15),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            height: 30,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 5, right: 10, top: 2, bottom: 2),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
                color: Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
                borderRadius:
                    Injector.isBusinessMode ? null : BorderRadius.circular(20),
                image: Injector.isBusinessMode
                    ? DecorationImage(
                        image: AssetImage(Utils.getAssetsImg("value")),
                        fit: BoxFit.fill)
                    : null),
            child: Text(
              '10',
              style: TextStyle(color: ColorRes.white, fontSize: 22),
            ),
          ),
        ),
      ],
    );
  }

  showFirstHalf() {
    return Expanded(
      flex: 1,
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          CommonView.showTitle(context, StringResBusiness.businessSector),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
//            color: ColorRes.lightBg,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: ColorRes.white,
                        ),
                        alignment: Alignment.topLeft,
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 14, color: ColorRes.hintColor),
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 10),
                              hintText: Utils.getText(
                                  context, StringResBusiness.searchForKeywords),
                              hintStyle: TextStyle(color: ColorRes.hintColor),
                              border: InputBorder.none),
                        ))),
                SizedBox(
                  width: 5,
                ),
                Image(
                  height: 35,
                  image: AssetImage(
                    Utils.getAssetsImg(Injector.isBusinessMode?"search":'search_prof'),
                  ),
                  fit: BoxFit.fill,
                )
              ],
            ),
          ),
          showSubHeader(),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: arrSector.length,
            itemBuilder: (BuildContext context, int index) {
              return showItem(index);
            },
          )
        ],
      ),
    );
  }

  showSecondHalf() {
    return Container(
      color: Injector.isBusinessMode ? null : Color(0xFFeaeaea),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              height: double.infinity,
              child: Stack(
                children: <Widget>[
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Injector.isBusinessMode
                        ? ColorRes.whiteDarkBg
                        : ColorRes.white,
                    margin: EdgeInsets.only(
                        top: 20, bottom: Utils.getDeviceHeight(context) / 7),
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 30, bottom: 10),
                      decoration: BoxDecoration(
                        color: Injector.isBusinessMode
                            ? ColorRes.bgDescription
                            : ColorRes.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Injector.isBusinessMode
                            ? Border.all(color: ColorRes.white, width: 1)
                            : null,
                      ),
                      child: SingleChildScrollView(
                        child: Text(
                          "qwywer shankar riddhi govindbhaoqwywer shankar riddhi govindbhaoqwywer shankar riddhi govindbhaoqwywer shankar riddhi govindbhaoqwywer shankar riddhi govindbhaoqwywer shankar ",
                          style: TextStyle(
                              color: Injector.isBusinessMode
                                  ? ColorRes.white
                                  : ColorRes.textProf),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      alignment: Alignment.center,
                      height: Utils.getTitleHeight(),
                      margin: EdgeInsets.symmetric(
                          horizontal: Utils.getDeviceWidth(context) / 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: Injector.isBusinessMode
                              ? null
                              : ColorRes.titleBlueProf,
                          borderRadius: BorderRadius.circular(20),
                          image: Injector.isBusinessMode
                              ? DecorationImage(
                                  image:
                                      AssetImage(Utils.getAssetsImg("bg_blue")),
                                  fit: BoxFit.fill)
                              : null),
                      child: Text(
                        Utils.getText(context, StringResBusiness.description),
                        style: TextStyle(color: ColorRes.white, fontSize: 17),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            height: Utils.getTitleHeight(),
            margin: EdgeInsets.symmetric(
                horizontal: Utils.getDeviceWidth(context) / 8,vertical: 20),
            padding:
            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                color: Injector.isBusinessMode
                    ? null
                    : ColorRes.headerBlue,
                borderRadius: BorderRadius.circular(20),
                image: Injector.isBusinessMode
                    ? DecorationImage(
                    image:
                    AssetImage(Utils.getAssetsImg("bg_blue")),
                    fit: BoxFit.fill)
                    : null),
            child: Text(
              Utils.getText(context, StringResBusiness.engageSegment),
              style: TextStyle(color: ColorRes.white, fontSize: 17),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
