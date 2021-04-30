import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/manager/theme_manager.dart';

class Show3ListingTitles extends StatelessWidget {
  final String title1;
  final String title2;
  final String title3;
  Show3ListingTitles({this.title1, this.title2, this.title3});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(title1, style: TextStyle(color: ThemeManager().getDarkColor(), fontSize: 13)),
          Container(
            width: Utils.getDeviceWidth(context) * 0.40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    child: Text(title2, textAlign: TextAlign.center, style: TextStyle(color: ThemeManager().getDarkColor(), fontSize: 13)),
                  ),
                ),
                Expanded(
                    child: Container(
                      child:  Text(title3, textAlign: TextAlign.center, style: TextStyle(color: ThemeManager().getDarkColor(), fontSize: 13)),
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

class Show2ListingTitles extends StatelessWidget {
  final String title1;
  final String title2;
  Show2ListingTitles({this.title1, this.title2});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(title1, style: TextStyle(color: ThemeManager().getDarkColor(), fontSize: 13)),
          Container(
            width: Utils.getDeviceWidth(context) * 0.30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    child: Text(title2, textAlign: TextAlign.center, style: TextStyle(color: ThemeManager().getDarkColor(), fontSize: 13)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ShowBottomSheetChallengeTitles extends StatelessWidget {
  final String title1;
  final String title2;
  final String title3;
  ShowBottomSheetChallengeTitles({this.title1, this.title2, this.title3});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(title1, style: TextStyle(color: ThemeManager().getDarkColor(), fontSize: 13)),
          Container(
            width: Utils.getDeviceWidth(context) * 0.50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    child: Text(title2, textAlign: TextAlign.center, style: TextStyle(color: ThemeManager().getDarkColor(), fontSize: 13)),
                  ),
                ),
                Expanded(
                  flex: 2,
                    child: Container(
                      child:  Text(title3, textAlign: TextAlign.center, style: TextStyle(color: ThemeManager().getDarkColor(), fontSize: 13)),
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

class ShowImageView extends StatelessWidget {
  final String imagePath;
  final String name;
  ShowImageView({this.imagePath, this.name});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  color: ColorRes.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity1()), width: 0.5)
              ),
              child : Image.asset(Utils.getAssetsImg("book"), height: Utils.getDeviceHeight(context) * 0.18)
          ),
          Padding(padding: EdgeInsets.all(5),
              child: Text(name, style: TextStyle(color: ThemeManager().getDarkColor(), fontSize: 16))
          )
        ],
      ),
    );
  }
}

class ShowDetailWidget extends StatelessWidget {
  final String title;
  final String value;
  ShowDetailWidget(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, style: TextStyle(color: ThemeManager().getDarkColor(), fontSize: 14)),
          Text(value, style: TextStyle(color: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity2()), fontSize: 13)),
        ],
      ),
    );
  }
}
