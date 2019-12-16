import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'commonview/background.dart';
import 'helper/Utils.dart';
import 'helper/res.dart';
import 'helper/string_res.dart';

class PLPage extends StatefulWidget {
  @override
  _PLPageState createState() => _PLPageState();
}

class _PLPageState extends State<PLPage> {
  var arrSector = ["Healthcare", "Industrials", "Technology", "Financials"];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: CommonView.getBGDecoration(),
      child: Column(
        children: <Widget>[CommonView.showTitle(context, StringRes.pl)],
      ),
    );
  }
}
