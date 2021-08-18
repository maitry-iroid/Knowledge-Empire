import 'package:flutter/material.dart';
import 'package:knowledge_empire/helper/Utils.dart';
import 'package:knowledge_empire/helper/res.dart';
import 'package:knowledge_empire/manager/theme_manager.dart';

class AchievementLevelDetailView extends StatelessWidget {
  final int index;
  AchievementLevelDetailView({this.index});

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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
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
              Container(
                padding: EdgeInsets.only(top: 2, bottom: 5),
                height: Utils.getDeviceHeight(context) * 0.11,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text("Details", style: TextStyle(color: ThemeManager().getDarkColor(), fontSize: 15)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("10,000 Knowledge points", style: TextStyle(color: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity1()), fontSize: 12)),
                        SizedBox(height: 2),
                        Text("Subscribe to 5 Modules", style: TextStyle(color: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity1()), fontSize: 12))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

}
