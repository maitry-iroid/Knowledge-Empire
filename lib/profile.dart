import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/header.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:notifier/main_notifier.dart';
import 'package:notifier/notifier_provider.dart';

import 'commonview/background.dart';
import 'helper/Utils.dart';
import 'helper/constant.dart';
import 'helper/prefkeys.dart';
import 'helper/res.dart';
import 'helper/string_res.dart';
import 'login.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    nameController.text = Injector.userData.name;
    super.initState();
  }

  Notifier _notifier;

  @override
  Widget build(BuildContext context) {
    _notifier = NotifierProvider.of(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor:
          Injector.isBusinessMode ? ColorRes.colorBgDark : ColorRes.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: CommonView.getBGDecoration(),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    showFirstHalf(),
                    Container(
                      margin: EdgeInsets.only(top: 40, bottom: 40, left: 25),
                      height: double.infinity,
                      width: 1,
                      color: ColorRes.greyText.withOpacity(0.5),
                    ),
                    showSecondHalf()
                  ],
                ),
              )
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
                Utils.getText(context, StringResBusiness.settings),
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
                Utils.getText(context, StringResBusiness.privacyPolicy),
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
                Utils.getText(context, StringResBusiness.termsConditions),
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
                Utils.getText(context, StringResBusiness.contactUs),
                style: TextStyle(
                  color: ColorRes.white,
                  fontSize: 15,
                ),
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Utils.getAssetsImg('bg_privacy')))),
            ),
            InkResponse(
              child: Container(
                height: 35,
                margin: EdgeInsets.only(top: 15),
                padding: EdgeInsets.only(left: 8, right: 8),
                alignment: Alignment.center,
                child: Text(
                  Utils.getText(
                      context,
                      Injector.isBusinessMode
                          ? StringResBusiness.switchProfMode
                          : StringResBusiness.switchBusinessMode),
                  style: TextStyle(
                      color: ColorRes.white, fontSize: 15, letterSpacing: 0.7),
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            Utils.getAssetsImg('bg_switch_to_prfsnl')),
                        fit: BoxFit.fill)),
              ),
              onTap: () async {
                if (Injector.isBusinessMode)
                  await Injector.prefs
                      .setInt(PrefKeys.mode, Const.professionalMode);
                else
                  await Injector.prefs
                      .setInt(PrefKeys.mode, Const.businessMode);
                setState(() {
                  Injector.isBusinessMode = !Injector.isBusinessMode;
                });

                _notifier.notify('changeMode', 'Sending data from notfier!');
              },
            ),
            InkResponse(
              child: Container(
                height: 33,
                margin: EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.center,
                child: Text(
                  Utils.getText(context, StringResBusiness.logout),
                  style: TextStyle(
                    color: ColorRes.white,
                    fontSize: 16,
                  ),
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Utils.getAssetsImg('bg_log_out')))),
              ),
              onTap: () async {
                await Injector.prefs.clear();

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    ModalRoute.withName("/home"));
              },
            )
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
              width: 35,
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
                Utils.getText(context, StringResBusiness.editProfile),
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
                            Utils.getText(context, StringResBusiness.yourName),
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
                                controller: nameController,
                                obscureText: false,
                                style: TextStyle(
                                  color: ColorRes.white,
                                  fontSize: 13,
                                ),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "xxxx xxxx",
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
                            Utils.getText(context, StringResBusiness.yourEmail),
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
                                enabled: false,
                                obscureText: false,
                                style: TextStyle(
                                  color: ColorRes.white,
                                  fontSize: 13,
                                ),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: Injector.prefs
                                        .getString(PrefKeys.email),
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
                      child: Text(
                          Utils.getText(
                              context, StringResBusiness.changePassword),
                          style: TextStyle(
                            color: ColorRes.white,
                            fontSize: 15,
                          )),
                    ),
                    onTap: () {
                      Utils.showChangePasswordDialog(_scaffoldKey, true);
                    },
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
                      child:
                          Text(Utils.getText(context, StringResBusiness.save),
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
