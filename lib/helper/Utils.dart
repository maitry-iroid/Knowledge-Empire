import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ke_employee/dialogs/change_password.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:ke_employee/dialogs/loader.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/models/get_dashboard_value.dart';
import 'package:ke_employee/screens/customer_situation.dart';
import 'package:ke_employee/screens/engagement_customer.dart';
import 'package:ke_employee/screens/home.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/get_customer_value.dart';
import 'package:ke_employee/models/manage_organization.dart';
import 'package:ke_employee/models/organization.dart';
import 'package:ke_employee/models/questions.dart';
import 'package:ke_employee/models/submit_answer.dart';
import 'package:ke_employee/screens/organization2.dart';
import 'package:path/path.dart';
import 'package:simple_pdf_viewer/simple_pdf_viewer.dart';

import 'constant.dart';
import 'localization.dart';

class Utils {
  static double getDeviceWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getDeviceHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static getAssetsImg(String name) {
    return "assets/images/" + name + ".png";
  }

  static showSnackBar(GlobalKey<ScaffoldState> _scaffoldKey, String message) {
//    _scaffoldKey.currentState.showSnackBar(SnackBar(
//      content: Text(message),
//      duration: const Duration(milliseconds: 2000),
//    ));

//    Fluttertoast.showToast(
//        msg: message,
//        toastLength: Toast.LENGTH_SHORT,
//        gravity: ToastGravity.BOTTOM,
//        timeInSecForIos: 3,
//        backgroundColor: Colors.black87,
//        textColor: Colors.white);
  }

  static showToast(String message) {
//    _scaffoldKey.currentState.showSnackBar(SnackBar(
//      content: Text(message),
//      duration: const Duration(milliseconds: 2000),
//    ));

    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 3,
        backgroundColor: Colors.black87,
        textColor: Colors.white);
  }

  static Future<bool> isInternetConnectedWithAlert() async {
    bool isConnected = false;

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      isConnected = true;
    } else {
      showToast("Please check your internet connectivity.");
      isConnected = false;
    }

    return isConnected;
  }

  static Future<bool> isInternetConnected() async {
    bool isConnected = false;

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      isConnected = true;
    } else {
      isConnected = false;
    }
    return isConnected;
  }

  static showLoader(BuildContext context) async {
    await showDialog(
        context: context, builder: (BuildContext context) => Loader());
  }

  static closeLoader(BuildContext context) {
    Navigator.pop(context);
  }

//  static Future<String> getDeviceId() async {
//    String identifier;
//    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
//
//    try {
//      if (Platform.isAndroid) {
//        var build = await deviceInfoPlugin.androidInfo;
//        identifier = build.androidId; //UUID for Android
//      } else if (Platform.isIOS) {
//        var data = await deviceInfoPlugin.iosInfo;
//        identifier = data.identifierForVendor; //UUID for iOS
//      }
//    } catch (e) {
//      print(e);
//    }
//
////if (!mounted) return;
//    return identifier;
//  }

  static getHours(DateTime dateTime) {
    try {
      int hours = dateTime.difference(DateTime.now()).inHours % 24;

      return hours < 0 ? "0" : hours.toString();
    } catch (e) {
      print(e);
      return "0";
    }
  }

  static getMinutes(DateTime dateTime) {
    try {
      int minutes = dateTime.difference(DateTime.now()).inMinutes % 60;

      return minutes < 0 ? "0" : minutes.toString();
    } catch (e) {
      print(e);
      return "0";
    }
  }

  static getFormattedDate(String datetime) {
    DateTime startDate = DateTime.parse(datetime);
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(startDate);
  }

