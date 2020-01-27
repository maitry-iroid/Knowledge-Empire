import 'package:flutter/cupertino.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';

class TimeItem extends StatefulWidget {
  final String title;
  final int index;
  final bool isSelected;
  final Function(int) selectItem;

  TimeItem(
      this.selectItem, {
        Key key,
        this.title,
        this.index,
        this.isSelected,
      }) : super(key: key);

  _TimeItemState createState() => _TimeItemState();
}

class _TimeItemState extends State<TimeItem> {

  dayBoxCircular() {
    if(widget.index == 0) {
      return BorderRadius.only(bottomLeft: Radius.circular(20), topLeft: Radius.circular(20));
    } else if(widget.index == 2) {
      return BorderRadius.only(bottomRight: Radius.circular(20), topRight: Radius.circular(20));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Utils.playClickSound();
        widget.selectItem(widget.index);
      },
      child: Container(
        width: Utils.getDeviceWidth(context) / 12,
        margin: Injector.isBusinessMode ? EdgeInsets.symmetric(vertical: 11, horizontal: 3) : EdgeInsets.symmetric(vertical: 5, horizontal: 1),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: widget.isSelected ? ColorRes.titleBlueProf : ColorRes.rankingBackGround,
            borderRadius: dayBoxCircular(),
            image: DecorationImage(
                image: AssetImage(Utils.getAssetsImg(Injector.isBusinessMode ? widget.isSelected
                    ? "ranking_selected"
                    : "ranking_unselected" : ""
                )),
                fit: BoxFit.fill)),
        child: Text(
          widget.title,
          style: TextStyle(color: ColorRes.white, fontSize: 15),
        ),
      ),
    );
  }
}