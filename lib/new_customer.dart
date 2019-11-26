import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/engagement_customer.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';

import 'helper/string_res.dart';

class NewCustomerPage extends StatefulWidget {
  @override
  _NewCustomerPageState createState() => _NewCustomerPageState();
}

class _NewCustomerPageState extends State<NewCustomerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: CommonView.getBGDecoration(),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              CommonView.showTitle(context, StringRes.newCustomers),
              showSubHeader(),
              showItems()
            ],
          ),
        ),
      ),
    ));
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
      height: Injector.isBusinessMode ? 30 : 25,
      margin: EdgeInsets.only(left: 0, right: 4, top: 8, bottom: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
          image: Injector.isBusinessMode
              ? DecorationImage(
                  image: AssetImage(Utils.getAssetsImg("bg_rounded")),
                  fit: BoxFit.fill)
              : null),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              Utils.getText(context, StringRes.name),
              style: Theme.of(context).textTheme.body1,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              Utils.getText(context, StringRes.sector),
              style: Theme.of(context).textTheme.body1,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              Utils.getText(context, StringRes.value),
              style: Theme.of(context).textTheme.body1,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              Utils.getText(context, StringRes.loyalty),
              style: Theme.of(context).textTheme.body1,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              Utils.getText(context, StringRes.resources),
              style: Theme.of(context).textTheme.body1,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              Utils.getText(context, StringRes.engage),
              style: Theme.of(context).textTheme.body1,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget showItem(int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
              height: Injector.isBusinessMode ? 30 : 25,
              padding: EdgeInsets.only(left: 10),
              margin: EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                  color: Injector.isBusinessMode ? null : ColorRes.white,
                  borderRadius: Injector.isBusinessMode
                      ? null
                      : BorderRadius.circular(20),
                  image: Injector.isBusinessMode
                      ? DecorationImage(
                          image:
                              AssetImage(Utils.getAssetsImg("bg_record_white")),
                          fit: BoxFit.fill)
                      : null),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Text(
                      Utils.getText(context, StringRes.newCustomers),
                      style: TextStyle(
                        color: ColorRes.textRecordBlue,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      'Mobile Dev.',
                      style: TextStyle(
                          color: ColorRes.textRecordBlue, fontSize: 15),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      '25 \$',
                      style: TextStyle(
                          color: ColorRes.textRecordBlue, fontSize: 15),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      '25 d',
                      style: TextStyle(
                          color: ColorRes.textRecordBlue, fontSize: 15),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      '8',
                      style: TextStyle(
                          color: ColorRes.textRecordBlue, fontSize: 15),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ),
                ],
              )),
        ),
        Container(
            height: Injector.isBusinessMode ? 32 : 25,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 10, right: 2),
            padding: EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
                color: Injector.isBusinessMode ? null : ColorRes.headerBlue,
                borderRadius:
                    Injector.isBusinessMode ? null : BorderRadius.circular(20),
                image: Injector.isBusinessMode
                    ? DecorationImage(
                        image: AssetImage(Utils.getAssetsImg("bg_engage_now")),
                        fit: BoxFit.fill)
                    : null),
            child: InkResponse(
              child: Text(
                Utils.getText(context, StringRes.engageNow),
                style: TextStyle(color: ColorRes.white, fontSize: 14),
              ),
              onTap: () {
//                Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                        builder: (context) => EngagementCustomer()));
              },
            )),
      ],
    );
  }
}
