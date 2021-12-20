import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ke_employee/commonview/header.dart';
import 'package:ke_employee/helper/ResponsiveUi.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';

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
  final GestureDragCancelCallback onTapSecondBtn;

  final bool menuView;
  final bool secondBtn;

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
      @required this.menuView,
      this.secondBtn,
      this.onTapSecondBtn});

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
                top: widget.cardMoveBottom != null ? size.height / widget.cardMoveBottom : null,
                right: widget.cardMoveLeft != null ? size.width / widget.cardMoveLeft : null,
                child: Align(
                  alignment: widget.cardAlignment != null ? widget.cardAlignment : Alignment.center,
                  child: Container(
//                    height: widget.cardHeight != null
//                        ? size.height / widget.cardHeight
//                        : size.height / 1.6,
//                    width: widget.cardWidth != null
//                        ? size.width / widget.cardWidth
//                        : size.width / 1.4,
                    margin: EdgeInsets.symmetric(horizontal: size.width / 8, vertical: size.height / 7),
                    padding: EdgeInsets.only(
                      top: size.height / 30.7,
                      bottom: size.height / 30.7,
                    ),
                    decoration: BoxDecoration(border: Border.all(), color: Colors.white, borderRadius: BorderRadius.circular(size.width / 25.7)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: Utils.getDeviceWidth(context) / 80),
                        Text(widget.titleText,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline6.copyWith(color: ColorRes.black, fontWeight: FontWeight.w800)),
                        SizedBox(height: Utils.getDeviceWidth(context) / 60),
                        widget.desTextLine != null && widget.desTextLine.isNotEmpty
                            ? Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: Injector.isBusinessMode ? getPaddingByImage() : size.height / 30.7, left: size.height / 30.7),
                                        child: Text(widget.desTextLine,
                                            textAlign: TextAlign.start,
                                            maxLines: null,
                                            style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 17)),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                        SizedBox(height: Utils.getDeviceWidth(context) / 60),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            showSecondButton(size),
                            showMainButton(size),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              widget.imageName != null && Injector.isBusinessMode
                  ? Positioned(
                      right: size.width / getImageRightMargin(),
                      bottom: size.height / getImageBottomMargin(),
                      child: Container(
                        child: Image.asset(
                          Utils.getAssetsImg(widget.imageName),
//                            height: widget.imageHeight != null
//                                ? size.height / widget.imageHeight
//                                : size.height / 1.85,
                          width:
                              /* widget.imageWidth != null
                              ? size.height / widget.imageWidth
                              :*/
                              size.width / 4.2,
                        ),
                      ))
                  : Container()
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
                  alignment: widget.cardAlignment != null ? widget.cardAlignment : Alignment.center,
                  child: Container(
                    height: size.height / 1.9,
                    width: size.width / 1.7,
                    padding: EdgeInsets.all(size.height / 30.7),
                    decoration: BoxDecoration(border: Border.all(), color: Colors.white, borderRadius: BorderRadius.circular(size.width / 25.7)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: Utils.getDeviceWidth(context) / 80),
                        Text(widget.titleText,
                            textAlign: TextAlign.center, style: TextStyle(fontSize: Utils.getDeviceWidth(context) / 45, fontWeight: FontWeight.bold)),
                        SizedBox(height: Utils.getDeviceWidth(context) / 60),
                        widget.desTextLine != null && widget.desTextLine.isNotEmpty
                            ? Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Text(widget.desTextLine,
                                      maxLines: null, textAlign: TextAlign.start, style: TextStyle(fontSize: size.width / 50.5)),
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
                                  color: widget.btnColor != null ? widget.btnColor : Colors.grey,
                                  border: Border.all(color: ColorRes.header, width: 1),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                //  child: Text("",
                                child: Text(widget.btnName, style: TextStyle(fontSize: size.width / 46.5, color: ColorRes.white)),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  right: widget.imageMoveRight != null ? size.width / widget.imageMoveRight : size.width / 9.0,
                  bottom: widget.imageMoveTop != null ? size.height / widget.imageMoveTop : size.height / 5.3,
                  child: Image.asset(Utils.getAssetsImg(widget.imageName),
                      height: widget.imageHeight != null ? size.height / widget.imageHeight : size.height / 1.85,
                      width: widget.imageWidth != null ? size.height / widget.imageWidth : size.width / 4.5,
                      fit: BoxFit.contain)),
              Positioned(
                bottom: Utils.getDeviceWidth(context) / 60,
                right: Utils.getDeviceWidth(context) / 60,
                child: Container(
                  height: Utils.getDeviceWidth(context) / 20,
                  width: Utils.getDeviceWidth(context) / 5,
                  decoration: BoxDecoration(
                      color: ColorRes.blue, border: Border.all(color: ColorRes.header, width: 2), borderRadius: BorderRadius.circular(5)),
                  padding: EdgeInsets.all(Utils.getDeviceWidth(context) / 100),
                  child: Center(
                    child: Text(
                      Utils.getText(context, StringRes.skipTutorial),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: ColorRes.white, fontWeight: FontWeight.w800, fontSize: Utils.getDeviceWidth(context) / 45),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.amber,
                margin: EdgeInsets.all(15),
                child: HeaderView(scaffoldKey: _scaffoldKey, isShowMenu: true),
              ),
            ],
          );
        },
      ),
    );
  }

  getPaddingByImage() {
    switch (widget.imageName) {
      case "hr_niki":
        return 50.0;
      case "tina":
        return 100.0;
      case "bob":
        return 60.0;
      case "john":
        return 70.0;
      case "will":
        return 50.0;
      case "akiko":
        return 100.0;
      case "li_wei":
        return 60.0;
      case "lydia":
        return 60.0;
      default:
        return 50.0;
    }
  }

  num getImageRightMargin() {
    switch (widget.imageName) {
      case "hr_niki":
        return 20.0;
      case "tina":
        return 18.0;
      case "bob":
        return 32.0;
      case "john":
        return 38.0;
      case "will":
        return 20.0;
      case "akiko":
        return 15.0;
      case "li_wei":
        return 26.0;
      case "lydia":
        return 26.0;
      default:
        return 50.0;
    }
  }

  num getImageBottomMargin() {
    switch (widget.imageName) {
      case "hr_niki":
        return 10.0;
      case "tina":
        return 7.0;
      case "bob":
        return 10.0;
      case "john":
        return 11.0;
      case "will":
        return 7.0;
      case "akiko":
        return 7.0;
      case "li_wei":
        return 7.0;
      case "lydia":
        return 7.0;
      default:
        return 50.0;
    }
  }

  showSecondButton(Size size) {
    return widget.secondBtn != null && widget.secondBtn
        ? GestureDetector(
            onTap: widget.onTapSecondBtn,
            child: Container(
                width: size.width / 3.5,
                margin: EdgeInsets.symmetric(horizontal: 5),
                padding: EdgeInsets.symmetric(vertical: 2),
                decoration:
                    BoxDecoration(color: Colors.grey, border: Border.all(color: ColorRes.header, width: 1), borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Text(Utils.getText(context, StringRes.updateLatter),
                      style: Theme.of(context).textTheme.bodyText1.copyWith(color: ColorRes.white)),
                )),
          )
        : Container();
  }

  showMainButton(Size size) {
    return GestureDetector(
      onTap: widget.onTapBtn,
      child: Container(
          width: size.width / 3.2,
          margin: EdgeInsets.symmetric(horizontal: 5),
          padding: EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(
              color: widget.btnColor != null ? widget.btnColor : Colors.grey,
              border: Border.all(color: ColorRes.header, width: 1),
              borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: Text(widget.btnName != null ? widget.btnName : "", style: Theme.of(context).textTheme.bodyText1.copyWith(color: ColorRes.white)),
          )),
    );
  }
}
