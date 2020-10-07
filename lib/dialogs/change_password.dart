import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/BLoC/locale_bloc.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/privay_policy.dart';
import 'package:ke_employee/screens/home.dart';
import 'package:ke_employee/models/change_password.dart';

class ChangePasswordDialog extends StatefulWidget {
  ChangePasswordDialog({
    Key key,
    this.scaffoldKey,
    this.isFromProfile,
    this.isOldPasswordRequired,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool isFromProfile;
  final bool isOldPasswordRequired;

  @override
  ChangePasswordDialogState createState() => new ChangePasswordDialogState();
}

class ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final pass1Controller = TextEditingController();
  final pass2Controller = TextEditingController();
  final pass3Controller = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    localeBloc.setLocale(Utils.getIndexLocale(Injector.userData.language));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      body: showSetupPin(context),
    );
  }

  showSetupPin(BuildContext context) {
    return Center(
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Container(
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
                          SizedBox(height: 10),
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
                                if(widget.isFromProfile == false)
                                  Utils.showNickNameDialog(_scaffoldKey, false);
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
        Utils.showToast(Utils.getText(context, StringRes.enterOldPassword));
        return;
      }
    }
    if (pass2Controller.text.trim().isEmpty) {
      Utils.showToast(Utils.getText(context, StringRes.enterNewPassword));
      return;
    }
    if (pass3Controller.text.trim().isEmpty) {
      Utils.showToast(Utils.getText(context, StringRes.enterRePassword));
      return;
    }

    if (pass2Controller.text.trim() != pass3Controller.text.trim()) {
      Utils.showToast(Utils.getText(context, StringRes.enterSameNewPassword));
      return;
    }

    if (mounted)
      setState(() {
        isLoading = true;
      });

    ChangePasswordRequest rq = ChangePasswordRequest();
    rq.userId = Injector.userData.userId;
    rq.oldPassword = widget.isFromProfile
        ? Utils.generateMd5(pass1Controller.text.trim())
        : null;
    rq.password = Utils.generateMd5(pass2Controller.text.trim());
    rq.isOldPasswordRequired = widget.isOldPasswordRequired;

    WebApi().callAPI(WebApi.rqChangePassword, rq.toJson()).then((data) {

      if (data != null) {
        Utils.showToast(Utils.getText(context, StringRes.passwordChange));
        Injector.isPasswordChange = true;

        if (widget.isFromProfile) {
          if (mounted)
            setState(() {
              isLoading = false;
            });
          Navigator.pop(context);
        } else {
          Navigator.of(context).pop();
          Utils.showNickNameDialog(_scaffoldKey, false);
        }
      } else {
        if (mounted)
          setState(() {
            isLoading = false;
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
