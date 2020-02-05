import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/screens/forgot_password.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/screens/home.dart';
import 'package:ke_employee/screens/intro_screen.dart';
import 'package:ke_employee/models/login.dart';
import '../models/get_customer_value.dart';

class FadeRouteLogin extends PageRouteBuilder {
  final Widget page;

  FadeRouteLogin({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: LoginPage(),
          ),
        );
}

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
  void initState() {
    super.initState();
  }

  //Sound Is mute

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
//      resizeToAvoidBottomPadding: false,
        backgroundColor: ColorRes.fontDarkGrey,
        body: Container(
//        height: double.infinity,

          height: 400,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage(Utils.getAssetsImg('bg_login')),
              fit: BoxFit.cover,
//            alignment: Alignment.center,
            ),
          ),

          child: Row(
//            alignment: Alignment.center,
            children: <Widget>[
              Container(
                height: Utils.getDeviceHeight(context) / 2.0,
                width: Utils.getDeviceWidth(context) / 3.5,
//                padding: EdgeInsets.only(left: 50),
                margin: EdgeInsets.only(left: 40),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Utils.getAssetsImg("logo_login")),
                        fit: BoxFit.fill)),
              ),
              Expanded(
                  flex: 5,
                  child: Container(
                    width: Utils.getDeviceWidth(context) / 2.3,
                    height: Utils.getDeviceHeight(context) / 1.7,
                    margin: EdgeInsets.only(
                        right: 20, left: Utils.getDeviceWidth(context) / 5.5),
                    decoration: BoxDecoration(
                      color: ColorRes.colorBgDark,
                      border: Border.all(color: ColorRes.white, width: 1),
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    child: showLoginForm(),
                  ))
            ],
          ),
        )

        /*Container(
        height: double.infinity,
        width: double.infinity,

          decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage(Utils.getAssetsImg('bg_login')),
            fit: BoxFit.fill,
//            alignment: Alignment.center,
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text("hello"),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  width: Utils.getDeviceWidth(context) / 2.3,
                  height: Utils.getDeviceHeight(context) / 1.7,
                  margin: EdgeInsets.only(right: 20,left: 15),
                  decoration: BoxDecoration(
                    color: ColorRes.colorBgDark,
                    border: Border.all(color: ColorRes.white, width: 1),
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  child: showLoginForm(),
                ))
          ],
        )
        /*Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[

//            Row(
//              children: <Widget>[
//                Expanded(flex: 1,
//                  child: Image(
//                  height: Utils.getDeviceHeight(context) / 1.7,
//                  image: AssetImage(
//                    Utils.getAssetsImg('logo_login'),
//                  ),
//                  width: Utils.getDeviceHeight(context) / 2,
//                ),),
//                Expanded(flex: 1,
//                    child: Container(
//                      width: Utils.getDeviceWidth(context) / 2.3,
//                      height: Utils.getDeviceHeight(context) / 1.7,
//                      margin: EdgeInsets.only(right: 20,left: 15),
//                      decoration: BoxDecoration(
//                        color: ColorRes.colorBgDark,
//                        border: Border.all(color: ColorRes.white, width: 1),
//                        borderRadius: new BorderRadius.circular(10.0),
//                      ),
//                      child: showLoginForm(),
//                    ))
//              ],
//            ),

         /*   Padding(
              padding: EdgeInsets.only(left: 50),
              child: Image(
                image: AssetImage(
                  Utils.getAssetsImg('logo_login'),
                ),
                width: Utils.getDeviceHeight(context) / 2,
              ),
            ),
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
            */
            CommonView.showCircularProgress(isLoading)
          ],
        ), */
      ), */
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
//                  Text(Const.APP_NAME),
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
                        Navigator.push(context, FadeRouteForgotPassword());
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
                      onTap: () {
                        Utils.isInternetConnectedWithAlert()
                            .then((isConnected) {
                          if (isConnected) validateForm();
                        });
                      },
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

    WebApi()
        .callAPI(WebApi.rqLogin, loginRequest.toJson())
        .then((loginData) async {
      if (loginData != null) {
        LoginResponseData loginResponseData =
            LoginResponseData.fromJson(loginData);

        await Injector.prefs.setInt(PrefKeys.userId, loginResponseData.userId);
        await Injector.prefs.setString(PrefKeys.user, jsonEncode(loginData));

        Injector.userData = loginResponseData;
        Injector.userId = loginResponseData.userId;

        if (loginResponseData.isFirstTimeLogin)
          navigateToIntro();
        else {
          navigateToDashboard();
        }
      }
    }).catchError((e) {
      print("login_" + e.toString());
      setState(() {
        isLoading = false;
      });
      Utils.showToast(e.toString());
    });
  }

  void getCustomerValues(LoginResponse loginData) {
    CustomerValueRequest rq = CustomerValueRequest();
    rq.userId = Injector.userData.userId;

    WebApi().callAPI(WebApi.rqGetCustomerValue, rq.toJson()).then((data) async {
      setState(() {
        isLoading = false;
      });

      if (data != null) {
        await Injector.prefs
            .setString(PrefKeys.customerValueData, json.encode(data.toJson()));

        Injector.customerValueData = data;

        if (loginData.data.isPasswordChanged == 0) {
          Utils.showChangePasswordDialog(_scaffoldKey, false, false);
        } else {
          if (loginData.data.isFirstTimeLogin)
            navigateToIntro();
          else {
            navigateToDashboard();
          }
        }
      }
    }).catchError((e) {
      print("customervalue_" + e.toString());
      setState(() {
        isLoading = false;
      });
      Utils.showToast(e.toString());
    });
  }

  void navigateToIntro() {
    Navigator.pushAndRemoveUntil(
        context, FadeRouteIntro(), ModalRoute.withName("/login"));
  }

  void navigateToDashboard() {
    Navigator.pushAndRemoveUntil(
        context, FadeRouteHome(), ModalRoute.withName("/login"));
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
                height: 45,
                decoration: BoxDecoration(
                    color: ColorRes.bgTextBox,
                    border: Border.all(width: 1, color: ColorRes.white),
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(left: 8),
                child: Center(
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    style: TextStyle(fontSize: 17, color: ColorRes.white),
                    decoration: InputDecoration(
//                          contentPadding: EdgeInsets.only(left: 8, right: 8),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 10),
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
                height: 45,
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
                            vertical: 12.0, horizontal: 10),
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
