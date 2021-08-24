import 'dart:io';

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
    // Injector.firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print('on message $message');
    //     showNotification(message);
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     // Trigger on notification tap when app is in background.
    //     print('on resume $message');
    //     Utils.showSuccessToast("Trigger on notification tap when app is in background.");
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     // Trigger on notification tap when app is terminated.
    //     print('on launch $message');
    //     Utils.showSuccessToast("Trigger on notification tap when app is terminated.");
    //   },
    // );
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

  Future<void> showNotification(Map<String, dynamic> message) async {
    Injector.notificationID++;

    String title = "";
    String body = "";

    print(message);

    // String fname = "";
    // String lname = "";

    Utils.addBadge();

    try {
      if (Platform.isIOS) {
        title = message['aps']['alert']['title'];
        body = message['aps']['alert']['body'];

        // fname = message['gcm.notification.firstName'];
        // lname = message['gcm.notification.lastName'];

      } else if (Platform.isAndroid) {
        title = message['notification']['title'];
        body = message['notification']['body'];

        // fname = message['data']['firstName'];
        // lname = message['data']['lastName'];

      }

      // print("::::::::: Original body :::::::: ${body}\n::::::::::::");

      // if (fname != null) {
      //   String decrptyedFName = await EncryptionManager().stringDecryption(fname);
      //   body = body.replaceAll(fname, decrptyedFName);
      // }
      //
      // if (lname != null) {
      //   String decrptyedLName = await EncryptionManager().stringDecryption(lname);
      //   body = body.replaceAll(lname, decrptyedLName);
      // }

      // print("::::::::: Decrypted body :::::::: ${body}\n::::::::::::");

      showLocalNotification(Injector.notificationID, body);

//      title = message['title'];
//      body = message['body'];
    } catch (e) {
      print(e);
    }

    PushModel pushModel;
    if (Injector.deviceType == "android") {
      if (message['data'] != null) {
        mPushModel = new PushModel.fromJson(message['data']);
      }
    } else {
      if (message != null) {
        mPushModel = new PushModel.fromJson(message);
      }
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
      showLocalNotification(Injector.notificationID, body);
    }
  }

  showLocalNotification(int id, String body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails('your channel id', 'your channel name', 'your channel description',
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await Injector.flutterLocalNotificationsPlugin.show(id, body, body, platformChannelSpecifics, payload: 'item x');
  }
}
