import 'dart:io';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ke_employee/BLoC/customer_value_bloc.dart';
import 'package:ke_employee/BLoC/navigation_bloc.dart';
import 'package:ke_employee/commonview/pdf_viewer.dart';
import 'package:ke_employee/dialogs/change_password.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'dart:async';

import 'package:flutter/services.dart' show rootBundle;
import 'package:ke_employee/dialogs/nickname_dialog.dart';
import 'package:ke_employee/dialogs/privacy_policy_dialog.dart';
import 'package:ke_employee/models/on_off_feature.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ke_employee/dialogs/loader.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/models/homedata.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/get_customer_value.dart';
import 'package:ke_employee/models/manage_organization.dart';
import 'package:ke_employee/models/organization.dart';
import 'package:ke_employee/models/questions.dart';
import 'package:ke_employee/models/submit_answer.dart';
import 'package:ke_employee/screens/organization.dart';
import 'package:path/path.dart';

import 'constant.dart';
import 'localization.dart';

import 'package:ke_employee/screens_portrait/bottom_navigation.dart';

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

  static getAssetsImgJpg(String name) {
    return "assets/images/" + name + ".jpg";
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
        backgroundColor: Colors.black87,
        textColor: Colors.white);
  }

  static Future<String> initPlatformState() async {
    String timezone;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      timezone = await FlutterNativeTimezone.getLocalTimezone();
    } on PlatformException {
      timezone = 'Failed to get the timezone.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    return timezone;
  }

  static Future<bool> isInternetConnectedWithAlert(BuildContext context) async {
    bool isConnected = false;

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      isConnected = true;
    } else {
      showToast(Utils.getText(context, StringRes.noInternet));
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
    navigationBloc.updateNavigation(HomeData(initialPageType: Const.typeHome));

    /*  if (!Navigator.canPop(context)) {
      Navigator.pop(context);

//      Navigator.pushReplacement(context, FadeRouteHome());
      navigationBloc.updateNavigation(Const.typeHome);
      */ /*showDialog(
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
          });*/ /*
    } else
      Navigator.pop(context);*/
  }

  static String getText(BuildContext context, String text) {
    return AppLocalizations.of(context).text(text) ?? text;
  }


  static showNickNameDialog(GlobalKey<ScaffoldState> _scaffoldKey, bool isFromProfile) async {
    await showDialog(
        context: _scaffoldKey.currentContext,
        builder: (BuildContext context) => NickNameDialog(
            isFromProfile: isFromProfile));
  }

  static showPrivacyPolicyDialog(GlobalKey<ScaffoldState> _scaffoldKey, bool isFromProfile, int companyId, String title, String content, String acceptText, {void Function(bool) completion}) async {
    await showDialog(
        context: _scaffoldKey.currentContext,
        builder: (BuildContext context) => PrivacyPolicyDialog(
            scaffoldKey: _scaffoldKey,
            isFromProfile: isFromProfile,
            companyId: companyId,
            privacyPolicyTitle: title,
            privacyPolicyContent: content,
            privacyPolicyAcceptText: acceptText,
            completion: completion,
        ));
  }


  static showChangePasswordDialog(GlobalKey<ScaffoldState> _scaffoldKey,
      bool isFromProfile, bool isOldPasswordRequired) async {
    await showDialog(
        context: _scaffoldKey.currentContext,
        builder: (BuildContext context) => ChangePasswordDialog(
            scaffoldKey: _scaffoldKey,
            isFromProfile: isFromProfile,
            isOldPasswordRequired: isOldPasswordRequired));
  }

  static String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  static getSecret(String email, String password) {
    String text =
        email.split('').reversed.join() + password.split('').reversed.join();
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

  static playBackgroundMusic() async {
    // Injector.audioCache.play("game_bg_music.mp3");
    bool isPlaySound = false;
    if (Injector.isBusinessMode &&
        Injector.isSoundEnable != null &&
        Injector.isSoundEnable) {
      isPlaySound = true;
    } else {
      isPlaySound = false;
    }
    await playSound(isPlaySound);
  }

  static Future playSound(bool isPlaySound) async {
    try {
      if (isPlaySound) {
        final file = new File('${(await getTemporaryDirectory()).path}/music.mp3');
        print(file.path);
        await file.writeAsBytes((await loadAsset()).buffer.asUint8List());
        await Injector.audioPlayerBg.setReleaseMode(ReleaseMode.LOOP);
        Injector.audioPlayerBg.play(file.path, isLocal: true);
      } else {
        Injector.audioPlayerBg.stop();
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<ByteData> loadAsset() async {
    return await rootBundle.load('assets/sounds/game_bg_music.mp3');
  }

  static playAchievementSound() async {
    if (Injector.isSoundEnable != null && Injector.isSoundEnable)
      Injector.audioCache.play("achievement_music.mp3");
  }

  static playClickSound() {
    if (Injector.isSoundEnable != null && Injector.isSoundEnable) {
      Injector.audioCache.play("all_button_clicks.wav");
    }
//    if (Injector.isSoundEnable)
//      audioPlay('assets/sounds/all_button_clicks.wav');
  }

  static correctAnswerSound() async {
//    if (Injector.isSoundEnable) Injector.audioCache.play("right_answer.wav");
    if (Injector.isSoundEnable != null && Injector.isSoundEnable)
      Injector.audioCache.play("coin_sound.wav");
  }

  static incorrectAnswerSound() async {
    if (Injector.isSoundEnable != null && Injector.isSoundEnable)
      Injector.audioCache.play("wrong_answer.wav");
  }

  static achievementSound() async {
    if (Injector.isSoundEnable != null && Injector.isSoundEnable)
      Injector.audioCache.play("achievement_music.mp3");
  }

  static proCorrectAnswerSound() async {
    if (Injector.isSoundEnable != null && Injector.isSoundEnable)
      Injector.audioCache.play("pro_right_answer.mp3");
  }

  static proIncorrectAnswerSound() async {
    if (Injector.isSoundEnable != null && Injector.isSoundEnable)
      Injector.audioCache.play("pro_wrong_answer.mp3");
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

        await Injector.prefs.remove(PrefKeys.answerData);
        customerValueBloc.setCustomerValue(customerValueData);
      }
    }).catchError((e) {
      print("callSubmitAnswerApi" + e.toString());
      // Utils.showToast(e.toString());
    });
  }

  static FileInfo getCacheFile(String url) {
    try {
      return Injector.cacheManager.getFileFromMemory(url);
    } catch (e) {
      print(e);
      return null;
    }
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
    customerValueData.totalEmployeeCapacity = organizationData.totalEmployeeCapacity;
    customerValueData.remainingEmployeeCapacity = organizationData.remainingEmployeeCapacity;
    customerValueData.totalSalesPerson = organizationData.totalSalesPerson;
    customerValueData.remainingSalesPerson = organizationData.remainingSalesPerson;
    customerValueData.totalCustomerCapacity = organizationData.totalCustomerCapacity;
    customerValueData.remainingCustomerCapacity = organizationData.remainingCustomerCapacity;

    customerValueBloc?.setCustomerValue(customerValueData);
//    Injector.streamController.add("manage level");
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
        PrefKeys.questionData, jsonEncode(questionsResponse.toJson()));
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
          if (type == Const.getNewQueType
              ? newDateTimeObj2.difference(DateTime.now()).inDays > 1
              : newDateTimeObj2.difference(DateTime.now()).inDays <= 1)
            arrFinalQuestion.add(questionData);
        }
      });
    }
    return arrFinalQuestion;
  }

  static getUserNameForIntroDialog(String word, BuildContext context) {
    String finalString;
    if (word != null && word.isNotEmpty) {
      if (word == "yes") {
        return Injector.userData?.name ?? "";
      } else {
        finalString = Utils.getText(context, StringRes.hi);
      }
    } else {
      finalString = Utils.getText(context, StringRes.dear);
    }
    return finalString + " " + Injector.userData?.name ?? "";
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

  static performDashboardItemClick(BuildContext context, String type) async {
    if (Injector.isSoundEnable!=null && Injector.isSoundEnable) {
      Injector.audioCache.play("all_button_clicks.wav");
    }

    if (type == Const.typeOrg ||
        type == Const.typeChallenges ||
        type == Const.typeAchievement ||
        type == Const.typeReward ||
        type == Const.typeRanking ||
        type == Const.typeTeam ||
        type == Const.typePl) {
      bool isConnected = await isInternetConnected();


      if (Injector.dashboardStatusResponse != null) {
        OnOffFeatureData data = Injector.dashboardStatusResponse.data
            .where((obj) => obj.type == int.parse(type))
            ?.first;

        if (data != null && data.isFeatureOn == 0) return;

        if (!isConnected) {
          Utils.showLockReasonDialog(StringRes.noOffline, context, true);
          return;
        }

        if (data != null && data.isUnlock == 0) {
          showLockReasonDialog(type, context, false);
          return;
        }
      }
    }
    performNavigation(type, context);
  }

  static Widget lockUi(String type, BuildContext context) {
    return InkResponse(
      onTap: () {
        Utils.playClickSound();
        Utils.performDashboardItemClick(context, type);
      },
      child: Container(
        foregroundDecoration:
            BoxDecoration(color: ColorRes.white.withOpacity(0.5)),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Utils.getAssetsImg("pro_lock")),
                //bg_main_card
                fit: BoxFit.fill)),
      ),
    );
  }

  static checkAudio(isAnsweredCorrect) {
    if (Injector.isBusinessMode) {
      if (isAnsweredCorrect) {
        return Utils.correctAnswerSound();
      } else {
        return Utils.incorrectAnswerSound();
      }
    } else {
      if (isAnsweredCorrect) {
        return Utils.proCorrectAnswerSound();
      } else {
        return Utils.proIncorrectAnswerSound();
      }
    }
  }

  /*static pdfShow() {
    return SimplePdfViewerWidget(
      completeCallback: (bool result) {
        print("completeCallback,result:$result");
      },
      initialUrl: questionData.mediaLink,
    );
  }*/

  static Widget pdfShow(String pdfPath, bool _isLoading) {
    return new TemplatePageWidget(
      height: double.infinity,
      isLoading: _isLoading,
      width: double.infinity,
      previewPath: pdfPath,
    );
  }

  static isImage(String path) {
    return extension(path).toLowerCase() == ".png".toLowerCase() ||
        extension(path).toLowerCase() == ".jpeg".toLowerCase() ||
        extension(path).toLowerCase() == ".jfif".toLowerCase() ||
        extension(path).toLowerCase() == ".jpg".toLowerCase();
  }

  static isVideo(String path) {
    return extension(path).toLowerCase() == ".mp4".toLowerCase();
  }

  static isPdf(String path) {
    return extension(path).toLowerCase() == ".pdf".toLowerCase();
  }

  static getCacheNetworkImage(String url) {
    if (url.isNotEmpty) {
      return CachedNetworkImageProvider(url,
          scale: 1, cacheManager: Injector.cacheManager);
    } else
      return AssetImage(Utils.getAssetsImg("user_org"));
  }

  static getCacheNetworkImageWidget(String url) {
    if (url.isNotEmpty) {
      return CachedNetworkImage(imageUrl: url);
    } else
      return AssetImage(Utils.getAssetsImg("user_org"));
  }

