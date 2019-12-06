import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/get_customer_value.dart';
import 'package:ke_employee/models/get_learning_module.dart';
import 'package:ke_employee/models/login.dart';
import 'package:ke_employee/models/organization.dart';
import 'package:ke_employee/models/questions.dart';

class WebApi {
  static const baseUrl = "http://13.127.186.25:7000/api";

  static getRequest(String req, String data) {
    return {
      'api_id': 'e1530f4d52b7a5b806e2b051e72c80ef',
      'api_secret': '1a42cc080ef2464a60134473276fe42e',
      'api_request': req,
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

    try {
      final response = await dio.post("",
          data: json.encode(getRequest('login', json.encode(jsonMap))));

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

  Future<LoginResponse> changePassword(Map<String, dynamic> jsonMap) async {
    initDio();

    print("change_password_request__" + json.encode(jsonMap));

    try {
      final response = await dio.post("",
          data:
              json.encode(getRequest('change_password', json.encode(jsonMap))));

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

  Future<LearningModuleResponse> getLearningModule() async {
    initDio();

    var req = json.encode({'userId': Injector.userData.userId});

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
      String moduleId, String type, String companyId) async {
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

  void initDio() {
    var headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader:
          Injector.prefs.getString(PrefKeys.user) != null
              ? "pig " +
                  LoginResponseData.fromJson(
                          json.decode(Injector.prefs.getString(PrefKeys.user)))
                      .accessToken
              : "",
      'devicetype': 'android',
      'deviceid': Injector.deviceId
    };

    BaseOptions options = new BaseOptions(
        baseUrl: "http://13.127.186.25:7000/api",
        connectTimeout: 10000,
        receiveTimeout: 3000,
        headers: headers);

    dio.options = options;
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

//    Utils.showLoader(context);

    try {
      final response = await dio.post("",
          data: json.encode(getRequest('getOrganization', json.encode(jsonMap))));

//      Utils.closeLoader(context);

      if (response.statusCode == 200) {
        print(response.data);
        GetOrganizationResponse getOrganizationResponse =
            GetOrganizationResponse.fromJson(jsonDecode(response.data));

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
//      Utils.closeLoader(context);
      print(e);
      return null;
    }
  }

  Future<OrganizationData> manageOrganizations(
      BuildContext context, Map<String, dynamic> jsonMap) async {
    initDio();

    print("manageOrganization__" + json.encode(jsonMap));

//    Utils.showLoader(context);

    try {
      final response = await dio.post("",
          data: json.encode(getRequest('manageOrganization', json.encode(jsonMap))));

//      Utils.closeLoader(context);

      if (response.statusCode == 200) {
        print(response.data);
        GetOrganizationResponse getOrganizationResponse =
            GetOrganizationResponse.fromJson(jsonDecode(response.data));

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
//      Utils.closeLoader(context);
      print(e);
      return null;
    }
  }

  Future<CustomerValueData> getCustomerValue(
      BuildContext context, Map<String, dynamic> jsonMap) async {
    initDio();

    print("getCustomerValue__" + json.encode(jsonMap));

//    Utils.showLoader(context);

    try {
      final response = await dio.post("",
          data: json.encode(getRequest('getCustomerValue', json.encode(jsonMap))));

//      Utils.closeLoader(context);

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
//      Utils.closeLoader(context);
      print(e);
      return null;
    }
  }

}
