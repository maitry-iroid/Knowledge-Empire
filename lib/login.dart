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
              alignment: Alignment.topRight,
              child: SingleChildScrollView(
                child: Container(
                  width: Utils.getDeviceWidth(context) / 2.5,
                  margin: EdgeInsets.only(
                      top: 50,
                      left: Utils.getDeviceWidth(context) / 1.8,
                      right: 20),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorRes.white, width: 1),
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        color: ColorRes.colorPrimary,
                        height: 15,
                      ),
                      Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Image(
                                    image: AssetImage(
                                        Utils.getAssetsImg("email1")),
                                    width: 50,
                                    height: 50,
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(left: 5),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: ColorRes.white,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: TextField(
                                        obscureText: false,
                                        style: TextStyle(
                                            color: ColorRes.white,
                                            fontSize: 15),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Password',
                                        ),
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
                                      margin: EdgeInsets.only(left: 5),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: ColorRes.white,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: TextField(
                                        obscureText: true,
                                        style: TextStyle(
                                            color: ColorRes.white,
                                            fontSize: 15),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Password',
                                        ),
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
                                  "Forgot Password",
                                  style: TextStyle(color: ColorRes.white),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: 50, left: 70, top: 20),
                                height: 30,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: ExactAssetImage(
                                          'assets/images/btn_login.png'),
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
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
