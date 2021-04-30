import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/manager/theme_manager.dart';

class ChallengeListingItemView extends StatelessWidget {
  final int index;
  ChallengeListingItemView({this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              showLeftView(context),
              showRightView(context),
            ],
          ),
          SizedBox(height: 10),
          index == 3 ? Container() : Divider(height: 1)
        ],
      ),
    );
  }

  showLeftView(BuildContext context) {
    return Expanded(
        child: Container(
          child: Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: ColorRes.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity1()), width: 0.5)
                  ),
                  child : Image.asset(Utils.getAssetsImg("book"), height: Utils.getDeviceHeight(context) * 0.11)
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Marco Denzrl", style: TextStyle(color: ThemeManager().getDarkColor(), fontSize: 15)),
                  SizedBox(height: 2),
                  Text("+720 kpt", style: TextStyle(color: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity1()), fontSize: 12))
                ],
              )
            ],
          ),
        ));
  }

  showRightView(BuildContext context) {
    return Container(
      width: Utils.getDeviceWidth(context) * 0.25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
              child: Container(
                child:  Text("Challenge", textAlign: TextAlign.center, style: TextStyle(color: ThemeManager().getDarkColor(), fontSize: 15)),
              )
          ),
        ],
      ),
    );
  }
}

class ChallengeBottomSheetListingItemView extends StatelessWidget {
  final String module;
  final String level;
  final String correctPercentage;
  ChallengeBottomSheetListingItemView({this.module, this.level, this.correctPercentage});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(module, style: TextStyle(color: ThemeManager().getDarkColor(), fontSize: 13)),
          Container(
            width: Utils.getDeviceWidth(context) * 0.50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    child: Text(level, textAlign: TextAlign.center, style: TextStyle(color: ThemeManager().getDarkColor(), fontSize: 13)),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Container(
                      child:  Text(correctPercentage, textAlign: TextAlign.center, style: TextStyle(color: ThemeManager().getDarkColor(), fontSize: 13)),
                    )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

