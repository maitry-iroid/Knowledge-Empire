import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/register_for_push.dart';

class PushNotificationHelper {
  BuildContext context;
  String page;

  PushNotificationHelper(BuildContext _context, String _page) {
    this.context = _context;
    this.page = _page;
  }

  void initPush() async {
    print("register___" + page);

    firebaseCloudMessagingListeners();

    var initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await Injector.flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onSelectNotification: onSelectNotification);

    await Injector.firebaseMessaging.requestNotificationPermissions();

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
    Injector.firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');

        showNotification(message);
      },
//      onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
        showNotification(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');

        showNotification(message);
      },
    );
  }


  Future<void> onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
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
            child: Text('Ok'),
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
          print("registerForPush_" + e.toString());
          Utils.showToast(e.toString());
        });
      }
    });
  }

  Future<void> showNotification(Map<String, dynamic> message) async {
    Injector.notificationID++;

    String title = "";
    String body = "";

    print(message);

    Utils.addBadge();
//    CommonView().pushNotificationAlert(context);

//    if (Platform.isIOS) {
//      title = message['title'];
//      body = message['body'];
//    } else {

    title = message['notification']['title'];
    body = message['notification']['body'];

    if(message['data']!=null){

      String challengeId = message['data']['challengeId'];

      if (challengeId != null) {
        Injector.homeStreamController?.add("${Const.openPendingChallengeDialog}");
//      CommonView().pushNotificationAlert(context);

      }
    }



//      message.values.forEach((value) {
//        title = Map.from(value)['title'] ?? "";
//
//        body = Map.from(value)['body'] ?? "";
//      });

    Utils.showToast(title);
//    }

    print(title);
    print(body);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await Injector.flutterLocalNotificationsPlugin.show(
        Injector.notificationID, title, body, platformChannelSpecifics,
        payload: 'item x');
  }

  showLocalNotification(int id,String body) async{
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await Injector.flutterLocalNotificationsPlugin.show(
        id, Const.appName, body, platformChannelSpecifics,
        payload: 'item x');
  }




}
