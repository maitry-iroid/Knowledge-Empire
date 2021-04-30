import 'package:flutter/material.dart';
import 'package:ke_employee/baseController/base_textfield.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/manager/theme_manager.dart';
import 'package:ke_employee/models/change_password.dart';
import 'package:ke_employee/models/parameter.dart';

class ChangePasswordPortrait extends StatefulWidget {
  final ChangePwdParam changePwdParam;
  ChangePasswordPortrait(this.changePwdParam);

  @override
  _ChangePasswordPortraitState createState() => _ChangePasswordPortraitState();
}

class _ChangePasswordPortraitState extends State<ChangePasswordPortrait> {

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final newPasswordAgainController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(44.0),
          child: AppBar(
            title: Text("Change password", style: TextStyle(color: ThemeManager().getTextColor(), fontSize: 17)),
            leading: IconButton(icon: Icon(Icons.close, size: 24, color: ThemeManager().getTextColor()), onPressed: (){
              Navigator.of(context).pop();
            }),
            actions: [
              IconButton(
                  icon: Icon(Icons.check, size: 24, color: ThemeManager().getTextColor()),
                  onPressed: (){
                    Utils.playClickSound();
                    Utils.hideKeyboard(context);
                    validateData();
                  }),
            ],
          )),
      body: Scaffold(
        backgroundColor: ThemeManager().getBgGradientLight(),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFieldWithBorder(
                  hintText: "Current password",
                  controller: currentPasswordController,
                  isSecure: true,
                  fillColor: ThemeManager().getStaticGradientColor(),
                  textInputType: TextInputType.text,
                  validator: (value){
                    return null;
                  }),
              SizedBox(height: 10),
              TextFieldWithBorder(
                  hintText: "New password",
                  controller: newPasswordController,
                  isSecure: true,
                  fillColor: ThemeManager().getStaticGradientColor(),
                  textInputType: TextInputType.text,
                  validator: (value){
                    return null;
                  }),
              SizedBox(height: 10),
              TextFieldWithBorder(
                  hintText: "New password again",
                  controller: newPasswordAgainController,
                  isSecure: true,
                  fillColor: ThemeManager().getStaticGradientColor(),
                  textInputType: TextInputType.text,
                  validator: (value){
                    return null;
                  }),
              SizedBox(height: 10),
              Text(Utils.getText(context, StringRes.forgotPassword), style: TextStyle(color: ThemeManager().getDarkColor(), fontWeight: FontWeight.normal))
            ],
          ),
        ),
      ),
    );
  }

  void validateData() async {
    if (widget.changePwdParam.isFromProfile) {
      if (currentPasswordController.text.trim().isEmpty) {
        Utils.showToast(Utils.getText(context, StringRes.enterOldPassword));
        return;
      }
    }
    if (newPasswordController.text.trim().isEmpty) {
      Utils.showToast(Utils.getText(context, StringRes.enterNewPassword));
      return;
    }
    if (newPasswordAgainController.text.trim().isEmpty) {
      Utils.showToast(Utils.getText(context, StringRes.enterRePassword));
      return;
    }

    if (newPasswordController.text.trim() != newPasswordAgainController.text.trim()) {
      Utils.showToast(Utils.getText(context, StringRes.enterSameNewPassword));
      return;
    }

    if (mounted)
      setState(() {
        isLoading = true;
      });

    ChangePasswordRequest rq = ChangePasswordRequest();
    rq.userId = Injector.userData.userId;
    rq.oldPassword = widget.changePwdParam.isFromProfile
        ? Utils.generateMd5(currentPasswordController.text.trim())
        : null;
    rq.password = Utils.generateMd5(newPasswordController.text.trim());
    rq.isOldPasswordRequired = widget.changePwdParam.isOldPasswordRequired;

    WebApi().callAPI(WebApi.rqChangePassword, rq.toJson()).then((data) {
      if (mounted)
        setState(() {
          isLoading = false;
        });

      if (data != null) {
        Utils.showToast(Utils.getText(context, StringRes.passwordChange));
        Injector.isPasswordChange = true;

        if (widget.changePwdParam.isFromProfile) {
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
//          Utils.showNickNameDialog(_scaffoldKey, false);
//          Navigator.pushAndRemoveUntil(
//              context, FadeRouteHome(), ModalRoute.withName("/login"));
        }
      }
    }).catchError((e) {
      if (mounted)
        setState(() {
          isLoading = false;
        });
    });
  }
}
