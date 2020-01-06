import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/intro_screen.dart';
import 'package:ke_employee/models/bailout.dart';
import 'package:notifier/main_notifier.dart';
import 'package:notifier/notifier_provider.dart';
import 'package:volume/volume.dart';
//import 'package:volume/volume.dart';

import 'commonview/background.dart';
import 'helper/Utils.dart';
import 'helper/constant.dart';
import 'helper/prefkeys.dart';
import 'helper/res.dart';
import 'helper/string_res.dart';
import 'login.dart';
import 'models/logout.dart';

AudioManager audioManager;
int currentVol;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  FocusNode myFocusNode;

  @override
  void initState() {
    myFocusNode = FocusNode();

    nameController.text = Injector.userData.name;

    photoUrl = Injector.userData != null
        ? Injector.userData.profileImage != null
            ? Injector.userData.profileImage
            : ""
        : "";

    super.initState();

    audioManager = AudioManager.STREAM_SYSTEM;
    initPlatformState();
    updateVolumes();
  }

  //Sound Is mute
  Future<void> initPlatformState() async {
    await Volume.controlVolume(AudioManager.STREAM_SYSTEM);
//    await Volume.controlVolume(AudioManager.STREAM_MUSIC);
  }

  updateVolumes() async {
    // get Current Volume
    currentVol = await Volume.getVol;
    print("helloooo =======>>>  $currentVol");
    setState(() {});
  }

  Notifier _notifier;
  File _image;
  String photoUrl = "";

  @override
  void dispose() {
    _notifier.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _notifier = NotifierProvider.of(context);

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
          CommonView.showCircularProgress(isLoading)
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: 150,
                            height: Injector.isBusinessMode ? 35 : 30,
                            margin:
                                EdgeInsets.only(top: 15, left: 45, right: 0),
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

//                          Padding(padding: EdgeInsets.only(top: 30)),

                          InkResponse(
                            onTap: () {
                              if (currentVol != 0) {
                                Utils.playClickSound();
                              }
                              Navigator.push(context, FadeRouteIntro());

//                              Navigator.push(
//                                  context,
//                                  MaterialPageRoute(
//                                      builder: (context) => HomePage(
//                                            initialPageType: Const.typeHelp,
//                                          )));
                            },
                            child: Container(
                              height: 25,
                              width: 25,
                              margin: EdgeInsets.only(top: 15),
//                    child: Image(image: AssetImage(Utils.getAssetsImg("ic_profile_help"))),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(Injector.isBusinessMode
                                          ? Utils.getAssetsImg(
                                              "ic_profile_help")
                                          : Utils.getAssetsImg("pro_help")))),
                            ),
                          )
                        ],
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
                          if (currentVol != 0) {
                            Utils.playClickSound();
                          }

                          if (Injector.isBusinessMode)
                            await Injector.prefs
                                .setInt(PrefKeys.mode, Const.professionalMode);
                          else
                            await Injector.prefs
                                .setInt(PrefKeys.mode, Const.businessMode);
                          setState(() {
                            Injector.isBusinessMode = !Injector.isBusinessMode;
                          });

                          Injector.streamController.add("chnage mode");

//                          _notifier.notify('updateHeaderValue',
//                              'Sending data from notfier!');
//                  Navigator.pushReplacement(
//                    context,
//                    MaterialPageRoute(builder: (context) => HomePage()),
//                  );
                        },
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
                                Injector.customerValueData.manager == null ||
                                        Injector
                                            .customerValueData.manager.isEmpty
                                    ? StringRes.bailout
                                    : StringRes.requestBailOut
//
                                ),
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
                          if(currentVol != 0) {
                            Utils.playClickSound();
                          }
//                          Injector.customerValueData.manager != null || Injector.customerValueData.manager.isNotEmpty ?

                          _asyncConfirmDialog(context);
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
                                  image: AssetImage(
                                      Utils.getAssetsImg('bg_log_out')))),
                        ),
                        onTap: logout,
                      )
                    ],
                  ),
                )),
            /*  Expanded(
                flex: 1,
                child: InkResponse(
                  onTap: () {
//                      HelpPage();
//                    Navigator.push(context, MaterialPageRoute(builder: (context) => HelpPage()));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(
                              initialPageType: Const.typeHelp,
                            )));
                  },
                  child: Container(
//                    child: Image(image: AssetImage(Utils.getAssetsImg("ic_profile_help"))),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Injector.isBusinessMode ? Utils.getAssetsImg("ic_profile_help") : Utils.getAssetsImg("null"))
                        )
                    ),
                  ),
                )
            )*/
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
          title: Text('Alert', style: TextStyle(color: ColorRes.black)),
          content: const Text('Are you conform Request Bail Out.'),
          actions: <Widget>[
            FlatButton(
              child: const Text('Yes'),
              onPressed: () {
                //alert pop
                Navigator.of(context).pop();
                performBailOut();
              },
            ),
            FlatButton(
              child: const Text('No'),
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

  void performBailOut() {
    BailOutRequest rq = BailOutRequest();
    rq.userId = Injector.userData.userId;
    rq.mode = Injector.mode;

    setState(() {
      isLoading = true;
    });

    WebApi().bailOut(context, rq.toJson()).then((customerValueResponse) async {
      setState(() {
        isLoading = false;
      });

      if (customerValueResponse != null) {
        if (customerValueResponse.flag == "true") {
          if (customerValueResponse.data != null) {
            await Injector.prefs.setString(PrefKeys.customerValueData,
                json.encode(customerValueResponse.data.toJson()));

            Injector.customerValueData = customerValueResponse.data;
            Utils.showToast(
                Utils.getText(context, "Action performed successfully!"));

            Injector.streamController.add("bail out");
          }
        } else {
          Utils.showToast(Utils.getText(context, StringRes.somethingWrong));
        }
      }
    }).catchError((e) {
      print(e.toString());
      Utils.showToast(e.toString());
      setState(() {
        isLoading = false;
      });
    });
  }

  logout() async {
    if(currentVol != 0) {
      Utils.playClickSound();
    }
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
          Injector.userData = null;
          Injector.customerValueData = null;
        } else {
          Utils.showToast(data.msg);
        }
      }

      Navigator.pushAndRemoveUntil(
          context, FadeRouteLogin(), ModalRoute.withName("/home"));
    }).catchError((e) {
      print(e);
      setState(() {
        isLoading = false;
      });
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
            child: Image(
              image: AssetImage(Utils.getAssetsImg("back")),
              width: 30,
            ),
            onTap: () {

              if(currentVol != 0) {
                Utils.playClickSound();
              }
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
                                focusNode: myFocusNode,
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
                  onTap: () {
                    if(currentVol != 0) {
                      Utils.playClickSound();
                    }
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
                      if(currentVol != 0) {
                        Utils.playClickSound();
                      }
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
    if(currentVol != 0) {
      Utils.playClickSound();
    }
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
                  if(currentVol != 0) {
                    Utils.playClickSound();
                  }
                  //alert pop
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
                  if(currentVol != 0) {
                    Utils.playClickSound();
                  }
                  //alert pop
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
    if(currentVol != 0) {
      Utils.playClickSound();
    }
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

         Injector.streamController.add("update_profile");
        }
      } else {
        Utils.showToast("Something went wrong.");
      }
    }).catchError((e) {
      print(e);
      setState(() {
        isLoading = false;
      });
      Utils.showToast(e.toString());
    });
  }
}
