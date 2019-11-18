import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/profile.dart';
import 'package:notifier/main_notifier.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class HeaderView extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool isShowMenu;

  HeaderView({this.scaffoldKey, this.isShowMenu});

  @override
  Widget build(BuildContext context) {
    return showHeaderView(context);
  }

  showHeaderView(BuildContext context) {
    return Notifier.of(context).register<String>('changeMode', (data) {
      print('notified');

      return Container(
        height: Utils.getDeviceHeight(context) / 7,
//      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        color: Injector.isBusinessMode
            ? ColorRes.headerDashboard
            : Color(0xFF000040),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            isShowMenu
                ? InkResponse(
              child: Image(
                image: AssetImage(
                  Utils.getAssetsImg("menu"),
                ),
                fit: BoxFit.fill,
              ),
              onTap: () {
                scaffoldKey.currentState.openDrawer();
              },
            )
                : Container(),
            SizedBox(
              width: 8,
            ),
            InkResponse(
              child: Image(
                image: AssetImage(Utils.getAssetsImg("ic_menu")),
                width: 25,
              ),
              onTap: () {},
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    Injector.userData.name,
                    style:
                    TextStyle(color: ColorRes.textLightBlue, fontSize: 15),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    Injector.userData.phone,
                    style:
                    TextStyle(color: ColorRes.colorPrimary, fontSize: 15),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
            showHeaderItem(Const.typeChecked, context),
            showHeaderItem(Const.typePeople, context),
            showHeaderItem(Const.typeBadge, context),
            showHeaderItem(Const.typeResources, context),
            showHeaderItem(Const.typeDollar, context),
            showProfile(context)
          ],
        ),
      );
      ;
    });
  }

  showHeaderItem(int type, BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.only(left: 4, right: 4),
      margin: EdgeInsets.symmetric(horizontal: 1),
      decoration: Injector.isBusinessMode
          ? BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Utils.getAssetsImg("bg_header_card")),
              fit: BoxFit.fill))
          : BoxDecoration(),
      child: Row(
        children: <Widget>[
          LinearPercentIndicator(
            animation: true,
            animationDuration: 2000,
            width: Utils.getDeviceWidth(context) / 12,
            linearStrokeCap: LinearStrokeCap.roundAll,
            lineHeight: 18,
            center: type == Const.typeDollar
                ? Text(
              ' \$ 120.00',
              style:
              TextStyle(color: ColorRes.colorPrimary, fontSize: 18),
            )
                : Text(
              getProgress(type),
              style: TextStyle(color: ColorRes.white, fontSize: 14),
            ),
            leading: Image(
              image: AssetImage(Utils.getAssetsImg(getHeaderIcon(type))),
              height: 30,
            ),
            percent: getProgressInt(type),
            backgroundColor: Colors.grey,
            progressColor: Colors.blue,

          )
        ],
      ),
    );
  }

  showProfile(BuildContext context) {
    return InkResponse(
      child: Container(
        width: 30,
        height: 30,
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage(Utils.getAssetsImg('user_org'))),
            border: Border.all(color: ColorRes.textLightBlue)),
      ),
      onTap: () {
        Route route1 = MaterialPageRoute(builder: (context) => ProfilePage());
        print(route1.isCurrent);
        if (!route1.isCurrent) {
          Navigator.push(context, route1);
        }
      },
    );
  }

  String getHeaderIcon(int type) {
    if (type == Const.typeChecked)
      return "ic_checked_header";
    else if (type == Const.typePeople)
      return "ic_people";
    else if (type == Const.typeBadge)
      return "ic_badge";
    else if (type == Const.typeResources)
      return "ic_resourses";
    else if (type == Const.typeDollar)
      return "ic_dollar";
    else
      return "";
  }

  getProgress(int type) {
    if (type == Const.typeChecked) {
      return "30/100";
    } else if (type == Const.typePeople) {
      return "50/100";
    } else if (type == Const.typeBadge) {
      return "97%";
    } else if (type == Const.typeResources) {
      return "80/100";
    } else
      return "50/100";
  }

  getProgressInt(int type) {
    if (type == Const.typeChecked) {
      return 0.3;
    } else if (type == Const.typePeople) {
      return 0.5;
    } else if (type == Const.typeBadge) {
      return 0.97;
    } else if (type == Const.typeResources) {
      return 0.8;
    } else
      return 0.5;
  }
}
