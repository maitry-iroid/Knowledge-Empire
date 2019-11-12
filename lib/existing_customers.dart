import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'helper/Utils.dart';
import 'helper/res.dart';

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
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            Utils.getAssetsImg('bg_dashboard_trans')),
                        fit: BoxFit.fill)),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      showTitle(),
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
      padding: EdgeInsets.symmetric(vertical: 15),
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Utils.getAssetsImg("bg_rounded")),
              fit: BoxFit.fitWidth)),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              'Name',
              style: TextStyle(color: ColorRes.colorPrimary),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              'Sector',
              style: TextStyle(color: ColorRes.colorPrimary),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Value',
              style: TextStyle(color: ColorRes.colorPrimary),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Loyalty',
              style: TextStyle(color: ColorRes.colorPrimary),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'End Rel.',
              style: TextStyle(color: ColorRes.colorPrimary),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Row showTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkResponse(
          child: Image(
            image: AssetImage(Utils.getAssetsImg("back")),
            width: 40,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Container(
          alignment: Alignment.center,
          height: 40,
          margin: EdgeInsets.only(left: 10),
          padding: EdgeInsets.symmetric(horizontal: 40),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Utils.getAssetsImg("bg_blue")),
                  fit: BoxFit.fill)),
          child: Text(
            'Existing Customers',
            style: TextStyle(color: ColorRes.colorPrimary, fontSize: 22),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  Widget showItem(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 5),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Utils.getAssetsImg("bg_rounded_1")),
                    fit: BoxFit.fill)),
            child: Text(
              'Mobile Dev.',
              style: TextStyle(color: ColorRes.blue, fontSize: 15),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 5),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Utils.getAssetsImg("bg_rounded_2")),
                    fit: BoxFit.fill)),
            child: Text(
              'Mobile Dev.',
              style: TextStyle(color: ColorRes.blue, fontSize: 15),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 5),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Utils.getAssetsImg("bg_rounded_1")),
                    fit: BoxFit.fill)),
            child: Text(
              '25 \$',
              style: TextStyle(color: ColorRes.blue, fontSize: 15),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 5),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Utils.getAssetsImg("bg_rounded_1")),
                    fit: BoxFit.fill)),
            child: Text(
              '25 d',
              style: TextStyle(color: ColorRes.blue, fontSize: 15),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            height: 35,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 5),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Utils.getAssetsImg("close")),
                    fit: BoxFit.fitHeight)),
          ),
        ),
      ],
    );
  }
}
