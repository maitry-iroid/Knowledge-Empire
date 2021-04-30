import 'package:flutter/material.dart';
import 'package:ke_employee/baseController/base_textfield.dart';
import 'package:ke_employee/commonview/common_views.dart';
import 'package:ke_employee/commonview/team_listing_item_view.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/manager/screens_manager.dart';
import 'package:ke_employee/manager/theme_manager.dart';

class RankingPortrait extends StatefulWidget {
  @override
  _RankingPortraitState createState() => _RankingPortraitState();
}

class _RankingPortraitState extends State<RankingPortrait> {

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(44.0),
          child: AppBar(
            elevation: 0,
            title: Text("Ranking", style: TextStyle(color: ThemeManager().getTextColor(), fontSize: 17)),
            leading: IconButton(icon: Icon(Icons.arrow_back, size: 24, color: ThemeManager().getTextColor()), onPressed: (){Navigator.of(context).pop();}),
          )),
      body: Container(
        color: ThemeManager().getStaticGradientColor(),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                showSearchField(),
                Show3ListingTitles(title1: "Member", title2: "Percentage", title3: "K-points"),
                showRankingData(),
              ],
            ),
            showStickyView()
//            this.customDropdown(),
          ],
        ),
      ),
    );
  }

  showStickyView() {
    return Positioned(
        bottom: 0,
        child: Container(
          width: Utils.getDeviceWidth(context),
          color: ThemeManager().getStaticGradientColor(),
          child: Column(
            children: [
              Divider(height: 1, thickness: 1.5),
              TeamListingItemView(isSecondText: false)
            ],
          ),
        )
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

  showRankingData(){
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
                      itemCount: 10,
                      itemBuilder: (context, index){
                        return TeamListingItemView(index: index, isSecondText: false);
                      }))
            ],
          ),
        )
    );
  }

}
