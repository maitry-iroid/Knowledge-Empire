import 'package:flutter/material.dart';
import 'package:ke_employee/dialogs/intro_sreen_dailog.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';

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
  static showIntroKnowledgeEmpire(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            sixthView: false,
            seventhView: false,
            secondView: false,
            forthView: false,
            fifthView: false,
            firstView: true,
            thirdView: false,
            imageName: "john",
            titleText: "Wellcome to Knowledge Empire",
            btnName: "Click on your Profile",
            desTextLine:
                "Dear {{\$user-first-name}}, \n\nMy name is Mike, your Head of Operations.\nAre you ready to becom CEO of your own virtual company?\nClick on your name \"\profile\" in the\nnavigation menu(\">\""
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
            sixthView: false,
            seventhView: false,
            secondView: false,
            forthView: false,
            fifthView: false,
            firstView: false,
            thirdView: false,
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
  static Widget showIntroDialog(BuildContext context) {
    return IntroScreenDialog(
      menuView: false,
      sixthView: false,
      seventhView: false,
      secondView: false,
      forthView: false,
      fifthView: false,
      firstView: false,
      thirdView: false,
      imageName: "john",
      cardWidth: 2.25,
      cardMoveLeft: 9,
      cardMoveBottom: 4,
      imageMoveRight: 80,
      imageMoveTop: 5.6,
      imageWidth: 2.85,
      imageHeight: 2,
      titleText: "Customize your company",
      btnName: "Make changes & click \"save\"",
      desTextLine:
          "Upload a profile picture and edit your company name then click \"save\"",
      onTapBtn: () async {
        try {
          await Injector.updateIntroDialogType(Const.introSettings);
          showSettingsDialog(context);
          Navigator.of(context).pop();
        } catch (e) {
          print(e);
        }
      },
    );
  }

  static showSettingsDialog(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            sixthView: false,
            seventhView: false,
            secondView: false,
            forthView: false,
            fifthView: false,
            firstView: false,
            thirdView: false,
            imageName: "john",
            titleText: "Setttings",
            btnName: "Next",
            btnColor: ColorRes.blue,
            desTextLine:
                "You can switch to a professional mode (no virtual company)\nand turn the sound on and off.\n\nIn case your company has negitive cash you can request\na bail out which will needto be approved by your manager.",
            onTapBtn: () async {
              try {
                print(Const.introMeetYourTeam);
                await Injector.updateIntroDialogType(Const.introMeetYourTeam);
                Navigator.of(context).pop();
                Utils.performBack(context);
              } catch (e) {
                print(e);
              }
            },
          );
        });
  }

  //todo  This dialogs only for Organization screen
  static Widget showHireHRDialog(BuildContext context,GestureDragCancelCallback onTap) {
    return IntroScreenDialog(
      menuView: false,
      sixthView: false,
      seventhView: false,
      secondView: false,
      forthView: false,
      fifthView: false,
      firstView: false,
      thirdView: false,
      cardWidth: 1.8,
      cardHeight: 1.8,
      cardMoveLeft: 9,
      cardMoveBottom: 3,
      imageMoveRight: 110,
      imageMoveTop: 28.6,
      imageWidth: 1.85,
      imageHeight: 2,
      imageName: "hr_niki",
      titleText: "Hire HR Employees",
      btnName: "Next",
      btnColor: ColorRes.blue,
      desTextLine:
      "Hi {{\$user-first-name}},\n\nWelcome on board and welcome to the board room.\nMy name is Nikita but please call me Niki.\nAs Head of HR i will introduce you to the team and how you\ncan hire new employees to strengthen the team.",
      onTapBtn: onTap,
    );
  }

  static Widget showHireHRBoardDialog(BuildContext context,GestureDragCancelCallback onTap) {
    return IntroScreenDialog(
      menuView: false,
      sixthView: false,
      seventhView: false,
      secondView: false,
      forthView: false,
      fifthView: false,
      firstView: false,
      thirdView: false,
      imageName: "hr_niki",
      cardMoveBottom: 2.8,
      cardMoveLeft: 8,
      imageMoveTop: 100,
      imageMoveRight: 15,
      imageHeight: 2,
      imageWidth: hrNikiImageWidth,
      titleText: "Hire HR Employees",
      btnName: "Click on HR",
      desTextLine:
      "To hear yout Team's recommendatons on why you should\nhire more employees in thier team, click on them?\n\nLets start with hiring 10 Hr employees by clicking on HR and then\n\"hire 10 employees\".",
      onTapBtn: onTap,
      /*onTapBtn: () async {
        Navigator.pop(context);
        await Injector.updateIntroDialogType(Const.introEmployOMeter);
        showEmployOMeterDialog(context);
      },*/
    );
  }

 static Widget showEmployOMeterDialog(BuildContext context,GestureDragCancelCallback onTap)  {
    return IntroScreenDialog(
      menuView: false,
      sixthView: false,
      seventhView: false,
      secondView: true,
      forthView: false,
      fifthView: false,
      firstView: false,
      thirdView: false,
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
      onTapBtn: onTap,
      /*onTapBtn: () async {
        Navigator.pop(context);
        await Injector.updateIntroDialogType(Const.introCostOfEmployees);
        showCostOfEmployees(context);
      },*/
    );
  }

  static Widget showCostOfEmployees(BuildContext context,GestureDragCancelCallback onTap)   {
    return IntroScreenDialog(
      menuView: false,
      sixthView: true,
      seventhView: false,
      secondView: false,
      forthView: false,
      fifthView: false,
      firstView: false,
      thirdView: false,
      imageName: "hr_niki",
      imageMoveTop: hrNikiImageMoveTop,
      imageMoveRight: hrNikiImageMoveRight,
      imageHeight: hrNikiImageHeight,
      imageWidth: hrNikiImageWidth,
      titleText: "Cost of employees",
      btnName: "Next",
      btnColor: ColorRes.blue,
      desTextLine:
      "Here you see your total cash.\n\nHiring employees will incure hiring cost(increasing over time.)\nThe cost will be deducted from your cash.\nEvery employee also recieves a daily salary which starts at 200.\nSalary levels will increse over time",
      onTapBtn: onTap,
     /* onTapBtn: () async {
        Navigator.pop(context);
        await Injector.updateIntroDialogType(
            Const.introGetReadyToApproachCustomers);
        showGetReadyToApproachCustomers(context);
      },*/
    );
  }

  static Widget showGetReadyToApproachCustomers(BuildContext context,GestureDragCancelCallback onTap)   {
    return IntroScreenDialog(
      menuView: false,
      sixthView: false,
      seventhView: false,
      secondView: false,
      forthView: false,
      fifthView: false,
      firstView: false,
      thirdView: false,
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
  }

  static Widget showSalesOMeter(BuildContext context,GestureDragCancelCallback onTap)   {
    return IntroScreenDialog(
      menuView: false,
      sixthView: false,
      seventhView: false,
      secondView: false,
      forthView: false,
      fifthView: false,
      firstView: false,
      thirdView: true,
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

  static Widget showGetReadyToServeCustomers(BuildContext context,GestureDragCancelCallback onTap)   {
    return IntroScreenDialog(
      menuView: false,
      sixthView: false,
      seventhView: false,
      secondView: false,
      forthView: false,
      fifthView: false,
      firstView: false,
      thirdView: false,
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

  static Widget showServiceOMeter(BuildContext context,GestureDragCancelCallback onTap)   {
    return IntroScreenDialog(
      menuView: false,
      sixthView: false,
      seventhView: false,
      secondView: false,
      forthView: true,
      fifthView: false,
      firstView: false,
      thirdView: false,
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

  static Widget showReadyForSeriousBusiness(BuildContext context,GestureDragCancelCallback onTap)  {
    return IntroScreenDialog(
      menuView: true,
      sixthView: false,
      seventhView: false,
      secondView: false,
      forthView: false,
      fifthView: false,
      firstView: false,
      thirdView: false,
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
            sixthView: false,
            seventhView: false,
            secondView: false,
            forthView: false,
            fifthView: false,
            firstView: false,
            thirdView: false,
            imageName: "li_wei",
            imageMoveRight: liWeiImageMoveRight,
            imageMoveTop: liWeiImageMoveTop,
            imageHeight: liWeiImageHeight,
            imageWidth: liWeiImageWidth,
            titleText: "Customer Relationship Management",
            btnName: "Next",
            btnColor: ColorRes.blue,
            desTextLine:
                "Hi {{\$user-first-name}},\n\nMy name is Li Wei. Just like the english word leeway.\nI am in charge of Customer Relationship Management (CRM)\nin your company. Shall we have a look at the different business\nsectors to find potential customers?",
            onTapBtn: () async {
              Navigator.pop(context);
              await Injector.updateIntroDialogType(Const.introAreaOfCompetency);
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
            sixthView: false,
            seventhView: false,
            secondView: false,
            forthView: false,
            fifthView: false,
            firstView: false,
            thirdView: false,
            imageName: "li_wei",
            imageMoveRight: liWeiImageMoveRight,
            imageMoveTop: liWeiImageMoveTop,
            imageHeight: liWeiImageHeight,
            imageWidth: liWeiImageWidth,
            titleText: "Area of competency",
            btnName: "Next",
            btnColor: ColorRes.blue,
            desTextLine:
                "Each Business Sector will test specific knowledge to win\ncustomers. \"Size\" is the number of customers per Sector.\nYou can click pn a business sector to read the description,\nsubscribe to it and download the questions for offline use.\nSome Business Sectors might already be assigned to you.",
            onTapBtn: () async {
              Navigator.pop(context);
              await Injector.updateIntroDialogType(
                  Const.introAccesToYourFirstCustomers);
              showIntroAccesToYourFirstCustomers(context);
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
            sixthView: false,
            seventhView: false,
            secondView: false,
            forthView: false,
            fifthView: false,
            firstView: false,
            thirdView: false,
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
            firstView: false,
            secondView: false,
            thirdView: true,
            forthView: false,
            fifthView: false,
            sixthView: false,
            seventhView: false,
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
            firstView: false,
            secondView: false,
            thirdView: false,
            forthView: false,
            fifthView: false,
            sixthView: false,
            seventhView: false,
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
              await Injector.updateIntroDialogType(
                  Const.introListOfPotentialCustomers);
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
            firstView: false,
            secondView: false,
            thirdView: false,
            forthView: false,
            fifthView: false,
            sixthView: false,
            seventhView: false,
            imageName: "tina",
            imageMoveRight: tinaImageMoveRight,
            imageMoveTop: tinaImageMoveTop,
            imageHeight: tinaImageHeight,
            imageWidth: tinaImageWidth,
            titleText: "List of potential Customers",
            btnName: "Click on “Engage Now”",
            desTextLine:
                "Each customer has a name and belongs to a sector.\nValue is the cash you will recieve every day while the\ncustomer is loyal to you. Loyalty of customers will\nincrease when you master the customer situation.\nResources indicate how many Sales Reps you willneed to engage this customer. Click on “Engage Now”.",
            onTapBtn: () async {
              Navigator.pop(context);
              await Injector.updateIntroDialogType(
                  Const.introYourFirstEngegement);
              showYourFirstEngegement(context);
            },
          );
        });
  }

  static showYourFirstEngegement(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            firstView: false,
            secondView: false,
            thirdView: false,
            forthView: false,
            fifthView: false,
            sixthView: false,
            seventhView: false,
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
              showImpactOnSalesAndService(context);
            },
          );
        });
  }

  static showImpactOnSalesAndService(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            firstView: false,
            secondView: false,
            thirdView: true,
            forthView: true,
            fifthView: false,
            sixthView: false,
            seventhView: false,
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
              await Injector.updateIntroDialogType(
                  Const.introImpactOnBrandValueAndCash);
              showImpactOnBrandValueAndCash(context);
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
            firstView: false,
            secondView: false,
            thirdView: false,
            forthView: false,
            fifthView: true,
            sixthView: true,
            seventhView: false,
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
            firstView: false,
            secondView: false,
            thirdView: false,
            forthView: true,
            fifthView: false,
            sixthView: false,
            seventhView: false,
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
            firstView: false,
            secondView: false,
            thirdView: false,
            forthView: false,
            fifthView: false,
            sixthView: false,
            seventhView: false,
            imageName: "bob",
            imageMoveRight: bobImageMoveRight,
            imageMoveTop: bobImageMoveTop,
            imageHeight: bobImageHeight,
            imageWidth: bobImageWidth,
            titleText: "Serving your existing customers",
            btnName: "Next",
            btnColor: ColorRes.blue,
            desTextLine:
                "Hi {{\$user-first-name}},\n\nI am Bob and taking care of Customer Service.\nLet me introduce you to the list of existing customer.",
            onTapBtn: () async {
              Navigator.pop(context);
              await Injector.updateIntroDialogType(
                  Const.introListOfExistingCustomers);
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
            firstView: false,
            secondView: false,
            thirdView: false,
            forthView: false,
            fifthView: false,
            sixthView: false,
            seventhView: false,
            imageName: "bob",
            imageMoveRight: bobImageMoveRight,
            imageMoveTop: bobImageMoveTop,
            imageHeight: bobImageHeight,
            imageWidth: bobImageWidth,
            titleText: "List of existing Customers",
            btnName: "Next",
            btnColor: ColorRes.blue,
            desTextLine:
                "Here you see all customers and contracts that you are currently\nengaged with. How much cash they generate each day and\nhow many days they will be loyal to you.\nYou can click the “X” if you want to end the contract.\nThis customer will no longer generate cash but you will\nwin back 1 Service Rep",
            onTapBtn: () async {
              Navigator.pop(context);
              await Injector.updateIntroDialogType(Const.introReadyForBusiness);
              showReadyForBusiness(context);
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
            firstView: false,
            secondView: false,
            thirdView: false,
            forthView: false,
            fifthView: false,
            sixthView: false,
            seventhView: false,
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
            sixthView: false,
            seventhView: false,
            secondView: false,
            forthView: false,
            fifthView: false,
            firstView: true,
            thirdView: false,
            imageName: "john",
            titleText: "Rewards",
            btnName: "Got it",
            desTextLine:
                "Check out the reward categories and click on a trophy to find out\nwhat you have achieved already and what you will need to\nachieve for the next level.\n\nThe number below the “Next Level” is the bonus\nyou will receive.",
            onTapBtn: () async {
              Navigator.pop(context);
              await Injector.updateIntroDialogType(Const.introYourWillIsAtYourCommand);
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
            sixthView: false,
            seventhView: false,
            secondView: false,
            forthView: false,
            fifthView: false,
            firstView: false,
            thirdView: false,
            imageName: "will",
            btnColor: ColorRes.blue,
            imageWidth: willImageWidth,
            imageHeight: willImageHeight,
            imageMoveTop: willImageMoveTop,
            imageMoveRight: willImageMoveRight,
            titleText: "Your Will is at your command",
            btnName: "Got it",
            desTextLine:
                "Dear {{\$user-first-name}},\n\nMy name is Will and I am your corporate lawyer.\nI will help you to challange other competitors and also to defen\nagainst attacks.",
            onTapBtn: () async {
              Navigator.pop(context);
              await Injector.updateIntroDialogType(Const.introChallanges);
              showIntroChallanges(context);
            },
          );
        });
  }

  static showIntroChallanges(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroScreenDialog(
            menuView: false,
            sixthView: false,
            seventhView: false,
            secondView: false,
            forthView: false,
            fifthView: false,
            firstView: false,
            thirdView: false,
            imageName: "will",
            btnColor: ColorRes.blue,
            imageWidth: willImageWidth,
            imageHeight: willImageHeight,
            imageMoveTop: willImageMoveTop,
            imageMoveRight: willImageMoveRight,
            titleText: "Challanges",
            btnName: "Got it",
            desTextLine:
                "Search or select a competitor you would like to challenge.\nSelect one of his business sectors you would like to challenge\nhim and select the reward (% of current cash) the the winner\ncan get. Your competitor will need to answer 3 out of 3 questions\nfrom the selected sector correctly in order to win the challenge",
            onTapBtn: () async {
              Navigator.pop(context);
              await Injector.updateIntroDialogType(
                  Const.introMarketingAndCommunications);
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
            sixthView: false,
            seventhView: false,
            secondView: false,
            forthView: false,
            fifthView: false,
            firstView: false,
            thirdView: false,
            imageName: "lydia",
            btnColor: ColorRes.blue,
            imageWidth: lydiaImageWidth,
            imageHeight: lydiaImageHeight,
            imageMoveTop: lydiaImageMoveTop,
            imageMoveRight: lydiaImageMoveRight,
            titleText: "Marketing & Communications",
            btnName: "Got it",
            desTextLine:
                "Hi {{\$user-first-name}},\n\nWhat a great pleasure meeting you. I have heard a lot of good\nthings about you. So I am extremely exited to work for you.\nI am Lydia and in charge of Marketing & Communications.\nLet's have a look at your overall market position. ",
            onTapBtn: () async {
              Navigator.pop(context);
              await Injector.updateIntroDialogType(Const.introRanking);
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
            sixthView: false,
            seventhView: false,
            secondView: false,
            forthView: false,
            fifthView: false,
            firstView: false,
            thirdView: false,
            imageName: "lydia",
            btnColor: ColorRes.blue,
            imageWidth: lydiaImageWidth,
            imageHeight: lydiaImageHeight,
            imageMoveTop: lydiaImageMoveTop,
            imageMoveRight: lydiaImageMoveRight,
            titleText: "Ranking",
            btnName: "Got it",
            desTextLine:
                "Select on the left side the ranking criteria (e.g. cash) and at the\ntop which group you would like to compare it with and in which\ntime frame.\nYou can also click in “You” to scroll to your position and\nchallenge and add friends.",
            onTapBtn: () async {
              Navigator.pop(context);
              await Injector.updateIntroDialogType(
                  Const.introYourTeamsPerformance);
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
            sixthView: false,
            seventhView: false,
            secondView: false,
            forthView: false,
            fifthView: false,
            firstView: false,
            thirdView: false,
            imageName: "hr_niki",
            imageMoveTop: hrNikiImageMoveTop,
            imageMoveRight: hrNikiImageMoveRight,
            imageHeight: hrNikiImageHeight,
            imageWidth: hrNikiImageWidth,
            titleText: "Your Team's Performance",
            btnName: "Next",
            btnColor: ColorRes.blue,
            desTextLine:
                "Hi, it's me again, Niki.\n\nThis section is exclusively for team leaders.\nHere you can see the performance of your reports.",
            onTapBtn: () async {
              Navigator.pop(context);
              await Injector.updateIntroDialogType(Const.introYourTeams);
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
            sixthView: false,
            seventhView: false,
            secondView: false,
            forthView: false,
            fifthView: false,
            firstView: false,
            thirdView: false,
            imageName: "hr_niki",
            imageMoveTop: hrNikiImageMoveTop,
            imageMoveRight: hrNikiImageMoveRight,
            imageHeight: hrNikiImageHeight,
            imageWidth: hrNikiImageWidth,
            titleText: "Team",
            btnName: "Next",
            btnColor: ColorRes.blue,
            desTextLine:
                "As a manager you can see and monitor the performance\nof your team. If you click on a team member you can see his\nindividual performance and also bail him out in case his company is\nout of cash (reset his cash to 30.000).",
            onTapBtn: () async {
              Navigator.pop(context);
              await Injector.updateIntroDialogType(Const.introYourTeams2);
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
            sixthView: false,
            seventhView: false,
            secondView: false,
            forthView: false,
            fifthView: false,
            firstView: false,
            thirdView: false,
            imageName: "hr_niki",
            imageMoveTop: hrNikiImageMoveTop,
            imageMoveRight: hrNikiImageMoveRight,
            imageHeight: hrNikiImageHeight,
            imageWidth: hrNikiImageWidth,
            titleText: "Team",
            btnName: "Got it",
            btnColor: ColorRes.blue,
            desTextLine:
                "The graphs show you the “Retention Level” & “Question Status”\n“Retention Level” indicates how many questions are retained\n(1 = low retention and 10 = very well retained knowledge).\n“Question Status” indicates if questions are open and answered\n(open = open for answering, completed = correctly answered)",
            onTapBtn: () async {
              Navigator.pop(context);
              await Injector.updateIntroDialogType(
                  Const.introThePersonYouCanCountOn);
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
            sixthView: false,
            seventhView: false,
            secondView: false,
            forthView: false,
            fifthView: false,
            firstView: false,
            thirdView: false,
            imageName: "akiko",
            imageMoveTop: akikoImageMoveTop,
            imageMoveRight: akikoImageMoveRight,
            imageHeight: akikoImageHeight,
            imageWidth: akikoImageWidth,
            titleText: "The person you can count on",
            btnName: "Next",
            btnColor: ColorRes.blue,
            desTextLine:
                "Nice to meet you {{\$user-first-name}},\n\nMy name is Akiko Nakamura. I am in charge of Finance.\nLet's make sure to always have more revenue then cost.",
            onTapBtn: () async {
              Navigator.pop(context);
              await Injector.updateIntroDialogType(Const.introPL);
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
            sixthView: false,
            seventhView: false,
            secondView: false,
            forthView: false,
            fifthView: false,
            firstView: false,
            thirdView: false,
            imageName: "akiko",
            imageMoveTop: akikoImageMoveTop,
            imageMoveRight: akikoImageMoveRight,
            imageHeight: akikoImageHeight,
            imageWidth: akikoImageWidth,
            titleText: "P+L",
            btnName: "Got it",
            btnColor: ColorRes.blue,
            desTextLine:
                "Here you can monitor the cost and the revenue of your company.\n\nYou can also select the period you want to look at and\ncompare the current period with the previous period.",
            onTapBtn: () async {
              Navigator.pop(context);
            },
          );
        });
  }
}
