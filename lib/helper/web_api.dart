import 'dart:convert';
import 'dart:io';

import 'package:ansicolor/ansicolor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/login.dart';
import 'package:pretty_json/pretty_json.dart';
import 'constant.dart';

class WebApi {
//  static const baseUrl = "http://13.127.186.25:7000/api";  // dev url
//  static const baseUrl = "http://18.141.132.109:7000/api"; // prod url
  static final baseUrl = Const.webUrl;

  static String rqLogin = "login";
  static String rqForgotPassword = "forgot_password";
  static String rqLogout = "logout";
  static String rqUpdateProfile = "updateProfile";
  static String rqChangePassword = "change_password";
  static String rqPrivacyPolicy = "privacyPolicy";

  static String rqGetLearningModule = "getLearningModule";
  static String rqGetLearningModule_v2 = "getLearningModule_v2";
  static String rqGetRewards = "getRewards";
  static String rqAssignUserToModule = "assignUserToModule";
  static String rqGetQuestions = "getQuestions";
  static String rqGetQuestions_v2 = "getQuestions_v2";
  static String rqGetOrganization = "getOrganization";
  static String rqReleaseResource = "releaseResource";
  static String rqManageOrganization = "manageOrganization";
  static String rqGetCustomerValue = "getCustomerValue";
  static String rqBailOut = "bailOut";
  static String rqSubmitChallengeAnswer = "submitChallengeAnswer";
  static String rqSubmitAnswers = "submitAnswers";
  static String rqGetUserAchievement = "getUserAchievement";
  static String rqUpdateModulePermission = "updateModulePermission";
  static String rqGetAchievementCategory = "getAchievementCategory";
  static String rqGetUserGroups = "getUserGroups";
  static String rqGetFriends = "getFriends";
  static String rqFriendUnFriendUser = "FriendUnfriendUser";
  static String rqSendChallenge = "sendChallenge";
  static String rqGetChallenge = "getChallenge";
  static String rqGetDownloadQuestions = "getDownloadQuestions";
  static String rqSearchFriends = "searchFriends";
  static String rqRegisterForPush = "registerForPush";
  static String rqRedeemReward = "redeemReward";

//  static String rqUnreadBubbleCount = "unreadBubbleCount";
  static String rqGetTeamUsers = "getTeamUsers";
  static String rqGetTeamUserById = "getTeamUserById";
  static String rqGetPerformance = "getPerformance";
  static String rqGetCompany = "getCompany";
  static String updateModeAndSoundStatus = "updateModeAndSoundStatus";
  static String switchCompanyProfile = "switchCompanyProfile";
  static String rqGameIntro = "gameIntro";
  static String forceUpdate = "forceUpdate";
  static String updateUserSetting = "updateUserSetting";
  static String rqGetDashboardStatus = "getDashboardStatus";
  static String getIntroText = "getIntroText";
  static String rqVerifyCompanyCode = "verifyCompanyCode";
  static String rqInformationActivityLog = 'informationActivityLog';
  static String rqGetAppThemeColors = "getAppThemeColors";

  static getRequest(String req, String data) {
    return {'apiId': 'e1530f4d52b7a5b806e2b051e72c80ef', 'apiSecret': '1a42cc080ef2464a60134473276fe42e', 'apiRequest': req, 'data': data};
  }

  static getUploadProfileRequest(String req, String data, File file) async {
    return FormData.fromMap({
      'apiId': 'e1530f4d52b7a5b806e2b051e72c80ef',
      'apiSecret': '1a42cc080ef2464a60134473276fe42e',
      'apiRequest': req,
      'data': data,
      'profileImage': file != null ? await MultipartFile.fromFile(file.path, filename: "image.jpg") : null,
    });
  }

  Dio dio = Dio();

  Future<dynamic> callAPI(String apiReq, Map<String, dynamic> jsonMap) async {
    initDio();

    print("----------------------------------- API request > " + apiReq + " --------------------------------");
    print("BODY - " + json.encode(jsonMap) + "\n\n");

    if (!Injector.isInternetConnected) return;

    var finalResponse;

    await dio.post("", data: json.encode(getRequest(apiReq, json.encode(jsonMap)))).then((response) {
      if (response != null && response.statusCode == 200) {
        print("---------------------------------- API response > " + apiReq + "--------------------------------");
        BaseResponse _response = BaseResponse.fromJson(jsonDecode(response.data));
        print(prettyJson(_response.toJson(), indent: 2));

        if (_response != null) {
          if (_response.flag == "true") {
            if (!isUserRemovedFromCompany(_response.flag, _response.msg)) {
              if (apiReq == rqGetDashboardStatus) {
                finalResponse = jsonDecode(response.data);
              } else {
                finalResponse = _response.data;
              }
            } else {
              Utils.showToast(_response.msg);
            }
          } else {
            Utils.showToast(_response.msg ?? StringRes.somethingWrong);
          }
        } else {
          Utils.showToast(StringRes.somethingWrong);
        }
      }
    }).catchError((e) {
      print("err_ " + apiReq + ": " + e.toString());
//      Utils.showErrToast(apiReq + ": " + e.toString());
    });

    // debugPrint("--------------------Final Response + $apiReq :: $finalResponse");
    return finalResponse;
  }

  Future<UserData> updateProfile(Map<String, dynamic> jsonMap, File file) async {
    initDio();

    try {
      FormData formData = await getUploadProfileRequest(rqUpdateProfile, json.encode(jsonMap), file);

      final response = await dio.post("", data: formData, onSendProgress: (int sent, int total) {});

      print(response.data);

      if (response.statusCode == 200) {
        BaseResponse baseResponse = BaseResponse.fromJson(jsonDecode(response.data));

        if (baseResponse != null) {
          if (baseResponse.flag == "true") {
            UserData userData = UserData.fromJson(baseResponse.data);
            await userData.decryptRequiredData();
            return userData;
          } else {
            Utils.showToast(baseResponse.msg);
            return null;
          }
        } else {
          Utils.showToast(StringRes.somethingWrong);
          return null;
        }
      } else {
        Utils.showToast(StringRes.somethingWrong);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  initDio() {
    String contentTypeHeader = 'application/json';
    String authorizationHeader = Injector.userData != null && Injector.userData.accessToken != null ? "pig " + Injector.userData.accessToken : "";
    String deviceType = Injector.deviceType;
    String deviceId = Injector.deviceId != null ? Injector.deviceId : "abcdefg";

    // print("contentTypeHeader " + contentTypeHeader);
    // print("accessToken " + authorizationHeader);
    // print("devicetype " + deviceType);
    // print("deviceid " + deviceId);

    var headers = {
      HttpHeaders.contentTypeHeader: contentTypeHeader,
      HttpHeaders.authorizationHeader: authorizationHeader,
      'devicetype': deviceType,
      'deviceid': deviceId
    };

    BaseOptions options = new BaseOptions(
        baseUrl: Injector.prefs.getString(PrefKeys.mainBaseUrl) == null || Injector.prefs.getString(PrefKeys.mainBaseUrl).isEmpty
            ? baseUrl
            : Injector.prefs.getString(PrefKeys.mainBaseUrl),
        connectTimeout: 120000,
        receiveTimeout: 3000,
        headers: headers);

    // print("finalbaseUrl :  " + options.baseUrl);
    dio.options = options;
    return dio;
  }

  bool isUserRemovedFromCompany(String flag, String msg) {
    return flag == "false" && msg == "You are removed from company".trim();
  }
}
