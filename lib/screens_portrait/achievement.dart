import 'package:flutter/material.dart';
import 'package:ke_employee/baseController/base_textfield.dart';
import 'package:ke_employee/commonview/common_views.dart';
import 'package:ke_employee/commonview/team_listing_item_view.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/manager/screens_manager.dart';
import 'package:ke_employee/manager/theme_manager.dart';
import 'package:ke_employee/routes/custom_router.dart';
import 'package:ke_employee/routes/route_names.dart';

class AchievementPortrait extends StatefulWidget {
  @override
  _AchievementPortraitState createState() => _AchievementPortraitState();
}

class _AchievementPortraitState extends State<AchievementPortrait> {

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(44.0),
          child: AppBar(
            elevation: 0,
            title: Text("Achievement", style: TextStyle(color: ThemeManager().getTextColor(), fontSize: 17)),
            leading: IconButton(icon: Icon(Icons.arrow_back, size: 24, color: ThemeManager().getTextColor()), onPressed: (){Navigator.of(context).pop();}),
          )),
      body: Container(
        color: ThemeManager().getStaticGradientColor(),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                showSearchField(),
                Show3ListingTitles(title1: "Achievements", title2: "Level", title3: "K-points"),
                showAchievementData()
              ],
            ),
//            this.customDropdown(),
          ],
        ),
      ),
    );
  }

  showSearchField() {
    return Container(
      padding: EdgeInsets.only(right: 10, left: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 25,
            width: Utils.getDeviceWidth(context) * 0.7,
            child: SearchTextField(
                hintText: "Search",
                controller: searchController,
                fillColor: ThemeManager().getStaticGradientColor(),
                validator: (value){
                  return null;
                }),
          )
        ],
      ),
    );
  }

  showAchievementData(){
    return Expanded(
        child: Container(
          color: ThemeManager().getBgGradientLight(),
          child: Column(
            children: [
              Divider(height: 1),
              Expanded(
                  child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (context, index){
                        return showItem(index);
                      }))
            ],
          ),
        )
    );
  }

  showItem(int index) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(CustomRouter.getRoute(name: achievementDetailRoute));
      },
      child: TeamListingItemView(index: index, isSecondText: false),
    );
  }

}
