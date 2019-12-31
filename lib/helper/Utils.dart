import 'dart:math';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ke_employee/dialogs/change_password.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:ke_employee/dialogs/loader.dart';
import 'package:ke_employee/dialogs/org_info.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/home.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/questions.dart';
import 'package:ke_employee/models/submit_answer.dart';

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
//    return AppLocalizations.of(context).tr(text);

    return AppLocalizations.of(context).text(text) != null
        ? AppLocalizations.of(context).text(text)
        : text;

    if (Injector.prefs.getString(PrefKeys.userId) != null &&
        Injector.prefs.getString(PrefKeys.userId).isNotEmpty) {
      return Injector.isBusinessMode
          ? StringRes.localizedValues['en'][text] != null
              ? StringRes.localizedValues['en'][text]
              : ""
          : StringRes.localizedValuesProf['en'][text] != null
              ? StringRes.localizedValuesProf['en'][text]
              : "";
    } else {
      return StringRes.localizedValues['en'][text] != null
          ? StringRes.localizedValues['en'][text]
          : "";
    }
  }

  static showChangePasswordDialog(GlobalKey<ScaffoldState> _scaffoldKey,
      bool isFromProfile, bool isOldPasswordRequired) async {
    await showDialog(
        context: _scaffoldKey.currentContext,
        builder: (BuildContext context) => ChangePasswordDialog(
            isFromProfile: isFromProfile,
            isOldPasswordRequired: isOldPasswordRequired));
  }

  static showOrgInfoDialog(
      GlobalKey<ScaffoldState> _scaffoldKey, String description) async {
    await showDialog(
        context: _scaffoldKey.currentContext,
        builder: (BuildContext context) => OrgInfoDialog(
              text: description,
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

  static getOrgText(int orgType) {
    if (orgType == Const.typeHR) {
      return StringRes.textHr;
    } else if (orgType == Const.typeServices) {
      return StringRes.textServices;
    } else if (orgType == Const.typeMarketing) {
      return StringRes.textMarketing;
    } else if (orgType == Const.typeSales) {
      return StringRes.textSales;
    } else if (orgType == Const.typeOperations) {
      return StringRes.textOperations;
    } else if (orgType == Const.typeLegal) {
      return StringRes.textLegal;
    } else if (orgType == Const.typeFinance) {
      return StringRes.textFinance;
    } else if (orgType == Const.typeCRM) {
      return StringRes.textCRM;
    } else
      return "";
  }

//  static checkSound() async {
//    int maxVol, currentVol;
//    maxVol = await Volume.getMaxVol;
//    // get Current Volume
//    currentVol = await Volume.getVol;
//  }

  static playClickSound() async {
    Injector.audioPlayer.play("sounds/all_button_clicks.wav");
  }

  static correctAnswerSound() async {
    Injector.audioPlayer.play("sounds/right_answer.wav");
  }

  static incorrectAnswerSound() async {
    Injector.audioPlayer.play("sounds/wrong_answer.wav");
  }

  static procorrectAnswerSound() async {
    Injector.audioPlayer.play("sounds/pro_right_answer.mp3");
  }

  static proincorrectAnswerSound() async {
    Injector.audioPlayer.play("sounds/pro_wrong_answer.mp3");
  }

//  Future<void> initPlatformState() async {
//    var dig = await FlutterVolume.volume;
//
//    print("${(dig * 100)}%");
//  }

  static saveQuestionLocally(List<QuestionData> arrQuestions) async {
    List<String> jsonQuestionData = List();
    List<QuestionData> questionData_ = List();

    if (Injector.prefs.getStringList(PrefKeys.questionData) != null) {
      List<String> jsonQuestionData =
          Injector.prefs.getStringList(PrefKeys.questionData);

      jsonQuestionData.forEach((jsonQuestion) {
        questionData_.add(QuestionData.fromJson(json.decode(jsonQuestion)));
      });
    }

    questionData_.addAll(arrQuestions);

    questionData_.forEach((questionData) {
      jsonQuestionData.add(json.encode(questionData));
    });

    await Injector.prefs.setStringList(PrefKeys.questionData, jsonQuestionData);
  }

  static List<QuestionData> getQuestionsLocally() {
    List<QuestionData> questionData = List();

    if (Injector.prefs.getStringList(PrefKeys.questionData) != null) {
      List<String> jsonQuestionData =
          Injector.prefs.getStringList(PrefKeys.questionData);

      jsonQuestionData.forEach((jsonQuestion) {
        questionData.add(QuestionData.fromJson(json.decode(jsonQuestion)));
      });
    }

    return questionData;
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
        json.decode(Injector.prefs.getString(PrefKeys.answerData)));

    WebApi().submitAnswers(context, rq).then((data) async {
      if (data != null) {
        Injector.customerValueData = data;
      }
      await Injector.prefs.remove(PrefKeys.answerData);
      Injector.streamController.add("submit answer");
    }).catchError((e) {
      print(e);
      Utils.showToast(e.toString());
    });
  }

  static FileInfo getCacheFile(String url) {
    return DefaultCacheManager().getFileFromMemory(url);
  }

  static getHeaderHeight(BuildContext context) {
    return Utils.getDeviceHeight(context) / 7.5;
  }

  static getValue(QuestionData questionData) {
    var random = ((Random().nextInt(10))) / 10;

    var a = 500 + min(50 * questionData.daysInList, 350) + random * 150;
    var b = (1 +
        (0.01 * min(Injector.customerValueData.totalAttemptedQuestion, 900)));
    var c = (1 + (Injector.customerValueData.valueBonus / 100));

    int finalValue = (a * b * c).round();

    return finalValue;
  }

  static getLoyalty(QuestionData questionData) {
    var random = ((Random().nextInt(10))) / 10;

    var a = max(pow(questionData.counter, 2), 1);
    var b = questionData.counter * random;
    var c = (1 + (Injector.customerValueData.loyaltyBonus / 100));

    int finalValue = (a + b * c).round();

    return finalValue;
  }

  static getResource(QuestionData questionData) {
//    =ROUND((MAX(MIN(K16,10)^1.2,1)+(MIN(K16,10)*RAND()))*(1+(0.01*MIN($K$12,900)))*(2-$N$14),0)

    var random = ((Random().nextInt(10))) / 10;

    var a = max(pow(min(questionData.counter, 10), 1.2), 1) +
        min(questionData.counter, 10) * random;
    var b = (1 +
        (0.01 * min(Injector.customerValueData.totalAttemptedQuestion, 900)));
    var c = (2 - (Injector.customerValueData.resourceBonus / 100));

    int finalValue = (a * b * c).round();

    return finalValue;
  }
}
