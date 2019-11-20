import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'commonview/background.dart';
import 'helper/Utils.dart';
import 'helper/res.dart';
import 'helper/string_res.dart';
import 'injection/dependency_injection.dart';

class ExistingCustomerPage extends StatefulWidget {
  @override
  _ExistingCustomerPageState createState() => _ExistingCustomerPageState();
}

class _ExistingCustomerPageState extends State<ExistingCustomerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorRes.colorBgDark,
        body: SafeArea(
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: CommonView.getBGDecoration(),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      CommonView.showTitle(context,StringResBusiness.existingCustomers),
                      showSubHeader(),
                      showItems()
                    ],
                  ),
                ))));
  }

  Expanded showItems() {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return showItem(index);
        },
      ),
    );
  }

  Container showSubHeader() {
    return Container(
      height: Injector.isBusinessMode?30:25,
      margin: EdgeInsets.only(top: 8, bottom: 5),
      padding: EdgeInsets.only(right: 3),
      decoration: BoxDecoration(
          color: Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
          borderRadius:
          Injector.isBusinessMode ? null : BorderRadius.circular(20),
          image: Injector.isBusinessMode?DecorationImage(
              image: AssetImage(Utils.getAssetsImg("bg_rounded")),
              fit: BoxFit.fill):null),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Text(
              Utils.getText(context, StringResBusiness.name),
              style: Theme.of(context).textTheme.body1,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 7,
            child: Text(
              Utils.getText(context, StringResBusiness.sector),
              style: Theme.of(context).textTheme.body1,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              Utils.getText(context, StringResBusiness.value),
              style: Theme.of(context).textTheme.body1,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              Utils.getText(context, StringResBusiness.loyalty),
              style: Theme.of(context).textTheme.body1,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              Utils.getText(context, StringResBusiness.endRel),
              style: Theme.of(context).textTheme.body1,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }


  Widget showItem(int index) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
              height: Injector.isBusinessMode?30:25,
              margin: EdgeInsets.symmetric(vertical: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Injector.isBusinessMode ? null : ColorRes.white,
                  borderRadius:
                  Injector.isBusinessMode ? null : BorderRadius.circular(20),
                  image: Injector.isBusinessMode?DecorationImage(
                      image: AssetImage(Utils.getAssetsImg("bg_record_white")),
                      fit: BoxFit.fill):null),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Text(
                      'Mobile Dev.',
                      style: TextStyle(
                        color: ColorRes.blue,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      'Mobile Dev.',
                      style: TextStyle(color: ColorRes.blue, fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      '25 \$',
                      style: TextStyle(color: ColorRes.blue, fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      '25 d',
                      style: TextStyle(color: ColorRes.blue, fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )),
        ),
        Container(
          height: 35,
          width: 35,
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 15, right: 20),
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Utils.getAssetsImg("close")),
                  fit: BoxFit.fill)),
        )
      ],
    );
  }
}
