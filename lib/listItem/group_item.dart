import 'package:flutter/cupertino.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';

class GroupItem extends StatefulWidget {
  final String title;
  final int index;
  final bool isSelected;
  final Function(int) selectItem;

  GroupItem(
    this.selectItem, {
    Key key,
    this.title,
    this.index,
    this.isSelected,
  }) : super(key: key);

  _GroupItemState createState() => _GroupItemState();
}

class _GroupItemState extends State<GroupItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Utils.playClickSound();
        widget.selectItem(widget.index);
      },
      child: Container(
        width: Utils.getDeviceWidth(context) / (Injector.isBusinessMode?7.5:9),
        margin: Injector.isBusinessMode
            ? EdgeInsets.symmetric(vertical: 8, horizontal: 3)
            : EdgeInsets.symmetric(vertical: 3, horizontal: 3),
        padding: EdgeInsets.symmetric(horizontal: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Utils.getAssetsImg(Injector.isBusinessMode
                    ? widget.isSelected
                        ? "ranking_selected"
                        : "ranking_unselected"
                    : "")),
                fit: BoxFit.fill)),
        child: Text(
          widget.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              decoration: Injector.isBusinessMode
                  ? TextDecoration.none
                  : widget.isSelected
                      ? TextDecoration.underline
                      : TextDecoration.none,
              color: Injector.isBusinessMode
                  ? ColorRes.white
                  : widget.isSelected
                      ? ColorRes.titleBlueProf
                      : ColorRes.fontGrey,
              fontSize: Injector.isBusinessMode ? 15 : 18),
        ),
      ),
    );
  }
}
