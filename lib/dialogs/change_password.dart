import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/dashboard.dart';
import 'package:ke_employee/dashboard_new.dart' as prefix0;
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/menu_drawer.dart';

//import 'package:yoyokids/helper/constant.dart';
//import 'package:yoyokids/helper/res.dart';
//import 'package:yoyokids/helper/utils.dart';
//import 'package:yoyokids/injection/dependency_injection.dart';
//import 'package:yoyokids/models/user.dart';

class ChangePasswordDialog extends StatefulWidget {
  ChangePasswordDialog({
    Key key,
    this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  ChangePasswordDialogState createState() => new ChangePasswordDialogState();
}

class ChangePasswordDialogState extends State<ChangePasswordDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: showSetupPin(context),
    );
  }

  showSetupPin(BuildContext context) {
    final pass1Controller = TextEditingController();
    final pass2Controller = TextEditingController();
    final pass3Controller = TextEditingController();

    return Center(
      child: Container(
        height: Utils.getDeviceHeight(context),
        width: Utils.getDeviceWidth(context) / 2,
        alignment: Alignment.center,
        child: Container(
          height: Utils.getDeviceHeight(context) / 1.5,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          top: 20, left: 10, right: 10, bottom: 50),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(Utils.getAssetsImg('bg_change_pass'),),fit: BoxFit.fill),
                         ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: ListView(
                          children: <Widget>[
                            Container(
                              height: 40,
                              margin: EdgeInsets.only(left: 8, top: 20),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: ColorRes.bgTextBox,
                                  border: Border.all(
                                    color: ColorRes.white,
                                    width: 1,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: TextField(
                                controller: pass1Controller,
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                style: TextStyle(
                                    color: ColorRes.white, fontSize: 15),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Current Password',
                                    hintStyle:
                                        TextStyle(color: ColorRes.hintColor,fontSize: 15)),
                              ),
                            ),
                            Container(
                              height: 40,
                              margin: EdgeInsets.only(left: 8, top: 10),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: ColorRes.bgTextBox,
                                  border: Border.all(
                                    color: ColorRes.white,
                                    width: 1,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: TextField(
                                controller: pass2Controller,
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                style: TextStyle(
                                    color: ColorRes.white, fontSize: 15),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'New Password',
                                    hintStyle:
                                        TextStyle(color: ColorRes.hintColor,fontSize: 15)),
                              ),
                            ),
                            Container(
                              height: 40,
                              margin: EdgeInsets.only(left: 8, top: 10),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: ColorRes.bgTextBox,
                                  border: Border.all(
                                    color: ColorRes.white,
                                    width: 1,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: TextField(
                                controller: pass3Controller,
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                style: TextStyle(
                                    color: ColorRes.white, fontSize: 15),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Re-enter new Password',
                                    hintStyle:
                                        TextStyle(color: ColorRes.hintColor,fontSize: 15)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Image(
                          image: AssetImage(Utils.getAssetsImg("close_dialog")),
                          width: 20,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: InkResponse(
                          child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              margin: EdgeInsets.symmetric(horizontal: 70),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          Utils.getAssetsImg("btn_login")),
                                      fit: BoxFit.fill)),
                              child: Text(
                                "CONTINUE",
                                style: TextStyle(
                                    fontSize: 17, color: ColorRes.white),
                              )),
                          onTap: () {
                            Utils.hideKeyboard(context);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => prefix0.DashboardPage()));

                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
