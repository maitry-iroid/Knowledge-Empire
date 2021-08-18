import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/manager/encryption_manager.dart';
import 'package:ke_employee/models/update_profile.dart';
import 'package:ke_employee/screens/home.dart';

class NickNameDialog extends StatefulWidget {
  NickNameDialog({
    Key key,
    this.isFromProfile,
  }) : super(key: key);

  final bool isFromProfile;

  @override
  NickNameDialogState createState() => new NickNameDialogState();
}

class NickNameDialogState extends State<NickNameDialog> {
  final nickNameController = TextEditingController();
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
                                controller: nickNameController,
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                style: TextStyle(fontSize: 14, color: ColorRes.white),
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                    hintText: Utils.getText(context, StringRes.newNickName),
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
    if (nickNameController.text.trim().isEmpty) {
      Utils.showToast(Utils.getText(context, StringRes.enterNickName));
      return;
    }

    if (mounted)
      setState(() {
        isLoading = true;
      });

    UpdateProfileRequest rq = UpdateProfileRequest();
    rq.userId = Injector.userData.userId.toString();
    rq.nickName = await EncryptionManager().stringEncryption(nickNameController.text);

    WebApi().callAPI(WebApi.rqUpdateProfile, rq.toJson()).then((data) {
      if (mounted)
        setState(() {
          isLoading = false;
        });

      if (data != null) {
        Utils.showToast(Utils.getText(context, StringRes.nicknameChange));
        Injector.isNickNameChange = true;

        if (widget.isFromProfile) {
          Navigator.pop(context);
        } else {
          print("Navigate to dashboard nickname--------------------------------------------------------");
          Navigator.pushAndRemoveUntil(context, FadeRouteHome(), ModalRoute.withName("/login"));
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
