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
  static double liWeiImageMoveTop = 4.2;

  //todo hrNiki  image configuration
  static double hrNikiImageHeight = 1.25;
  static double hrNikiImageWidth = 2.5;
  static double hrNikiImageMoveRight = 8.0;
  static double hrNikiImageMoveTop = 50.0;

  //todo tina image configuration
  static double tinaImageHeight = 2.10;
  static double tinaImageWidth = 2.5;
  static double tinaImageMoveRight = 7.5;
  static double tinaImageMoveTop = 4.2;

  //todo tina image configuration
  static double bobImageHeight = 2.10;
  static double bobImageWidth = 2.5;
  static double bobImageMoveRight = 9.5;
  static double bobImageMoveTop = 5.0;

  //todo tina image configuration
  static double willImageHeight = 2.10;
  static double willImageWidth = 2.5;
  static double willImageMoveRight = 7.5;
  static double willImageMoveTop = 4.2;

  //todo lydia image configuration
  static double lydiaImageHeight = 1.25;
  static double lydiaImageWidth = 2.5;
  static double lydiaImageMoveRight = 8.0;
  static double lydiaImageMoveTop = 16.0;

  //todo lydia akiki configuration
  static double akikoImageHeight = 1.25;
  static double akikoImageWidth = 2.9;
  static double akikoImageMoveRight = 6.3;
  static double akikoImageMoveTop = 18.0;

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
                  Text("Your are challenged by $userName",
                      style: Theme.of(context).textTheme.title),
                  SizedBox(height: 45),
                  RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Utils.showChallengeQuestionDialog(
                            context, questionData);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: ColorRes.colorPrimary,
                      child: Text("Next",
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
                await Injector.updateIntroDialogType(Const.introHireHR);
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
            titleText: "Customize your company",
            btnName: "Next",
            btnColor: ColorRes.blue,
            desTextLine:
                "Dear ${Injector.userData?.name},\n\nMy name is Mike, your Head of Operations.\nAre you ready to become CEO of your own virtual company?\nUpload a profile picture and edit your company name then click \"save\"",
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
            titleText: "Settings",
            btnName: Utils.getText(context, StringRes.gotIt),
            btnColor: ColorRes.blue,
            desTextLine:
                "You can switch to a professional mode (no virtual company)\nand turn the sound on and off.\n\nIn case your company has negitive cash you can request\na bail out which will needto be approved by your manager.",
            onTapBtn: () async {
              try {
                print(Const.introMeetYourTeam);
                Injector.introData.profile2 = 1;
                await Injector.setIntroData(Injector.introData);
                await Injector.updateIntroDialogType(Const.introMeetYourTeam);
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
            titleText: "Hire HR Employees",
            btnName: "Next",
            btnColor: ColorRes.blue,
            desTextLine:
                "Hi ${Injector.userData?.name},\n\nWelcome on board and welcome to the board room.\nMy name is Nikita but please call me Niki.\nAs Head of HR i will introduce you to the team and how you\ncan hire new employees to strengthen the team.",
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
            imageWidth: hrNikiImageWidth,
            titleText: "Hire HR Employees",
            btnName: StringRes.next,
            btnColor: ColorRes.blue,
            desTextLine:
                "To hear yout Team's recommendatons on why you should\nhire more employees in thier team, click on them?\n\nLets start with hiring 10 Hr employees by clicking on HR and then\n\"hire 10 employees\".",
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
            imageMoveTop: hrNikiImageMoveTop,
            imageMoveRight: hrNikiImageMoveRight,
            imageHeight: hrNikiImageHeight,
            imageWidth: hrNikiImageWidth,
            titleText: "Employ-o-Meter",
            btnName: "Next",
            btnColor: ColorRes.blue,
            desTextLine:
                "Note that your Employ-o-Meter shows 40/50.\n50 is your maximum number employees and 40 your fee capacity.\nYou can increase your maximum by hiering more HR employees.\nA click on your Employ-o-Meter will also bring you to this organizational screen.",
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
            imageMoveTop: hrNikiImageMoveTop,
            imageMoveRight: hrNikiImageMoveRight,
            imageHeight: hrNikiImageHeight,
            imageWidth: hrNikiImageWidth,
            titleText: "Cost of employees",
            btnName: Utils.getText(context, StringRes.gotIt),
            btnColor: ColorRes.blue,
            desTextLine:
                "Here you see your total cash.\n\nHiring employees will incure hiring cost(increasing over time.)\nThe cost will be deducted from your cash.\nEvery employee also recieves a daily salary which starts at 200.\nSalary levels will increse over time",
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
            titleText: "Customer Relationship Management",
            btnName: "Next",
            btnColor: ColorRes.blue,
            desTextLine:
                "Hi ${Injector.userData?.name},\n\nMy name is Li Wei. Just like the english word leeway.\nI am in charge of Customer Relationship Management (CRM)\nin your company. Shall we have a look at the different business\nsectors to find potential customers?",
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
            titleText: "Area of competency",
            btnName: Utils.getText(context, StringRes.gotIt),
            btnColor: ColorRes.blue,
            desTextLine:
                "Each Business Sector will test specific knowledge to win\ncustomers. \"Size\" is the number of customers per Sector.\nYou can click pn a business sector to read the description,\nsubscribe to it and download the questions for offline use.\nSome Business Sectors might already be assigned to you.",
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
            titleText: "Access to your first customers",
            btnName: "Click on \"Getting Started\"",
            desTextLine:
                "Why don't you subscribe to the first business sector to\ngain access to your first customers.\n\nClick on the Business Segment “Getting Started” and then on “Subscribe”.",
            onTapBtn: () async {
              Navigator.pop(context);
              await Injector.updateIntroDialogType(
                  Const.introReadyForYourFirstCustomerContact);
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
            titleText: "Ready for your first customer contact?",
            btnName: "Click on your Sales-o-Meter",
            desTextLine:
                "Let's head over to the laptop which contains a list of new\ncustomers you can engage.\n\nYou can click on your Sales-o-Meter, use the navigation\nmenu “>”, or click the back button and select the laptop.",
            onTapBtn: () async {
              Navigator.pop(context);
              await Injector.updateIntroDialogType(
                  Const.introHeartOfTheBusiness);
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
            imageMoveTop: tinaImageMoveTop,
            imageHeight: tinaImageHeight,
            imageWidth: tinaImageWidth,
            titleText: "The heart of the business",
            btnColor: ColorRes.blue,
            btnName: "Next",
            desTextLine:
                "Hi Boss,\n\nthis is where the rubber hits the road, where only the best\nsurvive and where we earn the money for our company.\nI am Tina, your Senior Vice President of Global Sales.\nLet's get to work without any further due.",
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
            titleText: "List of potential Customers",
            btnName: Utils.getText(context, StringRes.gotIt),
            btnColor: ColorRes.blue,
            desTextLine:
                "Each customer has a name and belongs to a sector.\nValue is the cash you will recieve every day while the\ncustomer is loyal to you. Loyalty of customers will\nincrease when you master the customer situation.\nResources indicate how many Sales Reps you willneed to engage this customer. Click on “Engage Now”.",
            onTapBtn: () async {
              Navigator.pop(context);
              Injector.introData.newCustomer2 = 1;
              await Injector.setIntroData(Injector.introData);
            },
          );
        });
  }

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
            titleText: "Your first engegement",
            btnName: "Select answer & click “Next”",
            desTextLine:
                "In order to win this customer, you will need to answer this\nquestion correctly. You can click on the expand button to\nenlarge the picture, question and answer option.\n\nSelect the right answer and click on “Next”",
            onTapBtn: () async {
              Navigator.pop(context);
              await Injector.updateIntroDialogType(
                  Const.introImpactOnSalesAndService);
              //showImpactOnSalesAndService(context);
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
            titleText: "Impact on Sales and Service",
            btnName: "Next",
            btnColor: ColorRes.blue,
            desTextLine:
                "Congratulations! You just won your first customer.\nYour Sales-o-Meter shows now 8/10 as this custome\nrequired 2 Sales Reps and your Service-o-Meter shows\n9/10 as one Service Rep is busy with this customer.",
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
            titleText: "Impact on Brand Value and Cash",
            btnName: "Next",
            btnColor: ColorRes.blue,
            desTextLine:
                "Also your Brand Value is now 100% as you answered 100% of all\ncustomer situations correct. \n\nIndependent of your Brand Value, your cash increased\nby the value of the customer.",
            onTapBtn: () async {
              Navigator.pop(context);
              await Injector.updateIntroDialogType(
                  Const.introCheckYourExistingCustomers);
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
            titleText: "Check your existing customers",
            btnName: "Select on Service-O-Meter",
            desTextLine:
                "You can check on your existing customer in the notepad at\nthe main screen.\n\nYou can reach your notepad by clicking on your\nSerice-o-Meter, selecting “Existing customers” from\nthe menu or by going to the main screen and\nselecting the notepad.",
            onTapBtn: () async {
              Navigator.pop(context);
              await Injector.updateIntroDialogType(
                  Const.introServingYourExistingCustomers);
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
            titleText: "Serving your existing customers",
            btnName: "Next",
            btnColor: ColorRes.blue,
            desTextLine:
                "Hi ${Injector.userData?.name},\n\nI am Bob and taking care of Customer Service.\nLet me introduce you to the list of existing customer.",
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
            titleText: "List of existing Customers",
            btnName: Utils.getText(context, StringRes.gotIt),
            btnColor: ColorRes.blue,
            desTextLine:
                "Here you see all customers and contracts that you are currently\nengaged with. How much cash they generate each day and\nhow many days they will be loyal to you.\nYou can click the “X” if you want to end the contract.\nThis customer will no longer generate cash but you will\nwin back 1 Service Rep",
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
            titleText: "Ready for business",
            btnName: "Finish Tutorial",
            btnColor: ColorRes.blue,
            desTextLine:
                "Why don't you check out more business sectors and engage\na few more customers.\n\nOr explore the other area of your company where you can\nearn rewards, challenge other players, see your financial\nperformance and compare your ranking.",
            onTapBtn: () async {
              Navigator.pop(context);
              await Injector.updateIntroDialogType(Const.introRewards);
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
              await Injector.updateIntroDialogType(
                  Const.introYourWillIsAtYourCommand);
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
              await Injector.updateIntroDialogType(Const.introYourTeams);
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
            desTextLine:
                "${Utils.getText(context, StringRes.niceMeetYou)} ,${Utils.getText(context, StringRes.plMyName)}",
            onTapBtn: () async {
              Navigator.pop(context);
              await Injector.updateIntroDialogType(Const.introPL);
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
