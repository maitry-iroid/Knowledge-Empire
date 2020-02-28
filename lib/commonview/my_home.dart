import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation flip_anim;
  bool startAnim = false;
  Timer timer;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: 103500), vsync: this);
    flip_anim = Tween(begin: 0.0, end: 100.0).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.0, 0.5, curve: Curves.linear)));
    controller.forward();
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
                ..rotateY(2 * pi * flip_anim.value),
              alignment: Alignment.center,
              child: Image.asset(
                Utils.getAssetsImg("coin"),
                height: 25,
                width: 25,
              ),
            ),
          );
        });
  }
}
