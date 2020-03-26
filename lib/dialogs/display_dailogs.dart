import 'package:flutter/material.dart';
import 'package:ke_employee/dialogs/intro_sreen_dailog.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/questions.dart';

class DisplayDialogs {
  //todo li_wei  image configuration
  static double liWeiImageHeight = 2.10;
  static double liWeiImageWidth = 2.7;
  static double liWeiImageMoveRight = 8.5;
  static double liWeiImageMoveTop = 5.2;

  //todo hrNiki  image configuration
  static double hrNikiImageHeight = 1.25;
  static double hrNikiImageWidth = 2.5;
  static double hrNikiImageMoveRight = 8.0;
  static double hrNikiImageMoveTop = 50.0;

  //todo tina image configuration
  static double tinaImageHeight = 2.10;
  static double tinaImageWidth = 2.5;
  static double tinaImageMoveRight = 7.5;
  static double tinaImageMoveTop = 5.2;

  //todo tina image configuration
  static double bobImageHeight = 2.10;
  static double bobImageWidth = 2.5;
  static double bobImageMoveRight = 9.5;
  static double bobImageMoveTop = 6.3;

  //todo tina image configuration
  static double willImageHeight = 2.10;
  static double willImageWidth = 2.5;
  static double willImageMoveRight = 7.5;
  static double willImageMoveTop = 5.2;

  //todo lydia image configuration
  static double lydiaImageHeight = 1.25;
  static double lydiaImageWidth = 2.5;
  static double lydiaImageMoveRight = 8.0;
  static double lydiaImageMoveTop = 70.0;

  //todo lydia akiki configuration
  static double akikoImageHeight = 1.25;
  static double akikoImageWidth = 2.9;
  static double akikoImageMoveRight = 6.3;
  static double akikoImageMoveTop = 80.0;

