import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ke_employee/BLoC/customer_value_bloc.dart';
import 'package:ke_employee/BLoC/locale_bloc.dart';
import 'package:ke_employee/BLoC/navigation_bloc.dart';
import 'package:ke_employee/dialogs/display_dailogs.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/bailout.dart';
import 'package:ke_employee/models/company.dart';
import 'package:ke_employee/models/get_customer_value.dart';
import 'package:ke_employee/models/homedata.dart';
import 'package:ke_employee/models/privay_policy.dart';
import 'package:ke_employee/models/update_user_setting.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

import '../commonview/background.dart';
import '../helper/Utils.dart';
import '../helper/constant.dart';
import '../helper/prefkeys.dart';
import '../helper/res.dart';
import '../helper/string_res.dart';
import 'login.dart';
import '../models/logout.dart';

/*
*   created by Riddhi
*
*   User can manage profile data and can update settings here
*
* */

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController companyController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();
  FocusNode companyNameFocusNode;
  FocusNode nameFocusNode;
  List<Company> companyList = new List();
  bool isLoading = false;
  List languagesList = [StringRes.english, StringRes.german, StringRes.chinese];

  String updateUserID;
  String updateType;
  String updateMode;
  String updateIsSoundEnable;
  String updateLanguage;
  int updateCompanyId;

  @override
  void initState() {
    showIntroDialog();
    super.initState();

  }


  Future<void> showIntroDialog() async {
    if (Injector.introData != null && Injector.introData.profile1 == 0)
      await DisplayDialogs.showIntroProfile1(context);

    companyNameFocusNode = FocusNode();
    nameFocusNode = FocusNode();

    companyController.text = Injector.userData?.companyName;
    // Support emoji in nickname
    nickNameController.text = EmojiParser().emojify(Injector.userData?.nickName ?? "");
    updateUserID = Injector.userId.toString();
    updateIsSoundEnable =
        Injector.isSoundEnable != null && Injector.isSoundEnable
            ? 1.toString()
            : 0.toString();
    updateMode = Injector.mode.toString();
    updateLanguage = Injector.userData.language;

    photoUrl = Injector.userData != null
        ? Injector.userData?.profileImage != null
            ? Injector.userData?.profileImage
            : ""
        : "";

    _initPackageInfo();
  }

  File _image;
  String photoUrl = "";

  @override
  void dispose() {
    companyNameFocusNode.dispose();
    nameFocusNode.dispose();
    super.dispose();
  }

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor:
          Injector.isBusinessMode ? ColorRes.colorBgDark : ColorRes.white,
      body: Stack(
        children: <Widget>[
          CommonView.showBackground(context),
          Padding(
            padding: EdgeInsets.only(top: Utils.getHeaderHeight(context)),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[showFirstHalf(), showSecondHalf()],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  showFirstHalf() {
    return Expanded(
      flex: 1,
      child: Container(
        child: ListView(
          children: <Widget>[
            showTitle(),
            SizedBox(
              height: 5,
            ),
            showProfile(),
            showForm(),
          ],
        ),
      ),
    );
  }

  showSecondHalf() {
    return Expanded(
      flex: 1,
      child: Card(
        color: Injector.isBusinessMode ? Colors.transparent : ColorRes.bgProf,
        margin: EdgeInsets.all(0),
        elevation: Injector.isBusinessMode ? 0 : 10,
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 15,
                child: Container(
                  color: Colors.transparent,
                  margin: EdgeInsets.symmetric(
                      horizontal: Utils.getDeviceWidth(context) / 20),
                  child: ListView(
                    children: <Widget>[
                      Container(
                        width: 150,
                        height: Injector.isBusinessMode ? 30 : 30,
                        margin: EdgeInsets.only(top: 15, left: 65, right: 65),
                        alignment: Alignment.center,
                        child: Text(
                          Utils.getText(context, StringRes.settings),
                          style: TextStyle(
                              color: ColorRes.white,
                              fontSize: 17,
                              letterSpacing: 0.5),
                        ),
                        decoration: BoxDecoration(
                            color: Injector.isBusinessMode
                                ? null
                                : ColorRes.titleBlueProf,
                            borderRadius: Injector.isBusinessMode
                                ? null
                                : BorderRadius.circular(20),
                            image: Injector.isBusinessMode
                                ? DecorationImage(
                                    image: AssetImage(Utils.getAssetsImg(
                                        Injector.userData != null &&
                                                Injector.userData.language ==
                                                    "German"
                                            ? 'bg_blue'
                                            : 'bg_setting')))
                                : null),
                      ),
                      Container(
                        height: 30,
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Container(
                          child: Center(
                            child: Text(
                              getVersion(),
                              style: TextStyle(
                                  color: Injector.isBusinessMode
                                      ? ColorRes.white
                                      : ColorRes.fontDarkGrey),
                            ),
                          ),
                        ),
                      ),
                      InkResponse(
                        onTap: () {
                          _launchInWebViewOrVC(
                              "https://www.blue-elephants-solutions.com/wp/privacy-policy");
                        },
                        child: Container(
                          height: 30,
                          margin: EdgeInsets.only(top: 0, bottom: 10),
                          alignment: Alignment.center,
                          child: Text(
                            Utils.getText(context, StringRes.privacyPolicy),
                            style: TextStyle(
                              color: ColorRes.white,
                              fontSize: 15,
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Injector.isBusinessMode
                                  ? null
                                  : ColorRes.bgSettings,
                              borderRadius: Injector.isBusinessMode
                                  ? null
                                  : BorderRadius.circular(20),
                              image: Injector.isBusinessMode
                                  ? DecorationImage(
                                      image: AssetImage(
                                          Utils.getAssetsImg('bg_privacy')))
                                  : null),
                        ),
                      ),
                      Container(
                        height: 30,
                        alignment: Alignment.center,
                        child: Text(
                          Utils.getText(context, StringRes.termsConditions),
                          style: TextStyle(
                            color: ColorRes.white,
                            fontSize: 15,
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Injector.isBusinessMode
                                ? null
                                : ColorRes.bgSettings,
                            borderRadius: Injector.isBusinessMode
                                ? null
                                : BorderRadius.circular(20),
                            image: Injector.isBusinessMode
                                ? DecorationImage(
                                    image: AssetImage(
                                        Utils.getAssetsImg('bg_privacy')),
                                    fit: Injector.userData != null &&
                                            Injector.userData.language ==
                                                "German"
                                        ? BoxFit.fill
                                        : null)
                                : null),
                      ),
                      InkResponse(
                        onTap: () {
                          _launchEmail("support@knowledge-empire.com");
                        },
                        child: Container(
                          height: 30,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          child: Text(
                            Utils.getText(context, StringRes.contactUs),
                            style: TextStyle(
                              color: ColorRes.white,
                              fontSize: 15,
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Injector.isBusinessMode
                                  ? null
                                  : ColorRes.bgSettings,
                              borderRadius: Injector.isBusinessMode
                                  ? null
                                  : BorderRadius.circular(20),
                              image: Injector.isBusinessMode
                                  ? DecorationImage(
                                      image: AssetImage(
                                          Utils.getAssetsImg('bg_privacy')))
                                  : null),
                        ),
                      ),
                      InkResponse(
                        onTap: () async {
                          await callAPIForComponyName();
                        },
                        child: Container(
                          height: 30,
                          margin: EdgeInsets.symmetric(vertical: 1),
                          alignment: Alignment.center,
                          child: Text(
                            Utils.getText(context, StringRes.selectCompany),
                            style: TextStyle(
                              color: ColorRes.white,
                              fontSize: 15,
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Injector.isBusinessMode
                                  ? null
                                  : ColorRes.bgSettings,
                              borderRadius: Injector.isBusinessMode
                                  ? null
                                  : BorderRadius.circular(20),
                              image: Injector.isBusinessMode
                                  ? DecorationImage(
                                      image: AssetImage(
                                          Utils.getAssetsImg('bg_privacy')))
                                  : null),
                        ),
                      ),
                      InkResponse(
                        onTap: () async {
                          selectLanguagesDialog();
                        },
                        child: Container(
                          height: 30,
                          margin: EdgeInsets.only(top: 10),
                          alignment: Alignment.center,
                          child: Text(
                            Utils.getText(context, StringRes.selectLanguage) +
                                "-" + Injector?.userData?.language.toString() ?? "",
                            style: TextStyle(
                              color: ColorRes.white,
                              fontSize: 15,
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Injector.isBusinessMode
                                  ? null
                                  : ColorRes.bgSettings,
                              borderRadius: Injector.isBusinessMode
                                  ? null
                                  : BorderRadius.circular(20),
                              image: Injector.isBusinessMode
                                  ? DecorationImage(
                                      image: AssetImage(
                                          Utils.getAssetsImg('bg_privacy')))
                                  : null),
                        ),
                      ),
                      Injector.customerValueData != null &&
                              Injector.customerValueData.isSwitchEnable !=
                                  null &&
                              Injector.customerValueData.isSwitchEnable == 1
                          ? InkResponse(
                              child: Container(
                                height: 35,
                                margin: EdgeInsets.only(top: 15),
                                alignment: Alignment.center,
                                child: Text(
                                  Utils.getText(
                                      context,
                                      Injector.isBusinessMode
                                          ? StringRes.switchProfMode
                                          : StringRes.switchBusinessMode),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: ColorRes.white,
                                      fontSize: 15,
                                      letterSpacing: 0.7),
                                ),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(Utils.getAssetsImg(
                                            'bg_switch_to_prfsnl')),
                                        fit: BoxFit.fill)),
                              ),
                              onTap: () async {
//                                Utils.playClickSound();

                                await Injector.updateMode(
                                    Injector.isBusinessMode
                                        ? Const.professionalMode
                                        : Const.businessMode);

                                updateType = 1.toString();
                                updateMode = Injector.mode.toString();
                                await callApiForUpdateUserSetting(
                                    updateType, null);

                                Utils.playBackgroundMusic();

                                localeBloc.setLocale(Utils.getIndexLocale(Injector.userData.language));

                                setState(() {});
                              },
                            )
                          : Container(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkResponse(
                            child: Text(
                              Utils.getText(context, StringRes.sound),
                              style: TextStyle(
                                  color: Injector.isBusinessMode
                                      ? ColorRes.white
                                      : ColorRes.fontDarkGrey),
                            ),
                            onTap: () {
                              Utils.playClickSound();
                            },
                          ),
                          Switch(
                            value: Injector.isSoundEnable != null &&
                                Injector.isSoundEnable,
                            onChanged: (value) async {
                              Injector.isSoundEnable = value;
                              Injector.customerValueData.isEnableSound =
                                  Injector.isSoundEnable ? 1 : 0;
                              //Injector.setCustomerValueData(Injector.customerValueData);

                              Utils.playBackgroundMusic();

                              updateType = 2.toString();
                              updateIsSoundEnable =
                                  value ? 1.toString() : 0.toString();
                              updateMode = Injector.mode.toString();
                              callApiForUpdateUserSetting(updateType, null);

                              setState(() {});
                            },
                            activeTrackColor: Injector.isBusinessMode
                                ? ColorRes.white
                                : ColorRes.lightGrey,
                            inactiveTrackColor: Injector.isBusinessMode
                                ? ColorRes.lightGrey
                                : ColorRes.lightGrey,
                            activeColor: Injector.isBusinessMode
                                ? ColorRes.blue
                                : ColorRes.blue,
                          ),
                        ],
                      ),
                      InkResponse(
                        child: Container(
                          height: 35,
                          padding: EdgeInsets.only(left: 8, right: 8),
                          alignment: Alignment.center,
                          child: Text(
                            bailOutText(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: !Injector.isManager() &&
                                        Injector.customerValueData != null &&
                                        Injector.customerValueData
                                                .totalBalance !=
                                            null &&
                                        Injector.customerValueData
                                                .totalBalance <=
                                            0
                                    ? ColorRes.white
                                    : ColorRes.greyText,
                                fontSize: 15,
                                letterSpacing: 0.7),
                          ),
                          decoration: bailOutDecoration(),
                        ),
                        onTap: Injector.customerValueData != null &&
                                Injector.customerValueData.totalBalance <= 0
                            ? () async {
                                Injector.audioCache.clearCache();
//                                Injector.player.clear("game_bg_music.mp3");
//                                Injector.audioPlayerBg.pause();
                                Utils.playClickSound();
                                _asyncConfirmDialog(context);
                              }
                            : null,
                      ),
                      InkResponse(
                        child: Container(
                          height: 33,
                          margin: EdgeInsets.symmetric(vertical: 15),
                          alignment: Alignment.center,
                          child: Text(
                            Utils.getText(context, StringRes.logout),
                            style: TextStyle(
                              color: ColorRes.white,
                              fontSize: 16,
                            ),
                          ),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      Utils.getAssetsImg('bg_log_out')))),
                        ),
                        onTap: logout,
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  bailOutDecoration() {
    if (!Injector.isManager() && Injector.customerValueData != null && Injector.customerValueData.totalBalance <= 0) {
      return BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Utils.getAssetsImg('bg_switch_to_prfsnl'))));
    } else {
      return BoxDecoration(
          color: Injector.isBusinessMode ? null : ColorRes.bgSettings,
          borderRadius:
              Injector.isBusinessMode ? null : BorderRadius.circular(20),
          image: Injector.isBusinessMode
              ? DecorationImage(
                  image: AssetImage(Utils.getAssetsImg('bg_privacy')))
              : null);
    }
  }

  String bailOutText() {
    if (Injector.customerValueData == null ||
        Injector.customerValueData?.manager == null ||
        Injector.customerValueData.manager.isEmpty) {
      return Utils.getText(context, StringRes.bailout);
    } else {
      return Utils.getText(context, StringRes.requestBailOut);
    }
  }

  _asyncConfirmDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
//          title: Text('Alert', style: TextStyle(color: ColorRes.black)),
          content: Text(Utils.getText(context, StringRes.alertBailOut)),
          actions: <Widget>[
            FlatButton(
              child: Text(Utils.getText(context, StringRes.yes)),
              onPressed: () {
                //alert pop
                Navigator.of(context).pop();
                CommonView.showCircularProgress(true, context);
                performBailOut();
              },
            ),
            FlatButton(
              child: Text(Utils.getText(context, StringRes.no)),
              onPressed: () {
                //alert pop
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  selectCompanyDialog() {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Center(
            child: Container(
                width: Utils.getDeviceWidth(context) / 2,
                height: Utils.getDeviceHeight(context) / 2,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)),
                child: ListView.builder(
                    itemCount: companyList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          updateCompanyId = companyList[index].companyId;
                          this.apiCallToPrivacyPolicy(companyList[index]);
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                (index + 1).toString() +
                                    "    " +
                                    companyList[index].companyName,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: ColorRes.black,
                                    decoration: TextDecoration.none),
                              ),
                            ),
                          ),
                        ),
                      );
                    })),
            /*child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Divider(color: ColorRes.greyText),
                          Text(
                            "tag this ok",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 12,color: ColorRes.black,decoration: TextDecoration.none),
                          ),
                          Divider(color: ColorRes.greyText)
                        ],
                      ),
                    );
                  }),
                )),*/
          );
        });
  }

  apiCallToPrivacyPolicy(Company company) {
    if (mounted)
      setState(() {
        isLoading = true;
      });

    PrivacyPolicyRequest rq = PrivacyPolicyRequest();
    rq.userId = Injector.userData.userId;
    rq.type = Const.typeGetPrivacyPolicy.toString();
    rq.companyId = updateCompanyId;

    WebApi().callAPI(WebApi.rqPrivacyPolicy, rq.toJson()).then((data) {
      if (mounted)
        setState(() {
          isLoading = false;
        });

      if (data != null) {
        PrivacyPolicyResponse response = PrivacyPolicyResponse.fromJson(data);
        if(response.isSeenPrivacyPolicy != 1 && response.privacyPolicyTitle != "" && response.privacyPolicyContent != ""){
          Utils.showPrivacyPolicyDialog(_scaffoldKey, true, company.companyId,response.privacyPolicyTitle, response.privacyPolicyContent, response.privacyPolicyAcceptText, completion: (status){
            if (status == true) {
              companyController.text = company.companyName;
              Injector.userData.companyName = company.companyName;
              updateType = 4.toString();
              updateCompanyId = company.companyId;
              Injector.userData.activeCompany = company.companyId;
              callApiForUpdateUserSetting(updateType, null);
            }
          });
        }else{
          companyController.text = company.companyName;
          Injector.userData.companyName = company.companyName;
          updateType = 4.toString();
          updateCompanyId = company.companyId;
          Injector.userData.activeCompany = company.companyId;
          callApiForUpdateUserSetting(updateType, null);
        }
      }
    });
  }

  Future<void> performBailOut() async {
    BailOutRequest rq = BailOutRequest();
    rq.userId = Injector.userData.userId;
    rq.mode = Injector.mode;

    WebApi().callAPI(WebApi.rqBailOut, rq.toJson()).then((data) async {
      CommonView.showCircularProgress(false, context);
      if (data != null) {
        if (data is Map) {
          CustomerValueData customerValueData =
              CustomerValueData.fromJson(data);
          await customerValueBloc?.updateCustomerValue(customerValueData);
          navigationBloc
              .updateNavigation(HomeData(initialPageType: Const.typeProfile));
        } else if (data is String) {
          Utils.showToast(data.toString());
        }
      }
    }).catchError((e) {});
  }

  logout() async {
    Utils.playClickSound();
    CommonView.showCircularProgress(true, context);

    LogoutRequest rq = LogoutRequest();
    rq.userId = Injector.userId;
    rq.deviceType = Injector.deviceType;
    rq.deviceToken = Injector.prefs.getString(PrefKeys.deviceToken);

    Utils.isInternetConnected().then((isConnected) {
      if (isConnected) {
        WebApi().callAPI(WebApi.rqLogout, rq.toJson()).then((data) async {
          CommonView.showCircularProgress(false, context);

          if (data != null) {}
          try {
            Navigator.pushAndRemoveUntil(
                context, FadeRouteLogin(), ModalRoute.withName("/home"));
            Injector.audioPlayerBg.stop();
            await Injector.logout();
          } catch (e) {
            print(e);
          }
        }).catchError((e) {
          print("logout_" + e.toString());
          CommonView.showCircularProgress(false, context);
          // Utils.showToast(e.toString());
        });
      } else {
        CommonView.showCircularProgress(false, context);
        Fluttertoast.showToast(
            msg: Utils.getText(context, StringRes.noInternet));
      }
    });
  }

  showTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkResponse(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Image(
                image: AssetImage(Utils.getAssetsImg("back")),
                width: 30,
              ),
            ),
            onTap: () {
              Utils.playClickSound();
              Utils.performBack(context);
            },
          ),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.center,
              height: 30,
              margin: EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                  color:
                      Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
                  borderRadius: Injector.isBusinessMode
                      ? null
                      : BorderRadius.circular(20),
                  image: Injector.isBusinessMode
                      ? DecorationImage(
                          image: AssetImage(
                            Utils.getAssetsImg(Injector.userData != null &&
                                    Injector.userData.language == "German"
                                ? "bg_blue"
                                : "bg_setting"),
                          ),
                          fit: BoxFit.fill)
                      : null),
              child: Text(
                Utils.getText(context, StringRes.editProfile),
                style: TextStyle(
                  color: ColorRes.white,
                  fontSize: 17,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            width: 30,
          )
        ],
      ),
    );
  }

  showProfile() {
    return InkResponse(
      child: Center(
        child: Stack(
          children: <Widget>[
            new Container(
              margin: EdgeInsets.all(5),
              width: 70,
              height: 70,
              decoration: new BoxDecoration(
                border: Border.all(width: 2, color: Color(0xff7ab1cb)),
                shape: BoxShape.circle,
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: _image != null
                      ? FileImage(_image)
                      : photoUrl != null
                          ? Utils.getCacheNetworkImage(photoUrl)
                          : AssetImage(
                              Utils.getAssetsImg("dashboard-background"),
                            ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Image(
                image: AssetImage(
                  Utils.getAssetsImg("edit"),
                ),
                width: 30,
              ),
            )
          ],
        ),
      ),
      onTap: () => showPhotoOptionDialog(context),
      /*     onTap: () {
        DisplayDialogs.showChallengeDialog(context, "hello", null);
      },*/
    );
  }

  Container showForm() {
    return Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 10),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 36,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorRes.lightBg.withOpacity(0.5),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            width: 13,
                          ),
                          Text(
                            Utils.getText(context, StringRes.companyName),
                            style:
                                TextStyle(color: ColorRes.white, fontSize: 15),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              height: 38,
                              padding: EdgeInsets.only(left: 20, right: 20),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        Utils.getAssetsImg("bg_name_email")),
                                    fit: BoxFit.fill),
                              ),
                              child: TextField(
                                controller: companyController,
                                obscureText: false,
                                focusNode: companyNameFocusNode,
                                style: TextStyle(
                                  color: ColorRes.white,
                                  fontSize: 15,
                                ),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 5),
                                    border: InputBorder.none,
