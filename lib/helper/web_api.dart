import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/achievement_category.dart';
import 'package:ke_employee/models/change_password.dart';
import 'package:ke_employee/models/friendUnfriendUser.dart';
import 'package:ke_employee/models/getDownloadQuestions.dart';
import 'package:ke_employee/models/get_achievement.dart';
import 'package:ke_employee/models/get_challenges.dart';
import 'package:ke_employee/models/get_customer_value.dart';
import 'package:ke_employee/models/get_friends.dart';
import 'package:ke_employee/models/get_learning_module.dart';
import 'package:ke_employee/models/get_user_group.dart';
import 'package:ke_employee/models/login.dart';
import 'package:ke_employee/models/manage_module_permission.dart';
import 'package:ke_employee/models/manage_organization.dart';
import 'package:ke_employee/models/organization.dart';
import 'package:ke_employee/models/questions.dart';
import 'package:ke_employee/models/releaseResource.dart';
import 'package:ke_employee/models/send_challenge.dart';
import 'package:ke_employee/models/submit_answer.dart';

class WebApi {
//  static const baseUrl = "http://13.127.186.25:7000/api";
  static const baseUrl = "http://18.141.132.109:7000/api";

  static String apiRequestLogin = "login";

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
      'api_id': 'e1530f4d52b7a5b806e2b051e72c80ef',
      'api_secret': '1a42cc080ef2464a60134473276fe42e',
      'api_request': req,
      'data': data,
      'profileImage': file != null
          ? await MultipartFile.fromFile(file.path, filename: "image.jpg")
          : null,
    });
  }

  Dio dio = Dio();

  Future<LoginResponse> logout(Map<String, dynamic> jsonMap) async {
    initDio();
    print("logout_request__" + json.encode(jsonMap));
    try {
      final response = await dio.post("",
          data: json.encode(getRequest('logout', json.encode(jsonMap))));
      if (response.statusCode == 200) {
        print(response.data);
        LoginResponse loginRequest =
            LoginResponse.fromJson(jsonDecode(response.data));
        return loginRequest;
      }
      print(response.data);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<LoginResponse> login(Map<String, dynamic> jsonMap) async {
    initDio();

    print("login_request__" + json.encode(jsonMap));

    final response = await dio.post("",
        data: json.encode(getRequest('login', json.encode(jsonMap))));

    if (response.statusCode == 200) {
      print(response.data);
      LoginResponse loginRequest =
          LoginResponse.fromJson(jsonDecode(response.data));
      return loginRequest;
    } else {
      return null;
    }
  }

  Future<LoginResponse> forgotPassword(Map<String, dynamic> jsonMap) async {
    initDio();

    try {
      final response = await dio.post("",
          data:
              json.encode(getRequest('forgot_password', json.encode(jsonMap))));

      if (response.statusCode == 200) {
        print(response.data);
        LoginResponse loginRequest =
            LoginResponse.fromJson(jsonDecode(response.data));
        return loginRequest;
      }
      print(response.data);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<LoginResponse> changePassword(ChangePasswordRequest rq) async {
    initDio();

    print("change_password_request__" + json.encode(rq.toJson()));

    try {
      final response = await dio.post("",
          data: json
              .encode(getRequest('change_password', json.encode(rq.toJson()))));

      if (response.statusCode == 200) {
        print(response.data);
        LoginResponse loginRequest =
            LoginResponse.fromJson(jsonDecode(response.data));
        return loginRequest;
      }

      print(response.data);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<LoginResponse> updateProfile(
      Map<String, dynamic> jsonMap, File file) async {
    initDio();

    print("updateProfile_request__" + json.encode(jsonMap));
    print("headers" + dio.options.headers.toString());

    try {
      FormData formData = await getUploadProfileRequest(
          'updateProfile', json.encode(jsonMap), file);

      final response = await dio.post("", data: formData,
          onSendProgress: (int sent, int total) {
        print("$sent $total");
      });

      print(response.data);

      if (response.statusCode == 200) {
        LoginResponse loginRequest =
            LoginResponse.fromJson(jsonDecode(response.data));
        return loginRequest;
      }

      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<LearningModuleResponse> getLearningModule(int isChallenge) async {
    initDio();

    var req = json.encode(
        {'userId': Injector.userData.userId, 'isChallenge': isChallenge});

    print("getLearningModule" + " - " + req);
    print(dio.options.headers);

    try {
      final response = await dio
          .post("", data: getRequest('getLearningModule', req),
              onSendProgress: (int sent, int total) {
        print("$sent $total");
      });

      print(response.data);

      if (response.statusCode == 200) {
        LearningModuleResponse learningModuleResponse =
            LearningModuleResponse.fromJson(jsonDecode(response.data));
        return learningModuleResponse;
      }

      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<LoginResponse> assignUserToModule(
      int moduleId, String type, int companyId) async {
    initDio();

    var req = json.encode({
      'userId': Injector.userData.userId,
      'companyId': companyId,
      'moduleId': moduleId,
      'type': type
    });

    print("assignUserToModule" + " - " + req);

    try {
      final response = await dio
          .post("", data: getRequest('assignUserToModule', req),
              onSendProgress: (int sent, int total) {
        print("$sent $total");
      });

      print(response.data);

      if (response.statusCode == 200) {
        LoginResponse loginResponse =
            LoginResponse.fromJson(jsonDecode(response.data));
        return loginResponse;
      }

      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  initDio() {
    String contentTypeHeader = 'application/json';
    String authorizationHeader =
        Injector.userData != null ? "pig " + Injector.userData.accessToken : "";
    String deviceType = 'android';
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

  Future<QuestionsResponse> getQuestions(Map<String, dynamic> jsonMap) async {
    initDio();

    print("questions_request__" + json.encode(jsonMap));
    try {
      final response = await dio.post("",
          data: json.encode(getRequest('getQuestions', json.encode(jsonMap))));
      if (response.statusCode == 200) {
        print(response.data);
        QuestionsResponse questionRequest =
            QuestionsResponse.fromJson(jsonDecode(response.data));
        return questionRequest;
      }
      print(response.data);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<OrganizationData> getOrganizations(
      BuildContext context, Map<String, dynamic> jsonMap) async {
    initDio();

    print("getOrganizations_" + json.encode(jsonMap));

    try {
      final response = await dio.post("",
          data:
              json.encode(getRequest('getOrganization', json.encode(jsonMap))));

      if (response.statusCode == 200) {
        print(response.data);
        OrganizationResponse getOrganizationResponse =
            OrganizationResponse.fromJson(jsonDecode(response.data));

        if (getOrganizationResponse != null) {
          if (getOrganizationResponse.flag == "true") {
            return getOrganizationResponse.data;
          } else {
            Utils.showToast(getOrganizationResponse.msg);
          }
        } else {
          Utils.showToast(Utils.getText(context, StringRes.somethingWrong));
        }
      }
      print(response.data);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<GetCustomerValueResponse> releaseResource(
      BuildContext context, ReleaseResourceRequest rq) async {
    initDio();

    print("releaseResource" + json.encode(rq.toJson()));

    try {
      final response = await dio.post("",
          data: json
              .encode(getRequest('releaseResource', json.encode(rq.toJson()))));

      if (response.statusCode == 200) {
        print(response.data);
        GetCustomerValueResponse releaseResourceResponse =
            GetCustomerValueResponse.fromJson(jsonDecode(response.data));

        return releaseResourceResponse;
      }
      print(response.data);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<ManageOrgData> manageOrganizations(
      BuildContext context, ManageOrganizationRequest rq) async {
    initDio();

    print("manageOrganization__" + json.encode(rq.toJson()));

    try {
      final response = await dio.post("",
          data: json.encode(
              getRequest('manageOrganization', json.encode(rq.toJson()))));

      if (response.statusCode == 200) {
        print(response.data);
        ManageOrgResponse manageOrgResponse =
            ManageOrgResponse.fromJson(jsonDecode(response.data));

        if (manageOrgResponse != null) {
          if (manageOrgResponse.flag == "true") {
            return manageOrgResponse.data;
          } else {
            Utils.showToast(manageOrgResponse.msg);
          }
        } else {
          Utils.showToast(Utils.getText(context, StringRes.somethingWrong));
        }
      }
      print(response.data);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<CustomerValueData> getCustomerValue(
      BuildContext context, Map<String, dynamic> jsonMap) async {
    initDio();

    print("getCustomerValue__" + json.encode(jsonMap));

    try {
      final response = await dio.post("",
          data: json
              .encode(getRequest('getCustomerValue', json.encode(jsonMap))));

      if (response.statusCode == 200) {
        print(response.data);
        GetCustomerValueResponse getCustomerValueResponse =
            GetCustomerValueResponse.fromJson(jsonDecode(response.data));

        if (getCustomerValueResponse != null) {
          if (getCustomerValueResponse.flag == "true") {
            return getCustomerValueResponse.data;
          } else {
            Utils.showToast(getCustomerValueResponse.msg);
          }
        } else {
          Utils.showToast(Utils.getText(context, StringRes.somethingWrong));
        }
      }
      print(response.data);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<GetCustomerValueResponse> bailOut(
      BuildContext context, Map<String, dynamic> jsonMap) async {
    initDio();

    print("bailOut__" + json.encode(jsonMap));

    try {
      final response = await dio.post("",
          data: json.encode(getRequest('bailOut', json.encode(jsonMap))));

      if (response.statusCode == 200) {
        print(response.data);
        GetCustomerValueResponse getCustomerValueResponse =
            GetCustomerValueResponse.fromJson(jsonDecode(response.data));

        return getCustomerValueResponse;
      }
      print(response.data);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<CustomerValueData> submitAnswers(
      BuildContext context, SubmitAnswerRequest rq) async {
    initDio();

    print("submitAnswers__" + json.encode(rq.toJson()));

    try {
      final response = await dio.post("",
          data: json
              .encode(getRequest('submitAnswers', json.encode(rq.toJson()))));

      if (response.statusCode == 200) {
        print(response.data);
        GetCustomerValueResponse responseData =
            GetCustomerValueResponse.fromJson(jsonDecode(response.data));

        if (responseData != null) {
          if (responseData.flag == "true") {
            return responseData.data;
          } else {
            Utils.showToast(responseData.msg);
          }
        } else {
          Utils.showToast(Utils.getText(context, StringRes.somethingWrong));
        }
      }
      print(response.data);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<GetAchievementResponse> getAchievements(
      BuildContext context, GetAchievementRequest rq) async {
    initDio();

    print("get_achievements" + json.encode(rq.toJson()));

    try {
      final response = await dio.post("",
          data: json.encode(
              getRequest('getUserAchievement', json.encode(rq.toJson()))));

      if (response.statusCode == 200) {
        print(response.data);
        GetAchievementResponse responseData =
            GetAchievementResponse.fromJson(jsonDecode(response.data));

        return responseData;
      }
      print(response.data);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<ManageModulePermissionResponse> manageModulePermission(
      BuildContext context, ManageModulePermissionRequest rq) async {
    initDio();

    print("updateModulePermission_ " + json.encode(rq.toJson()));

    try {
      final response = await dio.post("",
          data: json.encode(
              getRequest('updateModulePermission', json.encode(rq.toJson()))));

      if (response.statusCode == 200) {
        print(response.data);
        ManageModulePermissionResponse responseData =
            ManageModulePermissionResponse.fromJson(jsonDecode(response.data));

        return responseData;
      }
      print(response.data);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<AchievementCategoryResponse> getAchievementCategory(
      BuildContext context, AchievementCategoryRequest rq) async {
    initDio();

    print("getAchievementCategory" + json.encode(rq.toJson()));

    try {
      final response = await dio.post("",
          data: json.encode(
              getRequest('getAchievementCategory', json.encode(rq.toJson()))));

      if (response.statusCode == 200) {
        print(response.data);
        AchievementCategoryResponse responseData =
            AchievementCategoryResponse.fromJson(jsonDecode(response.data));

        return responseData;
      }
      print(response.data);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<GetUserGroupResponse> getUserGroup(
      BuildContext context, GetUserGroupRequest rq) async {
    initDio();

    print("getUserGroup" + json.encode(rq.toJson()));

    try {
      final response = await dio.post("",
          data: json
              .encode(getRequest('getUserGroups', json.encode(rq.toJson()))));

      if (response.statusCode == 200) {
        print(response.data);
        GetUserGroupResponse responseData =
            GetUserGroupResponse.fromJson(jsonDecode(response.data));

        return responseData;
      }
      print(response.data);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<GetFriendsResponse> getFriends(
      BuildContext context, GetFriendsRequest rq) async {
    initDio();

    print("getFriends" + json.encode(rq.toJson()));

    try {
      final response = await dio.post("",
          data:
              json.encode(getRequest('getFriends', json.encode(rq.toJson()))));

      if (response.statusCode == 200) {
        print(response.data);
        GetFriendsResponse responseData =
            GetFriendsResponse.fromJson(jsonDecode(response.data));

        return responseData;
      }
      print(response.data);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<GetFriendsUnFriendResponse> friendUnFriendUser(
      BuildContext context, GetFriendsUnfriendReuest rq) async {
    initDio();

    print("FriendUnfriendUser" + json.encode(rq.toJson()));

    try {
      final response = await dio.post("",
          data: json.encode(
              getRequest('FriendUnfriendUser', json.encode(rq.toJson()))));

      if (response.statusCode == 200) {
        print(response.data);
        GetFriendsUnFriendResponse responseData =
            GetFriendsUnFriendResponse.fromJson(jsonDecode(response.data));
        return responseData;
      }
      print(response.data);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<SendChallengesResponse> sendChallenges(
      BuildContext context, SendChallengesRequest rq) async {
    initDio();

    print("getChallenges" + json.encode(rq.toJson()));

    try {
      final response = await dio.post("",
          data: json
              .encode(getRequest('sendChallenge', json.encode(rq.toJson()))));

      if (response.statusCode == 200) {
        print(response.data);
        SendChallengesResponse responseData =
            SendChallengesResponse.fromJson(jsonDecode(response.data));
        return responseData;
      }
      print(response.data);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<GetChallengesResponse> getChallenges(
      BuildContext context, GetChallengesRequest rq) async {
    initDio();

    print("getChallenges" + json.encode(rq.toJson()));

    try {
      final response = await dio.post("",
          data: json
              .encode(getRequest('getChallenge', json.encode(rq.toJson()))));

      if (response.statusCode == 200) {
        print(response.data);
        GetChallengesResponse responseData =
            GetChallengesResponse.fromJson(jsonDecode(response.data));
        return responseData;
      }
      print(response.data);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

//  Future<QuestionsResponse> getDownloadQuestions(Map<String, dynamic> jsonMap) async {

//    Future<QuestionsResponse> getDownloadQuestions(
//      BuildContext context, DownloadQuestionsRequest rq) async {
//    initDio();
////    print("questions_request__" + json.encode(jsonMap));
//        print("getDownloadQuestions" + json.encode(rq.toJson()));
//    try {
//      final response = await dio.post("",
//          data: json
//              .encode(getRequest('getDownloadQuestions', json.encode(rq.toJson()))));
//
//      if (response.statusCode == 200) {
//        print(response.data);
//        QuestionsResponse questionsResponse =
//        QuestionsResponse.fromJson(jsonDecode(response.data));
//        return questionsResponse;
//      }
//      print(response.data);
//      return null;
//    } catch (e) {
//      print(e);
//      return null;
//    }
//  }

  Future<QuestionsResponse> getDownloadQuestions(
      Map<String, dynamic> jsonMap) async {
    initDio();

    print("questions_request__" + json.encode(jsonMap));
    try {
      final response = await dio.post("",
          data: json.encode(
              getRequest('getDownloadQuestions', json.encode(jsonMap))));
      if (response.statusCode == 200) {
        print(response.data);
        QuestionsResponse questionsResponse =
            QuestionsResponse.fromJson(jsonDecode(response.data));
        return questionsResponse;
      }
      print(response.data);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
