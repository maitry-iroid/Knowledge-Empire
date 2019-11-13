import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'helper/Utils.dart';
import 'helper/res.dart';

class BusinessSectorPage extends StatefulWidget {
  @override
  _BusinessSectorPageState createState() => _BusinessSectorPageState();
}

class _BusinessSectorPageState extends State<BusinessSectorPage> {
  var arrSector = ["Healthcare", "Industrials", "Technology", "Financials"];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Utils.getAssetsImg('bg_dashboard_trans')),
              fit: BoxFit.fill)),
      child: Row(
        children: <Widget>[showFirstHalf(), showSecondHalf()],
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
            width: 35,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Container(
          alignment: Alignment.center,
          height: 35,
          margin: EdgeInsets.only(left: 10),
          padding: EdgeInsets.symmetric(horizontal: 40),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Utils.getAssetsImg("bg_blue")),
                  fit: BoxFit.fill)),
          child: Text(
            'Business Sector',
            style: TextStyle(color: ColorRes.colorPrimary, fontSize: 17),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  Container showSubHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Utils.getAssetsImg("bg_rounded")),
              fit: BoxFit.fill)),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Text(
              'Sector',
              style: TextStyle(color: ColorRes.colorPrimary),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Size',
              style: TextStyle(color: ColorRes.colorPrimary),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget showItem(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 8,
          child: Container(
            height: 32,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage(Utils.getAssetsImg("bg_new_customer_item")),
                    fit: BoxFit.fill)),
            child: Text(
              arrSector[index],
              style: TextStyle(color: ColorRes.blue, fontSize: 15),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            height: 35,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 5, right: 10),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Utils.getAssetsImg("value")),
                    fit: BoxFit.fill)),
            child: Text(
              '10',
              style: TextStyle(color: ColorRes.white, fontSize: 22),
            ),
          ),
        ),
      ],
    );
  }

  showFirstHalf() {
    return Expanded(
      flex: 1,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          showTitle(),
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.only(left: 10, right: 10, top: 2,bottom: 2),
//            color: ColorRes.lightBg,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    alignment: Alignment.center,
                    child: TextField(
                      textAlign: TextAlign.center,
//                      controller: searchCtrl,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
//                        hintText: 'Search for keywords',
                        hintStyle: TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        fillColor: ColorRes.colorPrimary,
                      ),
                    ),
                  )
                ),
                SizedBox(width: 5,),
                Image(
                  height: 35,
                  image: AssetImage(
                    Utils.getAssetsImg("search"),
                  ),
                  fit: BoxFit.fill,
                )
              ],
            ),
          ),
          showSubHeader(),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return showItem(index);
              },
            ),
          )
        ],
      ),
    );
  }

  showSecondHalf() {
    return Expanded(
      flex: 1,
      child: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                height: double.infinity,
                child: Stack(
                  children: <Widget>[
                    Card(
                      elevation: 10,
                                            color: ColorRes.whiteDarkBg,
                      margin: EdgeInsets.only(top: 20,bottom: Utils.getDeviceHeight(context)/7),
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 30, bottom: 10),
                        decoration: BoxDecoration(
                          color: ColorRes.bgDescription,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: ColorRes.colorPrimary, width: 1),
                        ),
                        child: SingleChildScrollView(
                          child: Text(
                            "qwywer shankar riddhi govindbhaoqwywer shankar riddhi govindbhaoqwywer shankar riddhi govindbhaoqwywer shankar riddhi govindbhaoqwywer shankar riddhi govindbhaoqwywer shankar ",
                            style: TextStyle(color: ColorRes.colorPrimary),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        alignment: Alignment.center,
                        height: 35,
                        margin: EdgeInsets.symmetric(horizontal: Utils.getDeviceWidth(context)/10),
                        padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                AssetImage(Utils.getAssetsImg("bg_blue")),
                                fit: BoxFit.fill)),
                        child: Text(
                          'Description',
                          style: TextStyle(
                              color: ColorRes.colorPrimary, fontSize: 17),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      child: InkResponse(
                        child:  Image(image: AssetImage(Utils.getAssetsImg("engage_segment")),),
                      ),
                    )
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
