import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../commonview/background.dart';
import '../helper/string_res.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: CommonView.getBGDecoration(context),
      child: Column(
        children: <Widget>[CommonView.showTitle(context, StringRes.help)],
      ),
    );
  }
}
