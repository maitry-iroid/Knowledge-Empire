import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/BLoC/locale_bloc.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
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
  final langController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
//    localeBloc.setLocale(Utils.getIndexLocale(Injector.userData.language));


    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    langController.text = Utils.getText(context, StringRes.selectLanguage) + " - " + Injector.language;

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
                height: 170,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                alignment: Alignment.center,
                child: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only( left: 10, right: Utils.getDeviceWidth(context) / 5.5),
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
                              decoration: BoxDecoration(
                                  color: ColorRes.bgTextBox,
                                  border: Border.all(width: 1, color: ColorRes.white),
                                  borderRadius: BorderRadius.circular(20)),
                              child: TextField(
                                controller: codeController,
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                style: TextStyle(fontSize: 16, color: ColorRes.white),
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                    hintText: Utils.getText(
                                      context,
                                      StringRes.companyCode,
                                    ),
                                    hintStyle: TextStyle(color: ColorRes.hintColor),
                                    border: InputBorder.none),
                              )),
                          InkResponse(
                            child: Container(
                                margin: EdgeInsets.only(top: 15),
                                decoration: BoxDecoration(
                                    color: ColorRes.bgTextBox,
                                    border: Border.all(width: 1, color: ColorRes.white),
                                    borderRadius: BorderRadius.circular(20)),
                                child: TextField(
                                  controller: langController,
                                  textAlign: TextAlign.left,
                                  maxLines: 1,
                                  enabled: false,
                                  style: TextStyle(fontSize: 16, color: ColorRes.white),
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                      // hintText: Utils.getText(
                                      //   context,
                                      //   StringRes.selectLanguage,
                                      // ),
                                      hintStyle: TextStyle(color: ColorRes.hintColor),
                                      border: InputBorder.none),
                                )),
                            onTap: () {
                              Utils.playClickSound();
//                        Navigator.push(context, FadeRouteForgotPassword());
//                        selectLanguagesDialog();
                              selectLanguagesAlert(context);
                            },
                          ),

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
                                  height: 45,
                                  width: 110,
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

//    Injector.prefs.getString(PrefKeys.mainBaseUrl)
    Injector.prefs.remove(PrefKeys.mainBaseUrl);
    WebApi().callAPI(WebApi.rqVerifyCompanyCode, {'companyCode': codeController.text.trim()}).then((data) {
      if (mounted)
        setState(() {
          isLoading = false;
        });

      if (data != null && data['baseUrl'] != null) {
        Injector.companyCode = codeController.text.trim();
        Injector.prefs.setString(PrefKeys.mainBaseUrl, data['baseUrl']);
        Navigator.pop(context);
      }
    }).catchError((e) {
      if (mounted)
        setState(() {
          isLoading = false;
        });
    });
  }

  selectLanguagesAlert(BuildContext context) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: ColorRes.blackTransparentColor,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Stack(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(40),
                      width: Utils.getDeviceWidth(context) / 3.0,
                      height: Utils.getDeviceHeight(context) / 1.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorRes.white,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 35,
                              width: Utils.getDeviceWidth(context),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                color: ColorRes.blue,
                              ),
                              alignment: Alignment.topCenter,
                              child: Center(
                                child: Text(
                                  Utils.getText(context, StringRes.selectLanguage),
                                  style: TextStyle(color: ColorRes.white, fontSize: 17),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 13)),
                            languageSelectCell(StringRes.english, 0),
                            languageSelectCell(StringRes.german, 1),
                            languageSelectCell(StringRes.chinese, 2),
                          ],
                        ),
                      )),
                  Positioned(
                      right: 10,
                      child: InkResponse(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Image(
                            image: AssetImage(Utils.getAssetsImg('close_dialog')),
                            width: 20,
                          ),
                        ),
                        onTap: () {
                          Utils.playClickSound();
                          Navigator.pop(context, null);
                        },
                      ))
                ],
              ),
            ),
          );
        });
  }

  languageSelectCell(String language, int index) {
    return InkResponse(
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        padding: EdgeInsets.only(top: 5, bottom: 5, left: 0, right: 0),
        decoration: BoxDecoration(color: ColorRes.rankingProValueBg, borderRadius: BorderRadius.all(Radius.circular(8))),
        width: Utils.getDeviceWidth(context),
        child: Text(
          Utils.getText(context, language),
          textAlign: TextAlign.center,
        ),
      ),
      onTap: () async {
        if (index == 0) {
          Injector.language = Const.english;
        } else if (index == 1) {
          Injector.language = Const.german;
        } else if (index == 2) {
          Injector.language = Const.chinese;
        } else {
          Injector.language = null;
        }

        localeBloc.setLocale(Utils.getIndexLocale(Injector.language));

        Navigator.pop(context);
      },
    );
  }
}
