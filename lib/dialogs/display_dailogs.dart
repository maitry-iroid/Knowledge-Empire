import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/BLoC/navigation_bloc.dart';
import 'package:ke_employee/dialogs/intro_sreen_dailog.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/homedata.dart';
import 'package:ke_employee/models/questions.dart';
import 'package:ke_employee/screens/help_pro_screen.dart';
import 'package:open_appstore/open_appstore.dart';

class DisplayDialogs {
  //todo li_wei  image configuration
  static double liWeiImageHeight = 2.10;
  static double liWeiImageWidth = 2.7;
  static double liWeiImageMoveRight = 15.5;
  static double liWeiImageMoveTop = 5.2;

  //todo hrNiki  image configuration
  static double hrNikiImageHeight = 1.25;
  static double hrNikiImageWidth = 2.5;
  static double hrNikiImageMoveRight = 12.0;
  static double hrNikiImageMoveTop = 50.0;

  //todo tina image configuration
  static double tinaImageHeight = 2.10;
  static double tinaImageWidth = 2.5;
  static double tinaImageMoveRight = 12.5;
  static double tinaImageMoveTop = 5.2;

  //todo tina image configuration
  static double bobImageHeight = 2.10;
  static double bobImageWidth = 2.5;
  static double bobImageMoveRight = 15.5;
  static double bobImageMoveTop = 6.3;

  //todo tina image configuration
  static double willImageHeight = 2.10;
  static double willImageWidth = 2.5;
  static double willImageMoveRight = 10.5;
  static double willImageMoveTop = 5.2;

  //todo lydia image configuration
  static double lydiaImageHeight = 1.25;
  static double lydiaImageWidth = 2.5;
  static double lydiaImageMoveRight = 10.0;
  static double lydiaImageMoveTop = 70.0;

  //todo lydia akiki configuration
  static double akikoImageHeight = 1.25;
  static double akikoImageWidth = 2.9;
  static double akikoImageMoveRight = 9.3;
  static double akikoImageMoveTop = 80.0;

