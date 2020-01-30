import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/models/organization.dart';
import 'package:ke_employee/screens/organization2.dart';


/*class OrgInfoDialog extends StatefulWidget {
  OrgInfoDialog({
    Key key,
    this.text,
    this.organizationsPage2
  }) : super(key: key);

  final String text;
  final _OrganizationsPage2State organizationsPage2;


  @override
  OrgInfoDialogState createState() => new OrgInfoDialogState();
}

class OrgInfoDialogState extends State<OrgInfoDialog> {
  final pass1Controller = TextEditingController();
  final pass2Controller = TextEditingController();
  final pass3Controller = TextEditingController();
  bool isLoading = false;

  List<Organization> arrOrganization = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: showBody(context),
    );
  }


  showBody(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(40),
              alignment: Alignment.center,
              width: Utils.getDeviceWidth(context) / 2.0,
              height: Utils.getDeviceHeight(context) / 2.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorRes.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        Utils.getText(context, widget.text),
                        style: TextStyle(color: ColorRes.blue, fontSize: 17),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 13)),
                    InkResponse(
                      child: InkResponse(
                        child: Container(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                              border: Border.all(width: 2, color: ColorRes.blue),
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          child: Text('Fire 10 employees',
                              style: TextStyle(color: ColorRes.blue, fontSize: 17)),
                        ),
                        onTap: () {

                        },
                      ),
                    ),
//                      showTextEmp("Fire 10 employees", "minus", 1)),
                    Padding(padding: EdgeInsets.only(top: 8)),
                    InkResponse(
                      child: InkResponse(
                        child: Container(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                              border: Border.all(width: 2, color: ColorRes.blue),
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          child: Text('Hire 10 employees',
                              style: TextStyle(color: ColorRes.blue, fontSize: 17)),
                        ),
                        onTap: () {

                        },
                      ),
                    ),
//                  Container(child: showTextEmp("Hire 10 employees", "plus", 2)),
                    Padding(padding: EdgeInsets.only(top: 12)),
                    InkResponse(
                      child: Container(
                        child: Text("Cancel",
                            style: TextStyle(color: ColorRes.blue, fontSize: 17)),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              )
          ),
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
                  Navigator.pop(context);
                },
              ))
        ],
      ),
    );
  }
}*/
