import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/routes/route_names.dart';
import 'package:ke_employee/screens_portrait/drawer.dart';
import 'package:ke_employee/screens_portrait/module.dart';
import 'package:ke_employee/screens_portrait/other.dart';
import 'package:ke_employee/screens_portrait/profile_and_settings.dart';
import 'package:ke_employee/screens_portrait/questions.dart';

class BottomNavigationPortrait extends StatefulWidget {
  @override
  _BottomNavigationPortraitState createState() => _BottomNavigationPortraitState();
}

class _BottomNavigationPortraitState extends State<BottomNavigationPortrait> {
  int _currentIndex;
  List<Widget> _children;
  List<String> _titles;

  @override
  void initState() {
    _currentIndex = 0;
    _children = [
      QuestionsPagePortrait(),
      ModulePagePortrait(),
      OtherPagePortrait(),
      ProfileAndSettingsPagePortrait(),
    ];
    _titles = [""];
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: ColorRes.portraitThemeColor,
        middle: Text(""),
        leading: GestureDetector(
          onTap: (){
            Navigator.of(context).push(
                PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (BuildContext context, _, __) {
                      return DrawerPortrait();
                    }
                ));
          },
          child: Icon(Icons.menu, size: 24, color: ColorRes.white,),
        ),
      ),
      child : CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            backgroundColor: ColorRes.portraitThemeColor,
            activeColor: ColorRes.white,
            inactiveColor: ColorRes.whiteTransparent,
            currentIndex: _currentIndex,
            onTap: onTabTapped,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.school, size: 24),
                title: Text("Questions"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.create_new_folder, size: 24,),
                title: Text("Modules"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.format_list_bulleted, size: 24,),
                title: Text("Other"),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_box, size: 24,),
                  title: Text("Profile & Settings")),
            ],

          ),
          tabBuilder: (BuildContext context, int index) {
            return CupertinoTabView(
              builder: (BuildContext context) {
                return SafeArea(
                  top: false,
                  bottom: false,
                  child: _children[_currentIndex],
                );
              },
            );
          }
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}


class EnterExitRoute extends PageRouteBuilder {
  final Widget enterPage;
  final Widget exitPage;
  EnterExitRoute({this.exitPage, this.enterPage})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    enterPage,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        Stack(
          children: <Widget>[
            SlideTransition(
              position: new Tween<Offset>(
                begin: const Offset(0.0, 0.0),
                end: const Offset(-1.0, 0.0),
              ).animate(animation),
              child: exitPage,
            ),
            SlideTransition(
              position: new Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: enterPage,
            )
          ],
        ),
  );
}