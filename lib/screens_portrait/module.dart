import 'package:flutter/material.dart';
import 'package:ke_employee/baseController/base_textfield.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/manager/module_manager.dart';
import 'package:ke_employee/manager/other_manager.dart';
import 'package:ke_employee/manager/screens_manager.dart';
import 'package:ke_employee/manager/theme_manager.dart';
import 'package:ke_employee/routes/custom_router.dart';
import 'package:ke_employee/routes/route_names.dart';


class ModulePagePortrait extends StatefulWidget {
  @override
  _ModulePagePortraitState createState() => _ModulePagePortraitState();
}

class _ModulePagePortraitState extends State<ModulePagePortrait> {

  final searchController = TextEditingController();
  List<ModuleOptions> moduleList = [
    ModuleOptions.finance,
    ModuleOptions.marketing,
    ModuleOptions.sales,
    ModuleOptions.management,
    ModuleOptions.product
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeManager().getBgGradientLight(),
      appBar: Utils().showAppBarWithDrawer(ScreensManager().bottomNavigationPortraitState.context, BottomItems.modules),
      body: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              showSearchField(),
              SizedBox(height: 10),
              showTitle(),
              SizedBox(height: 10),
              showOptions(),
            ],
          )
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
            width: Utils.getDeviceWidth(context) * 0.55,
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

  showTitle() {
    return Text("Learning Modules", style: TextStyle(color: ThemeManager().getDarkColor()));
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
            itemCount: this.moduleList.length,
            itemBuilder: (context, index){
              return GestureDetector(
                onTap: (){
                  print(this.moduleList[index].title);
                  Navigator.of(context).push(CustomRouter.getRoute(name: moduleDetailRoute, parameter: this.moduleList[index]));
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
                        Expanded(
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Center(child: Image.asset(Utils.getAssetsImg("book"))),
                                Container(
                                  padding: EdgeInsets.only(top: 8, right: 8),
                                  child: Icon(Icons.add, color: ThemeManager().getDarkColor(), size: 22),
                                )
                              ],
                            )
                        ),
                        LinearProgressIndicator(
                          backgroundColor: Colors.grey.withOpacity(0.3),
                          valueColor: AlwaysStoppedAnimation(ThemeManager().getDarkColor()),
                          value: this.moduleList[index].progressValue,
                          minHeight: 3,
                        ),
                        Container(
                          height: 55,
                          padding: EdgeInsets.only(top: 10, left: 8, right: 8),
                          alignment: Alignment.center,
                          color: ThemeManager().getStaticGradientColor(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(Utils.getText(context, this.moduleList[index].title), style: TextStyle(color: ThemeManager().getDarkColor(), fontSize: 14)),
                                  Container(
                                    height: 20,
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: ThemeManager().getDarkColor())
                                    ),
                                    child: Text("lv 2",
                                        style: TextStyle(color: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity2()), fontSize: 11)),
                                  )
                                ],
                              ),
                              SizedBox(height: 2),
                              Text("10 Questions",
                                  style: TextStyle(color: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity1()), fontSize: 11))
                            ],
                          ),
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
