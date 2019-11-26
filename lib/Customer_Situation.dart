import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'helper/res.dart';
import 'commonview/header.dart';

class Customer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomerHome();
  }
}

class CustomerHome extends StatefulWidget {
  @override
  _CustomerHomeState createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
//  var arrSector = ["Healthcare", "Industrials", "Technology", "Financials"];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _selectedItem = 0;

  openProfile() {
//    _onSelectItem(10);
    if (mounted) {
      setState(() => _selectedDrawerIndex = 10);
//      Navigator.of(context).pop(); // close the drawer
    }
  }

  int _selectedDrawerIndex = 0;

  selectItem(index) {
    setState(() {
      _selectedItem = index;
      print(selectItem.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
//        Container(
//          height: 20.0,
//        ),
            Container(
              child: HeaderView(
                scaffoldKey: _scaffoldKey,
                isShowMenu: true,
                openProfile: openProfile,
              ),
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(color: ColorRes.textProf
//              image: DecorationImage(
//                image: AssetImage(Utils.getAssetsImg("bg_header_card")),
//                fit: BoxFit.fill,
//              ),
                  ),
              child: Container(
//                decoration: BoxDecoration(color: Colors.blue),
                  child: CommonView.topThreeButton(context, 'Debrief', 'Next')),
            ),
            Expanded(
              flex: 8,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorRes.colorBgDark,
//                image: DecorationImage(
//                  image: AssetImage(Utils.getAssetsImg("bg_header_card")),
//                  fit: BoxFit.fill,
//                ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Stack(
                        children: <Widget>[
                          Card(
                            elevation: 20,
//                          color: ColorRes.whiteDarkBg,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            margin: EdgeInsets.only(
                                top: 25, bottom: 10, right: 8, left: 15),
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 15, bottom: 18),
                              decoration: BoxDecoration(
                                color: ColorRes.bgDescription,
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: ColorRes.white, width: 1),
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: 4,
                                itemBuilder: (BuildContext context, int index) {
                                  return CategoryItem(
                                    selectItem,
                                    // callback function, setstate for parent
                                    index: index,
                                    isSelected:
                                        _selectedItem == index ? true : false,
//                                  title: arrSector[index],
                                  );
                                },
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              alignment: Alignment.center,
                              height: 30,
                              margin: EdgeInsets.symmetric(
                                  horizontal: Utils.getDeviceWidth(context) / 6,
                                  vertical: 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          Utils.getAssetsImg("eddit_profile")),
                                      fit: BoxFit.fill)),
                              child: Text(
                                'Answers',
                                style: TextStyle(
                                    color: ColorRes.white, fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                                flex: 5,
                                child: CommonView.image(
                                    context, 'vector_smart_object2')),
                            Expanded(
                              flex: 4,
                              child: CommonView.questionAndExplanation(
                                  context, 'Explanation'),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
  var _indexShow = ["A", "B", "C", "D"];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.selectItem(widget.index);
      },
      child: Container(
//          height: 50,
        margin: EdgeInsets.only(left: 6, right: 6, top: 6),
        padding: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
//          margin: EdgeInsets.only(left: 10, right: 10, top: 6),
//        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
//              borderRadius: BorderRadius.circular(15),
//          color: (widget.isSelected ? ColorRes.greenDot : ColorRes.white)
            image: DecorationImage(
                image: AssetImage(Utils.getAssetsImg(widget.isSelected
                    ? "rounded_rectangle_837"
                    : "rounded_rectangle_8371")),
                fit: BoxFit.fill)),
        child: Row(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 5.0, right: 5.0)),
            Title(
                color: ColorRes.greenDot,
                child: new Text(_indexShow[widget.index],
                    style: TextStyle(
                        color: (widget.isSelected
                            ? ColorRes.white
                            : Colors.black)))),
            Padding(padding: EdgeInsets.only(left: 5.0, right: 5.0)),
            Expanded(
              child: new Text(
                "hellohellohellohellohellohellohellohellohellohellhellohelloellohellohellohellohell",
                style: TextStyle(
                    color: (widget.isSelected ? ColorRes.white : Colors.black)),
              ),
            )
          ],
        ),
//        Text(
//          widget.title,
//          style: TextStyle(color: (widget.isSelected ? ColorRes.white : ColorRes.black), fontSize: 15),
//        ),
      ),
    );
  }
}
