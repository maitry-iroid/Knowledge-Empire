import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/home.dart';
import 'package:ke_employee/models/change_password_request.dart';

class ChangePasswordDialog extends StatefulWidget {
  ChangePasswordDialog({
    Key key,
    this.isFromProfile,
  }) : super(key: key);

  final bool isFromProfile;

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
      backgroundColor: Colors.transparent,
      body: showSetupPin(context),
    );
  }

  showSetupPin(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            height: Utils.getDeviceHeight(context),
            width: Utils.getDeviceWidth(context) / 1.5,
            alignment: Alignment.center,
            child: Container(
                height: Utils.getDeviceHeight(context) / 2.5,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                alignment: Alignment.center,
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          top: 0,
                          left: 10,
                          right: Utils.getDeviceWidth(context) / 5.5,
                          bottom: 0),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              Utils.getAssetsImg('bg_change_pass'),
                            ),
                            fit: BoxFit.fill),
                      ),
                      child: ListView(
                        children: <Widget>[
                          Container(
                            height: 35,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: ColorRes.bgTextBox,
                                border: Border.all(
                                  color: ColorRes.white,
                                  width: 1,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: TextField(
                              controller: pass1Controller,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              style: TextStyle(
                                  color: ColorRes.white, fontSize: 15),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: Utils.getText(context, StringResBusiness.currentPassword),
                                  hintStyle: TextStyle(
                                      color: ColorRes.hintColor, fontSize: 15)),
                            ),
                          ),
                          Container(
                            height: 35,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: ColorRes.bgTextBox,
                                border: Border.all(
                                  color: ColorRes.white,
                                  width: 1,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: TextField(
                              controller: pass2Controller,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              style: TextStyle(
                                  color: ColorRes.white, fontSize: 15),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: Utils.getText(context, StringResBusiness.newPassword),
                                  hintStyle: TextStyle(
                                      color: ColorRes.hintColor, fontSize: 15)),
                            ),
                          ),
                          Container(
                            height: 35,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 15,right: 15),
                            decoration: BoxDecoration(
                                color: ColorRes.bgTextBox,
                                border: Border.all(
                                  color: ColorRes.white,
                                  width: 1,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: TextField(
                              controller: pass3Controller,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.left,
                              obscureText: true,
                              style: TextStyle(
                                  color: ColorRes.white, fontSize: 15),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: Utils.getText(context, StringResBusiness.reEnterPassword),
                                  hintStyle: TextStyle(
                                      color: ColorRes.hintColor, fontSize: 15)),
                            ),
                          ),
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
                                    Utils.getText(context, StringResBusiness.save),
                                    style: TextStyle(
                                        fontSize: 17, color: ColorRes.white),
                                  )),
                              onTap: () {
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
                                    Utils.getText(context, StringResBusiness.cancel),
                                    style: TextStyle(
                                        fontSize: 17, color: ColorRes.white),
                                  )),
                              onTap: () {
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
    if (pass1Controller.text.trim().isEmpty) {
      Utils.showToast("Please enter old Password.");
      return;
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
    rq.email = Injector.prefs.getString(PrefKeys.email);
    rq.oldPassword = Utils.generateMd5(pass1Controller.text.trim());
    rq.password = Utils.generateMd5(pass2Controller.text.trim());

    WebApi().changePassword(rq.toJson()).then((data) {
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
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                ModalRoute.withName("/login"));
          }
        } else {
          Utils.showToast(data.msg);
        }
      } else {
        Utils.showToast("Something went wrong.");
      }
    });
  }

  void navigateToDasboard() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }
}