//  static showToast(GlobalKey<ScaffoldState> _scaffoldKey, String message) {
//    Fluttertoast.showToast(
//        msg: message,
//        toastLength: Toast.LENGTH_SHORT,
//        gravity: ToastGravity.BOTTOM,
//        timeInSecForIos: 3,
//        backgroundColor: Colors.black87,
//        textColor: Colors.white);
//  }

  static hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static getCurrentFormattedDateTime() {
    DateTime dateTime = DateTime.now();
    return DateFormat("dd-MM-yyyy HH:mm:ss").format(dateTime);
  }

  static performBack(BuildContext context) {
    if (!Navigator.canPop(context)) {
      Navigator.pop(context);

      Navigator.pushReplacement(context, FadeRouteHome());

      /*showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text('Are you sure want to exit the app?'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Yes'),
                  onPressed: () {

//                    SystemNavigator.pop();
                  },
                ),
                FlatButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });*/
    } else
      Navigator.pop(context);
  }

  static String getText(BuildContext context, String text) {
    return AppLocalizations.of(context).text(text) ?? text;
  }

  static showChangePasswordDialog(GlobalKey<ScaffoldState> _scaffoldKey,
      bool isFromProfile, bool isOldPasswordRequired) async {
    await showDialog(
        context: _scaffoldKey.currentContext,
        builder: (BuildContext context) => ChangePasswordDialog(
            isFromProfile: isFromProfile,
            isOldPasswordRequired: isOldPasswordRequired));
  }

  static showOrgInfoDialog(GlobalKey<ScaffoldState> _scaffoldKey,
      String description, int position, bool checkUpdate) async {
    await showDialog(
        context: _scaffoldKey.currentContext,
        builder: (BuildContext context) => OrgInfoDialog(
              text: description,
              position: position,
              checkUpdate: checkUpdate,
            ));
  }

  static String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  static getSecret(String email, String password) {
    String text =
        email.split('').reversed.join() + password.split('').reversed.join();

    print('secret' + text);

    return generateMd5(text);
  }

  static getTitleHeight() {
    return Injector.isBusinessMode ? 35.0 : 30.0;
  }


//  static checkSound() async {
//    int maxVol, currentVol;
//    maxVol = await Volume.getMaxVol;
//    // get Current Volume
//    currentVol = await Volume.getVol;
//  }

  static playClickSound() async {
    if (Injector.isSoundEnable) Injector.player.play("all_button_clicks.wav");
//    if (Injector.isSoundEnable)
//      audioPlay('assets/sounds/all_button_clicks.wav');
  }

  static correctAnswerSound() async {
    if (Injector.isSoundEnable) Injector.player.play("right_answer.wav");
  }

  static incorrectAnswerSound() async {
    if (Injector.isSoundEnable) Injector.player.play("wrong_answer.wav");
  }

  static procorrectAnswerSound() async {
    if (Injector.isSoundEnable) Injector.player.play("pro_right_answer.mp3");
  }

  static proincorrectAnswerSound() async {
    if (Injector.isSoundEnable) Injector.player.play("pro_wrong_answer.mp3");
  }

