import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/BLoC/locale_bloc.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/dialogs/display_dailogs.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/models/UpdateDialogModel.dart';
import 'package:ke_employee/models/privay_policy.dart';
import 'package:ke_employee/screens/forgot_password.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/screens/home.dart';
import 'package:ke_employee/models/login.dart';
import 'package:url_launcher/url_launcher.dart';

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

  List languagesList = [StringRes.english, StringRes.german, StringRes.chinese];

  ScrollController _scrollController = new ScrollController();
  UpdateDialogModel status;

  bool isCompanyVerified = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 1000), () {
      verifyCompany();
    });

//    localeBloc.setLocale(Utils.getIndexLocale());
  }

  Future initStateMethods() async {
    status = await Injector.getCurrentVersion(context);
    if (status != null && status.status != null && status.status != "0" || status != null && status.status != null && status.status == "2") {
      if (status.status == "2") {
        if (Injector.prefs.get(PrefKeys.isCancelDialog) == null) {
          DisplayDialogs.showUpdateDialog(context, status.headlineText, status.message, true);
        } else {
          DateTime clickedTime = DateTime.parse(Injector.prefs.get(PrefKeys.isCancelDialog));
          if (DateTime.now().difference(clickedTime).inDays >= 1) {
            DisplayDialogs.showUpdateDialog(context, status.headlineText, status.message, true);
          }
        }
      } else {
        DisplayDialogs.showUpdateDialog(context, status.headlineText, status.message, false);
      }
    }
    localeBloc.setLocale(Utils.getIndexLocale(Injector.language));
  }

  //Sound Is mute

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: false,
        backgroundColor: ColorRes.fontDarkGrey,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(Utils.getAssetsImg('bg_login_profesonal'), fit: BoxFit.cover),
            Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: Utils.getDeviceWidth(context) / 15),
                    child: Center(
                      child: Image.asset(
                        Utils.getAssetsImg('logo_login'),
                        height: Utils.getDeviceHeight(context) / 1.8,
                        width: Utils.getDeviceWidth(context) / 3.8,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: ListView(
                      controller: _scrollController,
                      shrinkWrap: true,
                      children: <Widget>[
                        Container(height: Utils.getDeviceHeight(context) / 8),
                        Container(
                          width: double.infinity,
                          height: Utils.getDeviceHeight(context) / 1.3,
                          margin: EdgeInsets.only(left: 20, right: 20),
                          decoration: BoxDecoration(
                            color: ColorRes.loginBg,
                            border: Border.all(color: ColorRes.white, width: 1),
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                          child: showLoginForm(),
                        ),
                        Container(height: Utils.getDeviceHeight(context) / 4),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Widget showLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 15,
          decoration: BoxDecoration(
            color: ColorRes.blueMenuSelected,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(9), topRight: Radius.circular(9)),
          ),
        ),
        Container(height: 1, color: ColorRes.white),
        Expanded(
          child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ListView(
                shrinkWrap: true,
                primary: false,
                padding: EdgeInsets.all(0),
                children: <Widget>[
//                  Text(Const.APP_NAME),
                  showEmailView(),
                  SizedBox(height: 10),
                  showPassword(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Utils.getDeviceWidth(context) / 9),
                    child: InkResponse(
                        child: Container(
                          height: 30,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: ExactAssetImage(Utils.getAssetsImg('btn_login')), alignment: Alignment.topCenter, fit: BoxFit.fill),
                          ),
                          child: Text(
                            Utils.getText(context, StringRes.login).toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ColorRes.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        onTap: () {
                          Utils.isInternetConnectedWithAlert(context).then((isConnected) async {
                            if (isConnected) validateForm();
                          });
                        }),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkResponse(
                      child: Text(
                        Utils.getText(context, StringRes.forgotPassword).toUpperCase(),
                        style: TextStyle(color: ColorRes.white, fontSize: 17),
                      ),
                      onTap: () {
                        Utils.playClickSound();
                        Navigator.push(context, FadeRouteForgotPassword());
                      },
                    ),
                  ),
                  // SizedBox(
                  //   height: 5,
                  // ),
//                   Align(
//                     alignment: Alignment.topRight,
//                     child: InkResponse(
//                       child: Text(
//                         Utils.getText(context, StringRes.selectLanguage) + " - " + tempLanguage,
//                         style: TextStyle(color: ColorRes.white, fontSize: 17),
//                       ),
//                       onTap: () {
//                         Utils.playClickSound();
// //                        Navigator.push(context, FadeRouteForgotPassword());
// //                        selectLanguagesDialog();
//                         selectLanguagesAlert(context);
//                       },
//                     ),
//                   ),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkResponse(
                      child: Text(
                        Utils.getText(context, StringRes.requestDemoAccount),
                        style: TextStyle(color: ColorRes.blue, fontSize: 17),
                      ),
                      onTap: () {
                        _launchEmail("support@knowledge-empire.com");
                      },
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }

  _launchEmail(String email) async {
    if (await canLaunch("mailto:$email")) {
      await launch("mailto:$email");
    } else {
      throw 'Could not launch';
    }
  }

  validateForm() async {
    Utils.playClickSound();

    if (emailController.text.isEmpty) {
      Utils.showToast(Utils.getText(context, StringRes.emailEmpty));
      return;
    }

    if (passwordController.text.isEmpty) {
      Utils.showToast(Utils.getText(context, StringRes.passWordEmpty));
      return;
    }

    _scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );

    LoginRequest loginRequest = LoginRequest();
    loginRequest.email = emailController.text.trim();
    loginRequest.password = Utils.generateMd5(passwordController.text.trim());
    loginRequest.secret = Utils.getSecret(loginRequest.email, loginRequest.password);
    loginRequest.language = Injector.language == StringRes.strDefault ? null : Injector.language;
    loginRequest.companyCode = Injector.companyCode;

    Utils.hideKeyboard(context);

    CommonView.showCircularProgress(true, context);

    WebApi().callAPI(WebApi.rqLogin, loginRequest.toJson()).then((data) async {
      CommonView.showCircularProgress(false, context);

      if (data != null) {
        UserData userData = UserData.fromJson(data);
        localeBloc.setLocale(Utils.getIndexLocale(userData.language));
        Injector.setUserData(userData, false);
        Injector.updateInstance();

        if (userData.isSeenPrivacyPolicy != 1) {
          apiCallPrivacyPolicy(userData.userId, Const.typeGetPrivacyPolicy.toString(), userData.activeCompany, (privacyPolicyResponse) {
            if (privacyPolicyResponse != null) {
              if (privacyPolicyResponse.isSeenPrivacyPolicy != 1 &&
                  privacyPolicyResponse.privacyPolicyTitle != "" &&
                  privacyPolicyResponse.privacyPolicyContent != "" &&
                  privacyPolicyResponse.privacyPolicyAcceptText != "") {
                Utils.showPrivacyPolicyDialog(_scaffoldKey, false, userData.activeCompany, privacyPolicyResponse.privacyPolicyTitle,
                    privacyPolicyResponse.privacyPolicyContent, privacyPolicyResponse.privacyPolicyAcceptText, completion: (status) {
                  print("status :::::::::: $status--------------------------------------------------------");
                  if (status == true) {
                    // localeBloc.setLocale(Utils.getIndexLocale(userData.language));
                    moveToChangePasswordOrDashboard();
                  } else {
                    Navigator.of(context).pop();
                  }
                });
              } else {
                moveToChangePasswordOrDashboard();
              }
            }
          });
        } else {
          moveToChangePasswordOrDashboard();
        }
      }
    }).catchError((e) {
      print("Error::::::::::::::::::::::::::: $e");
      CommonView.showCircularProgress(false, context);
    });
  }

  moveToChangePasswordOrDashboard() {
    if (Injector.userData.isPasswordChanged != 1) {
      Utils.showChangePasswordDialog(_scaffoldKey, false, false);
    } else if (Injector.userData.isFirstTimeLogin == true) {
      Utils.showNickNameDialog(_scaffoldKey, false);
    } else {
      navigateToDashboard();
    }
  }

  void navigateToDashboard() {
    print("Navigate to dashboard--------------------------------------------------------");
    Navigator.pushAndRemoveUntil(context, FadeRouteHome(), ModalRoute.withName("/login"));
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
                    color: ColorRes.white, border: Border.all(width: 1, color: ColorRes.white), borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(left: 8),
                child: Center(
                  child: TextField(
                    controller: emailController,
                    autocorrect: Platform.isAndroid ? true : false,
                    keyboardType: TextInputType.emailAddress,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    style: TextStyle(fontSize: 17, color: ColorRes.titleBlueProf),
                    onSubmitted: (value) {
                      _scrollController.animateTo(
                        0.0,
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 300),
                      );
                    },
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
                        hintText: Utils.getText(context, StringRes.emailId).toUpperCase(),
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
                    color: ColorRes.white, border: Border.all(width: 1, color: ColorRes.white), borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(left: 8),
                child: Center(
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    style: TextStyle(fontSize: 17, color: ColorRes.titleBlueProf),
                    onSubmitted: (value) {
                      _scrollController.animateTo(
                        0.0,
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 300),
                      );
                    },
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
                        hintText: Utils.getText(context, StringRes.password).toUpperCase(),
                        hintStyle: TextStyle(color: ColorRes.greyText),
                        border: InputBorder.none),
                  ),
                )))
      ],
    );
  }

  void verifyCompany() async {
    isCompanyVerified = Injector.prefs.getString(PrefKeys.mainBaseUrl) != null && Injector.prefs.getString(PrefKeys.mainBaseUrl).isNotEmpty;

    if (!isCompanyVerified) {
      await Utils.showVerifyCompanyDialog(_scaffoldKey).then((value) => verifyCompany());
    } else
      initStateMethods();
  }
}
