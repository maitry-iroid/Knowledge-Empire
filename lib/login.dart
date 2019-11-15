import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/dashboard_new.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/forgot_password.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/login_request_data.dart';
import 'package:ke_employee/models/login_response_data.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorRes.fontDarkGrey,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage(Utils.getAssetsImg('bg_login')),
            fit: BoxFit.fill,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: Utils.getDeviceWidth(context) / 2.3,
                  height: Utils.getDeviceHeight(context) / 1.7,
                  margin: EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: ColorRes.colorBgDark,
                    border: Border.all(color: ColorRes.colorPrimary, width: 1),
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  child: showLoginForm(),
                )),
            showCircularProgress()
          ],
        ),
      ),
    );
  }

  Widget showCircularProgress() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  showLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
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
                  showEmailView(),
                  SizedBox(
                    height: 10,
                  ),
                  showPassword(),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkResponse(
                      child: Text(
                        "Forgot Password?".toUpperCase(),
                        style: TextStyle(color: ColorRes.white),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPasswordPage()));
                      },
                    ),
                  ),
                  InkResponse(
                    child: Container(
                      height: 30,
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(
                          horizontal: Utils.getDeviceWidth(context) / 8,
                          vertical: 5),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                ExactAssetImage('assets/images/btn_login.png'),
                            alignment: Alignment.topCenter,
                            fit: BoxFit.fill),
                      ),
                      child: Text(
                        "Login",
                        style: TextStyle(color: ColorRes.white),
                      ),
                    ),
                    onTap: validateForm,
                  )
                ],
              )),
        ),
      ],
    );
  }

  validateForm() async {
    if (emailController.text.isEmpty) {
      Utils.showToast("Email can't be empty.");
      return;
    }

    if (passwordController.text.isEmpty) {
      Utils.showToast("Password can't be empty.");
      return;
    }

    LoginRequestData loginRequest = LoginRequestData();
    loginRequest.email = emailController.text.trim();
    loginRequest.password = passwordController.text.trim();
    loginRequest.secret =
        Utils.getSecret(loginRequest.email, loginRequest.password);

//    String udid = await FlutterUdid.udid;

    Utils.hideKeyboard(context);

    setState(() {
      isLoading = true;
    });

    WebApi().login(loginRequest.toJson()).then((data) async {
      if (data != null) {
        if (data.flag == "true") {
          LoginResponseData loginResponseData = data.data;

          await Injector.prefs
              .setString(PrefKeys.userId, loginResponseData.userId);
          await Injector.prefs.setString(PrefKeys.email, loginRequest.email);
          await Injector.prefs.setString(PrefKeys.accessToken, loginResponseData.accessToken);
          await Injector.prefs.setString(
              PrefKeys.user, json.encode(loginResponseData.toJson()));

          setState(() {
            isLoading = false;
          });

//          if (data.data.isPasswordChanged == "0") {
//            Utils.showChangePasswordDialog(_scaffoldKey, "");
//          } else {
//            navigateToDashboard();
//          }


          navigateToDashboard();

        } else {
          setState(() {
            isLoading = false;
          });

          Utils.showToast(data.msg);
        }
      }
    });
  }

  void navigateToDashboard() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage()),
        ModalRoute.withName("/login"));
  }

  showEmailView() {
    return Row(
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
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
              style: TextStyle(color: ColorRes.white, fontSize: 13),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'EMAIL ID',
                  hintStyle: TextStyle(color: ColorRes.hintColor)),
            ),
          ),
        )
      ],
    );
  }

  showPassword() {
    return Row(
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
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: TextField(
              controller: passwordController,
              keyboardType: TextInputType.text,
              obscureText: true,
              style: TextStyle(color: ColorRes.white, fontSize: 13),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'PASSWORD',
                  hintStyle: TextStyle(color: ColorRes.hintColor)),
            ),
          ),
        )
      ],
    );
  }
}
