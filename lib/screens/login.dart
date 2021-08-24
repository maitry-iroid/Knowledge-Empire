import 'dart:io';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/BLoC/locale_bloc.dart';
import 'package:ke_employee/baseController/base_button.dart';
import 'package:ke_employee/baseController/base_textfield.dart';
import 'package:ke_employee/commonview/common_view.dart';
import 'package:ke_employee/dialogs/display_dailogs.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/manager/encryption_manager.dart';
import 'package:ke_employee/manager/version_manager.dart';
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

  final codeController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  List languagesList = [StringRes.english, StringRes.german, StringRes.chinese];

  // ScrollController _scrollController = new ScrollController();
  UpdateDialogModel status;

  bool isCompanyVerified = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    verifyCompany();
    preFillData();
    // callVersionApi();
  }

  void callVersionApi() async {
    UpdateDialogModel status = await Injector.getCurrentVersion(context);
    if (status != null) {
      if (status.status != "0" || status.status == "2") {
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
    }
  }

  preFillData() async {
    emailController.text = await EncryptionManager().stringDecryption(Injector.prefs.get(PrefKeys.emailId));
    codeController.text = Injector.prefs.get(PrefKeys.companyCode);
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
    if (Const.envType == Environment.DEV || Const.envType == Environment.PROD) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        body: Stack(
          fit: StackFit.expand,
          alignment: Alignment.bottomCenter,
          children: [
            (MediaQuery.of(context).viewInsets.bottom == 0) ? Image.asset(Utils.getAssetsImg('login_bg'), fit: BoxFit.cover) : Container(height: 0),
            Container(
                width: double.infinity,
                height: 100,
                margin: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: (MediaQuery.of(context).viewInsets.bottom == 0) ? 170 : 10,
                    bottom: (MediaQuery.of(context).viewInsets.bottom == 0) ? 10 : 170),
                decoration: BoxDecoration(
                  color: ColorRes.loginBg,
                  border: Border.all(color: ColorRes.white, width: 1),
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                child: showLoginForm()),
          ],
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: ColorRes.white,
        body: SafeArea(child: this.showMainView()),
      );
    }
  }

  Widget showMainView() {
    return Container(
      padding: EdgeInsets.all(10),
      color: ColorRes.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: Image.asset(Utils.getAssetsImg('logo_login'), width: Utils.getDeviceWidth(context))),
          Expanded(child: Container()),
          Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BaseTextField(
                      hintText: Utils.getText(context, StringRes.usernameText),
                      controller: emailController,
                      fillColor: ColorRes.white,
                      validator: (value) {
                        return null;
                      }),
                  SizedBox(height: Utils.getDeviceHeight(context) / 60),
                  BaseTextField(
                      hintText: Utils.getText(context, StringRes.password),
                      controller: passwordController,
                      isSecure: true,
                      fillColor: ColorRes.white,
                      validator: (value) {
                        return null;
                      }),
                  SizedBox(height: Utils.getDeviceHeight(context) / 60),
                  BaseTextField(
                      hintText: Utils.getText(context, StringRes.companyCode),
                      controller: codeController,
                      isSecure: false,
                      fillColor: ColorRes.white,
                      validator: (value) {
                        return null;
                      }),
//                  SizedBox(height: 15),
                  SizedBox(height: Utils.getDeviceHeight(context) / 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkResponse(
                        onTap: () {
                          Utils.playClickSound();
                          Navigator.push(context, FadeRouteForgotPassword());
                        },
                        child: Text(Utils.getText(context, StringRes.forgotPassword),
                            style: TextStyle(color: ColorRes.blue, fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      InkResponse(
                        onTap: () {
                          Utils.playClickSound();
                          selectLanguagesAlert(context);
                        },
                        child: Text(Utils.getText(context, StringRes.changeLanguage),
                            style: TextStyle(color: ColorRes.blue, fontSize: 16, fontWeight: FontWeight.bold)),
                      )
                    ],
                  )
                ],
              )),
          Expanded(child: Container()),
          Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BaseRaisedButton(
                      buttonColor: ColorRes.blue,
                      textColor: Colors.white,
                      borderColor: Colors.white,
                      buttonText: Utils.getText(context, StringRes.login),
                      onPressed: () {
                        Utils.isInternetConnectedWithAlert(context).then((isConnected) async {
                          if (isConnected) validateForm();
                        });
                        // Navigator.of(context).pushNamed(bottomNavigationRoute);
                      }),
                  SizedBox(height: 10),
                  InkResponse(
                      onTap: () {
                        _launchEmail("support@knowledge-empire.com");
                      },
                      child: Center(
                        child: Text(Utils.getText(context, StringRes.requestDemoAccount),
                            style: TextStyle(color: ColorRes.blue, fontSize: 17, fontWeight: FontWeight.bold)),
                      )),
                  Expanded(child: Container()),
                  Center(
                    child: Text(
                      VersionManager.getVersion(context),
                      style: TextStyle(color: ColorRes.lightGrey.withOpacity(0.5), fontSize: 18),
                      textAlign: TextAlign.right,
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  Widget showLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Row(
                  children: [
                    Expanded(child: showEmailView()),
                    SizedBox(width: 10),
                    Expanded(child: showCompanyCodeView()),
                  ],
                )),
                Expanded(
                    child: Row(
                  children: [
                    Expanded(child: showPassword()),
                    SizedBox(width: 10),
                    Expanded(child: showLoginButton()),
                  ],
                )),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [SizedBox(width: 50), Expanded(child: showForgotPasswordView()), Expanded(child: showChangeLanguageView())],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: 50),
                                  Expanded(child: showRequestDemoAccountView()),
                                ],
                              ),
                            )
                          ],
                        )),
                    showVersion(),
                  ],
                )),
