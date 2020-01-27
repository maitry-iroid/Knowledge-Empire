import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/screens/home.dart';
import 'package:ke_employee/screens/intro_screen.dart';
import 'package:ke_employee/models/change_password.dart';

class ChangePasswordDialog extends StatefulWidget {
  ChangePasswordDialog({
    Key key,
    this.isFromProfile,
    this.isOldPasswordRequired,
  }) : super(key: key);

  final bool isFromProfile;
  final bool isOldPasswordRequired;

  @override
  ChangePasswordDialogState createState() => new ChangePasswordDialogState();
}

class ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final pass1Controller = TextEditingController();
  final pass2Controller = TextEditingController();
  final pass3Controller = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent.withOpacity(0.8),
      body: showSetupPin(context),
    );
  }

  showSetupPin(BuildContext context) {
    return Center(
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Container(
//            height: Utils.getDeviceHeight(context),
            width: Utils.getDeviceWidth(context) / 1.5,
            alignment: Alignment.center,
            child: Container(
                height: Utils.getDeviceHeight(context) / 2.1,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                alignment: Alignment.center,
                child: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          top: 0,
                          left: 10,
                          right: Utils.getDeviceWidth(context) / 5.5,
                          bottom: 0),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              Utils.getAssetsImg('bg_change_pass'),
                            ),
                            fit: BoxFit.fill),
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          widget.isFromProfile
                              ? Container(
                                  height: 35,
                                  margin: EdgeInsets.symmetric(vertical: 3),
                                  decoration: BoxDecoration(
                                      color: ColorRes.bgTextBox,
                                      border: Border.all(
                                          width: 1, color: ColorRes.white),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: TextField(
                                    controller: pass1Controller,
//                                  textAlignVertical: TextAlignVertical.center,
                                    textAlign: TextAlign.left,
                                    maxLines: 1,
                                    obscureText: true,
                                    style: TextStyle(
                                        fontSize: 14, color: ColorRes.white),
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 10),
                                        hintText: Utils.getText(
                                            context, StringRes.currentPassword),
                                        hintStyle: TextStyle(
                                            color: ColorRes.hintColor),
                                        border: InputBorder.none),
                                  ))
                              : Container(),
                          Container(
                              height: 35,
                              margin: EdgeInsets.symmetric(vertical: 3),
                              decoration: BoxDecoration(
                                  color: ColorRes.bgTextBox,
                                  border: Border.all(
                                      width: 1, color: ColorRes.white),
                                  borderRadius: BorderRadius.circular(20)),
                              child: TextField(
                                controller: pass2Controller,
//                                  textAlignVertical: TextAlignVertical.center,
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                obscureText: true,
                                style: TextStyle(
                                    fontSize: 14, color: ColorRes.white),
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 10),
                                    hintText: Utils.getText(
                                        context, StringRes.newPassword),
                                    hintStyle:
                                        TextStyle(color: ColorRes.hintColor),
                                    border: InputBorder.none),
                              )),
                          Container(
                              height: 35,
                              margin: EdgeInsets.symmetric(vertical: 3),
                              decoration: BoxDecoration(
                                  color: ColorRes.bgTextBox,
                                  border: Border.all(
                                      width: 1, color: ColorRes.white),
                                  borderRadius: BorderRadius.circular(20)),
                              child: TextField(
                                obscureText: true,
                                controller: pass3Controller,
                                textAlignVertical: TextAlignVertical.center,
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 14, color: ColorRes.white),
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 10),
                                    hintText: Utils.getText(
                                        context, StringRes.reEnterPassword),
                                    hintStyle:
                                        TextStyle(color: ColorRes.hintColor),
                                    border: InputBorder.none),
                              )),
                        ],
                      ),
                    ),
//                        Positioned(
//                          right: 50,
//                          top: 10,
//                          child: GestureDetector(
//                            child: Image(
//                              image: AssetImage(
//                                  Utils.getAssetsImg("close_dialog")),
//                              width: 20,
//                            ),
//                            onTap: () {
//                              Navigator.pop(context);
//                            },
//                          ),
//                        ),
                    Positioned(
                      top: Utils.getDeviceHeight(context) / 11,
                      right: 0,
                      child: Column(
                        children: <Widget>[
                          InkResponse(
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              Utils.getAssetsImg("bg_save")),
                                          fit: BoxFit.fill)),
                                  child: Text(
                                    Utils.getText(context, StringRes.save),
                                    style: TextStyle(
                                        fontSize: 17, color: ColorRes.white),
                                  )),
                              onTap: () {
                                Utils.playClickSound();
                                Utils.hideKeyboard(context);

                                validateData();
                              }),
                          SizedBox(
                            height: 10,
                          ),
                          InkResponse(
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              Utils.getAssetsImg("bg_save")),
                                          fit: BoxFit.fill)),
                                  child: Text(
                                    Utils.getText(context, StringRes.cancel),
                                    style: TextStyle(
                                        fontSize: 17, color: ColorRes.white),
                                  )),
                              onTap: () {
                                Utils.playClickSound();
                                Utils.hideKeyboard(context);

                                Navigator.pop(context);
                              })
                        ],
                      ),
                    ),
                  ],
                )),
          ),
          showCircularProgress()
        ],
      ),
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

  void validateData() async {
    if (widget.isFromProfile) {
      if (pass1Controller.text.trim().isEmpty) {
        Utils.showToast("Please enter old Password.");
        return;
      }
    }
    if (pass2Controller.text.trim().isEmpty) {
      Utils.showToast("Please enter new Password.");
      return;
    }
    if (pass3Controller.text.trim().isEmpty) {
      Utils.showToast("Please re-eneter new Password.");
      return;
    }

    if (pass2Controller.text.trim() != pass3Controller.text.trim()) {
      Utils.showToast("Please enter same new password.");
      return;
    }

    setState(() {
      isLoading = true;
    });

    ChangePasswordRequest rq = ChangePasswordRequest();
    rq.userId = Injector.userData.userId;
    rq.oldPassword = widget.isFromProfile?Utils.generateMd5(pass1Controller.text.trim()):null;
    rq.password = Utils.generateMd5(pass2Controller.text.trim());
    rq.isOldPasswordRequired = widget.isOldPasswordRequired;

    WebApi().changePassword(rq).then((data) {
      setState(() {
        isLoading = false;
      });

      if (data != null) {
        if (data.flag == "true") {
          Utils.showToast("password changed Successfully.");

          if (widget.isFromProfile) {
            Navigator.pop(context);
          } else {

            Navigator.pushAndRemoveUntil(
                context, FadeRouteIntro(), ModalRoute.withName("/login"));
          }
        } else {
          Utils.showToast(data.msg);
        }
      } else {
        Utils.showToast("Something went wrong.");
      }
    }).catchError((e) {
      print("changePassword_"+e.toString());
      setState(() {
        isLoading = false;
      });
      Utils.showToast(e.toString());
    });
  }

  void navigateToDashboard() {
    Navigator.push(context, FadeRouteHome());

  }
}