//  static audioPlay(String path) async {
//    Audio audio = Audio.load(path);
//    audio.play();
//  }

  static saveQuestionLocally(List<QuestionData> arrQuestions) async {
//    List<String> jsonQuestionData = List();
//    List<QuestionData> questionData_ = List();
//
//    if (Injector.prefs.getStringList(PrefKeys.questionData) != null) {
//      List<String> jsonQuestionData =
//          Injector.prefs.getStringList(PrefKeys.questionData);
//
//      jsonQuestionData.forEach((jsonQuestion) {
//        questionData_.add(QuestionData.fromJson(jsonDecode(jsonQuestion)));
//      });
//    }
//
//    questionData_.addAll(arrQuestions);
//
//    questionData_.forEach((questionData) {
//      jsonQuestionData.add(json.encode(questionData));
//    });
//
//    await Injector.prefs.setStringList(PrefKeys.questionData, jsonQuestionData);
  }

  static getCurrentFormattedDate() {
    var now = new DateTime.fromMillisecondsSinceEpoch(
        DateTime.now().millisecondsSinceEpoch,
        isUtc: true);
    var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
    String formatted = formatter.format(now);
    print(formatted);
    return formatted; // something like 2013-04-20
  }

  static void callSubmitAnswerApi(BuildContext context) {
    if (Injector.prefs.getString(PrefKeys.answerData) == null) return;

    SubmitAnswerRequest rq = SubmitAnswerRequest.fromJson(
        jsonDecode(Injector.prefs.getString(PrefKeys.answerData)));

    WebApi().callAPI(WebApi.rqSubmitAnswers, rq.toJson()).then((data) async {
      if (data != null) {
        CustomerValueData customerValueData = CustomerValueData.fromJson(data);

        Injector.customerValueData = customerValueData;
        await Injector.prefs.remove(PrefKeys.answerData);
        Injector.streamController.add("submit answer");
      }
    }).catchError((e) {
      print("callSubmitAnswerApi" + e.toString());
      Utils.showToast(e.toString());
    });
  }

  static FileInfo getCacheFile(String url) {
    return Injector.cacheManager.getFileFromMemory(url);
  }

  static getHeaderHeight(BuildContext context) {
    return Utils.getDeviceHeight(context) / 7.5;
  }

  static getValue(QuestionData questionData) {
    var random = ((Random().nextInt(10))) / 10;
    int finalValue = 0;
    try {
      var a = 500 + min(50 * questionData.daysInList, 350) + random * 150;
      var b = (1 +
          (0.01 * min(Injector.customerValueData.totalAttemptedQuestion, 900)));
      var c = (1 + (Injector.customerValueData.valueBonus / 100));

      finalValue = (a * b * c).round();
    } catch (e) {
      print(e);
    }

    return finalValue;
  }

  static getLoyalty(QuestionData questionData) {
    var random = ((Random().nextInt(10))) / 10;
    int finalValue = 0;
    try {
      var a = max(pow(questionData.counter, 2), 1);
      var b = questionData.counter * random;
      var c = (1 + (Injector.customerValueData.loyaltyBonus / 100));

      finalValue = (a + b * c).round();
    } catch (e) {
      print(e);
    }

    return finalValue;
  }

  static getResource(QuestionData questionData) {
//    =ROUND((MAX(MIN(K16,10)^1.2,1)+(MIN(K16,10)*RAND()))*(1+(0.01*MIN($K$12,900)))*(2-$N$14),0)

    var random = ((Random().nextInt(10))) / 10;
    int finalValue = 0;
    try {
      var a = max(pow(min(questionData.counter, 10), 1.2), 1) +
          min(questionData.counter, 10) * random;
      var b = (1 +
          (0.01 * min(Injector.customerValueData.totalAttemptedQuestion, 900)));
      var c = (2 - (Injector.customerValueData.resourceBonus / 100));

      finalValue = (a * b * c).round();
    } catch (e) {
      print(e);
    }

    return finalValue;
  }

  static void performManageLevel(ManageOrgData organizationData) async {
    CustomerValueData customerValueData = Injector.customerValueData;
    customerValueData.totalBalance = organizationData.totalBalance;
    customerValueData.totalEmployeeCapacity =
        organizationData.totalEmployeeCapacity;
    customerValueData.remainingEmployeeCapacity =
        organizationData.remainingEmployeeCapacity;
    customerValueData.totalSalesPerson = organizationData.totalSalesPerson;
    customerValueData.remainingSalesPerson =
        organizationData.remainingSalesPerson;
    customerValueData.totalCustomerCapacity =
        organizationData.totalCustomerCapacity;
    customerValueData.remainingCustomerCapacity =
        organizationData.remainingCustomerCapacity;

    Injector.customerValueData = customerValueData;

    await Injector.prefs.setString(
        PrefKeys.customerValueData, json.encode(customerValueData.toJson()));

    Injector.streamController.add("manage level");
  }

  static getProgress(Organization organization) {
    var progress = organization.level / 10;

    if (progress <= 1 && progress >= 0) {
      return progress;
    } else if (progress < 0) {
      return 0.0;
    } else if (progress > 1)
      return 1.0;
    else {
      return 0.0;
    }
  }


  static updateAttemptTimeInQuestionDataLocally(
      int questionId, String attemptTime) async {
    List<QuestionData> arrQuestions = List();

    QuestionsResponse questionsResponse = QuestionsResponse.fromJson(
        jsonDecode(Injector.prefs.getString(PrefKeys.questionData)));
    arrQuestions = questionsResponse.data;

    QuestionData questionData =
        arrQuestions.where((que) => que.questionId == questionId).first;
    questionData.attemptTime = attemptTime;

    questionsResponse.data = arrQuestions;

    await Injector.prefs.setString(
        PrefKeys.questionData, json.encode(questionsResponse.toJson()));
  }

  static List<QuestionData> getQuestionsLocally(int type) {
    List<QuestionData> arrFinalQuestion = List();

    if (Injector.prefs.getString(PrefKeys.questionData) != null) {
      List<QuestionData> arrQuestionsLocal = QuestionsResponse.fromJson(
              jsonDecode(Injector.prefs.getString(PrefKeys.questionData)))
          .data;

      arrQuestionsLocal.forEach((questionData) {
        if (questionData.attemptTime == null ||
            questionData.attemptTime.isEmpty) {
          arrFinalQuestion.add(questionData);
        } else {
          DateTime newDateTimeObj2 = new DateFormat("yyyy-MM-dd HH:mm:ss")
              .parse(questionData.attemptTime);
          print("question date string : -    ${questionData.attemptTime}");

          if (type == Const.getNewQueType
              ? newDateTimeObj2.difference(DateTime.now()).inDays > 1
              : newDateTimeObj2.difference(DateTime.now()).inDays <= 1)
            arrFinalQuestion.add(questionData);
        }
      });
    }
    return arrFinalQuestion;
  }

  static showComingSoonDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            Utils.getText(context, StringRes.comingSoon),
            style: TextStyle(fontSize: 20),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(Utils.getText(context, StringRes.close)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static performDashboardItemClick(BuildContext context, String type) {
    if (Const.envType == Environment.PROD) {
      if (type == Const.typePl ||
          type == Const.typeRanking ||
          type == Const.typeTeam ||
          type == Const.typeReward ||
          type == Const.typeChallenges)
        Utils.showComingSoonDialog(context);
      else
        Navigator.push(context,
            FadeRouteHome(initialPageType: type, isCameFromDashboard: true));
    } else {
      Navigator.push(context,
          FadeRouteHome(initialPageType: type, isCameFromDashboard: true));
    }
  }

  static checkAudio() {
    if (Injector.isBusinessMode) {
      if (questionData.isAnsweredCorrect == true) {
        return Utils.correctAnswerSound();
      } else {
        return Utils.incorrectAnswerSound();
      }
    } else {
      if (questionData.isAnsweredCorrect == true) {
        return Utils.procorrectAnswerSound();
      } else {
        return Utils.proincorrectAnswerSound();
      }
    }
  }

  static pdfShow() {
    return Utils.isPdf(questionData.mediaLink)
        ? SimplePdfViewerWidget(
            completeCallback: (bool result) {
              print("completeCallback,result:$result");
            },
            initialUrl: questionData.mediaLink,
          )
        : Container();
  }

  static isImage(String path) {
    return extension(path) == ".png" ||
        extension(path) == ".jpeg" ||
        extension(path) == ".jpg";
  }

  static isVideo(String path) {
    return extension(path) == ".mp4";
  }

  static isPdf(String path) {
    return extension(path) == ".pdf";
  }

  static getCacheNetworkImage(String url) {
    if (url.isNotEmpty) {
      return CachedNetworkImageProvider(url,
          scale: 1, cacheManager: Injector.cacheManager);
    } else
      return AssetImage(Utils.getAssetsImg("title_art_2"));
  }

  static getCacheNetworkImageWidget(String url) {
    if (url.isNotEmpty) {
      return CachedNetworkImage(imageUrl: url);
    } else
      return AssetImage(Utils.getAssetsImg("title_art_2"));
  }

  static showCustomerSituationDialog(
    GlobalKey<ScaffoldState> _scaffoldKey,
    QuestionData questionData,
    QuestionData nextChallengeQuestionData,
  ) async {
    await showDialog(
        context: _scaffoldKey.currentContext,
        builder: (BuildContext context) => CustomerSituationPage(
              questionDataCustomerSituation: questionData,
              isChallenge: true,
              nextChallengeQuestionData: nextChallengeQuestionData,
            ));
  }

  static showChallengeQuestionDialog(
    GlobalKey<ScaffoldState> _scaffoldKey,
    QuestionData questionData,
  ) async {
    await showDialog(
        context: _scaffoldKey.currentContext,
        builder: (BuildContext context) => EngagementCustomer(
              questionDataEngCustomer: questionData,
              isChallenge: true,
            ));
  }

  static showUnreadCount(
      String type, double top, double right, List<GetDashboardData> data) {
    return Positioned(
      right: right,
      top: top,
      child: ConstrainedBox(
        constraints: new BoxConstraints(
          minHeight: 25.0,
          minWidth: 25.0,
        ),

//TODO comment below code fro prod mode

//        child: getCount(type, data) > 0
//            ? new DecoratedBox(
//                decoration: BoxDecoration(
//                    borderRadius: BorderRadius.circular(20),
//                    color: ColorRes.greenDot),
//                child: Center(
//                  child: Text(
//                    getCount(type, data).toString(),
//                    style: TextStyle(color: ColorRes.white),
//                  ),
//                ))
//            : null,
      ),
    );
  }

  static int getCount(String _type, List<GetDashboardData> data) {
    if (data != null) {
      int type = 0;

      if (_type == StringRes.home)
        type = 0;
      else if (_type == StringRes.businessSector)
        type = 1;
      else if (_type == StringRes.newCustomers)
        type = 2;
      else if (_type == StringRes.existingCustomers)
        type = 3;
      else if (_type == StringRes.rewards)
        type = 4;
      else if (_type == StringRes.team)
        type = 5;
      else if (_type == StringRes.challenges)
        type = 6;
      else if (_type == StringRes.organizations)
        type = 7;
      else if (_type == StringRes.pl)
        type = 8;
      else if (_type == StringRes.ranking)
        type = 9;
      else
        type = 0;

      return data.length > 0
          ? (data?.where((obj) => obj.type == type)?.first?.count ?? 00)
          : 00;
    } else
      return 0;
  }

  static int getHomePageIndex(String key) {
    if (key == Const.typeHome) {
      return 0;
    } else if (key == Const.typeBusinessSector) {
      return 1;
    } else if (key == Const.typeNewCustomer) {
      return 2;
    } else if (key == Const.typeExistingCustomer) {
      return 3;
    } else if (key == Const.typeReward) {
      return 4;
    } else if (key == Const.typeTeam) {
      return 5;
    } else if (key == Const.typeChallenges) {
      return Injector.isManager() ? 6 : 5;
    } else if (key == Const.typeOrg) {
      return Injector.isManager() ? 7 : 6;
    } else if (key == Const.typePl) {
      return Injector.isManager() ? 8 : 7;
    } else if (key == Const.typeRanking) {
      return Injector.isManager() ? 9 : 8;
    } else if (key == Const.typeProfile) {
      return Injector.isManager() ? 10 : 9;
    } else if (key == Const.typeHelp) {
      return Injector.isManager() ? 11 : 10;
    } else if (key == Const.typeEngagement) {
      return Injector.isManager() ? 12 : 11;
    } else if (key == Const.typeCustomerSituation) {
      return Injector.isManager() ? 13 : 12;
    }
    return 0;
  }
}
