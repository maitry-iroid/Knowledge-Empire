import 'package:flutter/material.dart';

import 'helper/Utils.dart';
import 'helper/res.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.colorBgDark,
      body: SafeArea(
        child: Row(
          children: <Widget>[showFirstHalf(), showSecondHalf()],
        ),
      ),
    );
  }

  showFirstHalf() {
    return Expanded(
      flex: 1,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          showTitle(),
          SizedBox(
            height: 10,
          ),
          showProfile(),
          showSubHeader(),
        ],
      ),
    );
  }

  showSecondHalf() {
    return Expanded(
      flex: 1,
      child: Container(
        color: ColorRes.whiteDarkBg,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Card(
                elevation: 10,
                margin: EdgeInsets.all(0),
                child: Container(
                  padding: EdgeInsets.all(20),
                  color: ColorRes.whiteDarkBg,
                  height: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      Card(
                        elevation: 10,
                        color: ColorRes.whiteDarkBg,
                        margin: EdgeInsets.only(
                            top: 20,
                            bottom: Utils.getDeviceHeight(context) / 7),
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 30, bottom: 10),
                          decoration: BoxDecoration(
                            color: ColorRes.bgDescription,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: ColorRes.colorPrimary, width: 1),
                          ),
                          child: SingleChildScrollView(
                            child: Text(
                              "qwywer shankar riddhi govindbhaoqwywer shankar riddhi govindbhaoqwywer shankar riddhi govindbhaoqwywer shankar riddhi govindbhaoqwywer shankar riddhi govindbhaoqwywer shankar ",
                              style: TextStyle(color: ColorRes.colorPrimary),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          margin: EdgeInsets.symmetric(
                              horizontal: Utils.getDeviceWidth(context) / 10),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage(Utils.getAssetsImg("bg_blue")),
                                  fit: BoxFit.fill)),
                          child: Text(
                            'Description',
                            style: TextStyle(
                                color: ColorRes.colorPrimary, fontSize: 22),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        child: InkResponse(
                          child: Image(
                            image: AssetImage(
                                Utils.getAssetsImg("engage_segment")),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row showTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkResponse(
          child: Image(
            image: AssetImage(Utils.getAssetsImg("back")),
            width: 40,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Container(
          alignment: Alignment.center,
          height: 40,
          margin: EdgeInsets.only(left: 10),
          padding: EdgeInsets.symmetric(horizontal: 40),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Utils.getAssetsImg("bg_blue")),
                  fit: BoxFit.fill)),
          child: Text(
            Utils.getText(context, StringRes.editProfile),
            style: TextStyle(color: ColorRes.colorPrimary, fontSize: 22),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  showProfile() {
    return Stack(
      children: <Widget>[
        new Container(
            width: 70,
            height: 70,
            decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new AssetImage(
                        Utils.getAssetsImg("dashboard-background"))))),
        Positioned(
          right: 0,
          top: 0,
          child: Image(
            image: AssetImage(
              Utils.getAssetsImg("edit"),
            ),
            width: 30,
          ),
        )
      ],
    );
  }

  Container showSubHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Utils.getAssetsImg("bg_rounded")),
              fit: BoxFit.fill)),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Text(
              'Sector',
              style: TextStyle(color: ColorRes.colorPrimary),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Size',
              style: TextStyle(color: ColorRes.colorPrimary),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
