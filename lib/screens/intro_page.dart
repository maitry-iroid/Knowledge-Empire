import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/screens/help_screen.dart';
import 'package:ke_employee/screens/home.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final List<String> imgList = [
    Utils.getAssetsImgJpg("001"),
    Utils.getAssetsImgJpg("002"),
    Utils.getAssetsImgJpg("003"),
    Utils.getAssetsImgJpg("004"),
    Utils.getAssetsImgJpg("005"),
    Utils.getAssetsImgJpg("006"),
    Utils.getAssetsImgJpg("007"),
    Utils.getAssetsImgJpg("008"),
    Utils.getAssetsImgJpg("009"),
    Utils.getAssetsImgJpg("010"),
    Utils.getAssetsImgJpg("011"),
    Utils.getAssetsImgJpg("012"),
    Utils.getAssetsImgJpg("013"),
    Utils.getAssetsImgJpg("013"),
    Utils.getAssetsImgJpg("014"),
    Utils.getAssetsImgJpg("015"),
    Utils.getAssetsImgJpg("016"),
    Utils.getAssetsImgJpg("017"),
    Utils.getAssetsImgJpg("018"),
    Utils.getAssetsImgJpg("019"),
    Utils.getAssetsImgJpg("020"),
    Utils.getAssetsImgJpg("021"),
    Utils.getAssetsImgJpg("022"),
    Utils.getAssetsImgJpg("023"),
    Utils.getAssetsImgJpg("024"),
    Utils.getAssetsImgJpg("025"),
    Utils.getAssetsImgJpg("026"),
    Utils.getAssetsImgJpg("027"),
    Utils.getAssetsImgJpg("028"),
    Utils.getAssetsImgJpg("029"),
  ];

  int index;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorRes.black,
        body: buttonDemo(),
      ),
    );
  }

  Widget buttonDemo() {
    final basicSlider = CarouselSlider(
      items: imgList.map(
        (url) {
          return ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Image.asset(
              url,
              fit: BoxFit.contain,
              width: Utils.getDeviceWidth(context),
            ),
          );
        },
      ).toList(),
      autoPlay: false,
      enlargeCenterPage: false,
      viewportFraction: 1.0,
      aspectRatio: 1.0,
      initialPage: 0,
      reverse: false,
      enableInfiniteScroll: false,
      height: Utils.getDeviceHeight(context),
      onPageChanged: (index) {
        this.index = index;
      },
    );
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        basicSlider,
        Row(children: [
          InkResponse(
              onTap: () {
                basicSlider.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.linear);
              },
              child: Image.asset(Utils.getAssetsImg("previus"),
                  width: 70, height: 70)),
          Spacer(),
          InkResponse(
              onTap: () {
                basicSlider.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.linear);
                if (index == imgList.length - 1) {


                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (BuildContext context) => HomePage()),
                      ModalRoute.withName('/'));

                  /*Navigator.pushAndRemoveUntil(
                      context, FadeRouteIntro(), ModalRoute.withName("/home"));*/
                }
              },
              child: Image.asset(Utils.getAssetsImg("next"),
                  width: 70, height: 70)),
        ]),
//        Positioned(
//          right: 10,
//          bottom: 10,
//          child: showSubscribeView(),
//        )
      ],
    );
  }

  showSubscribeView() {
    return InkResponse(
        child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 50),
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Utils.getAssetsImg("bg_subscribe")),
                    fit: BoxFit.fill)),
            child: Text(
              Utils.getText(context, StringRes.skipTutorial),
              style: TextStyle(color: ColorRes.white, fontSize: 17),
              textAlign: TextAlign.center,
            )),
        onTap: () {
          Utils.playClickSound();

        });
  }
}
