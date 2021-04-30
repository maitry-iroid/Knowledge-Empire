import 'package:flutter/material.dart';
import 'package:ke_employee/baseController/base_textfield.dart';
import 'package:ke_employee/commonview/challenge_listing_item_view.dart';
import 'package:ke_employee/commonview/common_views.dart';
import 'package:ke_employee/dialogs/bottomsheet.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/manager/theme_manager.dart';

class ChallengePortrait extends StatefulWidget {
  @override
  _ChallengePortraitState createState() => _ChallengePortraitState();
}

class _ChallengePortraitState extends State<ChallengePortrait> {

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(44.0),
          child: AppBar(
            elevation: 0,
            title: Text("Challenges", style: TextStyle(color: ThemeManager().getTextColor(), fontSize: 17)),
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
                Show2ListingTitles(title1: "Name", title2: ""),
                showChallengeData()
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

  showChallengeData(){
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

  showItem(int index){
    return GestureDetector(
      onTap: (){
        BottomSheets.challengeBottomSheet("Challenge", ThemeManager().getDarkColor(), (selectedMode) {

        });
      },
      child: ChallengeListingItemView(index: index),
    );
  }

}
