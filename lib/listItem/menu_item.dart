import 'package:flutter/cupertino.dart';
import 'package:knowledge_empire/helper/Utils.dart';
import 'package:knowledge_empire/helper/res.dart';
import 'package:knowledge_empire/injection/dependency_injection.dart';
import 'package:knowledge_empire/models/drawer_item.dart';

class MenuItem extends StatelessWidget {
  DrawerItem item;
  String _currentPage;

  MenuItem(this.item, this._currentPage);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Injector.isBusinessMode ? 8 : 5, horizontal: 5),
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: Injector.isBusinessMode
              ? null
              : item.key == _currentPage
                  ? ColorRes.blueMenuSelected
                  : ColorRes.blueMenuUnSelected,
          border: (!Injector.isBusinessMode && item.key == _currentPage)
              ? Border.all(
                  color: ColorRes.white,
                  width: 1,
                )
              : null,
          borderRadius: BorderRadius.circular(10),
          image: Injector.isBusinessMode
              ? DecorationImage(
                  image: AssetImage(Utils.getAssetsImg(item.key == _currentPage ? "slide_menu_highlight" : "bg_menu")), fit: BoxFit.fill)
              : null),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Center(
            child: Image(
              image: AssetImage(Utils.getAssetsImg(item.icon)),
              height: Injector.isBusinessMode ? 45 : 45,
              width: Injector.isBusinessMode ? 80 : 70,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(
              item.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(color: ColorRes.white, fontSize: 18),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
    );
  }
}
