import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/dashboard_new.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
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
            width: Utils.getDeviceWidth(context) / 2,
            alignment: Alignment.center,
            child: Container(
              height: Utils.getDeviceHeight(context) / 1.5,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              top: 20, left: 10, right: 10, bottom: 50),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  Utils.getAssetsImg('bg_change_pass'),
                                ),
                                fit: BoxFit.fill),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: ListView(
                              children: <Widget>[
                                Container(
                                  height: 40,
                                  margin: EdgeInsets.only(left: 8, top: 20),
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: ColorRes.bgTextBox,
                                      border: Border.all(
                                        color: ColorRes.white,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  child: TextField(
                                    controller: pass1Controller,
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                    style: TextStyle(
                                        color: ColorRes.white, fontSize: 15),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Current Password',
                                        hintStyle: TextStyle(
                                            color: ColorRes.hintColor,
                                            fontSize: 15)),
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  margin: EdgeInsets.only(left: 8, top: 10),
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: ColorRes.bgTextBox,
                                      border: Border.all(
                                        color: ColorRes.white,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  child: TextField(
                                    controller: pass2Controller,
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                    style: TextStyle(
                                        color: ColorRes.white, fontSize: 15),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'New Password',
                                        hintStyle: TextStyle(
                                            color: ColorRes.hintColor,
                                            fontSize: 15)),
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  margin: EdgeInsets.only(left: 8, top: 10),
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: ColorRes.bgTextBox,
                                      border: Border.all(
                                        color: ColorRes.white,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  child: TextField(
                                    controller: pass3Controller,
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                    style: TextStyle(
                                        color: ColorRes.white, fontSize: 15),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Re-enter new Password',
                                        hintStyle: TextStyle(
                                            color: ColorRes.hintColor,
                                            fontSize: 15)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Image(
                              image: AssetImage(
                                  Utils.getAssetsImg("close_dialog")),
                              width: 20,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: InkResponse(
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
                                    "Save",
                                    style: TextStyle(
                                        fontSize: 17, color: ColorRes.white),
                                  )),
                              onTap: () {
                                Utils.hideKeyboard(context);

                                validateData();
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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

    if (pass2Controller.text.trim().isEmpty !=
        pass3Controller.text.trim().isEmpty) {
      Utils.showToast("Please enter same new password.");
      return;
    }

    setState(() {
      isLoading = true;
    });

    ChangePasswordRequest rq = ChangePasswordRequest();
    rq.email = Injector.prefs.getString(PrefKeys.email);
    rq.password = pass2Controller.text.trim();

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
                MaterialPageRoute(builder: (context) => DashboardNewPage()),
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
        context, MaterialPageRoute(builder: (context) => DashboardNewPage()));
  }
}
