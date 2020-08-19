import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ke_employee/baseController/base_button.dart';
import 'package:ke_employee/baseController/base_textfield.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';

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
                      validator: (value){
                        return null;
                      }),
                  SizedBox(height: Utils.getDeviceHeight(context) / 60),
                  BaseTextField(
                      hintText: Utils.getText(context, StringRes.password),
                      controller: passwordController,
                      isSecure: true,
                      validator: (value){
                        return null;
                      }),
//                  SizedBox(height: 15),
                  SizedBox(height: Utils.getDeviceHeight(context) / 60),
                  Text(Utils.getText(context, StringRes.forgotPassword), style: TextStyle(color: ColorRes.blue, fontWeight: FontWeight.bold))
                ],
              )),
          Expanded(child: Container()),
          Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BaseRaisedButton(buttonColor: ColorRes.blue, buttonText: Utils.getText(context, StringRes.login), onPressed: (){}),
                  SizedBox(height: 10),
                  Center(child: Text(Utils.getText(context, StringRes.requestDemoAccount), style: TextStyle(color: ColorRes.blue, fontWeight: FontWeight.bold)),)
                ],
              )),
        ],
      ),
    );
  }

}