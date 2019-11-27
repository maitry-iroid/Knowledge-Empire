import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/engagement_customer.dart';

class CommonView {
  static getBGDecoration() {
    return Injector.isBusinessMode
        ? BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Utils.getAssetsImg('bg_dashboard_trans')),
                fit: BoxFit.fill))
        : BoxDecoration(color: ColorRes.bgProf);
  }

  static showTitle(BuildContext context, String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(),
        ),
        InkResponse(
          child: Image(
            image: AssetImage(Utils.getAssetsImg(
                Injector.isBusinessMode ? "back" : 'back_prof')),
            width: DimenRes.titleBarHeight,
          ),
          onTap: () {
            Utils.performBack(context);
          },
        ),
        Container(
          alignment: Alignment.center,
          height: DimenRes.titleBarHeight,
          padding: EdgeInsets.symmetric(horizontal: 20),
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius:
                  Injector.isBusinessMode ? null : BorderRadius.circular(20),
              border: Injector.isBusinessMode
                  ? null
                  : Border.all(width: 1, color: ColorRes.white),
              color: Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
              image: Injector.isBusinessMode
                  ? DecorationImage(
                      image: AssetImage(
                        Utils.getAssetsImg("bg_blue"),
                      ),
                      fit: BoxFit.fill)
                  : null),
          child: Text(
            Utils.getText(context, Utils.getText(context, title)),
            style: TextStyle(
              color: ColorRes.white,
              fontSize: DimenRes.titleTextSize,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Container(),
        ),
      ],
    );
  }

  static image(BuildContext context, String image) {
    var img = Container(
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 20),
      decoration: BoxDecoration(
        color: ColorRes.white,
        image: DecorationImage(
            image: AssetImage(
              Utils.getAssetsImg(image),
            ),
            fit: BoxFit.fill),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    return img;
  }

  static questionAndExplanation(BuildContext context, String title) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Card(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          margin: EdgeInsets.only(top: 15, bottom: 15, right: 15, left: 15),
          child: Container(
            margin: EdgeInsets.only(top: 0),
            padding: EdgeInsets.only(left: 10, right: 10, top: 20),
            decoration: BoxDecoration(
              color: Injector.isBusinessMode ? ColorRes.bgDescription : null,
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
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            alignment: Alignment.center,
            height: 30,
            margin: EdgeInsets.symmetric(
                horizontal: Utils.getDeviceWidth(context) / 6),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius:
                Injector.isBusinessMode ? null : BorderRadius.circular(20),
                border: Injector.isBusinessMode
                    ? null
                    : Border.all(width: 1, color: ColorRes.white),
                color: Injector.isBusinessMode ? null : ColorRes.titleBlueProf,

                image: Injector.isBusinessMode
                    ? DecorationImage(
                        image: AssetImage(Utils.getAssetsImg("eddit_profile")),
                        fit: BoxFit.fill)
                    : null),
            child: Text(
              title,
              style: TextStyle(color: ColorRes.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

/*
  static answers(BuildContext context, String title){
    return Stack(
      children: <Widget>[
        Card(
          elevation: 10,
//                          color: ColorRes.whiteDarkBg,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)),
          margin: EdgeInsets.only(
              top: 25, bottom: 10, right: 10, left: 15),
          child: Container(
            padding: EdgeInsets.only(
                left: 10, right: 10, top: 15, bottom: 18),
            decoration: BoxDecoration(
              color: ColorRes.bgDescription,
              borderRadius: BorderRadius.circular(12),
              border:
              Border.all(color: ColorRes.white, width: 1),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: arrSector.length,
              itemBuilder: (BuildContext context, int index) {
//                                GestureDetector(
//                                  onTap: () {
//                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Customer()));
//                                  },
//                                );
                return CategoryItem(
                  selectItem,
                  // callback function, setstate for parent
                  index: index,
                  isSelected:
                  _selectedItem == index ? true : false,
                  title: arrSector[index],
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
                vertical: 10),
            padding: EdgeInsets.symmetric(
                horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        Utils.getAssetsImg("eddit_profile")),
                    fit: BoxFit.fill)),
            child: Text(
              'Answers',
              style: TextStyle(
                  color: ColorRes.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
*/

  static topThreeButton(
      BuildContext context, String firstTitle, String secondTitle) {
    return Row(
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
              Utils.performBack(context);
            },
          ),
//          InkResponse(
//          child: Image(
//          image: AssetImage(Utils.getAssetsImg(
//          Injector.isBusinessMode ? "back" : 'back_prof')),
//          width: DimenRes.titleBarHeight,
//          ),
//          onTap: () {
//          Utils.performBack(context);
//          },
          alignment: Alignment.center,
          height: 40,
          width: 40,

          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Utils.getAssetsImg("back")),
                  fit: BoxFit.fill)),
//                        child: Icon(Icons.chevron_left, color: ColorRes.white,),
        ),
        Container(
          alignment: Alignment.center,
          height: 30,
//                          margin: EdgeInsets.only(left: 50.0, right: 50.0),

          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Utils.getAssetsImg("eddit_profile")),
                  fit: BoxFit.fill)),
          child: Text(
            firstTitle,
            style: TextStyle(color: ColorRes.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: 30,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Utils.getAssetsImg("bg_engage_now")),
                  fit: BoxFit.fill)),
          child: Text(
            secondTitle,
            style: TextStyle(color: ColorRes.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  static Widget showCircularProgress(bool isLoading) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }
}
