import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/learning_module_response.dart';
import 'package:ke_employee/models/login_response.dart';
import 'package:ke_employee/models/login_response_data.dart';

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

  static getUploadProfileRequest(getRequestString req, String data, File file) async {
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

  Dio dio  = Dio();

  Future<LoginResponse> login(Map<String, dynamic> jsonMap) async {

    initDio();

    print("login_request__" + json.encode(jsonMap));

    try {
      final response = await dio.post("",
          data: json.encode(('login', json.encode(jsonMap))));

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

  Future<LoginResponse> assignUserToModule(String moduleId) async {
    initDio();

    var req = json.encode({
      'userId': Injector.userData.userId,
      'companyId': Injector.userData.activeCompany,
      'moduleId': moduleId
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
}
