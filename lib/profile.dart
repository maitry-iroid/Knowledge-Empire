import 'package:flutter/material.dart';

import 'helper/Utils.dart';
import 'helper/res.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.colorBgDark,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Utils.getAssetsImg('bg_dashboard_trans')),
                  fit: BoxFit.fill)),
          child: Row(
            children: <Widget>[
              showFirstHalf(),
              Container(
                margin: EdgeInsets.only(top: 40,bottom: 40,left: 25),
                height: double.infinity,
                width: 1,
                color: ColorRes.greyText.withOpacity(0.5),
              ),
              showSecondHalf()
            ],
          ),
        ),
      ),
    );
  }

  showFirstHalf() {
    return Expanded(
      flex: 1,
      child: Container(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            showTitle(),
            SizedBox(
              height: 5,
            ),
            showProfile(),
            showForm(),
          ],
        ),
      ),
    );
  }

  showSecondHalf() {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: Utils.getDeviceWidth(context) / 12),
        child: ListView(
          children: <Widget>[
            Container(
              height: 35,
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.only(top: 3),
              alignment: Alignment.center,
              child: Text(
                Utils.getText(context, StringRes.settings),
                style: TextStyle(
                    color: ColorRes.white, fontSize: 17, letterSpacing: 0.5),
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Utils.getAssetsImg('bg_setting')))),
            ),
            Container(
              height: 30,
              margin: EdgeInsets.only(top: 15, bottom: 10),
              alignment: Alignment.center,
              child: Text(
                Utils.getText(context, StringRes.privacyPolicy),
                style: TextStyle(
                  color: ColorRes.white,
                  fontSize: 15,
                ),
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Utils.getAssetsImg('bg_privacy')))),
            ),
            Container(
              height: 30,
              alignment: Alignment.center,
              child: Text(
                Utils.getText(context, StringRes.termsConditions),
                style: TextStyle(
                  color: ColorRes.white,
                  fontSize: 15,
                ),
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Utils.getAssetsImg('bg_privacy')))),
            ),
            Container(
              height: 30,
              margin: EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              child: Text(
                Utils.getText(context, StringRes.contactUs),
                style: TextStyle(
                  color: ColorRes.white,
                  fontSize: 15,
                ),
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Utils.getAssetsImg('bg_privacy')))),
            ),
            Container(
              height: 35,
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.only(left: 8, right: 8),
              alignment: Alignment.center,
              child: Text(
                Utils.getText(context, StringRes.switchProfMode),
                style: TextStyle(
                    color: ColorRes.white, fontSize: 15, letterSpacing: 0.7),
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage(Utils.getAssetsImg('bg_switch_to_prfsnl')),
                      fit: BoxFit.fill)),
            ),
            Container(
              height: 33,
              margin: EdgeInsets.symmetric(vertical: 15),
              alignment: Alignment.center,
              child: Text(
                Utils.getText(context, StringRes.logout),
                style: TextStyle(
                  color: ColorRes.white,
                  fontSize: 16,
                ),
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Utils.getAssetsImg('bg_log_out')))),
            ),
          ],
        ),
      ),
    );
  }

  showTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
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
          Center(
            child: Container(
              alignment: Alignment.center,
              height: 35,
              margin: EdgeInsets.symmetric(horizontal: 90),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        Utils.getAssetsImg("bg_setting"),
                      ),
                      fit: BoxFit.fill)),
              child: Text(
                Utils.getText(context, StringRes.editProfile),
                style: TextStyle(
                  color: ColorRes.colorPrimary,
                  fontSize: 17,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }

  showProfile() {
    return InkResponse(
      child: Center(
        child: Stack(
          children: <Widget>[
            new Container(
              margin: EdgeInsets.all(5),
              width: 70,
              height: 70,
              decoration: new BoxDecoration(
                  border: Border.all(width: 2, color: Color(0xff7ab1cb)),
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage(
                          Utils.getAssetsImg("dashboard-background")))),
            ),
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
        ),
      ),
    );
  }

  Container showForm() {
    return Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 10),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 36,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorRes.lightBg.withOpacity(0.5),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            width: 13,
                          ),
                          Text(
                            Utils.getText(context, StringRes.yourName),
                            style:
                                TextStyle(color: ColorRes.white, fontSize: 12),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              height: 38,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        Utils.getAssetsImg("bg_name_email")),
                                    fit: BoxFit.fill),
                              ),
                              child: TextField(
                                obscureText: false,
                                style: TextStyle(
                                  color: ColorRes.white,
                                  fontSize: 13,
                                ),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'xxxx xxxx',
                                    hintStyle:
                                        TextStyle(color: ColorRes.hintColor)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                InkResponse(
                  child: Image(
                    image: AssetImage(Utils.getAssetsImg("edit")),
                    width: 40,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 36,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorRes.lightBg.withOpacity(0.5),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 13,
                          ),
                          Text(
                            Utils.getText(context, StringRes.yourEmail),
                            style:
                                TextStyle(color: ColorRes.white, fontSize: 12),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              height: 38,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        Utils.getAssetsImg("bg_name_email")),
                                    fit: BoxFit.fill),
                              ),
                              child: TextField(
                                obscureText: false,
                                style: TextStyle(
                                  color: ColorRes.white,
                                  fontSize: 13,
                                ),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'xxx@xxx.xxx',
                                    hintStyle:
                                        TextStyle(color: ColorRes.hintColor)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                InkResponse(
                    child: Container(
                  width: 40,
                ))
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: InkResponse(
                    child: Container(
                      height: 35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  Utils.getAssetsImg("bg_change_pw")),
                              fit: BoxFit.fill)),
                      child:
                          Text(Utils.getText(context, StringRes.changePassword),
                              style: TextStyle(
                                color: ColorRes.white,
                                fontSize: 15,
                              )),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  flex: 1,
                  child: InkResponse(
                    child: Container(
                      height: 35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Utils.getAssetsImg("bg_save")),
                              fit: BoxFit.fill)),
                      child: Text(Utils.getText(context, StringRes.save),
                          style: TextStyle(
                            color: ColorRes.white,
                            fontSize: 15,
                          )),
                    ),
                  ),
                ),
                Container(
                  width: 40,
                )
              ],
            )
          ],
        ));
  }
}
