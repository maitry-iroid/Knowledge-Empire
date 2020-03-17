import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/login.dart';
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

  static String rqGetLearningModule = "getLearningModule";
  static String rqAssignUserToModule = "assignUserToModule";
  static String rqGetQuestions = "getQuestions";
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
  static String rqDashboard = "dashboard";
  static String rqGetTeamUsers = "getTeamUsers";
  static String rqGetTeamUserById = "getTeamUserById";
    static String rqGetPerformance = "getPerformance";
    static String rqGetCompany = "getCompany";
    static String updateLanguage = "updateLanguage";

  static getRequest(String req, String data) {
    return {
      'apiId': 'e1530f4d52b7a5b806e2b051e72c80ef',
      'apiSecret': '1a42cc080ef2464a60134473276fe42e',
      'apiRequest': req,
      'data': data
    };
  }

  static getUploadProfileRequest(String req, String data, File file) async {
    return FormData.fromMap({
      'apiId': 'e1530f4d52b7a5b806e2b051e72c80ef',
      'apiSecret': '1a42cc080ef2464a60134473276fe42e',
      'apiRequest': req,
      'data': data,
      'profileImage': file != null
          ? await MultipartFile.fromFile(file.path, filename: "image.jpg")
          : null,
    });
  }

  Dio dio = Dio();

  Future<dynamic> callAPI(String apiReq, Map<String, dynamic> jsonMap) async {
    initDio();

    print(apiReq + "_" + json.encode(jsonMap));
    try {
      final response = await dio
          .post("", data: json.encode(getRequest(apiReq, json.encode(jsonMap))))
          .catchError((e) {
        Utils.showToast(apiReq + "_" + e.toString());
        return null;
      });

      print(apiReq + "_" + response?.data);

      if (response.statusCode == 200) {
        BaseResponse _response =
            BaseResponse.fromJson(jsonDecode(response.data));

        if (_response != null) {
          if (_response.flag == "true") {
            if (!isUserRemovedFromCompany(_response.flag, _response.msg))
              return _response.data;
            else {
              Utils.showToast(_response.msg);
              return null;
            }
          } else {
            Utils.showToast(_response.msg ?? StringRes.somethingWrong);
            return null;
          }
        } else {
          Utils.showToast(StringRes.somethingWrong);
          return null;
        }
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<UserData> updateProfile(
      Map<String, dynamic> jsonMap, File file) async {
    initDio();

    print("updateProfile_request__" + json.encode(jsonMap));
    print("headers" + dio.options.headers.toString());

    try {
      FormData formData = await getUploadProfileRequest(
          rqUpdateProfile, json.encode(jsonMap), file);

      final response = await dio.post("",
          data: formData, onSendProgress: (int sent, int total) {});

      print(response.data);

      if (response.statusCode == 200) {
        BaseResponse baseResponse =
            BaseResponse.fromJson(jsonDecode(response.data));

        if (baseResponse != null) {
          if (baseResponse.flag == "true")
            return UserData.fromJson(baseResponse.data);
          else {
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
    String authorizationHeader =
        Injector.userData != null && Injector.userData.accessToken != null
            ? "pig " + Injector.userData.accessToken
            : "";
    String deviceType = Injector.deviceType;
    String deviceId = Injector.deviceId != null ? Injector.deviceId : "abcdefg";

    print("contentTypeHeader " + contentTypeHeader);
    print("accessToken " + authorizationHeader);
    print("devicetype " + deviceType);
    print("deviceid " + deviceId);

    var headers = {
      HttpHeaders.contentTypeHeader: contentTypeHeader,
      HttpHeaders.authorizationHeader: authorizationHeader,
      'devicetype': deviceType,
      'deviceid': deviceId
    };

    BaseOptions options = new BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 20000,
        receiveTimeout: 3000,
        headers: headers);

    dio.options = options;

    return dio;
  }

  bool isUserRemovedFromCompany(String flag, String msg) {
    return flag == "false" && msg == "You are removed from company".trim();
  }
}
