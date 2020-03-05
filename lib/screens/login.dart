import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/screens/forgot_password.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/screens/home.dart';
import 'package:ke_employee/screens/intro_screen.dart';
import 'package:ke_employee/models/login.dart';

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
//          height: 400,
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage(Utils.getAssetsImg('bg_login_profesonal')),
              fit: BoxFit.cover,
//              alignment: Alignment.topCenter,
            ),
          ),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 50),
                  child: Image(
                    image: AssetImage(
                      Utils.getAssetsImg('logo_login'),
                    ),
                    width: Utils.getDeviceHeight(context) / 2,
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: Utils.getDeviceWidth(context) / 2.3,
                    height: Utils.getDeviceHeight(context) / 1.7,
                    margin: EdgeInsets.only(
                        right: 20, left: Utils.getDeviceWidth(context) / 5.5),
                    decoration: BoxDecoration(
//                    color: ColorRes.colorBgDark,
                      color: ColorRes.loginBg,
                      border: Border.all(color: ColorRes.white, width: 1),
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    child: showLoginForm(),
                  )),
            ],
          ),
        ));
  }

  showLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 15,
          decoration: BoxDecoration(
            color: ColorRes.blueMenuSelected,
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

    CommonView.showCircularProgress(true, context);

    WebApi().callAPI(WebApi.rqLogin, loginRequest.toJson()).then((data) async {
      CommonView.showCircularProgress(false, context);

      if (data != null) {
        UserData userData = UserData.fromJson(data);

        await Injector.setUserData(userData);

        if (userData.isFirstTimeLogin)
          Injector.prefs.setBool(PrefKeys.isIntroRemaining, true);

        if (Injector.userData.isPasswordChanged == 0) {
          Utils.showChangePasswordDialog(_scaffoldKey, false, false);
        } else {
          if (userData.isFirstTimeLogin)
            navigateToIntro();
          else
            navigateToDashboard();
        }
      }
    }).catchError((e) {
      print("login_" + e.toString());
      CommonView.showCircularProgress(false, context);
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
          image: AssetImage(Utils.getAssetsImg("email2")),
          width: 50,
          height: 50,
        ),
        Expanded(
            child: Container(
                height: 45,
                decoration: BoxDecoration(
                    color: ColorRes.white,
//                    color: ColorRes.bgTextBox,
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
                    style:
                        TextStyle(fontSize: 17, color: ColorRes.titleBlueProf),
                    decoration: InputDecoration(
//                          contentPadding: EdgeInsets.only(left: 8, right: 8),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 10),
                        hintText: Utils.getText(context, StringRes.emailId)
                            .toUpperCase(),
                        hintStyle: TextStyle(color: ColorRes.greyText),
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
          image: AssetImage(Utils.getAssetsImg("pw1")),
          width: 50,
          height: 50,
        ),
        Expanded(
            child: Container(
                height: 45,
                decoration: BoxDecoration(
                    color: ColorRes.white,
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
                    style:
                        TextStyle(fontSize: 17, color: ColorRes.titleBlueProf),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 10),
                        hintText: Utils.getText(context, StringRes.password)
                            .toUpperCase(),
                        hintStyle: TextStyle(color: ColorRes.greyText),
//                        hintStyle: TextStyle(color: ColorRes.hintColor),
                        border: InputBorder.none),
                  ),
                )))
      ],
    );
  }
}
