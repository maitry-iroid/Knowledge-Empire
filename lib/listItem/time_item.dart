import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  dayBoxCircular1() {
    if(widget.index == 0) {
      return BorderRadius.only(bottomLeft: Radius.circular(0), topLeft: Radius.circular(0));
    } else if(widget.index == 2) {
      return BorderRadius.only(bottomRight: Radius.circular(0), topRight: Radius.circular(0));
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
        margin: Injector.isBusinessMode ? EdgeInsets.symmetric(vertical: 0, horizontal: 3) : EdgeInsets.symmetric(vertical: 5, horizontal: 1),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Injector.isBusinessMode ? Colors.transparent : widget.isSelected ? ColorRes.titleBlueProf : ColorRes.rankingBackGround,
            borderRadius: Injector.isBusinessMode ? dayBoxCircular1() : dayBoxCircular(),
            image: DecorationImage(
                image: AssetImage(Utils.getAssetsImg(Injector.isBusinessMode ? widget.isSelected
                    ? "ranking_bg_time_selected"
                    : "ranking_bg_time_deselected" : ""
                )),
                fit: BoxFit.contain)),
        child: Text(
          widget.title,
          style: TextStyle(color: widget.isSelected ?  ColorRes.white : ColorRes.lightGrey, fontSize: 11,), textAlign: TextAlign.center,
        ),
      ),
    );
  }
}