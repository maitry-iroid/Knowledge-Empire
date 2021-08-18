import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/injection/dependency_injection.dart';

class MyHomePage extends StatefulWidget {
  final bool isCoinViseble;

  const MyHomePage({Key key, this.isCoinViseble}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation flipAnim;
  bool startAnim = false;
  Timer timer;

  @override
  void initState() {
    super.initState();
    if (widget.isCoinViseble) {
      controller = AnimationController(duration: Duration(milliseconds: 61100), vsync: this);
      flipAnim = Tween(begin: 0.0, end: 100.0).animate(CurvedAnimation(parent: controller, curve: Interval(0.0, 0.5, curve: Curves.linear)));
      controller.forward();
    } else {
      if (controller != null) {
        controller.dispose();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Container(
            height: 40.0,
            width: 40.0,
            color: Colors.transparent,
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.005)
                ..rotateY(2 * pi * flipAnim.value),
              alignment: Alignment.center,
              child: Image.asset(
                Utils.getAssetsImg(Injector.isBusinessMode ? "ic_dollar" : "brain"),
                height: 25,
                width: 25,
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