//  static showChallengeQuestionDialog(
//    BuildContext context,
//    QuestionData questionData,
//  ) async {
//    await showDialog(
//        context: context,
//        builder: (BuildContext context) => EngagementCustomer(
//              questionDataEngCustomer: questionData,
//              isChallenge: true,
//            ));
//  }

  static showUnreadCount(String type, double top, double right) {
    return Positioned(
        right: right,
        top: top,
        child: ConstrainedBox(
          constraints: new BoxConstraints(
            minHeight: 25.0,
            minWidth: 25.0,
          ),
          child: getCount(type) > 0
              ? new DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorRes.greenDot),
                  child: Center(
                    child: Text(
                      getCount(type).toString(),
                      style: TextStyle(color: ColorRes.white),
                    ),
                  ))
              : null,
        ));
  }

  static int getCount(String _type) {
    if (Injector.dashboardStatusResponse != null) {
      return Injector.dashboardStatusResponse.data.length > 0
          ? (Injector.dashboardStatusResponse.data
                  ?.where((obj) => obj.type == int.parse(_type))
                  ?.first
                  ?.unreadCount ??
              00)
          : 00;
    } else
      return 0;
  }

  static void performNavigation(String type, BuildContext context) {
    navigationBloc.updateNavigation(HomeData(initialPageType: type));
  }

  static int getIndexLocale(String language) {
    int index = 0;

    switch (language) {
      case "English":
        index = 0;
        break;
      case "German":
        index = 1;
        break;
      case "Chinese":
        index = 2;
        break;
      default:
        index = 0;
        break;
    }

    return index;
  }

  static String getQueValidationToast(int salesCount) {
    String language = Injector.userData.language;
    bool isBusinessMode = Injector.isBusinessMode;

    if (isBusinessMode) {
      switch (language) {
        case "English":
          return "You need at least ${salesCount} free Sales Reps and 1 free Service Reps to attempt this Question. You can add more Sales and Service Reps from the Organization.";
          break;
        case "German":
          return "Du brauchst mindestens ${salesCount} freie Vertriebsmitarbeiter und 1 freien Servicemitarbeiter, um diese Frage zu beantworten. Du kannst weitere Vertriebs- und Servicemitarbeiter im Organisationmenü hinzufügen.";
          break;
        case "Chinese":
          return "您需要至少${salesCount}个销售代表和1个服务代表来回答此问题。您可以从组织中添加更多销售代表。";
          break;
        default:
          return "You need atleast ${salesCount} free Sales Reps and 1 free Service Reps to attempt this Question. You can add more Sales and Service Reps from the Organization.";
          break;
      }
    } else {
      switch (language) {
        case "English":
          return "You need at least ${salesCount} free Study Points and 1 free Memory Point to attempt this Question. You can add more Study and Memory Points in the Power-Up section.";
          break;
        case "German":
          return "Du brauchst mindestens ${salesCount} freie Lernpunkte und 1 freie Bestandsfragenkapazität, um diese Frage zu beantworten. Du kannst weitere Kapazitä im Lernbonusmenü hinzufügen.";
          break;
        case "Chinese":
          return "您需要至少${salesCount}个学习点数和1个记忆点数来回答此问题。您可以从威力升级中添加更多学习点数。";
          break;
        default:
          return "You need at least ${salesCount} free Study Points and 1 free Memory Point to attempt this Question. You can add more Study and Memory Points in the Power-Up section.";
          break;
      }
    }
  }

  static String challengeString(int question, int earn, int totalValue) {
    String language = Injector.userData.language;
    bool isBusinessMode = Injector.isBusinessMode;
    if (isBusinessMode) {
      switch (language) {
        case "English":
          return "Your friend will have to answer ${question} questions. If he wins then he will earn ${earn} % of his total value. If you win then you will earn ${totalValue} % of your total value.";
          break;
        case "German":
          return "Dein Freund muss ${question} Fragen beantworten. Wenn er gewinnt, verdient er ${earn} % seines Vermögen. Wenn du gewinnst, erhältst du ${totalValue} % deines Vermögens.";
          break;
        case "Chinese":
          return "您的朋友将必须回答${question}个问题。如果他赢了，那么他将获得他的总价值的${earn} ％。如果您赢了，那么您将获得您的总价值的${totalValue} ％。";
          break;
        default:
          return "Your friend will have to answer ${question} questions. If he wins then he will earn ${earn} % of his total value. If you win then you will earn ${totalValue} % of your total value.";
          break;
      }
    } else {
      switch (language) {
        case "English":
          return "Your friend will have to answer ${question} questions. If he wins then he will earn ${earn} % of his total value. If you win then you will earn ${totalValue} % of your total value.";
          break;
        case "German":
          return "Dein Freund muss ${question} Fragen beantworten. Wenn er gewinnt, verdient er ${earn} % seines Vermögen. Wenn du gewinnst, erhältst du ${totalValue} % deines Vermögens.";
          break;
        case "Chinese":
          return "您的朋友将必须回答${question}个问题。如果他赢了，那么他将获得他的总价值的${earn} ％。如果您赢了，那么您将获得您的总价值的${totalValue} ％。";
          break;
        default:
          return "Your friend will have to answer ${question} questions. If he wins then he will earn ${earn} % of his total value. If you win then you will earn ${totalValue} % of your total value.";
          break;
      }
    }
  }

  static String subscribeText(String moduleName) {
    String language = Injector.userData.language;
    bool isBusinessMode = Injector.isBusinessMode;
    if (isBusinessMode) {
      switch (language) {
        case "English":
          return 'Are you sure, you want to unsubscribe from Module $moduleName? All progress will be lost.';
          break;
        case "German":
          return 'Wirklich vom Modul $moduleName abmelden? Aller Fortschritt geht verlohren.';
          break;
        case "Chinese":
          return "您确定要退订学习模块 $moduleName吗? 所有的进步都将丢失.";
          break;
        default:
          return 'Are you sure, you want to unsubscribe from Module $moduleName? All progress will be lost.';
          break;
      }
    } else {
      switch (language) {
        case "English":
          return 'Are you sure, you want to unsubscribe from Module $moduleName? All progress will be lost.';
          break;
        case "German":
          return "Wirklich vom Modul $moduleName abmelden? Aller Fortschritt geht verlohren.";
          break;
        case "Chinese":
          return "您确定要退订学习模块 $moduleName吗? 所有的进步都将丢失.";
          break;
        default:
          return 'Are you sure, you want to unsubscribe from Module $moduleName? All progress will be lost.';
          break;
      }
    }
  }

  static void addBadge() {
    int count = Injector.badgeCount + 1;
    FlutterAppBadger.updateBadgeCount(count);
    Injector.prefs.setInt(PrefKeys.badgeCount, count);
    Injector.badgeCount = Injector.prefs.getInt(PrefKeys.badgeCount);
  }

  static void removeBadge() {
    FlutterAppBadger.removeBadge();
    Injector.badgeCount = 0;
    Injector.prefs.setInt(PrefKeys.badgeCount, 0);
  }