  static showChallengeDialog(
      BuildContext context, String userName, QuestionData questionData) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              height: Utils.getDeviceHeight(context) / 1.4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage(Utils.getAssetsImg("challenges_bg_alert")),
                      fit: BoxFit.cover)),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Center(
                    child: Container(
                      width: Utils.getDeviceWidth(context) / 2.5,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          top: 30, left: 10, right: 10, bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            new Container(
                              height: 30,
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.only(
                                  top: Utils.getDeviceHeight(context) / 22),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(Utils.getAssetsImg(
                                          "challenges_alert_bg")))),
                              child: Center(
                                child: Text(
                                    Utils.getText(context, StringRes.challenge),
                                    style: TextStyle(
                                        color: ColorRes.textRecordBlue)),
                              ),
                            ),
                            SizedBox(height: 9),
                            challengesRow(
                                Utils.getText(context, StringRes.by) + ": ",
                                userName),
                            challengesRow(
                                Utils.getText(context, StringRes.inText) + ": ",
                                "${questionData.moduleName ?? ""}"),
                            challengesRow(
                                Utils.getText(context, StringRes.toWin) + ": ",
                                questionData.winningAmount
                                    .toString() /*+" "+ Utils.getText(context, StringRes.yourValue).toString()*/),
                            challengesRow(
                                Utils.getText(context, StringRes.questions) +
                                    ": ",
                                "${questionData.totalQuestion ?? ""}"),
                            InkResponse(
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: 35, right: 35, top: 10, bottom: 10),
                                margin: EdgeInsets.only(top: 5),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(Utils.getAssetsImg(
                                            'chhellages_alert_next_bg')),
                                        fit: BoxFit.fill)),
                                child: Text(
                                    Utils.getText(context, StringRes.next),
                                    style: TextStyle(color: ColorRes.white)),
                              ),
                              onTap: () {
                                Utils.playClickSound();
                                Navigator.pop(context);
//                                Utils.showChallengeQuestionDialog(
//                                    context, questionData);
                                navigationBloc.updateNavigation(HomeData(
                                  initialPageType: Const.typeEngagement,
                                  questionHomeData: questionData,
                                  isChallenge: true,
                                ));
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                              Utils.getAssetsImg("challenges_icon"),
                              fit: BoxFit.contain,
                              height: Utils.getDeviceHeight(context) / 6,
                              width: Utils.getDeviceHeight(context) / 6)))
                ],
              ),
            ),
          );
        }
        /*    child: Dialog(

//        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                height: Utils.getDeviceWidth(context)/3.0,
                width: Utils.getDeviceWidth(context)/2.7,
                color: Colors.white,
                alignment: Alignment.center,
                margin: EdgeInsets.all(10),
              ),
            ),
            Positioned(
                child: Container(
              height: 30,
              child: Text('hello'),
            ))
          ],
        ),
      ),*/
        );
  }

  static showUpdateDialog(
      BuildContext context, String headline, String message, isCancelAble) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {},
            child: IntroScreenDialog(
              menuView: false,
              secondBtn: isCancelAble,
//              imageName: "bob",
              imageMoveTop: akikoImageMoveTop,
              imageMoveRight: akikoImageMoveRight,
              imageHeight: akikoImageHeight,
              imageWidth: akikoImageWidth,
              titleText: headline,
              btnName: Utils.getText(context, StringRes.updateNow),
              btnColor: ColorRes.blue,
              desTextLine: message,
              onTapBtn: () async {
                //Navigator.pop(context);
                OpenAppstore.launch(
                    androidAppId: Injector.packageInfo.packageName,
                    iOSAppId: Injector.packageInfo.packageName);
              },
              onTapSecondBtn: () {
                Injector.prefs.setString(
                    PrefKeys.isCancelDialog, DateTime.now().toString());
                Navigator.pop(context);
              },
            ),
          );
        });
  }

  static challengesRow(String title, String details) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: ColorRes.headerBlue),
                ),
              )),
          Expanded(
              flex: 5,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(details,
                      style: TextStyle(color: ColorRes.greyText)))),
        ],
      ),
    );
  }

    static professionalDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return HelpProScreen();
        });
  }

  //todo  This dialogs only for Profile screen
  static showIntroProfile1(BuildContext context) async {
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
            desTextLine: Injector.introModel.profile1,
            onTapBtn: () async {
              try {
                Utils.playClickSound();
                Injector.introData.profile1 = 1;
                await Injector.setIntroData(Injector.introData);
                Navigator.of(context).pop();
                showIntroProfile2(context);
              } catch (e) {
                print(e);
              }
            },
          );
        });
  }

  static showIntroProfile2(BuildContext context) async {
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
            desTextLine: Injector.introModel.profile2,
            onTapBtn: () async {
              try {
                Utils.playClickSound();
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
  static Future showIntroOrg1(BuildContext context) async {
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
            imageMoveRight: 12,
            desTextLine: Injector.introModel.org1,
            onTapBtn: () async {
              Utils.playClickSound();
              Navigator.pop(context);
              Injector.introData.org1 = 1;
              await Injector.setIntroData(Injector.introData);
              showIntroOrg2(context);
            },
          );
        });
  }

  static showIntroOrg2(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            imageName: "hr_niki",
            imageMoveTop: 8.5,
            imageMoveRight: 12,
            titleText: Utils.getText(context, StringRes.hireHrEmp) ?? "",
            btnName: StringRes.next,
            btnColor: ColorRes.blue,
            desTextLine: Injector.introModel.org2,
            onTapBtn: () async {
              Utils.playClickSound();
              Navigator.pop(context);
              Injector.introData.org2 = 1;
              await Injector.setIntroData(Injector.introData);
              showIntroOrg3(context);
            },
          );
        });
  }

  static showIntroOrg3(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            imageName: "hr_niki",
            imageMoveTop: 8.5,
            imageMoveRight: 12,
            titleText: Utils.getText(context, StringRes.empOMaster) ?? "",
            btnName: Utils.getText(context, StringRes.next),
            btnColor: ColorRes.blue,
            desTextLine: Injector.introModel.org3,
            onTapBtn: () async {
              Utils.playClickSound();
              Navigator.pop(context);
              Injector.introData.org3 = 1;
              await Injector.setIntroData(Injector.introData);
              showIntroOrg4(context);
            },
          );
        });
  }

  static showIntroOrg4(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            imageName: "hr_niki",
            imageMoveTop: 8.5,
            imageMoveRight: 12,
            titleText: Utils.getText(context, StringRes.costOfEmp) ?? "",
            btnName: Utils.getText(context, StringRes.gotIt),
            btnColor: ColorRes.blue,
            desTextLine: Injector.introModel.org4,
            onTapBtn: () async {
              Utils.playClickSound();
              Navigator.pop(context);
              Injector.introData.org4 = 1;
              await Injector.setIntroData(Injector.introData);
            },
          );
        });
  }

  //todo  This dialogs only for Business sector screen
  static showIntroLearningModule1(BuildContext context) async {
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
            desTextLine: Injector.introModel.learningModule1,
            onTapBtn: () async {
              Utils.playClickSound();
              Navigator.pop(context);

              Injector.introData.learningModule1 = 1;
              await Injector.setIntroData(Injector.introData);

              showIntroLearningModule2(context);
            },
          );
        });
  }

  static showIntroLearningModule2(BuildContext context) async {
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
            desTextLine: Injector.introModel.learningModule2,
            onTapBtn: () async {
              Utils.playClickSound();
              Navigator.pop(context);
              Injector.introData.learningModule2 = 1;
              await Injector.setIntroData(Injector.introData);
              //     showIntroAccesToYourFirstCustomers(context);
            },
          );
        });
  }

  //todo  This dialogs only for New Customer screen
  static showIntroNewCustomer1(BuildContext context) async {
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
            desTextLine: Injector.introModel.newCustomer1,
            onTapBtn: () async {
              Utils.playClickSound();
              Navigator.pop(context);
              Injector.introData.newCustomer1 = 1;
              await Injector.setIntroData(Injector.introData);
              showIntroNewCustomers2(context);
            },
          );
        });
  }

  static showIntroNewCustomers2(BuildContext context) async {
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
            desTextLine: Injector.introModel.newCustomer2,
            onTapBtn: () async {
              Utils.playClickSound();
              Navigator.pop(context);
              Injector.introData.newCustomer2 = 1;
              await Injector.setIntroData(Injector.introData);
            },
          );
        });
  }

  //todo  customer situation
  static showIntroCustomerSituation(BuildContext context) async {
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
            desTextLine: Injector.introModel.customerSituation,
            onTapBtn: () async {
              Utils.playClickSound();
              Navigator.pop(context);
//              await Injector.updateIntroDialogType(Const.introImpactOnBrandValueAndCash);
              Injector.introData.customerSituation = 1;
              await Injector.setIntroData(Injector.introData);
//              showImpactOnBrandValueAndCash(context);
            },
          );
        });
  }

  //todo  This dialogs only for Existing Customer screen
  static showIntroExisting1(BuildContext context) async {
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
            desTextLine: Injector.introModel.existingCustomer1,
            onTapBtn: () async {
              Utils.playClickSound();
              Navigator.pop(context);
              Injector.introData.existingCustomer1 = 1;
              await Injector.setIntroData(Injector.introData);
//              await Injector.updateIntroDialogType(Const.introListOfExistingCustomers);
              showIntroExisting2(context);
            },
          );
        });
  }

  static showIntroExisting2(BuildContext context) async {
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
            desTextLine: Injector.introModel.existingCustomer2,
            onTapBtn: () async {
              Utils.playClickSound();
              Navigator.pop(context);
              Injector.introData.existingCustomer2 = 1;
              await Injector.setIntroData(Injector.introData);
              //showReadyForBusiness(context);
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
            desTextLine: Injector.introModel.rewards,
            btnColor: ColorRes.blue,
            onTapBtn: () async {
              Utils.playClickSound();
              Navigator.pop(context);

              Injector.introData.rewards = 1;
              await Injector.setIntroData(Injector.introData);
            },
          );
        });
  }

  //todo This dialogs only for Challenges screen
  static showIntroChallenge1(BuildContext context) async {
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
            desTextLine: Injector.introModel.challenge1,
            onTapBtn: () async {
              Utils.playClickSound();
              Navigator.pop(context);
              Injector.introData.challenge1 = 1;
              await Injector.setIntroData(Injector.introData);
              showIntroChallenge2(context);
            },
          );
        });
  }

  static showIntroChallenge2(BuildContext context) async {
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
            desTextLine: Injector.introModel.challenge2,
            onTapBtn: () async {
              Utils.playClickSound();
              Navigator.pop(context);
              Injector.introData.challenge2 = 1;
              await Injector.setIntroData(Injector.introData);
            },
          );
        });
  }

  //todo This dialogs only for Ranking screen
  static showIntroRanking1(BuildContext context) async {
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
            desTextLine: Injector.introModel.ranking1,
            onTapBtn: () async {
              Utils.playClickSound();
              Navigator.pop(context);
              Injector.introData.ranking1 = 1;
              await Injector.setIntroData(Injector.introData);
              showIntroRanking2(context);
            },
          );
        });
  }

  static showIntroRanking2(BuildContext context) async {
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
            desTextLine: Injector.introModel.ranking2,
            onTapBtn: () async {
              Utils.playClickSound();
              Navigator.pop(context);
              Injector.introData.ranking2 = 1;
              await Injector.setIntroData(Injector.introData);
            },
          );
        });
  }

  //todo This dialogs only for Team screen
  static showIntroTeam1(BuildContext context) async {
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
            desTextLine: Injector.introModel.team3,
            onTapBtn: () async {
              Utils.playClickSound();
              Navigator.pop(context);

              Injector.introData.team1 = 1;
              await Injector.setIntroData(Injector.introData);
              showIntroTeam2(context);
            },
          );
        });
  }

  static showIntroTeam2(BuildContext context) async {
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
            desTextLine: Injector.introModel.team3,
            onTapBtn: () async {
              Utils.playClickSound();
              Navigator.pop(context);
              Injector.introData.team2 = 1;
              await Injector.setIntroData(Injector.introData);
              showYourTeam3(context);
            },
          );
        });
  }

  static showYourTeam3(BuildContext context) async {
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
            desTextLine: Injector.introModel.team3,
            onTapBtn: () async {
              Utils.playClickSound();
              Navigator.pop(context);
              Injector.introData.team3 = 1;
              await Injector.setIntroData(Injector.introData);
            },
          );
        });
  }

  //todo This dialogs only for P+L screen
  static showIntroPL1(BuildContext context) async {
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
            desTextLine: Injector.introModel.pl1,
            onTapBtn: () async {
              Utils.playClickSound();
              Navigator.pop(context);
              Injector.introData.pl1 = 1;
              await Injector.setIntroData(Injector.introData);
              showIntroPL2(context);
            },
          );
        });
  }

  static showIntroPL2(BuildContext context) async {
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
            desTextLine: Injector.introModel.pl2,
            onTapBtn: () async {
              Utils.playClickSound();
              Injector.introData.pl2 = 1;
              await Injector.setIntroData(Injector.introData);
              Navigator.pop(context);
            },
          );
        });
  }
}