//                                    hintText: Injector.userData?.companyName,
                                    hintStyle:
                                        TextStyle(color: ColorRes.hintColor)),
                                maxLines: 1,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                InkResponse(
                  child: Image(
                    image: AssetImage(Utils.getAssetsImg("edit")),
                    width: 40,
                  ),
                  onTap: () {
                    Utils.playClickSound();
                    FocusScope.of(context).requestFocus(companyNameFocusNode);
                  },
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 36,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorRes.lightBg.withOpacity(0.5),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            Utils.getText(context, StringRes.yourName),
                            style:
                            TextStyle(color: ColorRes.white, fontSize: 15),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              height: 38,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 1),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        Utils.getAssetsImg("bg_name_email")),
                                    fit: BoxFit.fill),
                              ),
                              child: TextField(
                                enabled: false,
                                obscureText: false,
                                style: TextStyle(
                                  color: ColorRes.hintColor,
                                  fontSize: 15,
                                ),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: Injector.userData?.name,
                                    hintStyle:
                                    TextStyle(color: ColorRes.hintColor)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                InkResponse(
                    child: Container(
                      width: 40,
                    ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 36,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorRes.lightBg.withOpacity(0.5),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 13,
                          ),
                          Text(
                            "Nick name",
                            style:
                            TextStyle(color: ColorRes.white, fontSize: 15),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              height: 38,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 1),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        Utils.getAssetsImg("bg_name_email")),
                                    fit: BoxFit.fill),
                              ),
                              child: TextField(
                                controller: nickNameController,
                                enabled: true,
                                obscureText: false,
                                focusNode: nameFocusNode,
                                style: TextStyle(
                                  color: ColorRes.white ,
                                  fontSize: 15,
                                ),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: Injector.userData?.nickName,
                                    hintStyle:
                                    TextStyle(color: ColorRes.hintColor)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                InkResponse(
                  child: Image(
                    image: AssetImage(Utils.getAssetsImg("edit")),
                    width: 40,
                  ),
                  onTap: () {
                    Utils.playClickSound();
                    FocusScope.of(context).requestFocus(nameFocusNode);
                  },
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 36,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorRes.lightBg.withOpacity(0.5),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            Utils.getText(context, StringRes.yourEmail),
                            style:
                                TextStyle(color: ColorRes.white, fontSize: 15),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              height: 38,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 1),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        Utils.getAssetsImg("bg_name_email")),
                                    fit: BoxFit.fill),
                              ),
                              child: TextField(
                                enabled: false,
                                obscureText: false,
                                style: TextStyle(
                                  color: ColorRes.white,
                                  fontSize: 15,
                                ),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: Injector.userData?.email,
                                    hintStyle:
                                        TextStyle(color: ColorRes.hintColor)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                InkResponse(
                    child: Container(
                  width: 40,
                ))
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: InkResponse(
                    child: Container(
                      height: 38,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  Utils.getAssetsImg("bg_change_pw")),
                              fit: BoxFit.fill)),
                      child:
                          Text(Utils.getText(context, StringRes.changePassword),
                              style: TextStyle(
                                color: ColorRes.white,
                                fontSize: 18,
                              )),
                    ),
                    onTap: () {
                      Utils.playClickSound();
                      Utils.showChangePasswordDialog(_scaffoldKey, true, true);
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: InkResponse(
                    child: Container(
                      height: 37,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Utils.getAssetsImg("bg_save")),
                              fit: BoxFit.fill)),
                      child: Text(Utils.getText(context, StringRes.save),
                          style: TextStyle(
                            color: ColorRes.white,
                            fontSize: 18,
                          )),
                    ),
                    onTap: () {
                      updateProfile();
                    },
                  ),
                ),
                Container(
                  width: 40,
                )
              ],
            )
          ],
        ));
  }

  Future getImage(int type) async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    File tempImage = await ImagePicker.pickImage(
      source:
          type == Const.typeGallery ? ImageSource.gallery : ImageSource.camera,
      imageQuality: Const.imgQuality,
    );

    if (tempImage != null) {
      setState(() {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
        photoUrl = "";
        _image = tempImage;
        if (_image != null) {
          updateProfile();
        }
      });
    }
  }

  Future<void> _launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw '${Utils.getText(context, StringRes.strUrlExeption)} $url';
    }
  }

  _launchEmail(String email) async {
    if (await canLaunch("mailto:$email")) {
      await launch("mailto:$email");
    } else {
      throw Utils.getText(context, StringRes.strUrlExeption);
    }
  }

  selectLanguagesDialog() {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: ColorRes.blackTransparentColor,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Center(
            child: Container(
                width: Utils.getDeviceWidth(context) / 2,
                height: Utils.getDeviceHeight(context) / 2,
                decoration: BoxDecoration(
                    color: ColorRes.greyText,
                    borderRadius: BorderRadius.circular(10)),
                child: ListView.builder(
                    itemCount: languagesList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () async {
                          try {
                            updateType = 3.toString();
                            await setLanguage(index);
                            Navigator.pop(context);
                            callApiForUpdateUserSetting(updateType, index);
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                Utils.getText(context, languagesList[index]),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: ColorRes.black,
                                    decoration: TextDecoration.none),
                              ),
                            ),
                          ),
                        ),
                      );
                    })),
          );
        });
  }

