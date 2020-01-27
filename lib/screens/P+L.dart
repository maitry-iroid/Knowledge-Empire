import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../commonview/background.dart';
import '../helper/Utils.dart';
import '../helper/string_res.dart';

class PLPage extends StatefulWidget {
  @override
  _PLPageState createState() => _PLPageState();
}

class _PLPageState extends State<PLPage> {
  var arrSector = ["Healthcare", "Industrials", "Technology", "Financials"];
  var arrTime = ['Day', 'Month', 'Year'];
  int selectedTime = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CommonView.showBackground(context),
        Padding(
          padding: EdgeInsets.only(top: Utils.getHeaderHeight(context)),
          child: Column(
            children: <Widget>[
              CommonView.showTitle(context, StringRes.pl),
//             Expanded(
//               child:  Row(
//                 children: <Widget>[
//                   Expanded(
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       shrinkWrap: true,
//                       physics: ClampingScrollPhysics(),
//                       itemCount: arrTime.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return TimeItem(
//                           selectTime,
//                           index: index,
//                           isSelected: selectedTime == index ? true : false,
//                           title: arrTime[index],
//                         );
//                       },
//                     ),
//                   )
//                 ],
//               ),
//             )
            ],
          ),
        ),
      ],
    );
  }

  selectTime(index) {
    if (selectedTime != index) {
      setState(() {
        selectedTime = index;
      });
    }
  }
}
