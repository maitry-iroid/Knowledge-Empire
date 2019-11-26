import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/LogoutRequest.dart';
import 'package:notifier/main_notifier.dart';
import 'package:notifier/notifier_provider.dart';

import 'commonview/background.dart';
import 'helper/Utils.dart';
import 'helper/constant.dart';
import 'helper/prefkeys.dart';
import 'helper/res.dart';
import 'helper/string_res.dart';
import 'login.dart';
import 'home.dart';
import 'models/login_response_data.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    nameController.text = Injector.userData.name;

    photoUrl = Injector.userData != null
        ? Injector.userData.profileImage != null
            ? Injector.userData.profileImage
            : ""
        : "";

    super.initState();
  }

  Notifier _notifier;
  File _image;
  String photoUrl = "";

  @override
  Widget build(BuildContext context) {
    _notifier = NotifierProvider.of(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor:
          Injector.isBusinessMode ? ColorRes.colorBgDark : ColorRes.white,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: CommonView.getBGDecoration(),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        showFirstHalf(),
//                    Container(
//                      margin: EdgeInsets.only( left: 25),
//                      height: double.infinity,
//                      width: 1,
//                      color: ColorRes.greyText.withOpacity(0.5),
//                    ),
                        showSecondHalf()
                      ],
                    ),
                  )
                ],
              ),
            ),
            CommonView.showCircularProgress(isLoading)
          ],
        ),
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
        child: Container(
          color: Colors.transparent,
          margin: EdgeInsets.symmetric(
              horizontal: Utils.getDeviceWidth(context) / 12),
          child: ListView(
            children: <Widget>[
              Container(
                height: Injector.isBusinessMode ? 35 : 30,
                margin: EdgeInsets.only(top: 15, left: 50, right: 50),
                alignment: Alignment.center,
                child: Text(
                  Utils.getText(context, StringRes.settings),
                  style: TextStyle(
                      color: ColorRes.white, fontSize: 17, letterSpacing: 0.5),
                ),
                decoration: BoxDecoration(
                    color:
                        Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
                    borderRadius: Injector.isBusinessMode
                        ? null
                        : BorderRadius.circular(20),
                    image: Injector.isBusinessMode
                        ? DecorationImage(
                            image: AssetImage(Utils.getAssetsImg('bg_setting')))
                        : null),
              ),
              Container(
                height: 30,
                margin: EdgeInsets.only(top: 15, bottom: 10),
                alignment: Alignment.center,
                child: Text(
                  Utils.getText(context, StringRes.privacyPolicy),
                  style: TextStyle(
                    color: ColorRes.white,
                    fontSize: 15,
                  ),
                ),
                decoration: BoxDecoration(
                    color: Injector.isBusinessMode ? null : ColorRes.bgSettings,
                    borderRadius: Injector.isBusinessMode
                        ? null
                        : BorderRadius.circular(20),
                    image: Injector.isBusinessMode
                        ? DecorationImage(
                            image: AssetImage(Utils.getAssetsImg('bg_privacy')))
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
                    color: Injector.isBusinessMode ? null : ColorRes.bgSettings,
                    borderRadius: Injector.isBusinessMode
                        ? null
                        : BorderRadius.circular(20),
                    image: Injector.isBusinessMode
                        ? DecorationImage(
                            image: AssetImage(Utils.getAssetsImg('bg_privacy')))
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
                    color: Injector.isBusinessMode ? null : ColorRes.bgSettings,
                    borderRadius: Injector.isBusinessMode
                        ? null
                        : BorderRadius.circular(20),
                    image: Injector.isBusinessMode
                        ? DecorationImage(
                            image: AssetImage(Utils.getAssetsImg('bg_privacy')))
                        : null),
              ),
              InkResponse(
                child: Container(
                  height: 35,
                  margin: EdgeInsets.only(top: 15),
                  padding: EdgeInsets.only(left: 8, right: 8),
                  alignment: Alignment.center,
                  child: Text(
                    Utils.getText(
                        context,
                        Injector.isBusinessMode
                            ? StringRes.switchProfMode
                            : StringRes.switchBusinessMode),
                    style: TextStyle(
                        color: ColorRes.white,
                        fontSize: 15,
                        letterSpacing: 0.7),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              Utils.getAssetsImg('bg_switch_to_prfsnl')),
                          fit: BoxFit.fill)),
                ),
                onTap: () async {
                  if (Injector.isBusinessMode)
                    await Injector.prefs
                        .setInt(PrefKeys.mode, Const.professionalMode);
                  else
                    await Injector.prefs
                        .setInt(PrefKeys.mode, Const.businessMode);
                  setState(() {
                    Injector.isBusinessMode = !Injector.isBusinessMode;
                  });

                  _notifier.notify('changeMode', 'Sending data from notfier!');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
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
                          image: AssetImage(Utils.getAssetsImg('bg_log_out')))),
                ),
                onTap: logout,

              )
            ],
          ),
        ),
      ),
    );
  }

  logout() async {
    setState(() {
      isLoading = true;
    });

    LogoutRequest rq = LogoutRequest();
    rq.userId = Injector.userData.userId;
    rq.deviceToken = Injector.userData.accessToken;
    rq.deviceType = Const.deviceType;

    WebApi().logout(rq.toJson()).then((data) async {
      setState(() {
        isLoading = false;
      });

      if (data != null) {
        if (data.flag == "true") {
          await Injector.prefs.clear();

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
              ModalRoute.withName("/home"));
        } else {
          Utils.showToast(data.msg);
        }
      }
    });
  }

  showTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: <Widget>[
          InkResponse(
            child: Image(
              image: AssetImage(Utils.getAssetsImg("back")),
              width: 35,
            ),
            onTap: () {
              Utils.performBack(context);
            },
          ),
          Center(
            child: Container(
              alignment: Alignment.center,
              height: Utils.getTitleHeight(),
              margin: EdgeInsets.only(left: 90, right: 90, top: 2),
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
                textAlign: TextAlign.center,
              ),
            ),
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
                          ? NetworkImage(photoUrl)
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
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        Utils.getAssetsImg("bg_name_email")),
                                    fit: BoxFit.fill),
                              ),
                              child: TextField(
                                controller: nameController,
                                obscureText: false,
                                style: TextStyle(
                                  color: ColorRes.white,
                                  fontSize: 13,
                                ),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "xxxx xxxx",
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
                              padding: EdgeInsets.symmetric(horizontal: 20),
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
                                    hintText: Injector.userData.email,
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: InkResponse(
                    child: Container(
                      height: 35,
                      alignment: Alignment.center,
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
                      Utils.showChangePasswordDialog(_scaffoldKey, true);
                    },
                  ),
                ),
                SizedBox(
                  width: 30,
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
    var tempImage = await ImagePicker.pickImage(
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

  void showPhotoOptionDialog(BuildContext mainContext) {
    // flutter defined function
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
                  child: Text("Choose photo"),
                  alignment: Alignment.center,
                ),
                onTap: () {
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
                  child: Text("Take photo"),
                  alignment: Alignment.center,
                ),
                onTap: () async {
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
    var req = {
      'userId': Injector.userData.userId,
      'name': nameController.text.trim(),
      'profileImage': ""
    };

    setState(() {
      isLoading = true;
    });

    WebApi().updateProfile(req, _image).then((data) async {
      setState(() {
        isLoading = false;
      });

      if (data != null) {
        if (data.flag == "true") {
          data.data.accessToken = Injector.userData.accessToken;

          await Injector.prefs
              .setString(PrefKeys.user, json.encode(data.data.toJson()));

          Injector.userData = data.data;

          Utils.showToast("Profile updated successfully!");

          if (_image != null) {
            _notifier.notify('changeMode', 'Sending data from notfier!');
          }
        }
      } else {
        Utils.showToast("Something went wrong.");
      }
    });
  }
}
