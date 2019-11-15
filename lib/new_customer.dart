import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';

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
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Utils.getAssetsImg('bg_dashboard_trans')),
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
      height: 30,
      margin: EdgeInsets.only(left: 0,right: 4,top: 5,bottom: 5),
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
            flex: 3,
            child: Text(
              'Resourses',
              style: TextStyle(color: ColorRes.colorPrimary),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Engage',
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
            width: DimenRes.titleBarHeight,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Container(
          alignment: Alignment.center,
          height: DimenRes.titleBarHeight,
          margin: EdgeInsets.only(left: 10),
          padding: EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Utils.getAssetsImg("bg_blue")),
                  fit: BoxFit.fill)),
          child: Text(
            'New Customers',
            style: TextStyle(
                color: ColorRes.colorPrimary, fontSize: DimenRes.titleTextSize),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  Widget showItem(int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
       Expanded(
         child:  Container(
           height: 25,
             padding: EdgeInsets.only(left: 10),
             decoration: BoxDecoration(
                 image: DecorationImage(
                     image: AssetImage(Utils.getAssetsImg("bg_record_customer")),
                     fit: BoxFit.fill)),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 Expanded(
                   flex: 4,
                   child: Text(
                     'New Customers',
                     style: TextStyle(color: ColorRes.white, fontSize: 13,),textAlign: TextAlign.center,
                   ),
                 ),
                 Expanded(
                   flex: 5,
                   child: Text(
                     'Mobile Dev.',
                     style: TextStyle(color: ColorRes.white, fontSize: 13),textAlign: TextAlign.center,
                   ),
                 ),
                 Expanded(
                   flex: 3,
                   child: Text(
                     '25 \$',
                     style: TextStyle(color: ColorRes.white, fontSize: 13),textAlign: TextAlign.center,
                   ),
                 ),
                 Expanded(
                   flex: 3,
                   child: Text(
                     '25 d',
                     style: TextStyle(color: ColorRes.white, fontSize: 13),textAlign: TextAlign.center,
                   ),
                 ),
                 Expanded(
                   flex: 3,
                   child: Text(
                     '8',
                     style: TextStyle(color: ColorRes.white, fontSize: 15),textAlign: TextAlign.center,
                   ),
                 ),
               ],
             )
         ),
       ),
        Container(
          height: 28,
          width: 80,
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 2,right: 2,top: 2),
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Utils.getAssetsImg("engage_now")),
                  fit: BoxFit.fill)),
        ),
      ],
    );
  }
}
