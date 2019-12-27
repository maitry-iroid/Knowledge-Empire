import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/models/forgot_password.dart';
import 'package:volume/volume.dart';


int currentVol;

class FadeRouteForgotPassword extends PageRouteBuilder {
  final Widget page;
  FadeRouteForgotPassword({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        FadeTransition(
          opacity: animation,
          child: ForgotPasswordPage(),
        ),
  );
}

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({Key key}) : super(key: key);

  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
    updateVolumes();
  }

  Future<void> initPlatformState() async {
    // pass any stream as parameter as per requirement
    var hello = await Volume.controlVolume(AudioManager.STREAM_SYSTEM);
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + hello);
  }

  updateVolumes() async {
    // get Current Volume
    currentVol = await Volume.getVol;
    print(currentVol);


    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.fontDarkGrey,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage(Utils.getAssetsImg('bg_login')),
            fit: BoxFit.fill,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: Utils.getDeviceWidth(context) / 2.3,
                  height: Utils.getDeviceHeight(context) / 2,
                  margin: EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: ColorRes.colorBgDark,
                    border: Border.all(color: ColorRes.white, width: 1),
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  child: showLoginForm(),
                )),
            SafeArea(
              child: IconButton(
                icon: new Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 40,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            showCircularProgress()
          ],
        ),
      ),
    );
  }

  showLoginForm() {
    return Column(
      children: <Widget>[
        Container(
          height: 25,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorRes.borderColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9), topRight: Radius.circular(9)),
          ),
          child: Text(
            Utils.getText(context, StringRes.forgotPassword).toUpperCase(),
            style: TextStyle(color: ColorRes.white, fontSize: 17),
          ),
        ),
        Container(
          height: 1,
          color: ColorRes.white,
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: ColorRes.bgTextBox,
                    border: Border.all(
                      color: ColorRes.white,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  style: TextStyle(color: ColorRes.white, fontSize: 15),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText:
                          Utils.getText(context, StringRes.enterRegisteredEmail)
                              .toUpperCase(),
                      hintStyle: TextStyle(color: ColorRes.hintColor)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkResponse(
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: Utils.getDeviceWidth(context) / 8),
                  alignment: Alignment.center,
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: ExactAssetImage(Utils.getAssetsImg('btn_login')),
                        alignment: Alignment.topCenter,
                        fit: BoxFit.fill),
                  ),
                  child: Text(
                    Utils.getText(context, StringRes.send).toUpperCase(),
                    style: TextStyle(color: ColorRes.white, fontSize: 17),
                  ),
                ),
                onTap: validateForm,
              ),
            ],
          ),
        )
      ],
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

  validateForm() {

    if(currentVol != 0) {
      Utils.playClickSound();
    }
    if (emailController.text.isEmpty) {
      Utils.showToast("Email can't be empty.");
      return;
    }

    Utils.hideKeyboard(context);
    setState(() {
      isLoading = true;
    });

    ForgotPasswordRequest rq = ForgotPasswordRequest();
    rq.email = emailController.text.trim();

    WebApi().forgotPassword(rq.toJson()).then((data) {
      setState(() {
        isLoading = false;
      });

      if (data != null) {
        if (data.flag == "true") {
          Utils.showToast("Mail sent Successfully.");
          //alert pop
          Navigator.pop(context);
        } else {
          Utils.showToast(data.msg);
        }
      } else {
        Utils.showToast('Something went worng.');
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
