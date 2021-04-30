import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/challenge_listing_item_view.dart';
import 'package:ke_employee/commonview/common_views.dart';
import 'package:ke_employee/manager/screens_manager.dart';
import 'package:ke_employee/manager/settings_manager.dart';
import 'package:ke_employee/manager/theme_manager.dart';
import 'package:ke_employee/manager/settings_manager.dart';


class BottomSheets {

  static ScrollController scrollController = ScrollController();
  static List<LanguageBottomSheetOptions> languageList = [LanguageBottomSheetOptions.english, LanguageBottomSheetOptions.german, LanguageBottomSheetOptions.chinese];
  static List<SwitchModeBottomSheetOptions> modeList = [SwitchModeBottomSheetOptions.modernVersion, SwitchModeBottomSheetOptions.professionalVersion, SwitchModeBottomSheetOptions.gamifiedVersion];

  static void languageBottomSheet(String title, Color color, void Function(String selectedLanguage) completion){
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: ScreensManager().bottomNavigationPortraitState.context,
        builder: (builder){
          return new Container(
            height: 350.0,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: new Container(
                decoration: new BoxDecoration(
                    color: ThemeManager().getStaticGradientColor(),
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: Column(
                  children: [
                    showBottomSheetTitle(title, color),
                    Container(
                      height: 300,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: languageList.length,
                          itemBuilder: (context, index){
                            return GestureDetector(
                              onTap: (){
                                completion(languageList[index].title);
                                Navigator.of(ScreensManager().bottomNavigationPortraitState.context).pop();
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 20, left: 10),
                                child: Text(languageList[index].title, style: TextStyle(color: color.withOpacity(ThemeManager().getOpacity1()), fontSize: 16)),
                              ),
                            );
                          }),
                    )
                  ],
                )),
          );
        }
    );
  }

  static void switchModeBottomSheet(String title, Color color, void Function(String selectedMode) completion){
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: ScreensManager().bottomNavigationPortraitState.context,
        builder: (builder){
          return new Container(
            height: 350.0,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: new Container(
                decoration: new BoxDecoration(
                    color: ThemeManager().getStaticGradientColor(),
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: Column(
                  children: [
                    showBottomSheetTitle(title, color),
                    Container(
                      height: 300,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: modeList.length,
                          itemBuilder: (context, index){
                            return GestureDetector(
                              onTap: (){
                                completion(modeList[index].title);
                                Navigator.of(ScreensManager().bottomNavigationPortraitState.context).pop();
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 20, left: 10),
                                child: Text(modeList[index].title, style: TextStyle(color: color.withOpacity(ThemeManager().getOpacity1()), fontSize: 16)),
                              ),
                            );
                          }),
                    )
                  ],
                )),
          );
        }
    );
  }

  static void challengeBottomSheet(String title, Color color, void Function(String selectedMode) completion){
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: ScreensManager().bottomNavigationPortraitState.context,
        builder: (builder){
          return new Container(
            height: 350.0,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: new Container(
                decoration: new BoxDecoration(
                    color: ThemeManager().getStaticGradientColor(),
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: Column(
                  children: [
                    showBottomSheetTitle(title, color),
                    ShowBottomSheetChallengeTitles(title1: "Module", title2: "Level", title3: "Correct percentage"),
                    Divider(height: 1, thickness: 1),
                    Expanded(
                        child: Container(
                          child: Scrollbar(
                            isAlwaysShown: true,
                              controller: scrollController,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  controller: scrollController,
                                  itemCount: 10,
                                  itemBuilder: (context, index){
                                    return GestureDetector(
                                      onTap: (){
                                        completion(modeList[index].title);
                                        Navigator.of(ScreensManager().bottomNavigationPortraitState.context).pop();
                                      },
                                      child: ChallengeBottomSheetListingItemView(module: "Finance", level: "4", correctPercentage: "85%",),
                                    );
                                  })),
                        ))
                  ],
                )),
          );
        }
    );
  }

  static showBottomSheetTitle(String title, Color color) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Column(
          children: [
            Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(title, style: TextStyle(color: color, fontSize: 16))),
            Divider(height: 1, thickness: 1)
          ],
        ),
        IconButton(icon: Icon(Icons.keyboard_arrow_down, color: color,), onPressed: (){
          Navigator.of(ScreensManager().bottomNavigationPortraitState.context).pop();
        })
      ],
    );
  }

}

