import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/common_views.dart';
import 'package:ke_employee/commonview/team_listing_item_view.dart';
import 'package:ke_employee/manager/theme_manager.dart';

class TeamDetailPortrait extends StatefulWidget {
  @override
  _TeamDetailPortraitState createState() => _TeamDetailPortraitState();
}

class _TeamDetailPortraitState extends State<TeamDetailPortrait> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(44.0),
          child: AppBar(
            elevation: 0,
            title: Text("Member stats", style: TextStyle(color: ThemeManager().getTextColor(), fontSize: 17)),
            leading: IconButton(icon: Icon(Icons.arrow_back, size: 24, color: ThemeManager().getTextColor()), onPressed: (){Navigator.of(context).pop();}),
            actions: [
              new Container(
                padding: EdgeInsets.only(right: 5),
                alignment: Alignment.center,
                child: Text("Marco Denzrl", style: TextStyle(fontSize: 11)),
              ),
            ],
          )),
      body: Container(
        color: ThemeManager().getStaticGradientColor(),
        child: Column(
          children: [
            ShowImageView(imagePath: "", name: "Marco"),
            SizedBox(height: 5),
            Show3ListingTitles(title1: "Modules", title2: "Correct", title3: "Completed"),
            showTeamData()
          ],
        ),
      ),
    );
  }

  showTeamData(){
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
                        return TeamListingItemView(index: index, isSecondText: true);
                      }))
            ],
          ),
        )
    );
  }

}
