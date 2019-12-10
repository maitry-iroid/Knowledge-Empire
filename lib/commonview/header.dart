import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/header_utild.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/organization.dart';
import 'package:notifier/main_notifier.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class HeaderView extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool isShowMenu;
  final Function openProfile;

  HeaderView({this.scaffoldKey, this.isShowMenu, this.openProfile});

//  List<Organization> arrOrganization = Injector.customerValueData.organization;

  @override
  Widget build(BuildContext context) {
    return showHeaderView(context);
  }

  showHeaderView(BuildContext context) {
    return Notifier.of(context).register<String>('changeMode', (data) {
      return Container(
        height: Utils.getDeviceHeight(context) / 7.5,
//      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        color: Injector.isBusinessMode
            ? ColorRes.headerDashboard
            : ColorRes.headerBlue,
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
                      Utils.playClickSound();
                      scaffoldKey.currentState.openDrawer();
                    },
                  )
                : Container(),
            SizedBox(
              width: 8,
            ),
            InkResponse(
              child: Image(
                image: AssetImage(
                  Utils.getAssetsImg("ic_menu"),
                ),
                color: Injector.isBusinessMode
                    ? ColorRes.textLightBlue
                    : ColorRes.white,
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
                    Injector.userData != null
                        ? Injector.userData.companyName
                        : "",
                    style: TextStyle(
                        color: Injector.isBusinessMode
                            ? ColorRes.textLightBlue
                            : ColorRes.white,
                        fontSize: 15),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    Injector.userData != null ? Injector.userData.name : "",
                    style: TextStyle(
                        color: Injector.isBusinessMode
                            ? ColorRes.white
                            : ColorRes.textLightBlue,
                        fontSize: 15),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
            showHeaderItem(Const.typeEmployee, context),
            showHeaderItem(Const.typeSalesPersons, context),
            showHeaderItem(Const.typeServicesPerson, context),
            showHeaderItem(Const.typeBadge, context),
            showHeaderItem(Const.typeDollar, context),
            showProfile(context)
          ],
        ),
      );
    });
  }

  showHeaderItem(int type, BuildContext context) {
    return Container(
      height: 40,
      padding:
          EdgeInsets.symmetric(horizontal: Injector.isBusinessMode ? 4 : 2),
      margin: EdgeInsets.symmetric(horizontal: 1),
      decoration: BoxDecoration(
          image: Injector.isBusinessMode
              ? DecorationImage(
                  image: AssetImage(Utils.getAssetsImg("bg_header_card")),
                  fit: BoxFit.fill)
              : null),
      child: Row(
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Injector.isBusinessMode
                  ? Container()
                  : Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                          border: Border.all(color: ColorRes.white, width: 1),
                          borderRadius: BorderRadius.circular(12.5)),
                    ),
              Image(
                image: AssetImage(Utils.getAssetsImg(HeaderUtils.getHeaderIcon(type))),
                height: 26,
              ),
            ],
          ),
          SizedBox(
            width: 4,
          ),
          type != Const.typeDollar
              ? Stack(
                  alignment: Alignment.centerLeft,
                  children: <Widget>[
                    Container(
                      height: Injector.isBusinessMode ? 19 : 21,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: ColorRes.greyText,
//                          image: Injector.isBusinessMode
//                              ? DecorationImage(
//                                  image: AssetImage(
//                                      Utils.getAssetsImg('bg_progress')),
//                                  fit: BoxFit.fill)
//                              : null,
                          borderRadius: BorderRadius.circular(12),
                          border: Injector.isBusinessMode
                              ? null
                              : Border.all(color: ColorRes.white, width: 1)),
                      padding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: Injector.isBusinessMode ? 0 : 1),
                      child: LinearPercentIndicator(
                        width: Utils.getDeviceWidth(context) / 12,
                        lineHeight: 19.0,
                        percent: HeaderUtils.getProgressInt(type),
                        backgroundColor: Colors.transparent,
                        progressColor: Colors.blue,
                      ),
                    ),
                    Positioned(
                      left: 4,
                      child: Text(
                        HeaderUtils.getProgress(type),
                        style: TextStyle(color: ColorRes.white, fontSize: 14),
                      ),
                    )
                  ],
                )
              : Text(
                  ' \$ ' +
                      (Injector.customerValueData != null
                          ? Injector.customerValueData.totalBalance.toString()
                          : "00.00"),
                  style: TextStyle(color: ColorRes.white, fontSize: 16),
                ),
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
                  image: Injector.userData.profileImage != null
                      ? NetworkImage(Injector.userData.profileImage)
                      : AssetImage(Utils.getAssetsImg('user_org')),
                  fit: BoxFit.fill),
              border: Border.all(color: ColorRes.textLightBlue)),
        ),
        onTap: () {
//            openProfile /*() {
          Utils.playClickSound();
          openProfile();
//        Route route1 = MaterialPageRoute(builder: (context) => ProfilePage());
//        print(route1.isCurrent);
//        if (!route1.isCurrent) {
//          Navigator.push(context, route1);
//        }
//      },*/
        });
  }


}
