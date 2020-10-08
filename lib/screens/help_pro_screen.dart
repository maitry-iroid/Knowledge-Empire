import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/help_model.dart';
import 'package:ke_employee/screens/profile.dart';

/*
*   created by Riddhi
*
*   User can get brief details about all the features here
*
* */

class HelpProScreen extends StatefulWidget {
  @override
  _HelpProScreenState createState() => _HelpProScreenState();
}

class _HelpProScreenState extends State<HelpProScreen> {
  String icons;
  String title;
  String description;
  static int selectedIndex = 0;
  List<HelpModel> helpList = List<HelpModel>();

  PageController pageController = PageController(
    initialPage: selectedIndex,
    keepPage: true,
  );

  PageController pageIconController = PageController(
    initialPage: selectedIndex,
    keepPage: true,
  );

  HelpModel helpModel;

  Future<void> getText() async {
    initFeatureDataArray();
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
            next(context),
            Positioned(
                right: 10,
                top: 30,
                child: InkResponse(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg('close_dialog')),
                      width: 20,
                    ),
                  ),
                  onTap: () {
                    Utils.playClickSound();
                    Navigator.pop(context, null);
                  },
                ))
          ],
        ),
      ),
    );
  }

  Widget centerCard(BuildContext context) {
    return Container(
        width: Utils.getDeviceWidth(context) / 1.5,
        height: Utils.getDeviceHeight(context) / 1.6,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 28, left: 10, right: 10, bottom: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: ColorRes.helpProBox, width: 5),
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
        child: PageView.builder(
          physics: new NeverScrollableScrollPhysics(),
          controller: pageController,
          itemCount: helpList.length,
          itemBuilder: (context, position) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: Utils.getDeviceWidth(context) / 13),

                  Center(
                    child: Text(helpList[position].title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .copyWith(color: ColorRes.helpProBox,fontSize: 20)),
                  ),
                  SizedBox(height: 9),
                  Padding(
                      padding: EdgeInsets.only(
                          left: 50, right: 50, top: 8, bottom: 8),
                      child: Text(helpList[position].description,
                          style: Theme.of(context)
                              .textTheme
                              .subhead
                              .copyWith(fontWeight: FontWeight.w400,fontSize: 20))),
                  SizedBox(height: Utils.getDeviceWidth(context) / 21),
                ],
              ),
            );
          },
        ));
  }

  Widget titleImage(BuildContext context) {
    return Positioned(
        top: Utils.getDeviceWidth(context) / 18,
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: Utils.getDeviceHeight(context) / 4.5,
            width: Utils.getDeviceHeight(context) / 4.5,
            child: Center(
                child: PageView.builder(
              physics: new NeverScrollableScrollPhysics(),
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
        alignment: Alignment.centerRight,
        child: InkResponse(
          child: Container(
            width: Utils.getDeviceHeight(context) / 10,
            height: Utils.getDeviceHeight(context) / 10,
            decoration: BoxDecoration(
                color: ColorRes.whiteTransparent,
                borderRadius: BorderRadius.all(Radius.circular(35))),
            child: Icon(Icons.chevron_right),
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

  List<HelpModel> initFeatureDataArray() {
    helpList = new List<HelpModel>();

    addInModel(Utils.getText(context, StringRes.profile), "ic_pro_profile",
        Utils.getText(context, StringRes.strProProfile));

    if (Utils.isFeatureOn(Const.typeOrg)) {
      addInModel(Utils.getText(context, StringRes.empOMaster), "book",
          Utils.getText(context, StringRes.strEmpOMeter));
      addInModel(Utils.getText(context, StringRes.salesOMeter), "employee_prof_ic",
          Utils.getText(context, StringRes.strSalesOMeter));
      addInModel(Utils.getText(context, StringRes.serviceOMeter), "bulb",
          Utils.getText(context, StringRes.strServiceOMeter));
    }
    addInModel(
        Utils.getText(context, StringRes.strBrandValueTitle),
        "question",
        Utils.getText(context, StringRes.strBrandValue));

    addInModel(Utils.getText(context, StringRes.value), "brain",
        Utils.getText(context, StringRes.strCash));

    addInModel(
        Utils.getText(context, StringRes.businessSector),
        "ic_pro_home_business",
        Utils.getText(context, StringRes.strBusinessSector));

    addInModel(
        Utils.getText(context, StringRes.newCustomers),
        "ic_pro_home_customer",
        Utils.getText(context, StringRes.strNewCustomer));

    addInModel(
        Utils.getText(context, StringRes.existingCustomers),
        "ic_pro_home_exis_customer",
        Utils.getText(context, StringRes.strExistingCustomer));


    if (Utils.isFeatureOn(Const.typeAchievement)) {
      addInModel(Utils.getText(context, StringRes.achievement),
          "ic_pro_home_achievement", Utils.getText(context, StringRes.strAchievement));
    }
    if (Utils.isFeatureOn(Const.typeReward)) {
      addInModel(Utils.getText(context, StringRes.rewards),
          "ic_pro_home_rewards", Utils.getText(context, StringRes.strReward));
    }

    if (Utils.isFeatureOn(Const.typeTeam) && Injector.isManager()) {
      addInModel(Utils.getText(context, StringRes.team), "ic_pro_home_team",
          Utils.getText(context, StringRes.strTeam));
    }

    if (Utils.isFeatureOn(Const.typeChallenges)) {
      addInModel(
          Utils.getText(context, StringRes.challenges),
          "ic_pro_home_challenges",
          Utils.getText(context, StringRes.strChallenges));
    }

    if (Utils.isFeatureOn(Const.typeOrg)) {
      addInModel(
          Utils.getText(context, StringRes.organizations),
          "ic_pro_home_organization",
          Utils.getText(context, StringRes.strOrganization));
    }
    if (Utils.isFeatureOn(Const.typePl)) {
      addInModel(Utils.getText(context, StringRes.pl), "ic_pro_home_pl",
          Utils.getText(context, StringRes.strPL));
    }

    if (Utils.isFeatureOn(Const.typeRanking)) {
      addInModel(Utils.getText(context, StringRes.ranking),
          "ic_pro_home_ranking", Utils.getText(context, StringRes.strRanking));
    }

    return helpList;
  }

  addInModel(String title, String icon, String description) {
    helpModel = new HelpModel();
    helpModel.title = title;
    helpModel.icons = icon;
    helpModel.description = description;
    helpList.add(helpModel);
  }
}
