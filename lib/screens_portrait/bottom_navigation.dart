import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/home_utils.dart';
import 'package:ke_employee/manager/screens_manager.dart';
import 'package:ke_employee/manager/theme_manager.dart';

class BottomNavigationPortrait extends StatefulWidget {
  @override
  BottomNavigationPortraitState createState() => BottomNavigationPortraitState();
}

class BottomNavigationPortraitState extends State<BottomNavigationPortrait> {

  final CupertinoTabController _controller = CupertinoTabController();
  GlobalKey _kTabBarHeight = GlobalKey();
  double tabBarHeight = 0;

  int currentIndex;
  List<BottomItems> _children;
  List<GlobalKey<NavigatorState>> navKeyList;

  @override
  void initState() {
    currentIndex = 0;
    _children = [
      BottomItems.questions,
      BottomItems.modules,
      BottomItems.others,
      BottomItems.profileAndSettings
    ];
    navKeyList = [
      ScreensManager().firstTabNavKey,
      ScreensManager().secondTabNavKey,
      ScreensManager().thirdTabNavKey,
      ScreensManager().forthTabNavKey
    ];
    super.initState();

    HomeUtils.initHome(context);
    ScreensManager().bottomNavigationPortraitState = this;
//    ThemeManager().getAppThemeColorsFromPrefs();
    ThemeManager().getAppThemeColors(() {
      setState(() {});
    });
  }

  _getSizes() {
    final RenderBox renderBoxRed = _kTabBarHeight.currentContext.findRenderObject();
    setState(() {
      this.tabBarHeight = renderBoxRed.size.height;
      ScreensManager().isTabBarVisible = false;
    });
    print("SIZE of _kTabBarHeight: $tabBarHeight");
  }


  @override
  void didUpdateWidget(BottomNavigationPortrait oldWidget) {
    // TODO: implement didUpdateWidget
    this._getSizes();
    super.didUpdateWidget(oldWidget);
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CupertinoTabScaffold(
            controller: _controller,
            tabBar: CupertinoTabBar(
              key: _kTabBarHeight,
              backgroundColor: ThemeManager().getFooterColor(),
              activeColor: ThemeManager().getTextColor(),
              inactiveColor: ThemeManager().getTextColor().withOpacity(ThemeManager().getOpacity3()),
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
                navigatorKey: navKeyList[index],
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
        Visibility(
            visible: ScreensManager().isTabBarVisible,
            child: Positioned(
              bottom: 0,
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      ScreensManager().isTabBarVisible = false;
                      ScreensManager().isTeamVisible = false;
                    });
                  },
                  child: Container(
                    height: tabBarHeight,
                    width: Utils.getDeviceWidth(context),
                    color: Colors.black.withOpacity(0.4),
                  ),
                )))
      ],
    );
  }

  void onTabTapped(int index) {
    setState(() {
      if(index == currentIndex){
        navKeyList[index].currentState.popUntil((r) => r.isFirst);
      }
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