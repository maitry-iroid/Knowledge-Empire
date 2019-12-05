import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/injection/dependency_injection.dart';

import 'commonview/background.dart';
import 'helper/Utils.dart';
import 'helper/res.dart';
import 'helper/string_res.dart';

class RewardsPage extends StatefulWidget {
  @override
  _RewardsPageState createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  var arrCategories = ["Healthcare", "Industrials", "Technology", "Financials"];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: CommonView.getBGDecoration(),
      child: Row(
        children: <Widget>[showFirstHalf(), showSecondHalf()],
      ),
    );
  }

  int _selectedItem = 0;

  selectItem(index) {
    setState(() {
      _selectedItem = index;
      print(selectItem.toString());
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
                    itemCount: arrCategories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CategoryItem(
                        selectItem, // callback function, setstate for parent
                        index: index,
                        isSelected: _selectedItem == index ? true : false,
                        title: arrCategories[index],
                      );
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          CommonView.showTitle(context, StringRes.rewards),
          Card(
            color: ColorRes.whiteDarkBg,
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              height: Utils.getDeviceHeight(context) / 3.6,
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 130,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
            decoration: BoxDecoration(
                borderRadius:
                    Injector.isBusinessMode ? null : BorderRadius.circular(20),
                border: Injector.isBusinessMode
                    ? null
                    : Border.all(width: 1, color: ColorRes.white),
                color: Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
                image: Injector.isBusinessMode
                    ? DecorationImage(
                        image: AssetImage(
                          Utils.getAssetsImg("bg_blue"),
                        ),
                        fit: BoxFit.fill)
                    : null),
            child: Text(
              Utils.getText(
                  context, Utils.getText(context, StringRes.description)),
              style: TextStyle(
                color: ColorRes.white,
                fontSize: DimenRes.titleTextSize,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Container(
              height: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: <Widget>[
                  showFirstAchivement(1),
                  showFirstAchivement(2)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  showFirstAchivement(int type) {
    return Expanded(
      flex: 1,
      child: Stack(
        fit: StackFit.loose,
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
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 18, bottom: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: ColorRes.white, width: 1),
              ),
              child: SingleChildScrollView(
                child: Text(
                  "qwywer shankar riddhi govindbhaoqwywer shankar riddhi govindbhaoqwywer shankar riddhi govindbhaoqwywer shankar riddhi govindbhaoqwywer shankar riddhi govindbhaoqwywer shankar ",
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
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Utils.getAssetsImg("bg_innovation")),
                      fit: BoxFit.fill)),
              child: Text(
                '10+ Innovation',
                style: TextStyle(color: ColorRes.white, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

//  -----------------------------

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
        height: Injector.isBusinessMode ? 35 : 30,
        margin: EdgeInsets.only(
            left: 10, right: 10, top: Injector.isBusinessMode ? 0 : 5),
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
        child: Text(
          widget.title,
          style: TextStyle(
              color: Injector.isBusinessMode
                  ? ColorRes.white
                  : widget.isSelected ? ColorRes.white : ColorRes.textBlue,
              fontSize: 15),
        ),
      ),
    );
  }
}
