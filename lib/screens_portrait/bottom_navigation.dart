import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/manager/screens_manager.dart';
import 'package:ke_employee/screens_portrait/drawer.dart';

class BottomNavigationPortrait extends StatefulWidget {
  @override
  BottomNavigationPortraitState createState() => BottomNavigationPortraitState();
}

class BottomNavigationPortraitState extends State<BottomNavigationPortrait> {
  final CupertinoTabController _controller = CupertinoTabController();

  int currentIndex;
  List<BottomItems> _children;

  @override
  void initState() {
    currentIndex = 0;
    _children = [
      BottomItems.questions,
      BottomItems.modules,
      BottomItems.others,
      BottomItems.profileAndSettings
    ];
    super.initState();
    ScreensManager().bottomNavigationPortraitState = this;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: ColorRes.portraitThemeColor,
        middle: Text(_children[currentIndex].title, style: TextStyle(color: ColorRes.white)),
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
          child: Icon(Icons.menu, size: 24, color: ColorRes.white),
        ),
      ),
      child : CupertinoTabScaffold(
          controller: _controller,
          tabBar: CupertinoTabBar(
            backgroundColor: ColorRes.portraitThemeColor,
            activeColor: ColorRes.white,
            inactiveColor: ColorRes.whiteTransparent,
            currentIndex: currentIndex,
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
                  child: _children[currentIndex].page,
                );
              },
            );
          }
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
      _controller.index = index;
    });
  }

  void selectBottomItem(BottomItems bottomItem) {
    int index =  _children.indexOf(bottomItem);
    this.onTabTapped(index);
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