import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/achievement_level_detail_view.dart';
import 'package:ke_employee/commonview/common_views.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/manager/theme_manager.dart';

class AchievementDetailPortrait extends StatefulWidget {
  @override
  _AchievementDetailPortraitState createState() => _AchievementDetailPortraitState();
}

class _AchievementDetailPortraitState extends State<AchievementDetailPortrait> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(44.0),
          child: AppBar(
            elevation: 0,
            title: Text("Collector", style: TextStyle(color: ThemeManager().getTextColor(), fontSize: 17)),
            leading: IconButton(icon: Icon(Icons.arrow_back, size: 24, color: ThemeManager().getTextColor()), onPressed: (){Navigator.of(context).pop();}),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            showTopView(),
            showAchievementLevelDetails()
          ],
        )
      ),
    );
  }

  showTopView() {
    return Container(
      padding: EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 10),
      child: Column(
        children: [
          ShowImageView(imagePath: "", name: "",),
          showLevel("Current level", "5", "5000 Kpt"),
          Divider(height: 1, thickness: 1),
          showLevel("Next level", "10", "10000 Kpt"),
        ],
      ),
    );
  }

  showLevel(String levelTitle, String noOfModule, String points) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(levelTitle, style: TextStyle(color: ThemeManager().getDarkColor(), fontWeight: FontWeight.bold)),
              SizedBox(height: 3),
              Text("Subscribed to " + noOfModule + " Module",
                  style: TextStyle(
                      color: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity3()),
                      fontSize: 13)),
            ],
          ),
          Text(points, style: TextStyle(
              color: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity3()),
              fontSize: 13)),
        ],
      ),
    );
  }

  showAchievementLevelDetails() {
    return Container(
      color: ThemeManager().getBgGradientLight(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(height: 1),
          Container(
            padding: EdgeInsets.only(top: 10, left: 10),
            child: Text("All levels", style: TextStyle(color: ThemeManager().getDarkColor(), fontWeight: FontWeight.bold)),
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              primary: false,
              itemCount: 4,
              itemBuilder: (context, index){
                return showItem(index);
              })
        ],
      ),
    );
  }

  showItem(int index) {
    return AchievementLevelDetailView(index: index);
  }
}
