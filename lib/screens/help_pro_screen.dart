import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/help_model.dart';

class HelpProScreen extends StatefulWidget {
  @override
  _HelpProScreenState createState() => _HelpProScreenState();
}

class _HelpProScreenState extends State<HelpProScreen> {
  String icons;
  String title;
  String description;
  static int selectedIndex = 0;
  static List<HelpModel> helpList = List<HelpModel>();

  PageController pageController = PageController(
    initialPage: selectedIndex,
    keepPage: true,
  );

  PageController pageIconController = PageController(
    initialPage: selectedIndex,
    keepPage: true,
  );

  List<String> arrType = List();
  HelpModel helpModel;



  void getText() {
    helpModel = new HelpModel();
    helpModel.title = "title 1";
    helpModel.icons = "ic_pro_profile.png";
    helpModel.description = Utils.getText(context, StringRes.strProProfile);
    helpList.add(helpModel);

    helpModel = new HelpModel();
    helpModel.title = "title 1";
    helpModel.icons = "ic_pro_profile.png";
    helpModel.description = Utils.getText(context, StringRes.strProProfile);
    helpList.add(helpModel);

    helpModel = new HelpModel();
    helpModel.title = "title 1";
    helpModel.icons = "ic_pro_profile.png";
    helpModel.description = Utils.getText(context, StringRes.strProProfile);
    helpList.add(helpModel);

    helpModel = new HelpModel();
    helpModel.title = "title 1";
    helpModel.icons = "ic_pro_profile.png";
    helpModel.description = Utils.getText(context, StringRes.strProProfile);
    helpList.add(helpModel);

    helpModel = new HelpModel();
    helpModel.title = "title 1";
    helpModel.icons = "ic_pro_profile.png";
    helpModel.description = Utils.getText(context, StringRes.strProProfile);
    helpList.add(helpModel);

    print(helpList);
  }

