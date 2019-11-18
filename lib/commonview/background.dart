import 'package:flutter/cupertino.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';

class CommonView {
  static getBGDecoration() {
    return Injector.isBusinessMode
        ? BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Utils.getAssetsImg('bg_dashboard_trans')),
                fit: BoxFit.fill))
        : BoxDecoration(color: ColorRes.white);
  }
}
