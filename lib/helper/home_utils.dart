import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:ke_employee/BLoC/challenge_question_bloc.dart';
import 'package:ke_employee/BLoC/locale_bloc.dart';
import 'package:ke_employee/animation/Explostion.dart';
import 'package:ke_employee/dialogs/display_dailogs.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/manager/encryption_manager.dart';
import 'package:ke_employee/models/UpdateDialogModel.dart';
import 'package:ke_employee/models/get_challenges.dart';
import 'package:ke_employee/models/homedata.dart';
import 'package:ke_employee/models/on_off_feature.dart';
import 'package:ke_employee/models/privay_policy.dart';
import 'package:ke_employee/models/questions.dart';
import 'package:ke_employee/push_notification/PushNotificationHelper.dart';
import 'package:ke_employee/screens/refreshAnimation.dart';
import 'Utils.dart';
import 'package:ke_employee/BLoC/navigation_bloc.dart';
import 'constant.dart';

class HomeUtils {
  static GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<ExplosionWidgetState> explosionWidgetStateKey = new GlobalKey<ExplosionWidgetState>();
  static String currentPage = Const.typeHome;
  static StreamSubscription<ConnectivityResult> connectivitySubscription;
  static ValueNotifier<bool> headerNotifier = ValueNotifier<bool>(false);

  bool startAnim = false;
  int duration = 1;
  bool isCoinVisible = false;

  HomeData homeData;

  static void initHome(BuildContext context) {
    print("Home Initstate:----------------------------------------------------------");
    Injector.prefs.setBool(PrefKeys.isLoggedIn, true);
    localeBloc.setLocale(Utils.getIndexLocale(Injector.userData.language));
    //update userdata if privacy policy is updated.
    apiCallPrivacyPolicy(Injector.userData.userId, Const.typeGetPrivacyPolicy.toString(), Injector.userData.activeCompany, (response) {
      if (response.isSeenPrivacyPolicy == 0) {
        Injector.userData.isSeenPrivacyPolicy = 0;
        Injector.setUserData(Injector.userData, false);
      }
      Injector.checkPrivacyPolicy(scaffoldKey, context);
    });
  }

  static void callDashboardStatusApi() {
    Utils.isInternetConnected().then((isConnected) {
      if (isConnected) {
        DashboardStatusRequest rq = DashboardStatusRequest();
        rq.userId = Injector.userData.userId;

        WebApi().callAPI(WebApi.rqGetDashboardStatus, rq.toJson()).then((data) {
          if (data != null) {
            DashboardStatusResponse response = DashboardStatusResponse.fromJson(data);

            if (response.data.isNotEmpty) {
              Injector.prefs.setString(PrefKeys.dashboardStatusData, jsonEncode(response.toJson()));
              Injector.dashboardStatusResponse = response;

              // if (mounted) setState(() {});
            }
          }
        }).catchError((e) {
          print("getDashboardValue_" + e.toString());
        });
      }
    });
  }

  static void callVersionApi(BuildContext context) async {
    UpdateDialogModel status = await Injector.getCurrentVersion(context);
    if (status != null) {
      if (status.status != "0" || status.status == "2") {
        if (status.status == "2") {
          if (Injector.prefs.get(PrefKeys.isCancelDialog) == null) {
            DisplayDialogs.showUpdateDialog(context, status.headlineText, status.message, true);
          } else {
            DateTime clickedTime = DateTime.parse(Injector.prefs.get(PrefKeys.isCancelDialog));
            if (DateTime.now().difference(clickedTime).inDays >= 1) {
              DisplayDialogs.showUpdateDialog(context, status.headlineText, status.message, true);
            }
          }
        } else {
          DisplayDialogs.showUpdateDialog(context, status.headlineText, status.message, false);
        }
      }
    }
  }

  static void initPush(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      PushNotificationHelper pushNotificationHelper = PushNotificationHelper(context);

      if (pushNotificationHelper != null) {
        pushNotificationHelper.initPush();
      }
    });
  }

  static void initPendingChallengeStream(BuildContext context) async {
    Injector.homeStreamController.stream.listen((data) async {
      if (data == "${Const.openPendingChallengeDialog}") {
        callPendingChallengesApi(context);
      }
    }, onDone: () {}, onError: (error) {});
  }

  static void callPendingChallengesApi(BuildContext context) {
    if (!Utils.isFeatureOn(Const.typeChallenges)) return;

    GetChallengesRequest rq = GetChallengesRequest();
    rq.userId = Injector.userData.userId;

    WebApi().callAPI(WebApi.rqGetChallenge, rq.toJson()).then((data) async {
      if (data != null && data.toString() != "{}") {
        QuestionData questionData = QuestionData.fromJson(data);
        new Future.delayed(const Duration(seconds: 5), () async {
          await getChallengeQueBloc.getChallengeQuestion();
        });
        if (questionData != null && questionData.challengeId != null) {
          if (questionData.isFirstQuestion == 1) {
            String firstName = await EncryptionManager().stringDecryption(questionData.firstName);
            String lastName = await EncryptionManager().stringDecryption(questionData.lastName);
            DisplayDialogs.showChallengeDialog(context, firstName + " " + lastName, questionData);
          } else {
            navigationBloc.updateNavigation(HomeData(
              initialPageType: Const.typeEngagement,
              questionHomeData: questionData,
              isChallenge: true,
            ));
          }
        } else {
          navigationBloc.updateNavigation(HomeData(initialPageType: Const.typeHome));
        }
      } else {
        navigationBloc.updateNavigation(HomeData(initialPageType: Const.typeHome));
      }
    }).catchError((e) {
      print("getChallenges_" + e.toString());
    });
  }

  static void initCheckNetworkConnectivity(BuildContext context) {
    connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        Injector.isInternetConnected = true;
        Utils.callSubmitAnswerApi(context);
      } else
        Injector.isInternetConnected = false;
    });
  }

  static void initPlatformState() async {
    String appBadgeSupported;
    try {
      bool res = await FlutterAppBadger.isAppBadgeSupported();
      if (res) {
        appBadgeSupported = 'Supported';
      } else {
        appBadgeSupported = 'Not supported';
      }
    } on PlatformException {
      appBadgeSupported = 'Failed to get badge support.';
    }
  }
}