  @override
  Widget build(BuildContext context) {
    getText();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.only(
            left: Utils.getDeviceHeight(context) / 15,
            right: Utils.getDeviceHeight(context) / 15),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            centerCard(context),
            titleImage(context),
            previous(context),
            next(context)
          ],
        ),
      ),
    );
  }

  Widget centerCard(BuildContext context) {
    return Container(
        width: Utils.getDeviceWidth(context) / 1.5,
        height: Utils.getDeviceHeight(context) / 2.2,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 28, left: 10, right: 10, bottom: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: ColorRes.helpProBox, width: 5),
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
        child: Center(
          child: PageView.builder(
            controller: pageController,
            itemCount: helpList.length,
            itemBuilder: (context, position) {
              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(helpList[position].title,
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .copyWith(color: ColorRes.helpProBox)),
                      SizedBox(height: 9),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 50, right: 50, top: 8, bottom: 8),
                          child: Text(helpList[position].description)),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }

  Widget titleImage(BuildContext context) {
    return Positioned(
        top: Utils.getDeviceWidth(context) / 11,
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: Utils.getDeviceHeight(context) / 5,
            width: Utils.getDeviceHeight(context) / 5,
            child: Center(
                child: PageView.builder(
              controller: pageIconController,
              itemCount: helpList.length,
              itemBuilder: (context, position) {
                return Image.asset(
                  Utils.getAssetsImg(helpList[position].icons),
                  fit: BoxFit.fill,
                );
              },
            )),
            decoration: BoxDecoration(
                color: ColorRes.titleBlueProf, shape: BoxShape.circle),
          ),
        ));
  }

  Widget next(BuildContext context) {
    if (selectedIndex == helpList.length) {
      return Align(
        alignment: Alignment.centerLeft,
        child: InkResponse(
          child: Container(
            width: Utils.getDeviceHeight(context) / 10,
            height: Utils.getDeviceHeight(context) / 10,
            decoration: BoxDecoration(
                color: ColorRes.whiteTransparent,
                borderRadius: BorderRadius.all(Radius.circular(35))),
            child: Icon(Icons.chevron_left),
          ),
        ),
      );
    }
    return Align(
      alignment: Alignment.centerRight,
      child: InkResponse(
        child: Container(
          width: Utils.getDeviceHeight(context) / 10,
          height: Utils.getDeviceHeight(context) / 10,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(35))),
          child: Icon(Icons.chevron_right),
        ),
        onTap: () {
          setState(() {
            selectedIndex++;
            pageController.animateToPage(selectedIndex,
                duration: Duration(milliseconds: 500), curve: Curves.ease);
            pageIconController.animateToPage(selectedIndex,
                duration: Duration(milliseconds: 500), curve: Curves.ease);
          });
        },
      ),
    );
  }

  Widget previous(BuildContext context) {
    if (selectedIndex <= 0) {
      return Align(
        alignment: Alignment.centerLeft,
        child: InkResponse(
          child: Container(
            width: Utils.getDeviceHeight(context) / 10,
            height: Utils.getDeviceHeight(context) / 10,
            decoration: BoxDecoration(
                color: ColorRes.whiteTransparent,
                borderRadius: BorderRadius.all(Radius.circular(35))),
            child: Icon(Icons.chevron_left),
          ),
        ),
      );
    }
    return Align(
      alignment: Alignment.centerLeft,
      child: InkResponse(
        child: Container(
          width: Utils.getDeviceHeight(context) / 10,
          height: Utils.getDeviceHeight(context) / 10,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(35))),
          child: Icon(Icons.chevron_left),
        ),
        onTap: () {
          setState(() {
            selectedIndex--;
            pageController.animateToPage(selectedIndex,
                duration: Duration(milliseconds: 500), curve: Curves.ease);
            pageIconController.animateToPage(selectedIndex,
                duration: Duration(milliseconds: 500), curve: Curves.ease);
          });
        },
      ),
    );
  }

  static showIcons() {
    return 'ic_pro_home_organization';
    /*if (getSelectedType() == Const.typeOrg) {
      return 'ic_pro_home_organization';
    } else if (getSelectedType() == Const.typePl) {
      return 'ic_pro_home_pl';
    } else if (getSelectedType() == Const.typeRanking) {
      return 'ic_pro_home_ranking';
    } else if (getSelectedType() == Const.typeReward) {
      return 'ic_pro_home_rewards';
    } else if (getSelectedType() == Const.typeTeam) {
      return 'ic_pro_home_team';
    } else if (getSelectedType() == Const.typeChallenges) {
      return 'ic_pro_home_challenges';
    } else if (getSelectedType() == Const.typeBusinessSector) {
      return 'ic_pro_home_business';
    } else if (getSelectedType() == Const.typeNewCustomer) {
      return 'ic_pro_home_customer';
    } else if (getSelectedType() == Const.typeExistingCustomer) {
      return 'ic_pro_home_exis_customer';
    } else if (getSelectedType() == Const.typeProfile) {
      return '';
    } else if (getSelectedType() == Const.typeEmployee) {
      return '';
    } else if (getSelectedType() == Const.typeSalesPersons) {
      return '';
    } else if (getSelectedType() == Const.typeServicesPerson) {
      return '';
    } else if (getSelectedType() == Const.typeBrandValue) {
      return '';
    } else if (getSelectedType() == Const.typeMoney) {
      return '';
    }*/
  }

  List<String> initFeatureDataArray() {
    List<String> arrTypeData = List();

    arrTypeData.add(Const.typeProfile);
    arrTypeData.add(Const.typeName);

    if (Utils.isFeatureOn(Const.typeOrg)) {
      arrTypeData.add(Const.typeEmployee);
      arrTypeData.add(Const.typeSalesPersons);
      arrTypeData.add(Const.typeServicesPerson);
    }
    arrTypeData.add(Const.typeBrandValue);
    arrTypeData.add(Const.typeMoney);

    arrTypeData.add(Const.typeBusinessSector);
    arrTypeData.add(Const.typeNewCustomer);
    arrTypeData.add(Const.typeExistingCustomer);

    if (Utils.isFeatureOn(Const.typeReward)) arrTypeData.add(Const.typeReward);

    if (Utils.isFeatureOn(Const.typeTeam) && Injector.isManager())
      arrTypeData.add(Const.typeTeam);
    if (Utils.isFeatureOn(Const.typeChallenges))
      arrTypeData.add(Const.typeChallenges);

    if (Utils.isFeatureOn(Const.typeOrg)) arrTypeData.add(Const.typeOrg);
    if (Utils.isFeatureOn(Const.typePl)) arrTypeData.add(Const.typePl);

    if (Utils.isFeatureOn(Const.typeRanking))
      arrTypeData.add(Const.typeRanking);

    return arrTypeData;
  }
}
