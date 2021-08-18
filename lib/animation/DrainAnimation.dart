import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';

class DrainAnimation extends StatefulWidget {
  final String icon;
  final bool visible;

  DrainAnimation({Key key, this.icon, this.visible}) : super(key: key);

  @override
  _DrainAnimationState createState() => _DrainAnimationState();
}

class _DrainAnimationState extends State<DrainAnimation> {
  bool visible = false;
  String coin = "coin";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedPositioned(
          top: 10.0,
          right: 250,
          duration: Duration(milliseconds: 4000),
          child: Container(
            width: 20.0,
            height: 20.0,
            child: AnimatedOpacity(duration: Duration(seconds: 1), opacity: 1.0, child: Image.asset(Utils.getAssetsImg(coin), width: 10, height: 10)),
          ),
        ),
        AnimatedPositioned(
          top: visible ? 50.0 : 10.0,
          right: 250,
          duration: Duration(milliseconds: visible ? 600 : 0),
          onEnd: () {
            visible = !visible;
            setState(() {});
          },
          child: Container(
            width: 20.0,
            height: 20.0,
            child: AnimatedOpacity(
                duration: Duration(milliseconds: visible ? 600 : 0),
                opacity: visible ? 0.0 : 1.0,
                child: Image.asset(Utils.getAssetsImg(coin), width: 10, height: 10)),
          ),
        ),
        RaisedButton(
          onPressed: () {
            visible = true;
            setState(() {});
          },
          child: Text("Anima"),
        ),
      ],
    );
  }
}
