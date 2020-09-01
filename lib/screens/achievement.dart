 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/dialogs/display_dailogs.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/get_achievement.dart';

import '../commonview/background.dart';
import '../helper/Utils.dart';
import '../helper/res.dart';
import '../helper/string_res.dart';

/*
*   created by Riddhi
*
*   Achievement will be shown here form API.
*
* */

class AchievementPage extends StatefulWidget {
  @override
  _AchievementPageState createState() => _AchievementPageState();
}

List<GetAchievementData> arrAchievementData = List();
GetAchievementData selectedAchievement;
SubCategory selectedSubCategory;

class _AchievementPageState extends State<AchievementPage> {
  List<RewardsModel> rewardsList = [
    RewardsModel(image: "trophy0"),
    RewardsModel(image: "trophy1"),
    RewardsModel(image: "trophy2"),
    RewardsModel(image: "trophy3"),
    RewardsModel(image: "trophy4"),
    RewardsModel(image: "trophy5"),
    RewardsModel(image: "trophy6"),
    RewardsModel(image: "trophy7"),
    RewardsModel(image: "trophy8"),
    RewardsModel(image: "trophy9"),
    RewardsModel(image: "trophy10"),
  ];

  @override
  void initState() {
    showDialogForCallApi();
    super.initState();
  }

  Future showDialogForCallApi() async {
    await Future.delayed(Duration(milliseconds: 50));

//    if (Injector.introData != null && Injector.introData.rewards == 0)
      await DisplayDialogs.showIntroRewards(context);

    Utils.isInternetConnectedWithAlert(context).then((isConnected) {
      getAchievements();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CommonView.showBackground(context),
        Padding(
          padding: EdgeInsets.only(top: Utils.getHeaderHeight(context)),
          child: Row(
            children: <Widget>[showFirstHalf(), showSecondHalf()],
          ),
        ),
      ],
    );
  }

  int _selectedItem = 0;

  int _subSelectedItem = 0;

  selectItem(index) {
    if (mounted)
      setState(() {
        _selectedItem = index;
        print(selectItem.toString());
        selectedAchievement = arrAchievementData[_selectedItem];

        if (selectedAchievement.subCategory.isNotEmpty) {
          _subSelectedItem = 0;
          selectedSubCategory =
              selectedAchievement.subCategory[_subSelectedItem];
        }
      });
  }

  subCatSelectItem(index) {
    if (mounted)
      setState(() {
        _subSelectedItem = index;
        selectedSubCategory = selectedAchievement.subCategory[_subSelectedItem];
//      isSelectSubCat = false;
      });
  }

