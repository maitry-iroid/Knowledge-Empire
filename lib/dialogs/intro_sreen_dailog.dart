import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ke_employee/commonview/header.dart';
import 'package:ke_employee/helper/ResponsiveUi.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';

class IntroScreenDialog extends StatefulWidget {
  final String titleText, desTextLine, btnName, imageName;
  final Color btnColor;
  final double cardMoveLeft;
  final double cardMoveBottom;
  final double imageHeight;
  final double imageWidth;
  final double cardHeight;
  final double cardWidth;
  final double imageMoveRight;
  final double imageMoveTop;
  final GestureDragCancelCallback onTapBtn;

  final bool menuView;


  final AlignmentGeometry cardAlignment;

  IntroScreenDialog(
      {this.titleText,
      this.desTextLine,
      this.btnName,
      this.cardHeight,
      this.cardWidth,
      this.btnColor,
      this.cardAlignment,
      this.cardMoveLeft,
      this.cardMoveBottom,
      this.imageMoveRight,
      this.imageMoveTop,
      @required this.imageName,
      this.onTapBtn,
      this.imageHeight,
      this.imageWidth,
      @required this.menuView});

  @override
  IntroScreenDialogState createState() => new IntroScreenDialogState();
}

class IntroScreenDialogState extends State<IntroScreenDialog> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveUi(
      builder: (context, size) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              Positioned(
                top: widget.cardMoveBottom != null
                    ? size.height / widget.cardMoveBottom
                    : null,
                right: widget.cardMoveLeft != null
                    ? size.width / widget.cardMoveLeft
                    : null,
                child: Align(
                  alignment: widget.cardAlignment != null
                      ? widget.cardAlignment
                      : Alignment.center,
                  child: Container(
                    height: widget.cardHeight != null
                        ? size.height / widget.cardHeight
                        : size.height / 1.8,
                    width: widget.cardWidth != null
                        ? size.width / widget.cardWidth
                        : size.width / 1.7,
                    padding: EdgeInsets.all(size.height / 30.7),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(size.width / 25.7)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: Utils.getDeviceWidth(context) / 80),
                        Text(widget.titleText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: Utils.getDeviceWidth(context) / 45,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: Utils.getDeviceWidth(context) / 60),
                        widget.desTextLine != null &&
                                widget.desTextLine.isNotEmpty
                            ? Expanded(
                                child: Scrollbar(
                                  child: SingleChildScrollView(

                                    child: Column(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(widget.desTextLine,
                                              textAlign: TextAlign.start,
                                              maxLines: null,
                                              style:
                                                  TextStyle(fontSize: size.width / 48.5)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                        SizedBox(height: Utils.getDeviceWidth(context) / 60),
                        GestureDetector(
                          onTap: widget.onTapBtn,
                          child: Container(
                              width: size.width / 3.5,
                              height: size.height / 16,
                              decoration: BoxDecoration(
                                  color: widget.btnColor != null
                                      ? widget.btnColor
                                      : Colors.grey,
                                  border: Border.all(
                                      color: ColorRes.header, width: 1),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                //  child: Text("",
                                child: Text(Utils.getText(context, StringRes.next),
                                    style: TextStyle(
                                        fontSize: size.width / 46.5,
                                        color: ColorRes.white)),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  right: widget.imageMoveRight != null
                      ? size.width / widget.imageMoveRight
                      : size.width / 10.0,
                  bottom: widget.imageMoveTop != null
                      ? size.height / widget.imageMoveTop
                      : size.height / 5.2,
                  child: Image.asset(Utils.getAssetsImg(widget.imageName),
                      height: widget.imageHeight != null
                          ? size.height / widget.imageHeight
                          : size.height / 1.85,
                      width: widget.imageWidth != null
                          ? size.height / widget.imageWidth
                          : size.width / 4.5,
                      fit: BoxFit.contain))
            ],
          ),
        );
      },
    );
  }

  Widget fullScreenWithSkipButtonDialog() {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorRes.white.withOpacity(0.6),
      body: ResponsiveUi(
        builder: (context, size) {
          return Stack(
            children: <Widget>[
              Positioned(
                child: Align(
                  alignment: widget.cardAlignment != null
                      ? widget.cardAlignment
                      : Alignment.center,
                  child: Container(
                    height: size.height / 1.9,
                    width: size.width / 1.7,
                    padding: EdgeInsets.all(size.height / 30.7),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(size.width / 25.7)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: Utils.getDeviceWidth(context) / 80),
                        Text(widget.titleText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: Utils.getDeviceWidth(context) / 45,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: Utils.getDeviceWidth(context) / 60),
                        widget.desTextLine != null &&
                                widget.desTextLine.isNotEmpty
                            ? Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Text(widget.desTextLine,
                                      maxLines: null,
                                      textAlign: TextAlign.start, style: TextStyle(
                                          fontSize: size.width / 50.5)),
                                ),
                              )
                            : Container(),
                        SizedBox(height: Utils.getDeviceWidth(context) / 60),
                        GestureDetector(
                          onTap: widget.onTapBtn,
                          child: Container(
                              width: size.width / 3.5,
                              height: size.height / 16,
                              decoration: BoxDecoration(
                                  color: widget.btnColor != null
                                      ? widget.btnColor
                                      : Colors.grey,
                                  border: Border.all(
                                      color: ColorRes.header, width: 1),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                //  child: Text("",
                                child: Text(widget.btnName,
                                    style: TextStyle(
                                        fontSize: size.width / 46.5,
                                        color: ColorRes.white)),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  right: widget.imageMoveRight != null
                      ? size.width / widget.imageMoveRight
                      : size.width / 10.0,
                  bottom: widget.imageMoveTop != null
                      ? size.height / widget.imageMoveTop
                      : size.height / 5.2,
                  child: Image.asset(Utils.getAssetsImg(widget.imageName),
                      height: widget.imageHeight != null
                          ? size.height / widget.imageHeight
                          : size.height / 1.85,
                      width: widget.imageWidth != null
                          ? size.height / widget.imageWidth
                          : size.width / 4.5,
                      fit: BoxFit.contain)),
              Positioned(
                bottom: Utils.getDeviceWidth(context) / 60,
                right: Utils.getDeviceWidth(context) / 60,
                child: Container(
                  height: Utils.getDeviceWidth(context) / 20,
                  width: Utils.getDeviceWidth(context) / 5,
                  decoration: BoxDecoration(
                      color: ColorRes.blue,
                      border: Border.all(color: ColorRes.header, width: 2),
                      borderRadius: BorderRadius.circular(5)),
                  padding: EdgeInsets.all(Utils.getDeviceWidth(context) / 100),
                  child: Center(
                    child: Text(
                      "Skip tutorial",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: ColorRes.white,
                          fontWeight: FontWeight.w800,
                          fontSize: Utils.getDeviceWidth(context) / 45),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.amber,
                margin: EdgeInsets.all(15),
                child: HeaderView(
                  scaffoldKey: _scaffoldKey,
                  isShowMenu: true
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
