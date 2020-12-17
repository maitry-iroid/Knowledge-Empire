import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/update_profile.dart';
import 'package:ke_employee/screens/home.dart';

class VerifyCompanyDialog extends StatefulWidget {
  VerifyCompanyDialog({
    Key key,
  }) : super(key: key);

  @override
  VerifyCompanyDialogState createState() => new VerifyCompanyDialogState();
}

class VerifyCompanyDialogState extends State<VerifyCompanyDialog> {
  final codeController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
//    localeBloc.setLocale(Utils.getIndexLocale(Injector.userData.language));
    super.initState();
  }

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
        fit: StackFit.loose,
        children: <Widget>[
          Container(
            width: Utils.getDeviceWidth(context) / 1.5,
            alignment: Alignment.center,
            child: Container(
                height: Utils.getDeviceHeight(context) / 3.6,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                alignment: Alignment.center,
                child: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 0, left: 10, right: Utils.getDeviceWidth(context) / 5.5, bottom: 0),
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
                          Container(
                              height: 35,
                              margin: EdgeInsets.symmetric(vertical: 3),
                              decoration: BoxDecoration(
                                  color: ColorRes.bgTextBox,
                                  border: Border.all(width: 1, color: ColorRes.white),
                                  borderRadius: BorderRadius.circular(20)),
                              child: TextField(
                                controller: codeController,
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                style: TextStyle(fontSize: 14, color: ColorRes.white),
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                    hintText: Utils.getText(
                                      context,
                                      StringRes.companyCode,
                                    ),
                                    hintStyle: TextStyle(color: ColorRes.hintColor),
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
                                  decoration:
                                      BoxDecoration(image: DecorationImage(image: AssetImage(Utils.getAssetsImg("bg_save")), fit: BoxFit.fill)),
                                  child: Text(
                                    Utils.getText(context, StringRes.save),
                                    style: TextStyle(fontSize: 17, color: ColorRes.white),
                                  )),
                              onTap: () {
                                Utils.playClickSound();
                                Utils.hideKeyboard(context);
                                validateData();
                              }),
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
    if (codeController.text.trim().isEmpty) {
      Utils.showToast(Utils.getText(context, StringRes.enterCompanyCode));
      return;
    }

    if (mounted)
      setState(() {
        isLoading = true;
      });

    WebApi().callAPI(WebApi.rqVerifyCompanyCode, {'companyCode': codeController.text.trim()}).then((data) {
      if (mounted)
        setState(() {
          isLoading = false;
        });

      if (data != null && data['baseUrl'] != null) {
        if (data['baseUrl'] != null) {
          Injector.prefs.setString(PrefKeys.mainBaseUrl, data['baseUrl']);
          Navigator.pop(context);
        } else {
          Utils.showToast(Utils.getText(context, StringRes.somethingWrong));
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
