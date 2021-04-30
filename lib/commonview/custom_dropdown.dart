import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/manager/screens_manager.dart';
import 'package:ke_employee/manager/theme_manager.dart';
import 'dart:math';

double maxWidth = 0.0;

class CustomDropDownAppbarView extends StatefulWidget {
  final List<String> dropdownList;
  CustomDropDownAppbarView(this.dropdownList);

  @override
  _CustomDropDownAppbarViewState createState() => _CustomDropDownAppbarViewState();
}

class _CustomDropDownAppbarViewState extends State<CustomDropDownAppbarView> {
  String _selectedValue;
  List<double> widthList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._selectedValue = widget.dropdownList[0];
    maxWidth = this.getMaxWidth() + 10;
  }

  double getMaxWidth(){
   widget.dropdownList.forEach((element) {
     double value = this._textSize(element);
     this.widthList.add(value);
   });
   return this.widthList.reduce(max);
  }

  double _textSize(String text) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text), maxLines: 1, textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size.width;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: (){
            ScreensManager().bottomNavigationPortraitState.setState(() {
              ScreensManager().isTeamVisible = !ScreensManager().isTeamVisible;
              ScreensManager().isTabBarVisible = !ScreensManager().isTabBarVisible;
            });
          },
          child: Container(
            padding: EdgeInsets.only(left: 10, top: 0, right: 5),
            height: AppBar().preferredSize.height / 1.7,
            width: maxWidth,
            decoration: BoxDecoration(
                color: ThemeManager().getTextColor(),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))
            ),
            child: Row(
              children: [
                Expanded(child: Text(_selectedValue, textAlign: TextAlign.center, style: TextStyle(color: ThemeManager().getHeaderColor(), fontSize: 11))),
                Icon(Icons.arrow_drop_down, size: 20, color: ThemeManager().getHeaderColor())
              ],
            ),
          ),
        ),
      ),
    );
  }



}

class CustomDropdownContentView extends StatefulWidget {
  final List<String> dropdownList;
  CustomDropdownContentView(this.dropdownList);

  @override
  _CustomDropdownContentViewState createState() => _CustomDropdownContentViewState();
}

class _CustomDropdownContentViewState extends State<CustomDropdownContentView> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: ScreensManager().isTeamVisible,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            InkResponse(
              onTap: (){
                setState(() {
                  ScreensManager().isTeamVisible = false;
                });
                ScreensManager().bottomNavigationPortraitState.setState(() {
                  ScreensManager().isTabBarVisible = false;
                });
              },
              child: Container(
                height: Utils.getDeviceHeight(context),
                width: Utils.getDeviceWidth(context),
                color: Colors.black.withOpacity(0.4),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
                itemCount: widget.dropdownList.length ?? 0,
                itemBuilder: (context, index){
                  return InkResponse(
                    onTap: (){
                      setState(() {
                        ScreensManager().isTeamVisible = false;
                        ScreensManager().isTabBarVisible = false;
                      });
                    },
                    child:  Container(
                      margin: EdgeInsets.only(right: 5, left: Utils.getDeviceWidth(context) - maxWidth - 5),
                      padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                      width: maxWidth,
                      decoration: BoxDecoration(
                          color: ThemeManager().getTextColor(),
                          borderRadius: index == widget.dropdownList.length - 1 ? BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)) : null
                      ),
                      child: Text(widget.dropdownList[index], textAlign: TextAlign.left,style: TextStyle(color: ThemeManager().getHeaderColor(), fontSize: 11)),
                    ),
                  );

                })
          ],
        )
    );
  }
}


class CustomDropDown {

  static List<String> dropdownList;
  static String selectedValue = dropdownList[0];
  static List<double> widthList = [];
  static double dropdownWidth = 0.0;

  static double getMaxWidth(){
    widthList = [];
    dropdownList.forEach((element) {
      double value = _textSize(element);
      widthList.add(value);
    });
    return widthList.reduce(max);
  }

  static double _textSize(String text) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text), maxLines: 1, textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size.width;
  }

  static Widget dropDownSelectedItem(void Function() completion){
    return Container(
      margin: EdgeInsets.only(right: 5),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: (){
            completion();
          },
          child: Container(
            padding: EdgeInsets.only(left: 10, top: 0, right: 5),
            height: AppBar().preferredSize.height / 1.7,
            width: dropdownWidth,
            decoration: BoxDecoration(
                color: ThemeManager().getTextColor(),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))
            ),
            child: Row(
              children: [
                Expanded(child: Text(selectedValue, textAlign: TextAlign.left, style: TextStyle(color: ThemeManager().getHeaderColor(), fontSize: 11))),
                Icon(Icons.arrow_drop_down, size: 20, color: ThemeManager().getHeaderColor())
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget dropDownList(BuildContext context, void Function(bool isItemSelected, int selectedItemIndex) completion){
    return Visibility(
        visible: ScreensManager().isTeamVisible,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            InkResponse(
              onTap: (){
                completion(false, null);
              },
              child: Container(
                height: Utils.getDeviceHeight(context),
                width: Utils.getDeviceWidth(context),
                color: Colors.black.withOpacity(0.4),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: dropdownList.length ?? 0,
                itemBuilder: (context, index){
                  return InkResponse(
                    onTap: (){
                      completion(true, index);
                    },
                    child:  Container(
                      margin: EdgeInsets.only(right: 5, left: Utils.getDeviceWidth(context) - dropdownWidth - 5),
                      padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                      width: dropdownWidth,
                      decoration: BoxDecoration(
                          color: ThemeManager().getTextColor(),
                          borderRadius: index == dropdownList.length - 1 ? BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)) : null
                      ),
                      child: Text(dropdownList[index], textAlign: TextAlign.left,style: TextStyle(color: ThemeManager().getHeaderColor(), fontSize: 11)),
                    ),
                  );
                })
          ],
        )
    );
  }
}