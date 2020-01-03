import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/get_achievement.dart';

import 'commonview/background.dart';
import 'helper/Utils.dart';
import 'helper/res.dart';
import 'helper/string_res.dart';

class RewardsPage extends StatefulWidget {
  @override
  _RewardsPageState createState() => _RewardsPageState();
}


List<GetAchievementData> arrAchievementData = List();
GetAchievementData selectedAchievement;
SubCategory selectedSubCategory;

class _RewardsPageState extends State<RewardsPage> {



  List<RewardsModel> rewardsList = [
    RewardsModel(levelName: "Level 0", image: "trophy0"),
    RewardsModel(levelName: "Level 1", image: "trophy1"),
    RewardsModel(levelName: "Level 2", image: "trophy2"),
    RewardsModel(levelName: "Level 3", image: "trophy3"),
    RewardsModel(levelName: "Level 4", image: "trophy4"),
    RewardsModel(levelName: "Level 5", image: "trophy5"),
    RewardsModel(levelName: "Level 6", image: "trophy6"),
    RewardsModel(levelName: "Level 7", image: "trophy7"),
    RewardsModel(levelName: "Level 8", image: "trophy8"),
    RewardsModel(levelName: "Level 9", image: "trophy9"),
    RewardsModel(levelName: "Level 10", image: "trophy10"),
  ];

  @override
  void initState() {
    super.initState();

    Utils.isInternetConnectedWithAlert().then((isConnected) {
      if (isConnected) {
        getAchievements();
      }
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
        CommonView.showCircularProgress(isLoading)
      ],
    );
  }

  int _selectedItem = 0;

  int _subSelectedItem = -1;

  selectItem(index) {
    setState(() {
      _selectedItem = index;
      print(selectItem.toString());
      selectedAchievement = arrAchievementData[index];
    });
  }

  subCatSelectItem(index) {
    setState(() {
      _subSelectedItem = index;
      selectedSubCategory = selectedAchievement.subCategory[index];
//      isSelectSubCat = false;
    });
  }


  showSecondHalf() {
    return Expanded(
      flex: 3,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          CommonView.showTitle(context, StringRes.rewards),
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
                  itemCount: selectedAchievement!=null?selectedAchievement.subCategory.length:0,
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
                  showFirstAchievement(1),
                  showFirstAchievement(2)
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
//                physics: ClampingScrollPhysics(),
//                itemCount: subCategory.length,
                itemCount: selectedAchievement.subCategory.length,

                itemBuilder: (BuildContext context, int index) {
//                      return showItem(index);
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
                  showFirstAchievement(1),
                  showFirstAchievement(2)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  showFirstAchievement(int type) {
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
                  style: TextStyle(
                    color: ColorRes.white,
                  ),
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
                style: TextStyle(color: ColorRes.white, fontSize: 14),
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
                style: TextStyle(color: ColorRes.white, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isLoading = false;

//  GetAchievementResponse getAchievementResponse = GetAchievementResponse();

  void getAchievements() {
    setState(() {
      isLoading = true;
    });

    String oneAsString = _selectedItem.toString();

    GetAchievementRequest rq = GetAchievementRequest();
    rq.userId = Injector.userData.userId;
//    rq.categoryId = oneAsString;

    WebApi().getAchievements(context, rq).then((response) {
      setState(() {
        isLoading = false;
      });

      if (response != null) {
        if (response.flag == "true") {
          if (response.data != null && response.data.isNotEmpty) {
            arrAchievementData = response.data;
            selectedAchievement = arrAchievementData[0];
            selectedSubCategory = selectedAchievement.subCategory[0];
            setState(() {});
          }
        } else {
          Utils.showToast(response.msg);
        }
      }
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
                            ? ColorRes.white
                            : ColorRes.borderRewardsName,
                        width: 1)),
//                 child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),

                child: Center(
                    child: Text(
                      selectedAchievement.subCategory[index].achievementName,
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
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
        subCatSelectItem(index);
      },
    );
  }

  showCategoryItem(int index) {
    return Center(
      child: CategoryItem(
        selectItem, // callback function, setstate for parent
        index: index,
        isSelected: _selectedItem == index ? true : false,
        title: arrAchievementData[index].achievementCategory,
      ),
    );
  }

//  -----------------------------

}

class RewardsModel {
  String levelName = "";
  String image = "";

//  bool isSelected = false;

  RewardsModel({this.levelName, this.image});
}

//-----------------------

class CategoryItem extends StatefulWidget {
  final String title;
  final int index;
  final bool isSelected;
  Function(int) selectItem;

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
        Utils.playClickSound();
        widget.selectItem(widget.index);
      },
      child: Container(
          height: Injector.isBusinessMode ? 50 : 40,
          margin: EdgeInsets.only(
              left: 5, right: 5, top: Injector.isBusinessMode ? 0 : 5),
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
                  fontSize: 15),
              textAlign: TextAlign.center,
            ),
          )),
    );
  }
}
