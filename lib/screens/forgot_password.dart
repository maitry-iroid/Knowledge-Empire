import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/models/forgot_password.dart';

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
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        key: _scaffoldKey,
      backgroundColor: ColorRes.fontDarkGrey,
      body: Stack(
        children: <Widget>[
          Container(
            height: 400,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage(Utils.getAssetsImg('bg_login')),
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  height: Utils.getDeviceHeight(context) / 2.0,
                  width: Utils.getDeviceWidth(context) / 3.5,
                  margin: EdgeInsets.only(left: 40),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(Utils.getAssetsImg("logo_login")),
                  )),
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
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: IconButton(
              icon: new Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          )
        ],
      ),
    );
  }

  showLoginForm() {
    return Column(
      children: <Widget>[
        Container(
          height: 25,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorRes.borderColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9), topRight: Radius.circular(9)),
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
                  style: TextStyle(color: ColorRes.white, fontSize: 15),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText:
                          Utils.getText(context, StringRes.enterRegisteredEmail)
                              .toUpperCase(),
                      hintStyle: TextStyle(color: ColorRes.hintColor)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkResponse(
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: Utils.getDeviceWidth(context) / 8),
                  alignment: Alignment.center,
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: ExactAssetImage(Utils.getAssetsImg('btn_login')),
                        alignment: Alignment.topCenter,
                        fit: BoxFit.fill),
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

  validateForm() {
//    if(currentVol != 0) {
    Utils.playClickSound();
//    }
    if (emailController.text.isEmpty) {
      Utils.showToast("Email can't be empty.");
      return;
    }

    Utils.hideKeyboard(context);
    setState(() {
      isLoading = true;
    });

    ForgotPasswordRequest rq = ForgotPasswordRequest();
    rq.email = emailController.text.trim();

    WebApi().callAPI(WebApi.rqForgotPassword, rq.toJson()).then((data) {
      setState(() {
        isLoading = false;
      });

      if (data != null) {
        Utils.showToast("Mail sent Successfully.");
        //alert pop
        Navigator.pop(context);
      }
    }).catchError((e) {
      print("forgotPassword_" + e.toString());
      setState(() {
        isLoading = false;
      });
      Utils.showToast(e.toString());
    });
  }
}