//  void compressImage() async {
//    File imageFile = await ImagePicker.pickImage();
//    final tempDir = await getTemporaryDirectory();
//    final path = tempDir.path;
//    int rand = new Math.Random().nextInt(10000);
//
//    Im.Image image = Im.decodeImage(imageFile.readAsBytesSync());
//    Im.Image smallerImage = Im.copyResize(image, 500); // choose the size here, it will maintain aspect ratio
//
//    var compressedImage = new File('$path/img_$rand.jpg')..writeAsBytesSync(Im.encodeJpg(image, quality: 85));
//  }

  void showPhotoOptionDialog(BuildContext mainContext) {
    Utils.playClickSound();
    showDialog(
      context: mainContext,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              InkResponse(
                child: Container(
                  padding: EdgeInsets.all(12),
                  child: Text(Utils.getText(context, StringRes.choosePhoto)),
                  alignment: Alignment.center,
                ),
                onTap: () {
                  Utils.playClickSound();
                  Navigator.pop(context);
                  getImage(Const.typeGallery);
                },
              ),
              Container(
                height: 1,
                color: ColorRes.fontGrey,
              ),
              InkResponse(
                child: Container(
                  padding: EdgeInsets.all(12),
                  child: Text(Utils.getText(context, StringRes.takePhoto)),
                  alignment: Alignment.center,
                ),
                onTap: () async {
                  Utils.playClickSound();
                  Navigator.pop(context);
                  getImage(Const.typeCamera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  updateProfile() {
    Utils.playClickSound();
    var req = {
      'userId': Injector.userId,
      'companyName': companyController.text.trim(),
      'nickName': nickNameController.text
    };

    print("Request ::::::::::::::::::::::::: \n${req.toString()}");

    CommonView.showCircularProgress(true, context);


    WebApi().updateProfile(req, _image).then((data) async {
      CommonView.showCircularProgress(false, context);

      if (data != null) {
        print("nickname ::: ${data.nickName}");

        Injector.userData.profileImage = data.profileImage;
        Injector.userData.companyName = data.companyName;
        Injector.userData.name = data.name;
        Injector.userData.nickName = data.nickName;
        await Injector.setUserData(Injector.userData, false);

        Utils.showToast(Utils.getText(context, StringRes.successProfileUpdate));

        Injector.headerStreamController.add(Const.updateProfileBrod);

        localeBloc.setLocale(Utils.getIndexLocale(Injector.userData.language));
      } else {
        Utils.showToast(Utils.getText(context, StringRes.somethingWrong));
      }
    }).catchError((e) {
      print("updatePorfile_" + e.toString());
      CommonView.showCircularProgress(false, context);
      // Utils.showToast(e.toString());
    });
  }

  callAPIForComponyName() {
    Utils.playClickSound();

    Map<String, dynamic> map = {"userId": Injector.userId};
    CommonView.showCircularProgress(true, context);
    WebApi().callAPI(WebApi.rqGetCompany, map).then((data) async {
      CommonView.showCircularProgress(false, context);

      if (data != null) {
        List<Company> arrFriendsData = List();
        data.forEach((v) {
          arrFriendsData.add(Company.fromJson(v));
        });
        companyList = arrFriendsData;
        selectCompanyDialog();
        setState(() {});
      } else {
        Utils.showToast(Utils.getText(context, StringRes.somethingWrong));
      }
    }).catchError((e) {
      print("updatePorfile_" + e.toString());
      CommonView.showCircularProgress(false, context);
      // Utils.showToast(e.toString());
    });
  }

  /*
  *           IMPORTANT
  * We introduced the "App version", so that we have a reference we can use to have a common understanding which version we are talking about.
  * The versioning could work like this:
  * "A-BBB-C Version: XXX.YYY-ZZZ"
  * A is replaced with P for Productive, T for Testing (which we do not have at the moment) and D for Development.
  * BBB is replaced if we have customer specific versions. Standard is BES (for Blue Elephants Solutions)
  * C is replaced with the target operating system (I for iOS and A for Android). is this enough or should we have more coding for the operating system
  * (e.g. in case of mayor changes of operating system and we need to have different versions ready for different operating systems?
  * X= is version numbering for mayor releases. Currently 000. Once we have a version to really go live with it will be 001.
  * Y= For bigger updated (e.g. new features implemented). Falls back to 000 when X goes up by one
  * Z= for smaller updates and bug fixes. Falls back to 000 when Y goes up by one.
  * */

  String getVersion() {
    String mode = Injector.isDev ? "D" : "P";
    String customerSpecificVersion = "BES"; //Blue Elephants Solutions
    String os = Injector.deviceType == "ios" ? "I" : "A";

    String x = "004";
    String y = "001";
    String z = "000";

    return mode +
        "-" +
        customerSpecificVersion +
        "-" +
        os +
        " ${Utils.getText(context, StringRes.strVersion)}: " +
        x +
        "." +
        y +
        "-" +
        z;
  }

  callApiForUpdateUserSetting(String updateType, int index) {
    Utils.playClickSound();

    UpdateUserSetting rq = UpdateUserSetting();
    rq.userId = updateUserID;
    rq.type = updateType;
    rq.mode = updateMode;
    rq.isSoundEnable = updateIsSoundEnable;
    rq.language = updateLanguage;
    if (updateCompanyId != null) {
      rq.companyId = updateCompanyId;
    }

    print(rq);
//    CommonView.showCircularProgress(true, context);
    WebApi().callAPI(WebApi.updateUserSetting, rq.toJson()).then((data) async {
//      CommonView.showCircularProgress(false, context);
      print(data);
      if (data != null) {
        await Injector.getIntroText();
        switch (updateType) {
          case "1":
            await setMode();
            break;
          case "3":
            break;
          case "4":
            await setCompany();
            break;
        }

        Utils.callCustomerValuesApi();
      } else {
        Utils.showToast(Utils.getText(context, StringRes.somethingWrong));
      }
    }).catchError((e) {
//      CommonView.showCircularProgress(false, context);
    });
  }

  Future setLanguage(int index) async {
    switch (index) {
      case 0:
        Injector.userData.language = Const.english;
        updateLanguage = Const.english;
        break;
      case 1:
        Injector.userData.language = Const.german;
        updateLanguage = Const.german;
        break;
      case 2:
        Injector.userData.language = Const.chinese;
        updateLanguage = Const.chinese;
        break;
    }

    localeBloc.setLocale(index);
    await Injector.setUserData(Injector.userData, true);
    await Injector.getIntroText();
  }

  removeKeys() {
//    Injector.prefs.clear();

    Injector.prefs.remove(PrefKeys.user);
    Injector.prefs.remove(PrefKeys.mode);
    Injector.prefs.remove(PrefKeys.isLoginFirstTime);
    Injector.prefs.remove(PrefKeys.questionData);
    Injector.prefs.remove(PrefKeys.answerData);
    Injector.prefs.remove(PrefKeys.customerValueData);
    Injector.prefs.remove(PrefKeys.learningModles);
    Injector.prefs.remove(PrefKeys.download);
    Injector.prefs.remove(PrefKeys.currentIntroType);
    Injector.prefs.remove(PrefKeys.deviceToken);
    Injector.prefs.remove(PrefKeys.badgeCount);
  }

  //switch Company List

  setMode() async {
    Injector.userData.mode = Injector.mode;
    await Injector.setUserData(Injector.userData, false);
  }

  setCompany() {
    localeBloc.setLocale(Utils.getIndexLocale(Injector.userData.language));
  }
}