//                 Expanded(
//                     child: Container(
//                         alignment: Alignment.center,
//                         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                         child: ListView(
//                           shrinkWrap: true,
//                           primary: false,
//                           padding: EdgeInsets.all(0),
//                           children: <Widget>[
// //                  Text(Const.APP_NAME),
//                             showCompanyCodeView(),
//                             SizedBox(height: 10),
//                             showEmailView(),
//                             SizedBox(height: 10),
//                             showPassword(),
//                             Padding(
//                               padding: EdgeInsets.symmetric(horizontal: Utils.getDeviceWidth(context) / 9),
//                               child: InkResponse(
//                                   child: Container(
//                                     height: 30,
//                                     alignment: Alignment.center,
//                                     margin: EdgeInsets.only(top: 10),
//                                     padding: EdgeInsets.symmetric(horizontal: 20),
//                                     decoration: BoxDecoration(
//                                       image: DecorationImage(
//                                           image: ExactAssetImage(Utils.getAssetsImg('btn_login')), alignment: Alignment.topCenter, fit: BoxFit.fill),
//                                     ),
//                                     child: Text(
//                                       Utils.getText(context, StringRes.login).toUpperCase(),
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                         color: ColorRes.white,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                   ),
//                                   onTap: () {
//                                     Utils.isInternetConnectedWithAlert(context).then((isConnected) async {
//                                       if (isConnected) validateForm();
//                                     });
//                                   }),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Align(
//                               alignment: Alignment.topRight,
//                               child: InkResponse(
//                                 child: Text(
//                                   Utils.getText(context, StringRes.forgotPassword).toUpperCase(),
//                                   style: TextStyle(color: ColorRes.fontDarkGrey, fontSize: 17),
//                                 ),
//                                 onTap: () {
//                                   Utils.playClickSound();
//                                   Navigator.push(context, FadeRouteForgotPassword());
//                                 },
//                               ),
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Align(
//                               alignment: Alignment.topRight,
//                               child: InkResponse(
//                                 child: Text(
//                                   Utils.getText(context, StringRes.requestDemoAccount),
//                                   style: TextStyle(color: ColorRes.fontDarkGrey, fontSize: 17),
//                                 ),
//                                 onTap: () {
//                                   _launchEmail("support@knowledge-empire.com");
//                                 },
//                               ),
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//
//                           ],
//                         ))),
              ],
            ),
          ),
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

  selectLanguagesAlert(BuildContext context) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: ColorRes.blackTransparentColor,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Stack(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(40),
                      width: (Const.envType == Environment.DEV || Const.envType == Environment.PROD)
                          ? Utils.getDeviceWidth(context) / 3.0
                          : Utils.getDeviceWidth(context) / 1.5,
                      height: (Const.envType == Environment.DEV || Const.envType == Environment.PROD)
                          ? Utils.getDeviceHeight(context) / 1.9
                          : Utils.getDeviceHeight(context) / 4.5,
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
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                color: ColorRes.blue,
                              ),
                              alignment: Alignment.topCenter,
                              child: Center(
                                child: Text(
                                  Utils.getText(context, StringRes.selectLanguage),
                                  style: TextStyle(color: ColorRes.white, fontSize: 17),
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
                            image: AssetImage(Utils.getAssetsImg('close_dialog')),
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
  }

  languageSelectCell(String language, int index) {
    return InkResponse(
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        padding: EdgeInsets.only(top: 5, bottom: 5, left: 0, right: 0),
        decoration: BoxDecoration(color: ColorRes.rankingProValueBg, borderRadius: BorderRadius.all(Radius.circular(8))),
        width: Utils.getDeviceWidth(context),
        child: Text(
          Utils.getText(context, language),
          textAlign: TextAlign.center,
        ),
      ),
      onTap: () async {
        if (index == 0) {
          Injector.language = Const.english;
        } else if (index == 1) {
          Injector.language = Const.german;
        } else if (index == 2) {
          Injector.language = Const.chinese;
        } else {
          Injector.language = null;
        }

        localeBloc.setLocale(Utils.getIndexLocale(Injector.language));

        Navigator.pop(context);
      },
    );
  }

  validateForm() async {
    Utils.playClickSound();

    if (codeController.text.trim().isEmpty) {
      Utils.showToast(Utils.getText(context, StringRes.enterCompanyCode));
      return;
    }

    if (emailController.text.isEmpty) {
      Utils.showToast(Utils.getText(context, StringRes.emailEmpty));
      return;
    }

    if (passwordController.text.isEmpty) {
      Utils.showToast(Utils.getText(context, StringRes.passWordEmpty));
      return;
    }

    // _scrollController.animateTo(
    //   0.0,
    //   curve: Curves.easeOut,
    //   duration: const Duration(milliseconds: 300),
    // );

    CommonView.showCircularProgress(true, context);

    Injector.prefs.remove(PrefKeys.mainBaseUrl);
    await WebApi().callAPI(WebApi.rqVerifyCompanyCode, {'companyCode': codeController.text.trim()}).then((data) async {
      CommonView.showCircularProgress(false, context);
      print("riddhi====");
      if (data != null && data['baseUrl'] != null) {
        Injector.companyCode = codeController.text.trim();
        await Injector.prefs.setString(PrefKeys.mainBaseUrl, data['baseUrl']);
        // Navigator.pop(context);

        String encEmail = await EncryptionManager().stringEncryption(emailController.text.trim());
        String encPass = Utils.generateMd5(passwordController.text.trim());

        LoginRequest loginRequest = LoginRequest(
            email: encEmail,
            password: encPass,
            secret: Utils.getSecret(encEmail, encPass),
            language: (Injector.language == StringRes.strDefault ? null : Injector.language),
            companyCode: Injector.companyCode);

        Utils.hideKeyboard(context);

        CommonView.showCircularProgress(true, context);

        print(loginRequest.toJson());
        WebApi().callAPI(WebApi.rqLogin, loginRequest.toJson()).then((data) async {
          CommonView.showCircularProgress(false, context);

          if (data != null) {
            UserData userData = UserData.fromJson(data);
            await userData.decryptRequiredData();
            localeBloc.setLocale(Utils.getIndexLocale(userData.language));
            Injector.setUserData(userData, false);
            Injector.updateInstance();

            //Store email and companycode in shared preference
            Injector.prefs.setString(PrefKeys.emailId, encEmail);
            Injector.prefs.setString(PrefKeys.companyCode, Injector.companyCode);

            if (userData.isSeenPrivacyPolicy != 1) {
              apiCallPrivacyPolicy(userData.userId, Const.typeGetPrivacyPolicy.toString(), userData.activeCompany, (privacyPolicyResponse) {
                if (privacyPolicyResponse != null) {
                  if (privacyPolicyResponse.isSeenPrivacyPolicy != 1 &&
                      privacyPolicyResponse.privacyPolicyTitle != "" &&
                      privacyPolicyResponse.privacyPolicyContent != "" &&
                      privacyPolicyResponse.privacyPolicyAcceptText != "") {
                    Utils.showPrivacyPolicyDialog(_scaffoldKey, false, userData.activeCompany, privacyPolicyResponse.privacyPolicyTitle,
                        privacyPolicyResponse.privacyPolicyContent, privacyPolicyResponse.privacyPolicyAcceptText, completion: (status) {
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
    }).catchError((e) {
      if (mounted)
        setState(() {
          isLoading = false;
        });
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

  showCompanyCodeView() {
    return Row(
      children: <Widget>[
        Image(
          image: AssetImage(Utils.getAssetsImg("ic_company_code")),
          width: 45,
          height: 45,
        ),
        Expanded(
            child: Container(
                height: 45,
                decoration: BoxDecoration(
                    color: ColorRes.white, border: Border.all(width: 1, color: ColorRes.white), borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(left: 8),
                child: Center(
                  child: TextField(
                    controller: codeController,
                    autocorrect: Platform.isAndroid ? true : false,
                    keyboardType: TextInputType.emailAddress,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    style: TextStyle(fontSize: 17, color: ColorRes.titleBlueProf),
                    // onSubmitted: (value) {
                    //   _scrollController.animateTo(
                    //     0.0,
                    //     curve: Curves.easeOut,
                    //     duration: const Duration(milliseconds: 300),
                    //   );
                    // },
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
                        hintText: Utils.getText(context, StringRes.companyCode).toUpperCase(),
                        hintStyle: TextStyle(color: ColorRes.greyText),
                        border: InputBorder.none),
                  ),
                )))
      ],
    );
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
                    // onSubmitted: (value) {
                    //   _scrollController.animateTo(
                    //     0.0,
                    //     curve: Curves.easeOut,
                    //     duration: const Duration(milliseconds: 300),
                    //   );
                    // },
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
                    // onSubmitted: (value) {
                    //   _scrollController.animateTo(
                    //     0.0,
                    //     curve: Curves.easeOut,
                    //     duration: const Duration(milliseconds: 300),
                    //   );
                    // },
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

  showLoginButton() {
    return Center(
      child: InkResponse(
          child: Container(
            height: 40,
            width: 180,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              image: DecorationImage(image: ExactAssetImage(Utils.getAssetsImg('btn_login')), alignment: Alignment.topCenter, fit: BoxFit.fill),
            ),
            child: Text(
              Utils.getText(context, StringRes.login).toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorRes.white,
                fontSize: 18,
              ),
            ),
          ),
          onTap: () {
            Utils.isInternetConnectedWithAlert(context).then((isConnected) async {
              if (isConnected) validateForm();
            });
          }),
    );
  }

  showForgotPasswordView() {
    return InkResponse(
      child: Text(
        Utils.getText(context, StringRes.forgotPassword),
        style: TextStyle(color: ColorRes.fontDarkGrey, fontSize: 17, decoration: TextDecoration.underline),
      ),
      onTap: () {
        Utils.playClickSound();
        Navigator.push(context, FadeRouteForgotPassword());
      },
    );
  }

  showChangeLanguageView() {
    return Align(
      alignment: Alignment.centerLeft,
      child: InkResponse(
        onTap: () {
          Utils.playClickSound();
          selectLanguagesAlert(context);
        },
        child: Text(
          Utils.getText(context, StringRes.changeLanguage),
          // + ' - '+ Injector.language,
          style: TextStyle(color: ColorRes.fontDarkGrey, fontSize: 17, decoration: TextDecoration.underline),
        ),
      ),
    );
  }

  showRequestDemoAccountView() {
    return InkResponse(
      onTap: () {
        _launchEmail("support@knowledge-empire.com");
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          Utils.getText(context, StringRes.requestDemoAccount),
          style: TextStyle(color: ColorRes.fontDarkGrey, fontSize: 17, decoration: TextDecoration.underline),
        ),
      ),
    );
  }

  showVersion() {
    return Expanded(
        flex: 1,
        child: Container(
          margin: EdgeInsets.only(bottom: 8, right: 5),
          child: Text(
            VersionManager.getVersion(context),
            style: TextStyle(color: ColorRes.lightGrey.withOpacity(0.5), fontSize: 16),
            textAlign: TextAlign.right,
          ),
        ));
  }

  void verifyCompany() async {
    isCompanyVerified = Injector.prefs.getString(PrefKeys.mainBaseUrl) != null && Injector.prefs.getString(PrefKeys.mainBaseUrl).isNotEmpty;

    // if (!isCompanyVerified) {
    //   await Utils.showVerifyCompanyDialog(_scaffoldKey).then((value) => verifyCompany());
    // } else
    //   initStateMethods();
  }
}