  //todo  This dialogs only for Dashboard Game screen
  static showChallengeDialog(
      BuildContext context, String userName, QuestionData questionData) {
    showDialog(
        context: context,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: Utils.getDeviceWidth(context) / 2.25,
            height: Utils.getDeviceHeight(context) / 2.25,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Your are challenged by $userName in module\nYou have to attempt all 3 challenges to win ${questionData.winningAmount}",
                      style: Theme.of(context).textTheme.title,textAlign: TextAlign.center,),
                  SizedBox(height: 20),
                  RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Utils.showChallengeQuestionDialog(context, questionData);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: ColorRes.colorPrimary,
                      child: Text(Utils.getText(context, StringRes.next),
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .copyWith(color: ColorRes.white)))
                ],
              ),
            ),
          ),
        ));
  }

  static showIntroKnowledgeEmpire(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            imageName: "john",
            titleText: "Wellcome to Knowledge Empire",
            btnName: "Click on your Profile",
            desTextLine:
                "Dear ${Injector.userData?.name}, \n\nMy name is Mike, your Head of Operations.\nAre you ready to becom CEO of your own virtual company?\nClick on your name \"\profile\" in the\nnavigation menu(\">\""
                ").",
            onTapBtn: () {
              Navigator.pop(context);
              Injector.homeStreamController?.add("${Const.typeProfile}");
            },
          );
        });
  }

  static showMeetYourTeamDialog(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            imageName: "john",
            titleText: "Meet your team",
            btnName: "Click the Org Chart",
            desTextLine:
                "Click the orgchart to have an overview of your organisation.\nYou get to hire and fire people as you want!\nTo get started you will need to hire some HR, Sales and Service\nemployees",
            onTapBtn: () async {
              try {
                Navigator.of(context).pop();
                Utils.performDashboardItemClick(context, Const.typeOrg);
              } catch (e) {
                print(e);
              }
            },
          );
        });
  }

  //todo  This dialogs only for Profile screen
  static Future<Widget> showIntroDialog(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            imageName: "john",
            titleText: Utils.getText(context, StringRes.customizeYourCompany),
            btnName: Utils.getText(context, StringRes.next),
            btnColor: ColorRes.blue,
            desTextLine: Utils.getText(context, StringRes.customizeYourCompanyContent),
//            desTextLine: "Dear ${Injector.userData?.name},\n\nMy name is Mike, your Head of Operations.\nAre you ready to become CEO of your own virtual company?\nUpload a profile picture and edit your company name then click \"save\"",
            onTapBtn: () async {
              try {
                Injector.introData.profile1 = 1;
                await Injector.setIntroData(Injector.introData);
                showSettingsDialog(context);
                Navigator.of(context).pop();
              } catch (e) {
                print(e);
              }
            },
          );
        });
  }

  static showSettingsDialog(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            imageName: "john",
            titleText: Utils.getText(context, StringRes.settings),
            btnName: Utils.getText(context, StringRes.gotIt),
            btnColor: ColorRes.blue,
            desTextLine: Utils.getText(context, StringRes.settingDetails),
            onTapBtn: () async {
              try {
                Injector.introData.profile2 = 1;
                await Injector.setIntroData(Injector.introData);

                Navigator.of(context).pop();
              } catch (e) {
                print(e);
              }
            },
          );
        });
  }

  //todo  This dialogs only for Organization screen
  static Future<Widget> showHireHRDialog(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            imageName: "hr_niki",
            titleText: Utils.getText(context, StringRes.hireHrEmp),
            btnName: Utils.getText(context, StringRes.next),
            btnColor: ColorRes.blue,
            imageMoveTop: 8.5,
            imageMoveRight: 8,
            desTextLine: Utils.getText(context, StringRes.hireHrEmpDetails),
            onTapBtn: () async {
              Navigator.pop(context);
              Injector.introData.org1 = 1;
              await Injector.setIntroData(Injector.introData);
              showHireHRBoardDialog(context);
            },
          );
        });
  }

  static Future<Widget> showHireHRBoardDialog(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            imageName: "hr_niki",
            imageMoveTop: 8.5,
            imageMoveRight: 8,
            titleText: Utils.getText(context, StringRes.hireHrEmp)??"",
//            btnName: StringRes.next,
            btnColor: ColorRes.blue,
            desTextLine: Utils.getText(context, StringRes.hireHrEmpDetailsSeconds)??"",
            onTapBtn: () async {
              Navigator.pop(context);
              Injector.introData.org2 = 1;
              await Injector.setIntroData(Injector.introData);
              showEmployOMeterDialog(context);
            },
          );
        });
  }

  static Future<Widget> showEmployOMeterDialog(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            imageName: "hr_niki",
            imageMoveTop: 8.5,
            imageMoveRight: 8,
            titleText: Utils.getText(context, StringRes.empOMaster)??"",
            btnName: Utils.getText(context, StringRes.next),
            btnColor: ColorRes.blue,
            desTextLine:
            Utils.getText(context, StringRes.empOMasterDetails)??"",
            onTapBtn: () async {
              Navigator.pop(context);
              Injector.introData.org3 = 1;
              await Injector.setIntroData(Injector.introData);
              showCostOfEmployees(context);
            },
          );
        });
  }

  static Future<Widget> showCostOfEmployees(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            imageName: "hr_niki",
            imageMoveTop: 8.5,
            imageMoveRight: 8,
            titleText: Utils.getText(context, StringRes.costOfEmp)??"",
            btnName: Utils.getText(context, StringRes.gotIt),
            btnColor: ColorRes.blue,
            desTextLine: Utils.getText(context, StringRes.costOfEmpDetails)??"",
            onTapBtn: () async {
              Navigator.pop(context);
              Injector.introData.org4 = 1;
              await Injector.setIntroData(Injector.introData);
            },
          );
        });
  }

  static Future<Widget> showGetReadyToApproachCustomers(
      BuildContext context, GestureDragCancelCallback onTap) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            imageName: "hr_niki",
            imageMoveTop: hrNikiImageMoveTop,
            imageMoveRight: hrNikiImageMoveRight,
            imageHeight: hrNikiImageHeight,
            imageWidth: hrNikiImageWidth,
            titleText: "Get ready to approach customers",
            btnName: "Click on Sale",
            desTextLine:
                "In order to win new customer you need to have Sales Reprs.\n\nLet's hire 10 Sales Reps by clicking on Sales and then \"Hire 10 employees.\"",
            onTapBtn: onTap,
            /*onTapBtn: () async {
        Navigator.pop(context);
        await Injector.updateIntroDialogType(Const.introSalesOMeter);
        showSalesOMeter(context);
      },*/
          );
        });
  }

  static Widget showSalesOMeter(
      BuildContext context, GestureDragCancelCallback onTap) {
    return IntroScreenDialog(
      menuView: false,
      imageName: "hr_niki",
      imageMoveTop: hrNikiImageMoveTop,
      imageMoveRight: hrNikiImageMoveRight,
      imageHeight: hrNikiImageHeight,
      imageWidth: hrNikiImageWidth,
      titleText: "Sale-O-Meter",
      btnName: "next",
      btnColor: ColorRes.blue,
      desTextLine:
          "Note that your Sale-o-Meter shows 10/10\nThe last number shows your current number of Sales Rep.\nThe first number shows how many of them are currently available.\n\nEngaging customers will keep Sale Reps busy for 8 hours.",
      onTapBtn: onTap,
      /* onTapBtn: () async {
              Navigator.pop(context);
              await Injector.updateIntroDialogType(
                  Const.introGetReadyToServeCustomers);
              showGetReadyToServeCustomers(context);
            },*/
    );
  }

  static Widget showGetReadyToServeCustomers(
      BuildContext context, GestureDragCancelCallback onTap) {
    return IntroScreenDialog(
      menuView: false,
      imageName: "hr_niki",
      imageMoveTop: hrNikiImageMoveTop,
      imageMoveRight: hrNikiImageMoveRight,
      imageHeight: hrNikiImageHeight,
      imageWidth: hrNikiImageWidth,
      titleText: "Get ready to serve customer",
      btnName: "Click on  Service",
      desTextLine:
          "In order to serve/provide serives to existing customers you need to\nhave one Sales Representatives per customer.\n\nLet's hire 10 Service Reps by clicking on Service and then \"Hire 10 employees.\"",
      onTapBtn: onTap,
      /*onTapBtn: () async {
        Navigator.pop(context);
        await Injector.updateIntroDialogType(
            Const.introReadyForSeriousBusiness);
        showServiceOMeter(context);
      },*/
    );
  }

  static Widget showServiceOMeter(
      BuildContext context, GestureDragCancelCallback onTap) {
    return IntroScreenDialog(
      menuView: false,
      imageName: "hr_niki",
      imageMoveTop: hrNikiImageMoveTop,
      imageMoveRight: hrNikiImageMoveRight,
      imageHeight: hrNikiImageHeight,
      imageWidth: hrNikiImageWidth,
      titleText: "Service-O-Meter",
      btnName: "Click on  Service",
      desTextLine:
          "Note that your Service-o-meter shows 10/10.\nThe last number shows your current number of Service Rep.\nThe first number shows how many of them are currently available.\n\nEach existing customer will keep 1 service Rep. occupied.",
      onTapBtn: onTap,
      /*onTapBtn: () async {
        Navigator.pop(context);
        await Injector.updateIntroDialogType(
            Const.introReadyForSeriousBusiness);
        showReadyForSeriousBusiness(context);
      },*/
    );
  }

  static Widget showReadyForSeriousBusiness(
      BuildContext context, GestureDragCancelCallback onTap) {
    return IntroScreenDialog(
      menuView: true,
      imageName: "hr_niki",
      imageMoveTop: hrNikiImageMoveTop,
      imageMoveRight: hrNikiImageMoveRight,
      imageHeight: hrNikiImageHeight,
      imageWidth: hrNikiImageWidth,
      titleText: "Ready for serious business",
      btnName: "Go to \"Business Sectors\"",
      desTextLine:
          "Great, you are all set for business.\nLets's head over to the newspaper to select the first business sector\nthat you want to engage in.\n\nYou can click on the menu \">\" and then \"Business Sectors\"",
      onTapBtn: onTap,
      /*onTapBtn: () async {
        Navigator.pop(context);
        await Injector.updateIntroDialogType(
            Const.introCustomerRelationshipManagement);
      },*/
    );
  }

  //todo  This dialogs only for Business sector screen
  static showCustomerRelationshipManagement(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            imageName: "li_wei",
            imageMoveRight: liWeiImageMoveRight,
            imageMoveTop: liWeiImageMoveTop,
            imageHeight: liWeiImageHeight,
            imageWidth: liWeiImageWidth,
            titleText: Utils.getText(context, StringRes.customerRelation),
            btnName: Utils.getText(context, StringRes.next),
            btnColor: ColorRes.blue,
            desTextLine: Utils.getText(context, StringRes.customerRelationDetails),
            onTapBtn: () async {
              Navigator.pop(context);

              Injector.introData.learningModule1 = 1;
              await Injector.setIntroData(Injector.introData);

              showAreaOfCompetency(context);
            },
          );
        });
  }

  static showAreaOfCompetency(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            imageName: "li_wei",
            imageMoveRight: liWeiImageMoveRight,
            imageMoveTop: liWeiImageMoveTop,
            imageHeight: liWeiImageHeight,
            imageWidth: liWeiImageWidth,
            titleText: Utils.getText(context, StringRes.areaOfComp),
            btnName: Utils.getText(context, StringRes.next),
            btnColor: ColorRes.blue,
            desTextLine: Utils.getText(context, StringRes.areaOfCompDetails),
            onTapBtn: () async {
              Navigator.pop(context);
              Injector.introData.learningModule2 = 1;
              await Injector.setIntroData(Injector.introData);
              //     showIntroAccesToYourFirstCustomers(context);
            },
          );
        });
  }

  static showIntroAccesToYourFirstCustomers(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            imageName: "li_wei",
            imageMoveRight: liWeiImageMoveRight,
            imageMoveTop: liWeiImageMoveTop,
            imageHeight: liWeiImageHeight,
            imageWidth: liWeiImageWidth,
            titleText: Utils.getText(context, StringRes.accessToFirst),
            btnName: Utils.getText(context, StringRes.accessToFirstBtn),
            desTextLine: Utils.getText(context, StringRes.accessToFirstDetails),
            onTapBtn: () async {
              Navigator.pop(context);

              showReadyForYourFirstCustomerContact(context);
            },
          );
        });
  }

  static showReadyForYourFirstCustomerContact(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: true,
            imageName: "li_wei",
            imageMoveRight: liWeiImageMoveRight,
            imageMoveTop: liWeiImageMoveTop,
            imageHeight: liWeiImageHeight,
            imageWidth: liWeiImageWidth,
            titleText: Utils.getText(context, StringRes.readyForCustomer),
            btnName: Utils.getText(context, StringRes.readyForCustomerBtn),
            desTextLine: Utils.getText(context, StringRes.readyForCustomerDetails),
            onTapBtn: () async {
              Navigator.pop(context);

            },
          );
        });
  }

  //todo  This dialogs only for New Customer screen
  static showIntroHeartOfTheBusiness(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            imageName: "tina",
            imageMoveRight: tinaImageMoveRight,
            imageMoveTop: 5.2,
            imageHeight: tinaImageHeight,
            imageWidth: tinaImageWidth,
            titleText: Utils.getText(context, StringRes.heartBusiness),
            btnColor: ColorRes.blue,
            btnName: Utils.getText(context, StringRes.next),
            desTextLine: Utils.getText(context, StringRes.heartBusinessDetails),
            onTapBtn: () async {
              Navigator.pop(context);
              Injector.introData.newCustomer1 = 1;
              await Injector.setIntroData(Injector.introData);
              showListOfPotentialCustomers(context);
            },
          );
        });
  }

  static showListOfPotentialCustomers(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            imageName: "tina",
            imageMoveRight: tinaImageMoveRight,
            imageMoveTop: tinaImageMoveTop,
            imageHeight: tinaImageHeight,
            imageWidth: tinaImageWidth,
            titleText: Utils.getText(context, StringRes.listOfPotential),
            btnName: Utils.getText(context, StringRes.listOfPotentialBtn),
            btnColor: ColorRes.blue,
            desTextLine: Utils.getText(context, StringRes.listOfPotentialDetails),
            onTapBtn: () async {
              Navigator.pop(context);
              Injector.introData.newCustomer2 = 1;
              await Injector.setIntroData(Injector.introData);
            },
          );
        });
  }

  //todo  This dialogs only for engagement screen

  static showYourFirstEngagement(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            imageName: "tina",
            imageMoveRight: tinaImageMoveRight,
            imageMoveTop: tinaImageMoveTop,
            imageHeight: tinaImageHeight,
            imageWidth: tinaImageWidth,
            titleText: Utils.getText(context, StringRes.yourFirstEngagement),
            btnName: Utils.getText(context, StringRes.yourFirstEngagementBtn),
            desTextLine: Utils.getText(context, StringRes.yourFirstEngagementDetails),
            onTapBtn: () async {
              Navigator.pop(context);
            },
          );
        });
  }

  //todo  customer situation
  static showImpactOnSalesAndService(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            imageName: "tina",
            imageMoveRight: tinaImageMoveRight,
            imageMoveTop: tinaImageMoveTop,
            imageHeight: tinaImageHeight,
            imageWidth: tinaImageWidth,
            titleText: Utils.getText(context, StringRes.impactOnSales),
            btnName: Utils.getText(context, StringRes.next),
            btnColor: ColorRes.blue,
            desTextLine: Utils.getText(context, StringRes.impactOnSalesDetails),
            onTapBtn: () async {
              Navigator.pop(context);
//              await Injector.updateIntroDialogType(Const.introImpactOnBrandValueAndCash);
              Injector.introData.customerSituation = 1;
              await Injector.setIntroData(Injector.introData);
//              showImpactOnBrandValueAndCash(context);
            },
          );
        });
  }

  static showImpactOnBrandValueAndCash(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            imageName: "tina",
            imageMoveRight: tinaImageMoveRight,
            imageMoveTop: tinaImageMoveTop,
            imageHeight: tinaImageHeight,
            imageWidth: tinaImageWidth,
            titleText: Utils.getText(context, StringRes.impactOnBrand),
            btnName: Utils.getText(context, StringRes.next),
            btnColor: ColorRes.blue,
            desTextLine: Utils.getText(context, StringRes.impactOnBrandDetails),
            onTapBtn: () async {
              Navigator.pop(context);

              showCheckYourExistingCustomers(context);
            },
          );
        });
  }

  static showCheckYourExistingCustomers(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            imageName: "tina",
            imageMoveRight: tinaImageMoveRight,
            imageMoveTop: tinaImageMoveTop,
            imageHeight: tinaImageHeight,
            imageWidth: tinaImageWidth,
            titleText: Utils.getText(context, StringRes.checkYourCustomer),
            btnName: Utils.getText(context, StringRes.clickServiceBtn),
            desTextLine: Utils.getText(context, StringRes.checkYourCustomerDetails),
            onTapBtn: () async {
              Navigator.pop(context);

            },
          );
        });
  }

  //todo  This dialogs only for Existing Customer screen
  static showServingYourExistingCustomers(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            imageName: "bob",
            imageMoveRight: bobImageMoveRight,
            imageMoveTop: bobImageMoveTop,
            imageHeight: bobImageHeight,
            imageWidth: bobImageWidth,
            titleText: Utils.getText(context, StringRes.servingYourExisting),
            btnName: Utils.getText(context, StringRes.next),
            btnColor: ColorRes.blue,
            desTextLine: Utils.getText(context, StringRes.servingYourExistingDialog),
            onTapBtn: () async {
              Navigator.pop(context);
              Injector.introData.existingCustomer1 = 1;
              await Injector.setIntroData(Injector.introData);
//              await Injector.updateIntroDialogType(Const.introListOfExistingCustomers);
              showListOfExistingCustomers(context);
            },
          );
        });
  }

  static showListOfExistingCustomers(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            imageName: "bob",
            imageMoveRight: bobImageMoveRight,
            imageMoveTop: bobImageMoveTop,
            imageHeight: bobImageHeight,
            imageWidth: bobImageWidth,
            titleText: Utils.getText(context, StringRes.listOfExisting),
            btnName: Utils.getText(context, StringRes.next),
            btnColor: ColorRes.blue,
            desTextLine: Utils.getText(context, StringRes.listOfExistingDetails),
            onTapBtn: () async {
              Navigator.pop(context);
              Injector.introData.existingCustomer2 = 1;
              await Injector.setIntroData(Injector.introData);
              //showReadyForBusiness(context);
            },
          );
        });
  }

  static showReadyForBusiness(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            imageName: "bob",
            imageMoveRight: bobImageMoveRight,
            imageMoveTop: bobImageMoveTop,
            imageHeight: bobImageHeight,
            imageWidth: bobImageWidth,
            titleText: Utils.getText(context, StringRes.readyForBusiness),
            btnName: Utils.getText(context, StringRes.finishTutorial),
            btnColor: ColorRes.blue,
            desTextLine: Utils.getText(context, StringRes.readyForBusinessDeatils),
            onTapBtn: () async {
              Navigator.pop(context);

            },
          );
        });
  }

  //todo This dialogs only for Reward screen
  static showIntroRewards(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            imageName: "john",
            titleText: Utils.getText(context, StringRes.rewards),
            btnName: Utils.getText(context, StringRes.gotIt),
            desTextLine: Utils.getText(context, StringRes.rewardsDialogContent),
            btnColor: ColorRes.blue,
            onTapBtn: () async {
              Navigator.pop(context);

              Injector.introData.rewards = 1;
              await Injector.setIntroData(Injector.introData);
            },
          );
        });
  }

  //todo This dialogs only for Challenges screen
  static showYourWillIsAtYourCommand(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            imageName: "will",
            btnColor: ColorRes.blue,
            imageWidth: willImageWidth,
            imageHeight: willImageHeight,
            imageMoveTop: willImageMoveTop,
            imageMoveRight: willImageMoveRight,
            titleText: Utils.getText(context, StringRes.challengesDialogTitle1),
            btnName: Utils.getText(context, StringRes.next),
            desTextLine:
                Utils.getText(context, StringRes.challengesDialogContent1),
            onTapBtn: () async {
              Navigator.pop(context);
              Injector.introData.challenge1 = 1;
              await Injector.setIntroData(Injector.introData);
              showIntroChallenge(context);
            },
          );
        });
  }

  static showIntroChallenge(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            imageName: "will",
            btnColor: ColorRes.blue,
            imageWidth: willImageWidth,
            imageHeight: willImageHeight,
            imageMoveTop: willImageMoveTop,
            imageMoveRight: willImageMoveRight,
            titleText: Utils.getText(context, StringRes.strChallanges),
            btnName: Utils.getText(context, StringRes.gotIt),
            desTextLine:
                Utils.getText(context, StringRes.strChallangesDialogContent),
            onTapBtn: () async {
              Navigator.pop(context);
              Injector.introData.challenge2 = 1;
              await Injector.setIntroData(Injector.introData);
            },
          );
        });
  }

  //todo This dialogs only for Ranking screen
  static showMarketingAndCommunications(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            imageName: "lydia",
            btnColor: ColorRes.blue,
            imageWidth: lydiaImageWidth,
            imageHeight: lydiaImageHeight,
            imageMoveTop: lydiaImageMoveTop,
            imageMoveRight: lydiaImageMoveRight,
            titleText:
                Utils.getText(context, StringRes.strMarketingCommunications),
            btnName: Utils.getText(context, StringRes.next),
            desTextLine: Utils.getText(
                context, StringRes.strMarketingCommunicationsDialog),
            onTapBtn: () async {
              Navigator.pop(context);
              Injector.introData.ranking1 = 1;
              await Injector.setIntroData(Injector.introData);
              showRanking(context);
            },
          );
        });
  }

  static showRanking(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            imageName: "lydia",
            btnColor: ColorRes.blue,
            imageWidth: lydiaImageWidth,
            imageHeight: lydiaImageHeight,
            imageMoveTop: lydiaImageMoveTop,
            imageMoveRight: lydiaImageMoveRight,
            titleText: Utils.getText(context, StringRes.ranking),
            btnName: Utils.getText(context, StringRes.gotIt),
            desTextLine:
                Utils.getText(context, StringRes.strRankingDialogContent),
            onTapBtn: () async {
              Navigator.pop(context);
              Injector.introData.ranking2 = 1;
              await Injector.setIntroData(Injector.introData);
            },
          );
        });
  }

  //todo This dialogs only for Team screen
  static showYourTeamsPerformance(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            imageName: "hr_niki",
            imageMoveTop: hrNikiImageMoveTop,
            imageMoveRight: hrNikiImageMoveRight,
            imageHeight: hrNikiImageHeight,
            imageWidth: hrNikiImageWidth,
            titleText: Utils.getText(context, StringRes.strYourTeamPerformance),
            btnName: Utils.getText(context, StringRes.next),
            btnColor: ColorRes.blue,
            desTextLine:
                Utils.getText(context, StringRes.strYourTeamPerformanceDialog),
            onTapBtn: () async {
              Navigator.pop(context);

              Injector.introData.team1 = 1;
              await Injector.setIntroData(Injector.introData);
              showYourTeams(context);
            },
          );
        });
  }

  static showYourTeams(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            imageName: "hr_niki",
            imageMoveTop: hrNikiImageMoveTop,
            imageMoveRight: hrNikiImageMoveRight,
            imageHeight: hrNikiImageHeight,
            imageWidth: hrNikiImageWidth,
            titleText: Utils.getText(context, StringRes.team),
            btnName: Utils.getText(context, StringRes.next),
            btnColor: ColorRes.blue,
            desTextLine: Utils.getText(context, StringRes.strTeamDialog),
            onTapBtn: () async {
              Navigator.pop(context);
              Injector.introData.team2 = 1;
              await Injector.setIntroData(Injector.introData);
              showYourTeams2(context);
            },
          );
        });
  }

  static showYourTeams2(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            imageName: "hr_niki",
            imageMoveTop: hrNikiImageMoveTop,
            imageMoveRight: hrNikiImageMoveRight,
            imageHeight: hrNikiImageHeight,
            imageWidth: hrNikiImageWidth,
            titleText: Utils.getText(context, StringRes.team),
            btnName: Utils.getText(context, StringRes.gotIt),
            btnColor: ColorRes.blue,
            desTextLine:
                Utils.getText(context, StringRes.strYourTeamPerformanceDialog2),
            onTapBtn: () async {
              Navigator.pop(context);
              Injector.introData.team3 = 1;
              await Injector.setIntroData(Injector.introData);
            },
          );
        });
  }

  //todo This dialogs only for P+L screen
  static showThePersonYouCanCountOn(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            imageName: "akiko",
            imageMoveTop: akikoImageMoveTop,
            imageMoveRight: akikoImageMoveRight,
            imageHeight: akikoImageHeight,
            imageWidth: akikoImageWidth,
            titleText: Utils.getText(context, StringRes.plPerson),
            btnName: Utils.getText(context, StringRes.next),
            btnColor: ColorRes.blue,
            desTextLine: "${Utils.getText(context, StringRes.niceMeetYou)} ,${Utils.getText(context, StringRes.plMyName)}",
            onTapBtn: () async {
              Navigator.pop(context);
              Injector.introData.pl1 = 1;
              await Injector.setIntroData(Injector.introData);
              showIntroPL(context);
            },
          );
        });
  }

  static showIntroPL(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            imageName: "akiko",
            imageMoveTop: akikoImageMoveTop,
            imageMoveRight: akikoImageMoveRight,
            imageHeight: akikoImageHeight,
            imageWidth: akikoImageWidth,
            titleText: Utils.getText(context, StringRes.pl),
            btnName: Utils.getText(context, StringRes.gotIt),
            btnColor: ColorRes.blue,
            desTextLine:
                "${Utils.getText(context, StringRes.hereYourMonitor)}\n\n${Utils.getText(context, StringRes.selectPeriod)}",
            onTapBtn: () async {
              Injector.introData.pl2 = 1;
              await Injector.setIntroData(Injector.introData);
              Navigator.pop(context);
            },
          );
        });
  }
}
