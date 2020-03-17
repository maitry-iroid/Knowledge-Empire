import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/screens/help_screen.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
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
            child: Image.network(
              url,
              fit: BoxFit.fill,
              width: Utils.getDeviceWidth(context),
            ),
          );
        },
      ).toList(),
      autoPlay: false,
      enlargeCenterPage: false,
      viewportFraction: 1.0,
      aspectRatio: 1.0,
      initialPage: 2,
      reverse: false,
      enableInfiniteScroll: false,
      height: Utils.getDeviceHeight(context),
      onPageChanged: (index) {
        this.index=index;
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
                if (index == imgList.length-1) {
                  Navigator.pushAndRemoveUntil(
                      context, FadeRouteIntro(), ModalRoute.withName("/home"));
                }
              },
              child: Image.asset(Utils.getAssetsImg("next"),
                  width: 70, height: 70)),
        ]),
      ],
    );
  }
}
