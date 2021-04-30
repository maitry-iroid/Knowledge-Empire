import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ke_employee/baseController/base_button.dart';
import 'package:ke_employee/baseController/base_textfield.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/login.dart';
import 'package:ke_employee/routes/route_names.dart';
import 'package:ke_employee/screens/forgot_password.dart';

class LoginPagePortrait extends StatefulWidget {
  @override
  _LoginPagePortraitState createState() => _LoginPagePortraitState();
}

class _LoginPagePortraitState extends State<LoginPagePortrait> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.emailController.text = "v4455@mailinator.com";
    this.passwordController.text = "11";

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorRes.white,
      body: SafeArea(
          child: this.showMainView()
      ),
    );
  }

  Widget showMainView(){
    return Container(
      padding: EdgeInsets.all(10),
      color: ColorRes.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 2,
              child: Image.asset(Utils.getAssetsImg('logo_login'), width: Utils.getDeviceWidth(context))),
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
                      textInputType: TextInputType.emailAddress,
                      enableInteractiveSelection: true,
                      fillColor: ColorRes.white,
                      validator: (value){
                        return null;
                      }),
                  SizedBox(height: Utils.getDeviceHeight(context) / 60),
                  BaseTextField(
                      hintText: Utils.getText(context, StringRes.password),
                      controller: passwordController,
                      isSecure: true,
                      enableInteractiveSelection: true,
                      fillColor: ColorRes.white,
                      validator: (value){
                        return null;
                      }),
//                  SizedBox(height: 15),
                  SizedBox(height: Utils.getDeviceHeight(context) / 60),
                  GestureDetector(
                    onTap: (){
                      Utils.playClickSound();
                      Navigator.push(context, FadeRouteForgotPassword());
                    },
                    child:Text(Utils.getText(context, StringRes.forgotPassword), style: TextStyle(color: ColorRes.blue, fontWeight: FontWeight.bold)),
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
                      buttonText: Utils.getText(context, StringRes.login),
                      textColor: Colors.white,
                      borderColor: Colors.white,
                      onPressed: (){
                        Utils.isInternetConnectedWithAlert(context)
                            .then((isConnected) async {
                          if (isConnected) validateForm();
                        });
//                        Navigator.of(context).pushNamed(bottomNavigationRoute);
                      }),
                  SizedBox(height: 10),
                  Center(child: Text(Utils.getText(context, StringRes.requestDemoAccount), style: TextStyle(color: ColorRes.blue, fontWeight: FontWeight.bold)),)
                ],
              )),
        ],
      ),
    );
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


    LoginRequest loginRequest = LoginRequest();
    loginRequest.email = emailController.text.trim();
    loginRequest.password = Utils.generateMd5(passwordController.text.trim());
    loginRequest.secret = Utils.getSecret(loginRequest.email, loginRequest.password);
//    loginRequest.language =
//    tempLanguage == StringRes.strDefault ? null : tempLanguage;

    Utils.hideKeyboard(context);

    CommonView.showCircularProgress(true, context);

    WebApi().callAPI(WebApi.rqLogin, loginRequest.toJson()).then((data) async {
      CommonView.showCircularProgress(false, context);

      if (data != null) {
        UserData userData = UserData.fromJson(data);

        await Injector.setUserData(userData, false);

        await Injector.updateInstance();

//        localeBloc.setLocale(Utils.getIndexLocale(userData.language));

          if (Injector.userData.isPasswordChanged == 0) {
            Utils.showChangePasswordDialog(_scaffoldKey, false, false);
          } else {
            Navigator.of(context).pushNamed(bottomNavigationRoute);
          }
      }
    }).catchError((e) {
      CommonView.showCircularProgress(false, context);
    });
  }

}