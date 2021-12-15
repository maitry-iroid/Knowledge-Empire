import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ke_employee/BLoC/customer_value_bloc.dart';
import 'package:ke_employee/commonview/common_view.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/push_model.dart';
import 'package:ke_employee/models/register_for_push.dart';

class PushNotificationHelper {
  BuildContext context;
  PushModel mPushModel;

  PushNotificationHelper(BuildContext _context) {
    this.context = _context;
  }

  void initPush() async {
    firebaseCloudMessagingListeners();

    var initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');
//    var initializationSettingsIOS = IOSInitializationSettings(
//        onDidReceiveLocalNotification: onDidReceiveLocalNotification, );

    var initializationSettingsIOS = IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await Injector.flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification).catchError((e) {
      print("Localnotification exception: " + e.message);
    });

    await Injector.firebaseMessaging.requestPermission();

    await Injector.firebaseMessaging.getToken().then((token) {
      print("token : " + token);
      callRegisterForPush(token);
    });
  }

  Future<void> onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  }

  void firebaseCloudMessagingListeners() async {
    Injector.firebaseMessaging.getInitialMessage().then((RemoteMessage message) {
      print("=====  getInitialMessage  ===========");
      print(message);
      RemoteNotification notification = message?.notification;
      // AndroidNotification android = message.notification?.android;
      if (message?.data != null) {
        showNotification(message);
        // Utils.goNextFromNotification(int.parse(message?.data["type"]), false,
        //     "firebaseMessaging.getInitialMessage().then", context);
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("===== onMessage ========");
      print("notification===");
      print(message.notification?.title);
      print(message.notification?.body);
      print("data===");
      print(message.data);
      showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("===== onMessageOpenedApp ========");
      print("===== onMessage ========");
      print("notification===");
      print(message.notification);
      print("data===");
      print(message.data);
      RemoteNotification notification = message.notification;
      // AndroidNotification android = message.notification?.android;
      print(message.data["senderId"]);
      showNotification(message);
      // if (message.data != null) {
      //   showNotification(notification, message.data["senderId"]);
      //   Utils.goNextFromNotification(int.parse(message.data["type"]), true,
      //       "FirebaseMessaging.onMessageOpenedApp.", context);
      // }
    });
  }

  Future<void> onDidReceiveLocalNotification(int id, String title, String body, String payload) async {
    print("onDidReceiveLocalNotification");
    // display a dialog with the notification details, tap ok to go to another page
    await showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text(Utils.getText(context, StringRes.ok)),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
//              await Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => SecondScreen(payload),
//                ),
//              );
            },
          )
        ],
      ),
    );
  }

  void callRegisterForPush(String token) {
    Utils.isInternetConnected().then((isConnected) async {
      if (isConnected) {
        print("===devicdId===${Injector.deviceId}");
        RegisterForPushRequest rq = RegisterForPushRequest();
        rq.userId = Injector.userId;
        rq.deviceId = Injector.deviceId;
        rq.deviceType = Injector.deviceType;
        rq.deviceToken = token;

        await Injector.prefs.setString(PrefKeys.deviceToken, token);

        WebApi().callAPI(WebApi.rqRegisterForPush, rq.toJson()).then((data) {
          if (data != null) {}
        }).catchError((e) {
          // Utils.showToast(e.toString());
        });
      }
    });
  }

  showLocalNotification(int id, String title, String body) async {
    print("riddhi====");

    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel desc',
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');

    //TODO keep in MIND , add config in AppDelegate.swift to get push in foreground
    const iOSPlatformChannelSpecifics = const IOSNotificationDetails(badgeNumber: 1, presentAlert: true);

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await Injector.flutterLocalNotificationsPlugin
        .show(id ?? 1, title, body, platformChannelSpecifics)
        .then((value) => print("done==="))
        .catchError((e) {
      print("exception====");
      print(e);
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    Injector.notificationID++;

    print(message);

    Utils.addBadge();

    showLocalNotification(Injector.notificationID, message.notification?.title, message?.notification?.body);

    PushModel pushModel;
    if (message.data != null) {
      mPushModel = new PushModel.fromJson(message.data);
    }
    String btnText = "";
    if (mPushModel.notificationType == Const.pushTypeChallenge.toString() && Utils.isFeatureOn(Const.typeChallenges)) {
      Injector.homeStreamController?.add("${Const.openPendingChallengeDialog}");
    } else if (mPushModel.notificationType == Const.pushTypeAchievement.toString() && Utils.isFeatureOn(Const.typeAchievement)) {
      if (mPushModel.type != null && mPushModel.type == "1" && mPushModel.bonus != null) {
        Injector.customerValueData.totalEmployeeCapacity += int.parse(mPushModel.bonus);
        Injector.customerValueData.remainingEmployeeCapacity += int.parse(mPushModel.bonus);
        btnText = "${mPushModel.bonus} " + Utils.getText(context, StringRes.employees);
      }
      if (mPushModel.type != null && mPushModel.type == "3" && mPushModel.bonus != null) {
        Injector.customerValueData.totalSalesPerson += int.parse(mPushModel.bonus);
        Injector.customerValueData.remainingSalesPerson += int.parse(mPushModel.bonus);
        btnText = "${mPushModel.bonus} " + Utils.getText(context, StringRes.salesReps);
      }

      if (mPushModel.type != null && mPushModel.type == "8" && mPushModel.bonus != null) {
        Injector.customerValueData.totalCustomerCapacity += int.parse(mPushModel.bonus);
        Injector.customerValueData.remainingCustomerCapacity += int.parse(mPushModel.bonus);
        btnText = "${mPushModel.bonus} " + Utils.getText(context, StringRes.serviceReps);
      }
      if (mPushModel.type != null && mPushModel.type == "0" && mPushModel.bonus != null) {
        Injector.customerValueData.totalBalance += int.parse(mPushModel.bonus);
        btnText = "${mPushModel.bonus} ${!Injector.isBusinessMode ? Utils.getText(context, StringRes.strKp) : "\$"}";
      }

      Injector.setCustomerValueData(Injector.customerValueData);
      customerValueBloc.setCustomerValue(Injector.customerValueData);

//      CustomerValueRequest rq =  CustomerValueRequest();
//      rq.userId = Injector.userId;
//      customerValueBloc.getCustomerValue(rq);

      CommonView().collectorDialog(context, mPushModel, btnText);
    } else {
      showLocalNotification(Injector.notificationID, message.notification?.title, message.notification?.body);
    }
  }
}
