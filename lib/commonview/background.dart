import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';

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
            image: AssetImage(Utils.getAssetsImg(Injector.isBusinessMode?"back":'back_prof')),
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
              color: Injector.isBusinessMode?null:ColorRes.titleBlueProf,
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

  static   Widget showCircularProgress(bool isLoading) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }
}
