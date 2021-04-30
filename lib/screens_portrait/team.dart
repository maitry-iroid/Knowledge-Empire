import 'package:flutter/material.dart';
import 'package:ke_employee/baseController/base_textfield.dart';
import 'package:ke_employee/commonview/common_views.dart';
import 'package:ke_employee/commonview/custom_dropdown.dart';
import 'package:ke_employee/commonview/team_listing_item_view.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/manager/screens_manager.dart';
import 'package:ke_employee/manager/theme_manager.dart';
import 'package:ke_employee/routes/custom_router.dart';
import 'package:ke_employee/routes/route_names.dart';

class TeamPortrait extends StatefulWidget {
  final String title;
  TeamPortrait(this.title);

  @override
  _TeamPortraitState createState() => _TeamPortraitState();
}

class _TeamPortraitState extends State<TeamPortrait> {

  final searchController = TextEditingController();

  List<String> teamDropdownList = ["Modules(15)", "Members(34)"];

  @override
  void initState() {
    super.initState();
    CustomDropDown.dropdownList = this.teamDropdownList;
    CustomDropDown.dropdownWidth = CustomDropDown.getMaxWidth() + 20;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(44.0),
          child: AppBar(
            elevation: 0,
            title: Text(widget.title, style: TextStyle(color: ThemeManager().getTextColor(), fontSize: 17)),
            leading: IconButton(icon: Icon(Icons.arrow_back, size: 24, color: ThemeManager().getTextColor()), onPressed: (){Navigator.of(context).pop();}),
            actions: [
              CustomDropDown.dropDownSelectedItem(() {
                ScreensManager().bottomNavigationPortraitState.setState(() {
                  CustomDropDown.dropdownList = CustomDropDown.dropdownList.where((element) => element != CustomDropDown.selectedValue).toList();
                  ScreensManager().isTeamVisible = !ScreensManager().isTeamVisible;
                  ScreensManager().isTabBarVisible = !ScreensManager().isTabBarVisible;
                });
              })
            ],
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
                Show3ListingTitles(title1: "Modules", title2: "Correct", title3: "Completed"),
                showTeamData()
              ],
            ),
            CustomDropDown.dropDownList(context, (isItemSelected, selectedItemIndex) {
              if(isItemSelected == true){
                print("Selected Item :::::::::::::::::: ${CustomDropDown.dropdownList[selectedItemIndex]}");
                setState(() {
                  CustomDropDown.selectedValue = CustomDropDown.dropdownList[selectedItemIndex];
                  CustomDropDown.dropdownList = teamDropdownList;
                  ScreensManager().isTeamVisible = false;
                  ScreensManager().isTabBarVisible = false;
                });
              }else{
                setState(() {
                  ScreensManager().isTeamVisible = false;
                });
                ScreensManager().bottomNavigationPortraitState.setState(() {
                  ScreensManager().isTabBarVisible = false;
                });
              }
            })
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
        print("Tapped");
        Navigator.of(context).push(CustomRouter.getRoute(name: teamDetailRoute));
      },
      child: TeamListingItemView(index: index, isSecondText: true),
    );
  }

}
