import 'package:flutter/material.dart';
import 'package:knowledge_empire/helper/Utils.dart';
import 'package:knowledge_empire/helper/res.dart';
import 'package:knowledge_empire/manager/theme_manager.dart';

class RewardsListingItemView extends StatelessWidget {
  final int index;
  RewardsListingItemView({this.index});

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
                  border: Border.all(color: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity1()), width: 0.5)),
              child: Image.asset(Utils.getAssetsImg("book"), height: Utils.getDeviceHeight(context) * 0.11)),
          SizedBox(width: 10),
          Text("Finance", style: TextStyle(color: ThemeManager().getDarkColor(), fontSize: 15)),
        ],
      ),
    ));
  }

  showRightView(BuildContext context) {
    return Container(
      width: Utils.getDeviceWidth(context) * 0.30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
              child: Container(
            child: Text("850 kpt", textAlign: TextAlign.center, style: TextStyle(color: ThemeManager().getDarkColor(), fontSize: 15)),
          )),
        ],
      ),
    );
  }
}
