import 'dart:convert';
import 'dart:ui' as prefix0;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/forgot_password.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/home.dart';
import 'package:ke_employee/intro_screen.dart';
import 'package:ke_employee/models/login.dart';

import 'models/get_customer_value.dart';

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
                    border: Border.all(color: ColorRes.white, width: 1),
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  child: showLoginForm(),
                )),
            CommonView.showCircularProgress(isLoading)
          ],
        ),
      ),
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
          color: ColorRes.white,
        ),
        Expanded(
          child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ListView(
                shrinkWrap: true,
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
                        Utils.getText(context, StringRes.forgotPassword)
                            .toUpperCase(),
                        style: TextStyle(color: ColorRes.white),
                      ),
                      onTap: () {
                        Utils.playClickSound();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPasswordPage()));
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Utils.getDeviceWidth(context) / 8),
                    child: InkResponse(
                      child: Container(
                        height: 30,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: ExactAssetImage(
                                  Utils.getAssetsImg('btn_login')),
                              alignment: Alignment.topCenter,
                              fit: BoxFit.fill),
                        ),
                        child: Text(
                          Utils.getText(context, StringRes.login).toUpperCase(),
                          style: TextStyle(color: ColorRes.white, fontSize: 15),
                        ),
                      ),
                      onTap: validateForm,
                    ),
                  )
                ],
              )),
        ),
      ],
    );
  }

  validateForm() async {

    Utils.playClickSound();

    if (emailController.text.isEmpty) {
      Utils.showToast("Email can't be empty.");
      return;
    }

    if (passwordController.text.isEmpty) {
      Utils.showToast("Password can't be empty.");
      return;
    }

    LoginRequest loginRequest = LoginRequest();
    loginRequest.email = emailController.text.trim();
    loginRequest.password = Utils.generateMd5(passwordController.text.trim());
    loginRequest.secret =
        Utils.getSecret(loginRequest.email, loginRequest.password);

//    String udid = await FlutterUdid.udid;

    Utils.hideKeyboard(context);

    setState(() {
      isLoading = true;
    });

    WebApi().login(loginRequest.toJson()).then((loginData) async {
      if (loginData != null) {
        if (loginData.flag == "true") {
          LoginResponseData loginResponseData = loginData.data;

          await Injector.prefs
              .setString(PrefKeys.userId, loginResponseData.userId);
          await Injector.prefs.setString(
              PrefKeys.user, json.encode(loginResponseData.toJson()));

          Injector.userData = loginResponseData;

         getCustomerValues(loginData);

        } else {
          setState(() {
            isLoading = false;
          });

          Utils.showToast(loginData.msg);
        }
      }
    });
  }


  void getCustomerValues(LoginResponse loginData) {
    CustomerValueRequest rq = CustomerValueRequest();
    rq.userId = Injector.userData.userId;

    WebApi()
        .getCustomerValue(context, rq.toJson())
        .then((customerValueData) async {

          setState(() {
            isLoading = false;
          });

      if (customerValueData != null) {
        await Injector.prefs.setString(PrefKeys.customerValueData,
            json.encode(customerValueData.toJson()));

        Injector.customerValueData = customerValueData;

        if (loginData.data.isPasswordChanged == "0") {
          Utils.showChangePasswordDialog(_scaffoldKey, false);
        } else {
          navigateToDashboard();
        }


      }
    });
  }

  void navigateToDashboard() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => IntroPage()),
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
                decoration: BoxDecoration(
                    color: ColorRes.bgTextBox,
                    border: Border.all(width: 1, color: ColorRes.white),
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(left: 5),
                child: Center(
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    style: TextStyle(fontSize: 17, color: ColorRes.white),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 10),
                        hintText: Utils.getText(context, StringRes.emailId)
                            .toUpperCase(),
                        hintStyle: TextStyle(color: ColorRes.hintColor),
                        border: InputBorder.none),
                  ),
                )))
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
                decoration: BoxDecoration(
                    color: ColorRes.bgTextBox,
                    border: Border.all(width: 1, color: ColorRes.white),
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(left: 8),
                child: Center(
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    style: TextStyle(fontSize: 17, color: ColorRes.white),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10),
                        hintText: Utils.getText(context, StringRes.password)
                            .toUpperCase(),
                        hintStyle: TextStyle(color: ColorRes.hintColor),
                        border: InputBorder.none),
                  ),
                )))
      ],
    );
  }
}
