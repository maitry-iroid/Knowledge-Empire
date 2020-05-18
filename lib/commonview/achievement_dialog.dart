import 'package:flutter/material.dart';
import 'package:ke_employee/animation/Explostion.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/models/push_model.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ke_employee/injection/dependency_injection.dart';

class AchievementDialog extends StatefulWidget {
  final PushModel mPushModel;
  final String btnText;
  final Animation<double> a1;

  AchievementDialog({this.mPushModel, this.btnText, this.a1});

  @override
  _AchievementDialogState createState() => _AchievementDialogState();
}

class _AchievementDialogState extends State<AchievementDialog>
    with SingleTickerProviderStateMixin {

  ByteData _byteData;
  Size _imageSize;
  AnimationController _animationController;
  GlobalKey globalKey = GlobalKey();
  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this)
          ..addStatusListener(
            (AnimationStatus status) {
              if (status == AnimationStatus.completed) {
                print('completed');
              }
            },
          );

    Future.delayed(Duration(milliseconds: 500)).then((_){
      Utils.achievementSound();
      onTap();
    });

  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void onTap() {
    if (_byteData == null || _imageSize == null) {
      RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
      boundary.toImage().then((image) {
        _imageSize = Size(image.width.toDouble(), image.height.toDouble());
        image.toByteData().then((byteData) {
          _byteData = byteData;
          _animationController.value = 0;
          _animationController.forward();
          setState(() {});
        });
      });
    } else {
      _animationController.value = 0;
      _animationController.forward();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: RepaintBoundary(
          key: globalKey,
          child: Stack(
            children: <Widget>[
              AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return ExplosionRenderObjectWidget(
                      image: Injector.image,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      byteData: _byteData,
                      imageSize: _imageSize,
                      progress: _animationController.value,
                    );
                  }),
              mainLayout(context),
            ],
          ),
        ));
  }

  Widget mainLayout(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(200),
      ),
      child: Center(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 25),
          width: Utils.getDeviceWidth(context) / 2.2,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: ColorRes.fontDarkGrey,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: ColorRes.borderRewardsName)),
                    child: Text(widget.mPushModel.achievementName ?? "",
                        style: TextStyle(color: ColorRes.white, fontSize: 15)),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: Utils.getDeviceWidth(context) / 3.5,
                    height: Utils.getDeviceHeight(context) / 3.5,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                Utils.getAssetsImg("bg_collector")))),
                    child: Image.asset(imageFomType(widget.mPushModel.level),
                        fit: BoxFit.contain),
                  ),
                  SizedBox(height: 15),
                  Text("${widget.mPushModel.achievementText ?? ""}",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .body2
                          .copyWith(color: ColorRes.white, fontSize: 20)),
                  SizedBox(height: 10),
                  InkResponse(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: ColorRes.header,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: ColorRes.white)),
                      child: Text(widget.btnText,
                          style:
                              TextStyle(color: ColorRes.white, fontSize: 15)),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  imageFomType(String level) {
    switch (level) {
      case "0":
        return Utils.getAssetsImg("trophy0");
        break;
      case "1":
        return Utils.getAssetsImg("trophy1");
        break;
      case "2":
        return Utils.getAssetsImg("trophy2");
        break;
      case "3":
        return Utils.getAssetsImg("trophy3");
        break;
      case "4":
        return Utils.getAssetsImg("trophy4");
        break;
      case "5":
        return Utils.getAssetsImg("trophy5");
        break;
      case "6":
        return Utils.getAssetsImg("trophy6");
        break;
      case "7":
        return Utils.getAssetsImg("trophy7");
        break;
      case "8":
        return Utils.getAssetsImg("trophy8");
        break;
      case "9":
        return Utils.getAssetsImg("trophy9");
        break;
      case "10":
        return Utils.getAssetsImg("trophy10");
        break;
    }
  }

  Widget createItem(Widget child,
      {VoidCallback onTap, Color bgColor = Colors.transparent}) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          color: bgColor,
          child: child,
          height: 100,
          alignment: Alignment.center,
        ));
  }
}
