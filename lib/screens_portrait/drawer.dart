import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/manager/screens_manager.dart';
import 'package:ke_employee/manager/theme_manager.dart';
import 'package:ke_employee/routes/custom_router.dart';
import 'package:ke_employee/routes/route_names.dart';

class DrawerPortrait extends StatefulWidget {
  @override
  _DrawerPortraitState createState() => _DrawerPortraitState();
}

const List<DrawerItems> _drawerItems = [
  DrawerItems.profile,
  DrawerItems.learnings,
  DrawerItems.modules,
  DrawerItems.ranking,
  DrawerItems.achievements,
  DrawerItems.awards,
  DrawerItems.performance,
  DrawerItems.team,
  DrawerItems.challenges,
  DrawerItems.logout
];

class _DrawerPortraitState extends State<DrawerPortrait> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ColorRes.black.withOpacity(0.2),
          body: Stack(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Container(
                  color: ColorRes.black.withOpacity(0.2),
                ),
              ),
              Container(
                color: ThemeManager().getHeaderColor(),
                width: Utils.getDeviceWidth(context) / 1.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    this.showDrawerHeader(),
                    Divider(),
                    this.showDrawerItems()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showDrawerHeader(){
    return Container(
      height: 35,
      padding: EdgeInsets.only(left: 15),
//      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      alignment: Alignment.centerLeft,
      child: Text("Yu Hsin", style: TextStyle(color: ThemeManager().getTextColor(), fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget showDrawerItems(){
    return Expanded(
        child: Container(
          padding: EdgeInsets.only(left: 15),
          child: ListView.builder(
              itemCount: _drawerItems.length,
              itemBuilder: (context, index){
                return InkResponse(
                  onTap: (){
                    print(_drawerItems[index].title);
                    if(_drawerItems[index].bottomItem != null){
                      ScreensManager().bottomNavigationPortraitState?.selectBottomItem(_drawerItems[index].bottomItem);
                      Navigator.of(context).pop();

                      // if(_drawerItems[index].bottomItem == BottomItems.others){
                      //   ScreensManager().thirdTabNavKey.currentState.popUntil((r) => r.isFirst);
                      //   ScreensManager().thirdTabNavKey.currentState.push(CustomRouter.getRoute(name: _drawerItems[index].pageRoute));
                      // }


                    }
                  },
                  child: ListTile(
                    contentPadding: EdgeInsets.all(0),
                    dense: true,
                    title: Text(_drawerItems[index].title, style: TextStyle(color: ThemeManager().getTextColor(), fontSize: 14)),
                  ),
                );
              }
          ),
        )
    );
  }
}
