import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';

import 'customViews/CustomClipper.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.fontDarkGrey,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/images/bg_login.png'),
            fit: BoxFit.fill,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.all(0.1),
                  width: Utils.getDeviceWidth(context) / 2.5,
                  height: Utils.getDeviceHeight(context) / 1.7,
                  margin: EdgeInsets.only(
                      left: Utils.getDeviceWidth(context) / 1.65, right: 20),
                  decoration: BoxDecoration(
                    color: ColorRes.colorBgDark,
                    border: Border.all(color: ColorRes.colorPrimary, width: 1),
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  child: showLoginForm(),
                ))
          ],
        ),
      ),
    );
  }

  showLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          height: 15,
          decoration: BoxDecoration(
            color: ColorRes.borderColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9), topRight: Radius.circular(9)),
          ),
        ),
        Container(
          height: 1,
          color: ColorRes.colorPrimary,

        ),
        Expanded(
          child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: ListView(
                padding: EdgeInsets.all(0),
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image(
                        image: AssetImage(Utils.getAssetsImg("email1")),
                        width: 50,
                        height: 50,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 8),
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: ColorRes.bgTextBox,
                              border: Border.all(
                                color: ColorRes.white,
                                width: 1,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: TextField(
                            obscureText: false,
                            style:
                                TextStyle(color: ColorRes.white, fontSize: 13),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'EMAIL ID',
                                hintStyle:
                                    TextStyle(color: ColorRes.hintColor)),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Image(
                        image: AssetImage(Utils.getAssetsImg("pw")),
                        width: 50,
                        height: 50,
                      ),
                      Expanded(
                        child: Container(
                          height: 40,
                          margin: EdgeInsets.only(left: 8),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: ColorRes.bgTextBox,

                              border: Border.all(
                                color: ColorRes.white,
                                width: 1,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: TextField(
                            obscureText: true,
                            style:
                                TextStyle(color: ColorRes.white, fontSize: 13),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'PASSWORD',
                                hintStyle:
                                    TextStyle(color: ColorRes.hintColor)),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "Forgot Password?".toUpperCase(),
                      style: TextStyle(color: ColorRes.white),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 50, left: 70, top: 20),
                    alignment: Alignment.center,
                    height: 40,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: ExactAssetImage('assets/images/btn_login.png'),
                          alignment: Alignment.topCenter,
                          fit: BoxFit.fill),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(color: ColorRes.white),
                    ),
                  )
                ],
              )),
        ),
      ],
    );
  }
}
