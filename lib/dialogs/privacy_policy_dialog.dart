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
import 'package:ke_employee/models/update_profile.dart';
import 'package:ke_employee/screens/home.dart';
import 'package:ke_employee/models/change_password.dart';
import 'package:ke_employee/screens/profile.dart';

class PrivacyPolicyDialog extends StatefulWidget {
  PrivacyPolicyDialog({
    Key key,
    this.scaffoldKey,
    this.isFromProfile,
    this.companyId,
    this.privacyPolicyTitle,
    this.privacyPolicyContent,
    this.privacyPolicyAcceptText,
    this.completion
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool isFromProfile;
  final String privacyPolicyTitle;
  final String privacyPolicyContent;
  final String privacyPolicyAcceptText;
  final void Function(bool) completion;
  final int companyId;

  @override
  PrivacyPolicyDialogState createState() => new PrivacyPolicyDialogState();
}

class PrivacyPolicyDialogState extends State<PrivacyPolicyDialog> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final nickNameController = TextEditingController();
  bool isLoading = false;

  bool rememberMe = false;

  void _onRememberMeChanged(bool newValue) => setState(() {
    rememberMe = newValue;

    if (rememberMe) {
      // TODO: Here goes your functionality that remembers the user.
    } else {
      // TODO: Forget the user
    }
  });

  @override
  void initState() {
    localeBloc.setLocale(Utils.getIndexLocale(Injector.userData.language));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      body: showSetupPin(context),
    ), onWillPop: (){
      return Future.value(false);
    });
  }

  showSetupPin(BuildContext context) {
    return Center(
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Container(
            width: Utils.getDeviceWidth(context) / 1.2,
            height: Utils.getDeviceHeight(context) / 1.3,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    Utils.getAssetsImg('bg_change_pass'),
                  ),
                  fit: BoxFit.fill),
            ),
            alignment: Alignment.center,
            child: Column(
              children: [
                Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      padding: EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 3),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(widget.privacyPolicyTitle, style: TextStyle(color: ColorRes.black, fontSize: 17, fontWeight: FontWeight.w700)),
                            SizedBox(height: 10),
                            Text(widget.privacyPolicyContent, style: TextStyle(color: ColorRes.black, fontSize: 16)),
                          ],
                        ),
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                  activeColor: ColorRes.headerBlue,
                                  value: rememberMe,
                                  onChanged: _onRememberMeChanged
                              ),
                              Expanded(
                                  child: Text(widget.privacyPolicyAcceptText,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: ColorRes.black, fontSize: 16)))
                            ],
                          )),
                      SizedBox(width: 40),
                      widget.isFromProfile ? InkResponse(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: 100,
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    color: ColorRes.headerBlue,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Colors.white
                                    )
                                ),
                                child: Text(
                                  Utils.getText(context, StringRes.decline),
                                  style: TextStyle(
                                      fontSize: 17, color: ColorRes.white),
                                )),
                          ),
                          onTap: () {
                            Utils.playClickSound();
                            Utils.hideKeyboard(context);
                            Navigator.of(context).pop();
                          }) : Container(),
                      InkResponse(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: rememberMe == true ? ColorRes.headerBlue : ColorRes.greyText,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Colors.white
                                    )
                                ),
                                child: Text(
                                  Utils.getText(context, StringRes.accept),
                                  style: TextStyle(
                                      fontSize: 17, color: ColorRes.white),
                                )),
                          ),
                          onTap: () {
                            if(rememberMe == true) Utils.playClickSound();
                            Utils.hideKeyboard(context);
                            if(rememberMe == true) {
                              if (widget.completion != null) {
                                apiCallPrivacyPolicy(Injector.userData.userId, Const.typeUpdateAccessTime.toString(), widget.companyId, (response) {
                                  Injector.userData.isSeenPrivacyPolicy = 1;
                                  Injector.setUserData(Injector.userData, false);
                                  widget.completion(true);
                                });
                              }
                              Navigator.of(context).pop();

                            }
                          })
                    ],
                  ),)
              ],
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


}
