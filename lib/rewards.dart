import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'commonview/background.dart';
import 'helper/Utils.dart';
import 'helper/res.dart';
import 'helper/string_res.dart';


class RewardsPage extends StatefulWidget {
  @override
  _RewardsPageState createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  var arrSector = ["Healthcare", "Industrials", "Technology", "Financials"];

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


  Container showSubHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Utils.getAssetsImg("bg_rounded")),
              fit: BoxFit.fill)),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Text(
              'Sector',
              style: TextStyle(color: ColorRes.colorPrimary),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Size',
              style: TextStyle(color: ColorRes.colorPrimary),
              textAlign: TextAlign.center,
            ),
          ),
        ],
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
      child: Container(
        color: ColorRes.colorBgDark,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Utils.getAssetsImg('bg_reward_sub')),
                      fit: BoxFit.fill)),
              child: Text(
                'Category',
                style: TextStyle(color: ColorRes.white, fontSize: 15),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                color: ColorRes.colorBgDark,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: arrSector.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CategoryItem(
                      selectItem, // callback function, setstate for parent
                      index: index,
                      isSelected: _selectedItem == index ? true : false,
                      title: arrSector[index],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  showSecondHalf() {
    return Expanded(
      flex: 3,
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10,),
            CommonView.showTitle(context,StringRes.rewards),
            Card(
              color: ColorRes.lightGrey,
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Container(
                height: Utils.getDeviceHeight(context) / 3.5,
              ),
            ),
            Expanded(
              child: Container(
                height: double.infinity,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Stack(
                        children: <Widget>[
                          Card(
                            elevation: 10,
                            color: ColorRes.whiteDarkBg,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            margin: EdgeInsets.only(
                                top: 14,
                                bottom: Utils.getDeviceHeight(context) / 12,
                                right: 5,
                                left: 10),
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 18, bottom: 18),
                              decoration: BoxDecoration(
                                color: ColorRes.bgDescription,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: ColorRes.colorPrimary, width: 1),
                              ),
                              child: SingleChildScrollView(
                                child: Text(
                                  "qwywer shankar riddhi govindbhaoqwywer shankar riddhi govindbhaoqwywer shankar riddhi govindbhaoqwywer shankar riddhi govindbhaoqwywer shankar riddhi govindbhaoqwywer shankar ",
                                  style:
                                  TextStyle(color: ColorRes.colorPrimary),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              alignment: Alignment.center,
                              height: 30,
                              margin: EdgeInsets.symmetric(
                                  horizontal:
                                      Utils.getDeviceWidth(context) / 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          Utils.getAssetsImg("bg_achivement")),
                                      fit: BoxFit.fill)),
                              child: Text(
                                'Achivement',
                                style: TextStyle(
                                    color: ColorRes.colorPrimary, fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              alignment: Alignment.center,
                              height: 32,
                              margin: EdgeInsets.only(
                                  left:
                                  Utils.getDeviceWidth(context) / 12,right:
                                  Utils.getDeviceWidth(context) / 12,bottom: 20),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          Utils.getAssetsImg("bg_innovation")),
                                      fit: BoxFit.fill)),
                              child: Text(
                                '10+ Innovation',
                                style: TextStyle(
                                    color: ColorRes.colorPrimary, fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Stack(
                        children: <Widget>[
                          Card(
                            elevation: 10,
                            color: ColorRes.whiteDarkBg,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            margin: EdgeInsets.only(
                                top: 20,
                                bottom: Utils.getDeviceHeight(context) / 11,
                                right: 10,
                                left: 5),
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 18, bottom: 18),
                              decoration: BoxDecoration(
                                color: ColorRes.bgDescription,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: ColorRes.colorPrimary, width: 1),
                              ),
                              child: SingleChildScrollView(
                                child: Text(
                                  "qwywer shankar riddhi govindbhaoqwywer shankar riddhi govindbhaoqwywer shankar riddhi govindbhaoqwywer shankar riddhi govindbhaoqwywer shankar riddhi govindbhaoqwywer shankar ",
                                  style:
                                      TextStyle(color: ColorRes.colorPrimary,fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              alignment: Alignment.center,
                              height: 30,
                              margin: EdgeInsets.symmetric(
                                  horizontal:
                                  Utils.getDeviceWidth(context) / 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          Utils.getAssetsImg("bg_achivement")),
                                      fit: BoxFit.fill)),
                              child: Text(
                                'Achivement',
                                style: TextStyle(
                                    color: ColorRes.colorPrimary, fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              alignment: Alignment.center,
                              height: 32,
                              margin: EdgeInsets.only(
                                  left:
                                  Utils.getDeviceWidth(context) / 12,right:
                              Utils.getDeviceWidth(context) / 12,bottom: 20),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          Utils.getAssetsImg("bg_innovation")),
                                      fit: BoxFit.fill)),
                              child: Text(
                                'Claim: +10 Innovation',
                                style: TextStyle(
                                    color: ColorRes.colorPrimary, fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
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

//Widget showItem(int index) {
//  return Container(
//    height: 35,
//    alignment: Alignment.center,
//    margin: EdgeInsets.only(left: 10),
//    decoration: BoxDecoration(
//        image: DecorationImage(
//            image: AssetImage(Utils.getAssetsImg("bg_reward_sub2")),
//            fit: BoxFit.fill)),
//    child: Text(
//      arrSector[index],
//      style: TextStyle(color: ColorRes.white, fontSize: 15),
//    ),
//  );
//}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.selectItem(widget.index);
      },
      child: Container(
        height: 35,
        margin: EdgeInsets.only(left: 10, right: 10),
//        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Utils.getAssetsImg(widget.isSelected
                    ? "bg_reward_sub_selected"
                    : "bg_reward_sub2")),
                fit: BoxFit.fill)),
        child: Text(
          widget.title,
          style: TextStyle(color: ColorRes.white, fontSize: 15),
        ),
      ),
    );
  }
}
