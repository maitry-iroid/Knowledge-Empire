import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/baseController/base_button.dart';
import 'package:ke_employee/commonview/common_views.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/manager/theme_manager.dart';

class RewardsDetailPortrait extends StatefulWidget {
  @override
  _RewardsDetailPortraitState createState() => _RewardsDetailPortraitState();
}

class _RewardsDetailPortraitState extends State<RewardsDetailPortrait> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(44.0),
          child: AppBar(
            elevation: 0,
            title: Text("Rewards", style: TextStyle(color: ThemeManager().getTextColor(), fontSize: 17)),
            leading: IconButton(icon: Icon(Icons.arrow_back, size: 24, color: ThemeManager().getTextColor()), onPressed: (){Navigator.of(context).pop();}),
          )),
      body: Container(
        color: ThemeManager().getStaticGradientColor(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShowImageView(imagePath: "", name: "Marco"),
            SizedBox(height: 5),
            showDescription(),
            showRewardsDetail()
          ],
        ),
      ),
    );
  }

  showDescription(){
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Utils.getText(context, StringRes.description), style: TextStyle(color: ThemeManager().getDarkColor(), fontSize: 15)),
          Container(
            padding: EdgeInsets.only(top: 5, bottom: 10),
            child: Text(Utils.getText(context, StringRes.rewardsDialogContent), maxLines: 3, style: TextStyle(color: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity3()), fontSize: 13)),
          )
        ],
      ),
    );
  }

  showRewardsDetail() {
    return Expanded(
        child: Container(
          color: ThemeManager().getBgGradientLight(),
          child: Column(
            children: [
              Divider(height: 1),
              Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ShowDetailWidget("Points needed to redeem", "1000kpt"),
                        Divider(height: 1),
                        ShowDetailWidget("Units left", "24"),
                        Divider(height: 1),
                        ShowDetailWidget("Categories", "Merchandise"),
                        SizedBox(height: 25),
                        showRedeemButton()
                      ],
                    ),
                  )
              )
            ],
          ),
        )
    );
  }

  showRedeemButton() {
    return BaseRaisedButton(
      buttonText: "Redeem",
      onPressed: (){},
      buttonColor: ThemeManager().getBgGradientLight(),
      textColor: ThemeManager().getDarkColor(),
      borderColor: ThemeManager().getDarkColor(),
    );
  }
}
