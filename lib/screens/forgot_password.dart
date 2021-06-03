import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knowledge_empire/baseController/base_button.dart';
import 'package:knowledge_empire/baseController/base_textfield.dart';
import 'package:knowledge_empire/helper/Utils.dart';
import 'package:knowledge_empire/helper/constant.dart';
import 'package:knowledge_empire/helper/prefkeys.dart';
import 'package:knowledge_empire/helper/res.dart';
import 'package:knowledge_empire/helper/string_res.dart';
import 'package:knowledge_empire/helper/web_api.dart';
import 'package:knowledge_empire/injection/dependency_injection.dart';
import 'package:knowledge_empire/manager/encryption_manager.dart';
import 'package:knowledge_empire/manager/theme_manager.dart';
import 'package:knowledge_empire/models/forgot_password.dart';

class FadeRouteForgotPassword extends PageRouteBuilder {
  final Widget page;

  FadeRouteForgotPassword({this.page})
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
            child: ForgotPasswordPage(),
          ),
        );
}

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({Key key}) : super(key: key);

  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();
  final codeController = TextEditingController();
  bool isLoading = false;
  ScrollController _scrollController = new ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Const.isLandscape) {
      return Scaffold(
//        key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: ColorRes.fontDarkGrey,
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage(Utils.getAssetsImg('bg_login_profesonal')),
                fit: BoxFit.cover,
//            alignment: Alignment.topCenter,
              ),
            ),
            child: Stack(
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
                          children: <Widget>[
                            Container(height: Utils.getDeviceHeight(context) / 5),
                            Container(
                              width: Utils.getDeviceWidth(context) / 2.3,
                              height: Utils.getDeviceHeight(context) / 1.7,
                              margin: EdgeInsets.only(left: 20, right: 20),
                              decoration: BoxDecoration(
                                color: ColorRes.loginBg,
                                border: Border.all(color: ColorRes.white, width: 1),
                                borderRadius: new BorderRadius.circular(10.0),
                              ),
                              child: showLoginForm(),
                            ),
                            Container(height: Utils.getDeviceHeight(context) / 2.5),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 1,
                  child: SafeArea(
                    child: IconButton(
                      icon: new Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 40,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
                showCircularProgress()
              ],
            ),
          ));
    } else {
      return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(44.0),
            child: AppBar(
              title: Text("Forgot password", style: TextStyle(color: ThemeManager().getTextColor(), fontSize: 18)),
              leading: IconButton(
                  icon: Icon(Icons.close, size: 24, color: ThemeManager().getTextColor()),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              actions: [
                IconButton(
                    icon: Icon(Icons.check, size: 24, color: ThemeManager().getTextColor()),
                    onPressed: () {
                      Utils.playClickSound();
                      Utils.hideKeyboard(context);
                      // validateData();
                    }),
              ],
            )),
        body: Scaffold(
          backgroundColor: ThemeManager().getBgGradientLight(),
          body: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFieldWithBorder(
                    hintText: Utils.getText(context, StringRes.enterRegisteredEmail).toUpperCase(),
                    controller: emailController,
                    isSecure: false,
                    fillColor: ThemeManager().getStaticGradientColor(),
                    textInputType: TextInputType.text,
                    validator: (value) {
                      return null;
                    }),
                SizedBox(height: 10),
                TextFieldWithBorder(
                    hintText: Utils.getText(context, StringRes.companyCode).toUpperCase(),
                    controller: codeController,
                    isSecure: false,
                    fillColor: ThemeManager().getStaticGradientColor(),
                    textInputType: TextInputType.text,
                    validator: (value) {
                      return null;
                    }),
                SizedBox(height: 50),
                BaseRaisedButton(
                    buttonColor: ColorRes.blue,
                    buttonText: Utils.getText(context, StringRes.send).toUpperCase(),
                    onPressed: () {
                      validateForm();
                    }),
              ],
            ),
          ),
        ),
      );
    }
  }

  showLoginForm() {
    return Column(
      children: <Widget>[
        Container(
          height: 25,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorRes.blueMenuSelected,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(9), topRight: Radius.circular(9)),
          ),
          child: Text(
            Utils.getText(context, StringRes.forgotPassword).toUpperCase(),
            style: TextStyle(color: ColorRes.white, fontSize: 17),
          ),
        ),
        Container(
          height: 1,
          color: ColorRes.white,
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: ColorRes.white,
                    border: Border.all(
                      color: ColorRes.white,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  style: TextStyle(color: ColorRes.titleBlueProf, fontSize: 15),
                  onSubmitted: (value) {
                    _scrollController.animateTo(
                      0.0,
                      curve: Curves.easeOut,
                      duration: const Duration(milliseconds: 300),
                    );
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: Utils.getText(context, StringRes.enterRegisteredEmail).toUpperCase(),
                      hintStyle: TextStyle(color: ColorRes.greyText)),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: ColorRes.white,
                    border: Border.all(
                      color: ColorRes.white,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  controller: codeController,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  style: TextStyle(color: ColorRes.titleBlueProf, fontSize: 15),
                  onSubmitted: (value) {
                    _scrollController.animateTo(
                      0.0,
                      curve: Curves.easeOut,
                      duration: const Duration(milliseconds: 300),
                    );
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: Utils.getText(context, StringRes.companyCode).toUpperCase(),
                      hintStyle: TextStyle(color: ColorRes.greyText)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkResponse(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: Utils.getDeviceWidth(context) / 8),
                  alignment: Alignment.center,
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: ExactAssetImage(Utils.getAssetsImg('btn_login')), alignment: Alignment.topCenter, fit: BoxFit.fill),
                  ),
                  child: Text(
                    Utils.getText(context, StringRes.send).toUpperCase(),
                    style: TextStyle(color: ColorRes.white, fontSize: 17),
                  ),
                ),
                onTap: validateForm,
              ),
            ],
          ),
        )
      ],
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

  validateForm() async {
//    if(currentVol != 0) {
    Utils.playClickSound();
//    }
    if (emailController.text.isEmpty) {
      Utils.showToast(Utils.getText(context, StringRes.emailEmpty));
      return;
    }

    Utils.hideKeyboard(context);
    if (mounted)
      setState(() {
        isLoading = true;
      });

    ForgotPasswordRequest rq = ForgotPasswordRequest();
    String encEmail = await EncryptionManager().stringEncryption(emailController.text.trim());
    rq.email = encEmail;

    Injector.prefs.remove(PrefKeys.mainBaseUrl);
    WebApi().callAPI(WebApi.rqVerifyCompanyCode, {'companyCode': codeController.text.trim()}).then((data) {
      if (data != null && data['baseUrl'] != null) {
        Injector.companyCode = codeController.text.trim();
        Injector.prefs.setString(PrefKeys.mainBaseUrl, data['baseUrl']);
        // Navigator.pop(context);
        rq.companyCode = codeController.text.trim();
        WebApi().callAPI(WebApi.rqForgotPassword, rq.toJson()).then((data) {
          if (mounted)
            setState(() {
              isLoading = false;
            });

          if (data != null) {
            Utils.showToast(Utils.getText(context, StringRes.mailSent));
            //alert pop
            Navigator.pop(context);
          } else {
            print("Data ::::::::::::::::: $data");
          }
        }).catchError((e) {
          print("forgotPassword_" + e.toString());
          if (mounted)
            setState(() {
              isLoading = false;
            });
          // Utils.showToast(e.toString());
        });
      }
    }).catchError((e) {
      if (mounted)
        setState(() {
          isLoading = false;
        });
    });
  }
}
