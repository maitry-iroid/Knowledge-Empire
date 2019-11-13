import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ke_employee/dialogs/change_password.dart';

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

//  static Future<bool> isInternetConnectedWithAlert(
//      GlobalKey<ScaffoldState> _scaffoldKey) async {
//    bool isConnected = false;
//
//    var connectivityResult = await (Connectivity().checkConnectivity());
//    if (connectivityResult == ConnectivityResult.mobile ||
//        connectivityResult == ConnectivityResult.wifi) {
//      isConnected = true;
//    } else {
//      showSnackBar(_scaffoldKey, "Please check your internet connectivity.");
//      isConnected = false;
//    }
//
//    return isConnected;
//  }

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
    return DateFormat("HH:mm a, dd MMMM, yyyy").format(startDate);
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

  static String getText(BuildContext context, String text) {
//    return AppLocalizations.of(context).tr(text);
    return text;
  }

  static showChangePasswordDialog(
      GlobalKey<ScaffoldState> _scaffoldKey, String senderAccessCode) async {
    await showDialog(
        context: _scaffoldKey.currentContext,
        builder: (BuildContext context) => ChangePasswordDialog());
  }
}
