import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ke_employee/BLoC/learning_module_bloc.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/bailout.dart';
import 'package:ke_employee/models/company.dart';
import 'package:package_info/package_info.dart';

import '../commonview/background.dart';
import '../helper/Utils.dart';
import '../helper/constant.dart';
import '../helper/prefkeys.dart';
import '../helper/res.dart';
import '../helper/string_res.dart';
import 'login.dart';
import '../models/logout.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController companyController = TextEditingController();

  FocusNode myFocusNode;

  List<Company> companyList = new List();

  String getCompany = "Select Company";

  @override
  void initState() {
    myFocusNode = FocusNode();

    companyController.text = Injector.userData?.companyName;

    photoUrl = Injector.userData != null
        ? Injector.userData?.profileImage != null
            ? Injector.userData?.profileImage
            : ""
        : "";

    super.initState();

//    packagesInfo();
    _initPackageInfo();
    callAPIForComponyName();
  }

  File _image;
  String photoUrl = "";

  @override
  void dispose() {
    myFocusNode.dispose();
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
            SizedBox(
              height: 15,
            ),
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
                        margin: EdgeInsets.only(top: 15, left: 0, right: 0),
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
                                    image: AssetImage(
                                        Utils.getAssetsImg('bg_setting')))
                                : null),
                      ),
                      Container(
                        height: 30,
//                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Container(
                          /* decoration: BoxDecoration(
                              color: Injector.isBusinessMode
                                  ? null
                                  : ColorRes.bgSettings,
                              borderRadius: Injector.isBusinessMode
                                  ? null
                                  : BorderRadius.circular(20),
//                              image: Injector.isBusinessMode
//                                  ? DecorationImage(
//                                  image: AssetImage(
//                                      Utils.getAssetsImg('bg_privacy')))
//                                  : null
                          ),*/

                          child: Center(
                            child: Text(
                              "App Version: ${_packageInfo.version}",
                              style: TextStyle(
                                  color: Injector.isBusinessMode
                                      ? ColorRes.white
                                      : ColorRes.fontDarkGrey),
                            ),
                          ),
                        ),
                      ),
                      Container(
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
                                        Utils.getAssetsImg('bg_privacy')))
                                : null),
                      ),
                      Container(
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
                      InkResponse(
                        onTap: () {
                          selectCompanyDialog();
                        },
                        child: Container(
                          height: 30,
                          margin: EdgeInsets.symmetric(vertical: 1),
                          alignment: Alignment.center,
                          child: Text(
                            getCompany,
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
                          Utils.playClickSound();

                          await Injector.updateMode(Injector.isBusinessMode
                              ? Const.professionalMode
                              : Const.businessMode);

                          Injector.streamController.add("chnage mode");
                          setState(() {});
                        },
                      ),
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
                            value: Injector.isSoundEnable,
                            onChanged: (value) {
                              Utils.isInternetConnectedWithAlert()
                                  .then((isConnected) {
                                if (isConnected) {
                                  setState(() {
                                    Injector.isSoundEnable = value;
                                    Injector.prefs
                                        .setBool(PrefKeys.isSoundEnable, value);
                                  });
                                }
                              });
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
                      !Injector.isManager() &&
                              Injector.customerValueData.totalBalance <= 0
                          ? InkResponse(
                              child: Container(
                                height: 35,
                                width: 50,
                                padding: EdgeInsets.only(left: 8, right: 8),
                                alignment: Alignment.center,
                                child: Text(
                                  Utils.getText(
                                      context,
                                      Injector.customerValueData == null ||
                                              Injector.customerValueData
                                                      ?.manager ==
                                                  null ||
                                              Injector.customerValueData.manager
                                                  .isEmpty
                                          ? StringRes.bailout
                                          : StringRes.requestBailOut),
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
                                Utils.playClickSound();

                                _asyncConfirmDialog(context);
                              },
                            )
                          : Container(),
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
                color: Colors.white,
                width: Utils.getDeviceWidth(context) / 2,
                height: Utils.getDeviceHeight(context) / 2,
                child: ListView.builder(
                    itemCount: companyList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          getCompany = companyList[index].companyName;
                          Navigator.pop(context);
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                companyList[index].companyName,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: ColorRes.black,
                                    decoration: TextDecoration.none),
                              ),
                              Divider(color: ColorRes.greyText),
                            ],
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

  void performBailOut() {
    BailOutRequest rq = BailOutRequest();
    rq.userId = Injector.userData.userId;
    rq.mode = Injector.mode;

    customerValueBloc?.bailOut(rq);
  }

  logout() async {
    Utils.playClickSound();
    CommonView.showCircularProgress(true, context);

    LogoutRequest rq = LogoutRequest();
    rq.userId = Injector.userId;
    rq.deviceType = Injector.deviceType;
    rq.deviceToken = Injector.prefs.getString(PrefKeys.deviceToken);

    WebApi().callAPI(WebApi.rqLogout, rq.toJson()).then((data) async {
      CommonView.showCircularProgress(false, context);

      if (data != null) {}
      try {
        await Injector.prefs.clear();
        Injector.userData = null;
        Injector.userId = null;
        Injector.customerValueData = null;
        Navigator.pushAndRemoveUntil(
            context, FadeRouteLogin(), ModalRoute.withName("/home"));
      } catch (e) {
        print(e);
      }
    }).catchError((e) {
      print("logout_" + e.toString());
      CommonView.showCircularProgress(false, context);
      Utils.showToast(e.toString());
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
                            Utils.getAssetsImg("bg_setting"),
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
                  fit: BoxFit.fill,
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
                                TextStyle(color: ColorRes.white, fontSize: 12),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              height: 38,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 0),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        Utils.getAssetsImg("bg_name_email")),
                                    fit: BoxFit.fill),
                              ),
                              child: TextField(
                                controller: companyController,
                                obscureText: false,
                                focusNode: myFocusNode,
                                style: TextStyle(
                                  color: ColorRes.white,
                                  fontSize: 13,
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
                    FocusScope.of(context).requestFocus(myFocusNode);
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
                            width: 13,
                          ),
                          Text(
                            Utils.getText(context, StringRes.yourName),
                            style:
                                TextStyle(color: ColorRes.white, fontSize: 12),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              height: 38,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
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
                                  fontSize: 13,
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
                            width: 13,
                          ),
                          Text(
                            Utils.getText(context, StringRes.yourEmail),
                            style:
                                TextStyle(color: ColorRes.white, fontSize: 12),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              height: 38,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
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
                                  fontSize: 13,
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
                      height: 35,
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
                                fontSize: 15,
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
                      height: 35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Utils.getAssetsImg("bg_save")),
                              fit: BoxFit.fill)),
                      child: Text(Utils.getText(context, StringRes.save),
                          style: TextStyle(
                            color: ColorRes.white,
                            fontSize: 15,
                          )),
                    ),
                    onTap: updateProfile,
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
    File tempImage = await ImagePicker.pickImage(
      source:
          type == Const.typeGallery ? ImageSource.gallery : ImageSource.camera,
      imageQuality: Const.imgQuality,
    );

    if (tempImage != null) {
      setState(() {
        photoUrl = "";
        _image = tempImage;
      });
    }
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
    };

    CommonView.showCircularProgress(true, context);
    WebApi().updateProfile(req, _image).then((data) async {
      CommonView.showCircularProgress(false, context);

      if (data != null) {
        Injector.userData.profileImage = data.profileImage;
        Injector.userData.companyName = data.companyName;

        await Injector.setUserData(Injector.userData);

        Utils.showToast(Utils.getText(context, StringRes.successProfileUpdate));

        Injector.streamController.add("update_profile");
      } else {
        Utils.showToast(Utils.getText(context, StringRes.somethingWrong));
      }
    }).catchError((e) {
      print("updatePorfile_" + e.toString());
      CommonView.showCircularProgress(false, context);
      Utils.showToast(e.toString());
    });
  }

  callAPIForComponyName() {
    Utils.playClickSound();

    Map<String, dynamic> map = {"userId": Injector.userId};

    WebApi().callAPI(WebApi.rqGetCompany, map).then((data) async {
      // CommonView.showCircularProgress(false, context);

      if (data != null) {
        List<Company> arrFriendsData = List();
        data.forEach((v) {
          arrFriendsData.add(Company.fromJson(v));
        });
        companyList = arrFriendsData;
        setState(() {});
      } else {
        Utils.showToast(Utils.getText(context, StringRes.somethingWrong));
      }
    }).catchError((e) {
      print("updatePorfile_" + e.toString());
      CommonView.showCircularProgress(false, context);
      Utils.showToast(e.toString());
    });
  }
}
