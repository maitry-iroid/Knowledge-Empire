import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/common_views.dart';
import 'package:ke_employee/manager/theme_manager.dart';

class PerformanceModuleDetailPortrait extends StatefulWidget {
  @override
  _PerformanceModuleDetailPortraitState createState() => _PerformanceModuleDetailPortraitState();
}

class _PerformanceModuleDetailPortraitState extends State<PerformanceModuleDetailPortrait> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(44.0),
          child: AppBar(
            elevation: 0,
            title: Text("Performance", style: TextStyle(color: ThemeManager().getTextColor(), fontSize: 17)),
            leading: IconButton(icon: Icon(Icons.arrow_back, size: 24, color: ThemeManager().getTextColor()), onPressed: (){Navigator.of(context).pop();}),
          )),
      body: Container(
        color: ThemeManager().getStaticGradientColor(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShowImageView(imagePath: "", name: "Marco"),
            SizedBox(height: 25),
            Show2ListingTitles(title1: "Score", title2: ""),
            showModuleDetail()
          ],
        ),
      ),
    );
  }

  showModuleDetail() {
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
                        ShowDetailWidget("Question answered", "78"),
                        Divider(height: 1),
                        ShowDetailWidget("Knowledge points", "7.8kpt"),
                        Divider(height: 1),
                        ShowDetailWidget("Learning modules", "15"),
                        Divider(height: 1),
                        ShowDetailWidget("Average level", "lv 4"),
                        Divider(height: 1),
                        ShowDetailWidget("Correct percentage", "65%"),
                        Divider(height: 1),
                        ShowDetailWidget("Challenges", "42/75"),
                        Divider(height: 1),
                      ],
                    ),
                  )
              )
            ],
          ),
        )
    );
  }

}
