import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/BLoC/locale_bloc.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/models/language.dart';
import 'package:ke_employee/screens/forgot_password.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/screens/home.dart';
import 'package:ke_employee/models/login.dart';
import 'package:ke_employee/screens/intro_page.dart';

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

  String tempLanguage = Const.english;

  @override
  void initState() {
    super.initState();

    localeBloc.setLocale(0);
//    localeBloc.setLocale(Utils.getIndexLocale());

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
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkResponse(
                      child: Text(
                        Utils.getText(context, StringRes.selectLanguages)
                            .toUpperCase(),
                        style: TextStyle(color: ColorRes.white),
                      ),
                      onTap: () {
                        Utils.playClickSound();
//                        Navigator.push(context, FadeRouteForgotPassword());
//                        selectLanguagesDialog();
                        selectLanguagesAlert(context);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 2,
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


  selectLanguagesAlert(BuildContext context) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: ColorRes.blackTransparentColor,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Stack(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(40),
                      width: Utils.getDeviceWidth(context) / 3.0,
                      height: Utils.getDeviceHeight(context) / 1.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorRes.white,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 35,
                              width: Utils.getDeviceWidth(context),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                color: ColorRes.blue,
                              ),
                              alignment: Alignment.topCenter,
                              child: Center(
                                child: Text(
                                  Utils.getText(context, "Select Your Language"),
                                  style: TextStyle(
                                      color: ColorRes.white, fontSize: 17),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 13)),


                            languageSelectCell(StringRes.english, 0),
                            languageSelectCell(StringRes.german, 1),
                            languageSelectCell(StringRes.chinese, 2),


                          ],
                        ),
                      )),
                  Positioned(
                      right: 10,
                      child: InkResponse(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Image(
                            image:
                            AssetImage(Utils.getAssetsImg('close_dialog')),
                            width: 20,
                          ),
                        ),
                        onTap: () {
                          Utils.playClickSound();
                          Navigator.pop(context, null);
                        },
                      ))
                ],
              ),
            ),
          );
        });


    /*showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: ColorRes.blackTransparentColor,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Container(
                  width: Utils.getDeviceWidth(context) / 2,
                  height: Utils.getDeviceHeight(context) / 2,
                  decoration: BoxDecoration(
                      color: ColorRes.greyText,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 50,
                        child: Text("Notification Alert"),
                      ),
                      Expanded(child: Text("Count of Notification.")),
                      Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 100,
                        padding: EdgeInsets.only(bottom: 0),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            color: ColorRes.blue,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: InkResponse(
                          child: Text("hello", textAlign: TextAlign.center,),
                          onTap: () {
                              Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  )),
            ),
          );
        })*/
  }

  languageSelectCell(String language, int index) {
    return  InkResponse(
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        padding: EdgeInsets.only(top: 5, bottom: 5, left: 0, right: 0),
        decoration: BoxDecoration(
            color: ColorRes.rankingProValueBg,
            borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        width: Utils.getDeviceWidth(context),
        child: Text(Utils.getText(context, language), textAlign: TextAlign.center,),
      ),
      onTap: () async {

        if(index == 0) {
          tempLanguage = Const.english;
//          await languageChangeAPI(Const.english, index);
        } else if(index == 1){
          tempLanguage = Const.german;
//          await languageChangeAPI(Const.german, index);
        } else if(index == 2) {
          tempLanguage = Const.chinese;
//          await languageChangeAPI(Const.chinese, index);
        }

        Navigator.pop(context);
      },
    );
  }

  selectLanguagesDialog() {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: ColorRes.blackTransparentColor,

        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Center(
            child: Container(
                width: Utils.getDeviceWidth(context) / 3,
                height: Utils.getDeviceHeight(context) / 2,
                decoration: BoxDecoration(
//                    color: ColorRes.greyText,
                    color: ColorRes.loginBg,
                    borderRadius: BorderRadius.circular(10)),
                child:


                    ListView.builder(
                        itemCount: languagesList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () async {
                              try {
                                if (index == 0) {
                                  await languageChangeAPI(Const.english, index);
                                } else if (index == 1) {
                                  await languageChangeAPI(Const.german, index);
                                } else if (index == 2) {
                                  await languageChangeAPI(Const.chinese, index);
                                }
                              } catch (e) {
                                print(e);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    Utils.getText(context, languagesList[index]),
                                    textAlign: TextAlign.center,

                                    style: TextStyle(
                                        fontSize: 15,
                                        color: ColorRes.black,
                                        decoration: TextDecoration.none),
                                  ),
                                ),
                              ),
                            ),
                          );
                        })

            ),
          );
        });
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
    loginRequest.language = tempLanguage;
//    tempLanguage

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
            Utils.navigateToIntro(context);
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
                    autocorrect: Platform.isAndroid ? true :false,
//                    autocorrect: false,
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
//                    autocorrect: true,
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


  //language select API
  languageChangeAPI(String language, int index) {
    Utils.playClickSound();

    LanguageRequest rq = LanguageRequest();
    rq.userId = Injector.userId.toString();
    rq.language = language;

//    Map<String, dynamic> map = {"userId": Injector.userId, "language": };
    CommonView.showCircularProgress(true, context);
    WebApi().callAPI(WebApi.updateLanguage, rq.toJson()).then((data) async {
      CommonView.showCircularProgress(false, context);

      if (data != null) {
        localeBloc.setLocale(index);
        Injector.userData.language = language;
        await Injector.setUserData(Injector.userData);
        setState(() {});
      } else {
        Utils.showToast(Utils.getText(context, StringRes.somethingWrong));
      }
      Utils.performBack(context);
    }).catchError((e) {
      Utils.performBack(context);
      print("updatePorfile_" + e.toString());
      CommonView.showCircularProgress(false, context);
      Utils.showToast(e.toString());
    });
  }
}
