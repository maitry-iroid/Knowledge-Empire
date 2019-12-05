import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';

class OrgInfoDialog extends StatefulWidget {
  OrgInfoDialog({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  OrgInfoDialogState createState() => new OrgInfoDialogState();
}

class OrgInfoDialogState extends State<OrgInfoDialog> {
  final pass1Controller = TextEditingController();
  final pass2Controller = TextEditingController();
  final pass3Controller = TextEditingController();
  bool isLoading = false;

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
            width: Utils.getDeviceWidth(context) / 2.5,
            height: Utils.getDeviceHeight(context) / 2.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorRes.white,
            ),
            child: Text(
              Utils.getText(context, widget.text),
              style: TextStyle(color: ColorRes.blue, fontSize: 17),
            ),
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
}
