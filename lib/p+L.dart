import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';

class PLPage extends StatefulWidget {
  @override
  _PLPageState createState() => _PLPageState();
}

class _PLPageState extends State<PLPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[showHeader(), showMainBody()],
        ),
      ),
    );
  }

  showMainBody() {
    return Container();
  }

  showHeader() {
    return Container();
  }

  showList() {
    return ListView(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Image(
                image: AssetImage(Utils.getAssetsImg("search")),
                height: 30,
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              flex: 1,
              child: Image(
                image: AssetImage(Utils.getAssetsImg("search")),
                height: 30,
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              flex: 1,
              child: Image(
                image: AssetImage(Utils.getAssetsImg("search")),
                height: 30,
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              flex: 1,
              child: Image(
                image: AssetImage(Utils.getAssetsImg("search")),
                height: 30,
                fit: BoxFit.fill,
              ),
            )
          ],
        )
      ],
    );
  }

  showChart() {
    return Container();
  }
}