//  static void incrementBadge(String userId) async {
//    await Injector.databaseRef
//        .collection(Const.usersCollection)
//        .document(userId)
//        .updateData({Const.keyBadgeCount: FieldValue.increment(1)});
//  }
  static void showLockReasonDialog(
      String typeOrg, BuildContext context, isForInternet) {
    showDialog(
        context: context,
        builder: (BuildContext context) => OrgInfoDialog(
              text: Utils.getText(context,
                  isForInternet ? typeOrg : getLockReasonText(typeOrg)),
              isForIntroDialog: true,
            ));
  }

  static String getLockReasonText(String type) {
    if (type == Const.typeOrg)
      return StringRes.unLockOrg;
    else if (type == Const.typeChallenges)
      return StringRes.unLockChallenge;
    else if (type == Const.typePl)
      return StringRes.unLockPl;
    else if (type == Const.typeRanking)
      return StringRes.unLockRanking;
    else if (type == Const.typeAchievement)
      return StringRes.unLockReward;
    else if (type == Const.typeReward)
      return StringRes.unLockReward;
    else
      return "";
  }

  static bool isFeatureOn(String type) {
    if (Injector.dashboardStatusResponse != null) {
      List<OnOffFeatureData> data = Injector.dashboardStatusResponse.data;

      if (data.length > 0) {
        int status = data
            .where((obj) => obj.type == int.parse(type))
            ?.first
            ?.isFeatureOn;

        return status == 1;
      }
    }

    return true;
  }

  static bool isLocked(String type) {
    if (Injector.dashboardStatusResponse != null) {
      List<OnOffFeatureData> data = Injector.dashboardStatusResponse.data;

      if (data.length > 0) {
        int status =
            data.where((obj) => obj.type == int.parse(type))?.first?.isUnlock;

        return status == 0;
      }
    }

    return true;
  }

  static isShowUnreadCount(String type) {
    return Utils.isFeatureOn(type) && !Utils.isLocked(type);
  }

  static isShowLock(String type) {
    return Utils.isFeatureOn(type) && Utils.isLocked(type);
  }

  static void callCustomerValuesApi() {
    CustomerValueRequest rq = CustomerValueRequest();
    rq.userId = Injector.userData.userId;

    Utils.isInternetConnected().then((isConnected) {
      if (isConnected) customerValueBloc?.getCustomerValue(rq);
    });
  }
}
