import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';

class DrawerPortrait extends StatefulWidget {
  @override
  _DrawerPortraitState createState() => _DrawerPortraitState();
}

class _DrawerPortraitState extends State<DrawerPortrait> {

  static const List<String> _drawerItemTitles = ["Profile", "Learnings", "Modules", "Ranking", "Achievements", "Awards", "Performance", "Team", "Challenges", "Logout"];

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
                color: ColorRes.portraitThemeColor,
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
      child: Text("Yu Hsin", style: TextStyle(color: ColorRes.white, fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget showDrawerItems(){
    return Expanded(
        child: Container(
          padding: EdgeInsets.only(left: 15),
          child: ListView.builder(
              itemCount: _drawerItemTitles.length,
              itemBuilder: (context, index){
                return InkResponse(
                  onTap: (){
                    print(_drawerItemTitles[index]);
                  },
                  child: ListTile(
                    contentPadding: EdgeInsets.all(0),
                    dense: true,
                    title: Text(_drawerItemTitles[index], style: TextStyle(color: ColorRes.white, fontSize: 14)),
                  ),
                );
              }
          ),
        )
    );
  }
}
