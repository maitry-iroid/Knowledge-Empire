import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/manager/other_manager.dart';
import 'package:ke_employee/manager/screens_manager.dart';
import 'package:ke_employee/manager/theme_manager.dart';
import 'package:ke_employee/routes/custom_router.dart';
import 'package:ke_employee/routes/route_names.dart';


class OtherPagePortrait extends StatefulWidget {
  @override
  _OtherPagePortraitState createState() => _OtherPagePortraitState();
}

class _OtherPagePortraitState extends State<OtherPagePortrait> {

  List<OtherTabOptions> otherTabList = [
    OtherTabOptions.ranking,
    OtherTabOptions.achievement,
    OtherTabOptions.awards,
    OtherTabOptions.performance,
    OtherTabOptions.team,
    OtherTabOptions.challenges,
    OtherTabOptions.history
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeManager().getBgGradientLight(),
      appBar: Utils().showAppBarWithDrawer(ScreensManager().bottomNavigationPortraitState.context, BottomItems.others),
      body: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              showTitle(),
              SizedBox(height: 10),
              showOptions(),
            ],
          )
      ),
    );
  }

  showTitle() {
    return Text("Other", style: TextStyle(color: ThemeManager().getDarkColor()));
  }

  showOptions(){
    return Expanded(
        child: GridView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 5,
                mainAxisSpacing: 0
            ),
            itemCount: this.otherTabList.length,
            itemBuilder: (context, index){
              return GestureDetector(
                onTap: (){
                  if(this.otherTabList[index] == OtherTabOptions.ranking)
                    Navigator.of(context).push(CustomRouter.getRoute(name: rankingRoute));
                  if(this.otherTabList[index] == OtherTabOptions.achievement)
                    Navigator.of(context).push(CustomRouter.getRoute(name: achievementRoute));
                  if(this.otherTabList[index] == OtherTabOptions.team)
                    Navigator.of(context).push(CustomRouter.getRoute(name: teamRoute, parameter: this.otherTabList[index].title));
                  if(this.otherTabList[index] == OtherTabOptions.awards)
                    Navigator.of(context).push(CustomRouter.getRoute(name: rewardsRoute));
                  if(this.otherTabList[index] == OtherTabOptions.performance)
                    Navigator.of(context).push(CustomRouter.getRoute(name: performanceRoute));
                  if(this.otherTabList[index] == OtherTabOptions.challenges)
                    Navigator.of(context).push(CustomRouter.getRoute(name: challengeRoute));
                  if(this.otherTabList[index] == OtherTabOptions.history)
                    Navigator.of(context).push(CustomRouter.getRoute(name: historyRoute));
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Card(
                    elevation: 3,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(child: Image.asset(Utils.getAssetsImg("book"))),
                        Container(
                          height: 45,
                          alignment: Alignment.center,
                          color: ThemeManager().getBgGradientDark(),
                          child: Text(Utils.getText(context, this.otherTabList[index].title), style: TextStyle(color: ThemeManager().getDarkColor(), fontSize: 16)),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
        )
    );
  }
}