  showFirstHalf() {
    return Expanded(
      flex: 1,
      child: Card(
        color: Injector.isBusinessMode ? ColorRes.colorBgDark : ColorRes.bgProf,
        margin: EdgeInsets.all(0),
        elevation: 10,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Container(
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color:
                        Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
                    image: Injector.isBusinessMode
                        ? DecorationImage(
                            image:
                                AssetImage(Utils.getAssetsImg('bg_reward_sub')),
                            fit: BoxFit.fill)
                        : null),
                child: Text(
                  Utils.getText(context, StringRes.category),
                  style: TextStyle(color: ColorRes.white, fontSize: 17),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: arrAchievementData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return showCategoryItem(index);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showSecondHalf() {
    return Expanded(
      flex: 3,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          CommonView.showTitle(context, StringRes.achievement),
          Expanded(
            flex: 1,
            child: Card(
              color: ColorRes.colorBgDark,
              margin: EdgeInsets.symmetric(horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: ColorRes.white),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: ListView.builder(
//                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: selectedAchievement != null
                      ? selectedAchievement.subCategory.length
                      : 0,
                  itemBuilder: (BuildContext context, int index) {
                    return showRewardItem(index);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: double.infinity,
              margin: EdgeInsets.only(left: 5, right: 5, top: 5),
              child: Row(
                children: <Widget>[
                  showAchievementBox(1),
                  showAchievementBox(2)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  showSecondHalfSecondCategory() {
    return Expanded(
      flex: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Card(
            color: ColorRes.whiteDarkBg,
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              height: Utils.getDeviceHeight(context) / 3.6,
              width: Utils.getDeviceWidth(context) / 1.4,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: selectedAchievement.subCategory.length,
                itemBuilder: (BuildContext context, int index) {
                  return showRewardItem(index);
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: <Widget>[
                  showAchievementBox(1),
                  showAchievementBox(2)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  showAchievementBox(int type) {
    return Expanded(
      flex: 1,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: <Widget>[
          Card(
            elevation: 10,
            color: ColorRes.bgDescription,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            margin: EdgeInsets.only(
                top: 14,
                bottom: Utils.getDeviceHeight(context) / 15,
                right: 2.5,
                left: 2.5),
            child: Container(
              width: Utils.getDeviceWidth(context) / 3,
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 18, bottom: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: ColorRes.white, width: 1),
              ),
              child: SingleChildScrollView(
                child: Text(
                  selectedSubCategory != null
                      ? type == 1
                          ? selectedSubCategory.currentLevelText
                          : selectedSubCategory.nextLevelText
                      : "",
                  style: TextStyle(color: ColorRes.white, fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              alignment: Alignment.center,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Utils.getAssetsImg("bg_achivement")),
                      fit: BoxFit.fill)),
              child: Text(
                Utils.getText(context,
                    type == 1 ? StringRes.achievement : StringRes.nextLevel),
                style: TextStyle(color: ColorRes.white, fontSize: 17),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              alignment: Alignment.center,
              height: 32,
              width: 120,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Utils.getAssetsImg("bg_innovation")),
                      fit: BoxFit.fill)),
              child: Text(
                Utils.getText(
                    context,
                    selectedSubCategory != null
                        ? type == 1
                            ? selectedSubCategory.currentLevelBlonus.toString()
                            : selectedSubCategory.nextLevelBlonus.toString()
                        : "null Innovation"),
                style: TextStyle(color: ColorRes.white, fontSize: 17),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

//  GetAchievementResponse getAchievementResponse = GetAchievementResponse();

  void getAchievements() {
    CommonView.showCircularProgress(true, context);

    GetAchievementRequest rq = GetAchievementRequest();
    rq.userId = Injector.userId;
    rq.mode = Injector.mode.toString();

    WebApi().callAPI(WebApi.rqGetUserAchievement, rq.toJson()).then((data) {
      CommonView.showCircularProgress(false, context);

      if (data != null) {
        arrAchievementData.clear();

        data.forEach((v) {
          arrAchievementData.add(GetAchievementData.fromJson(v));
        });

        if (arrAchievementData.isNotEmpty) {
          selectedAchievement = arrAchievementData[0];
          selectedSubCategory = selectedAchievement.subCategory[0];
          if (mounted) setState(() {});
        }
      }
    }).catchError((e) {
      CommonView.showCircularProgress(false, context);
    });
  }

  showRewardItem(int index) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                width: Utils.getDeviceWidth(context) / 6,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                        color: _subSelectedItem == index
                            ? ColorRes.borderRewardsName
                            : ColorRes.white,
                        width: 1)),
//                 child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 10),

                child: Center(
                    child: Text(
                  selectedAchievement.subCategory[index].achievementName,
                  style: TextStyle(fontSize: 17, color: ColorRes.white),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )),
//                 ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                  padding: EdgeInsets.only(bottom: 0),
//                    width: Utils.getDeviceWidth(context) / 10,
//                height: Utils.getDeviceHeight(context) / 4,
                  child: Image(
                    image: AssetImage(
                      Utils.getAssetsImg(rewardsList[selectedAchievement
                              .subCategory[index].currentLevel]
                          .image),
                    ),
//                  fit: BoxFit.fill,
                  )),
            )
          ],
        ),
      ),
      onTap: () {
//        if(currentVol != 0) {
        Utils.playClickSound();
//        }
        subCatSelectItem(index);
      },
    );
  }

  showCategoryItem(int index) {
    return Center(
      child: CategoryItem(
        selectItem, // callback function, if (mounted)setState for parent
        index: index,
        isSelected: _selectedItem == index ? true : false,
        title: arrAchievementData[index].achievementCategory,
      ),
    );
  }

//  -----------------------------

}

class RewardsModel {
//  String levelName = "";
  String image = "";

//  bool isSelected = false;

  RewardsModel({/*this.levelName,*/ this.image});
}

//-----------------------

class CategoryItem extends StatefulWidget {
  final String title;
  final int index;
  final bool isSelected;
  final Function(int) selectItem;

  CategoryItem(
    this.selectItem, {
    Key key,
    this.title,
    this.index,
    this.isSelected,
  }) : super(key: key);

  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
//        if(currentVol != 0) {
        Utils.playClickSound();
//        }
        widget.selectItem(widget.index);
      },
      child: Container(
          height: Injector.isBusinessMode ? 50 : 40,
          margin: EdgeInsets.only(
              left: 5,
              right: 5,
              top: Injector.isBusinessMode ? 0 : 5,
              bottom: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Injector.isBusinessMode
                  ? null
                  : widget.isSelected ? ColorRes.titleBlueProf : null,
              border: Injector.isBusinessMode
                  ? null
                  : Border.all(width: 1, color: ColorRes.titleBlueProf),
              borderRadius:
                  Injector.isBusinessMode ? null : BorderRadius.circular(10),
              image: Injector.isBusinessMode
                  ? DecorationImage(
                      image: AssetImage(Utils.getAssetsImg(widget.isSelected
                          ? "bg_reward_sub_selected"
                          : "bg_reward_sub2")),
                      fit: BoxFit.fill)
                  : null),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Text(
              widget.title,
              style: TextStyle(
                  color: Injector.isBusinessMode
                      ? ColorRes.white
                      : widget.isSelected ? ColorRes.white : ColorRes.textBlue,
                  fontSize: 17),
              textAlign: TextAlign.center,
            ),
          )),
    );
  }
}
